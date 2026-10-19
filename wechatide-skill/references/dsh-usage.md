# 在 DSH（DeepSeek Harness）里使用本 skill

本文件是 DSH 本机适配说明，不改动 skill 原有语义。命令与参数仍以 [tool-index.md](tool-index.md) 为准。

## 本机落点

| 项目 | 位置 |
| --- | --- |
| skill 安装目录 | `~/.agents/skills/wechatide-skill/`（从微信开发者工具自带的 `wechatide-skill` 包复制而来，作为只读公共技能根被 DSH 加载） |
| skill 来源（随工具更新） | `/Applications/wechatwebdevtools.app/Contents/Resources/app.asar.unpacked/wechatide-skill` |
| CLI 入口 | `~/.local/bin/wechatide` → `wechatwebdevtools.app/Contents/MacOS/wechatide`（`ensure-cli-path.mjs` 建立） |
| MCP 服务器配置 | `~/.dsh/profiles/web/cordis.patch.yml` 里的 `mcp-wechat-devtools`（web profile 的 patch 层） |

## 两条调用通道

两条通道**工具名与参数完全一致**（都是同一批 47 个工具，见 tool-index）：

1. **MCP（优先）**：DSH 把 MCP 工具暴露为 `mcp__wechat-devtools__<toolName>`，参数就是各工具的 `inputSchema`。
   例如 `mcp__wechat-devtools__check_wechatide_status`、`mcp__wechat-devtools__project_list`、`mcp__wechat-devtools__simulator_screenshot`。
   用 MCP 时不需要 `-c <clientName>`，也不需要 `--token`。
2. **CLI（兜底）**：`wechatide -c <clientName> <toolName> [flags...] [--token <token>]`。
   MCP 不可用、或需要把输出直接拿到 shell 里处理时用这条。

## 授权：按客户端名授权（MCP 连不上的头号原因）

微信开发者工具对每个 MCP/CLI 客户端**按名字授权**，白名单存在开发者工具本地存储的 `mcp_trusted_clients`（文件形如
`~/Library/Application Support/微信开发者工具/<hash>/WeappLocalData/ls_<hash>.json`，内含 `{"trustedClients":[{"name":...,"authorizedAt":...}]}`）。

- DSH 的 MCP 客户端自报名字固定为 **`dsh-mcp-client`**（见 `packages/mcp/mcp-client/src/connection.ts`，不可配置）。
- 未授权时的表现：MCP 端 initialize 直接返回 `Client authorization pending`（-32603），DSH 日志里反复出现 `[wechatide] stdio bridge started … stdin closed`；CLI 端返回 `taskId` + `taskType: auth` + `status: pending`。
- 该名字已在 `trustedClients` 里之后，**后续连接自动放行**，不需要再确认。

### 触发授权窗口

开发者工具会弹一个 420x200、置顶的小窗（标题 **MCP Client Authorization**，内容 `"<clientName>" is requesting MCP access. Allow?`，按钮 **Allow / Deny**）。三种触发方式：

```bash
# 1) 直接调开发者工具自带的 MCP 授权端点（端口写在 Default/.ide）
PORT=$(tr -dc '0-9' < "$HOME/Library/Application Support/微信开发者工具/d1e8765721a6c23d43b14c95b1843e6b/Default/.ide")
curl -X POST "http://127.0.0.1:$PORT/mcp/auth" -H 'Content-Type: application/json' -d '{"clientName":"dsh-mcp-client"}'
# 该请求会一直挂到你在弹窗里点 Allow / Deny

# 2) 任意 CLI 调用也会带出授权流程
wechatide -c dsh-mcp-client check_wechatide_status

# 3) 已授权名单（只读确认）
cat "$HOME/Library/Application Support/微信开发者工具"/*/WeappLocalData/ls_*.json | grep -o '"name":"[^"]*"'
```

注意：手改上面那个 `ls_*.json` 文件**不会立刻生效**——开发者工具把这份名单缓存在内存里（`this.trustedClients`），只在授权动作后回写；改动要等工具重启才重新读取。

文件名可以直接算出来：`md5("mcp_trusted_clients") = 50605687a9689a04a5bfaf9a7278de8e`，即
`<UserData>/WeappLocalData/ls_50605687a9689a04a5bfaf9a7278de8e.json`，内容形如 `{"trustedClients":[{"name":…,"authorizedAt":…}]}`。

### 已知坑：授权弹窗卡死（本机实际踩到过）

现象与成因：

- `POST /mcp/auth` 请求**永远挂着不返回**，而且**不再弹出任何授权窗口**（触发前后 Electron renderer 进程数不变）。
- 开发者工具日志 `<UserData>/WeappLog/logs/*.log` 里该客户端一直是 `[mcp-log] session_init clientName=dsh-mcp-client … authResult=deny`。
- 成因在主进程内存里：`pendingClientAuthorizations` 按客户端名缓存授权 Promise（`requestClientAuthorization` 命中即复用）。
  一旦那个弹窗消失但 Promise 没有结算，该名字就**永久卡死**——后续所有请求都复用这个死 Promise，窗口也不会再创建。
- 同时 `trustedClients` 是内存缓存，**手改文件不会被重新读取**。

结论：**只有重启开发者工具能同时清掉这两样**，重启后会重新从 `mcp_trusted_clients` 读白名单。
本机白名单里已经写好 `dsh-mcp-client`，所以重启即放行，**不需要再点任何弹窗**。

```bash
S=~/.agents/skills/wechatide-skill/scripts/dsh-mcp-trust.sh
bash $S --check     # 只读诊断：白名单 / MCP 端口 / DSH 同款握手
bash $S --seed      # 只补写白名单（要重启 IDE 才生效）
bash $S --restart   # 退出 → 退出后补写 → 拉起 → 握手验证（会关闭已打开的项目窗口）
```

验证成功的标志：握手输出 `CONNECT OK in …ms` 与 `TOOLS: 47`，且 IDE 日志里该客户端变成 `authResult=allow`。

### 授权后让 DSH 重连

MCP 插件连续失败 `reconnectMaxAttempts`（默认 10）次后会放弃并注销工具，此时需要重新触发加载：改写（哪怕只动注释）`~/.dsh/profiles/web/cordis.patch.yml` 让 loader 热重载该插件；实在不行再重启 `dsh web`。
重连成功的标志：`wechatide mcp` 桥进程**常驻不退出**，且不再刷 `stdin closed`。

## 沙箱与前置条件

- **不要在沙箱里跑**：开发者工具需要访问本机桌面与 IDE 的调试端口；DSH 侧用 danger-full-access（或至少非沙箱 shell）。
- 目标 IDE 必须**已启动**（bridge 会连到它在 `Default/.ide` 里登记的端口）。IDE 没开时工具调用会失败，但不影响 DSH profile 启动。
- 首次调用前建议跑 `check_wechatide_status`（本机该工具可跳过 `--token`），确认 `loginExpired: false` 与 `versionRelation`。

## 与 skill 正文的关系

正文里的 `wechatide -c <clientName> ...` 写法在 DSH 里依然可用（前提是该 `clientName` 已在白名单里）。若同一台机器上 MCP 通道已授权，**优先用 MCP**：不用记 clientName、没有 CLI 启动开销、结果直接进对话。
