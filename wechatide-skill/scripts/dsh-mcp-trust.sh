#!/bin/bash
# dsh-mcp-trust.sh —— 让 DSH 的 MCP 客户端（dsh-mcp-client）通过微信开发者工具的按名授权
#
# 用法:
#   bash dsh-mcp-trust.sh --check     只读诊断：白名单、MCP 端口、DSH 同款握手结果
#   bash dsh-mcp-trust.sh --seed      往白名单补写 dsh-mcp-client（IDE 运行中不会立即生效）
#   bash dsh-mcp-trust.sh --restart   优雅退出 → 退出后补写 → 重新拉起 → 握手验证（会关闭项目窗口）
#
# 背景：开发者工具把白名单缓存在主进程内存（this.trustedClients），并缓存未结算的授权
# Promise（pendingClientAuthorizations）。若某客户端名的授权弹窗消失而 Promise 未结算，
# 之后 /mcp/auth 会永远挂住且不再弹窗 —— 只有重启 IDE 能同时清掉这两者。
set -u

APP="/Applications/wechatwebdevtools.app"
MODE="${1:---check}"
CLIENT="dsh-mcp-client"
HASH="$(printf %s mcp_trusted_clients | md5)"
UD_ROOT="$HOME/Library/Application Support/微信开发者工具"
REPRO_DIR="/Users/lingyun/deepseek-harness/packages/mcp/mcp-client"

keyfile() { ls "$UD_ROOT"/*/WeappLocalData/ls_"$HASH".json 2>/dev/null | head -1; }

# 逐个候选端口试 heartbeat，返回真正在提供 MCP 服务的那个
port() {
  local f p
  for f in "$UD_ROOT"/*/Default/.ide; do
    [ -f "$f" ] || continue
    p="$(tr -dc 0-9 < "$f" 2>/dev/null)"
    if [ -n "$p" ] && curl -s -m 3 "http://127.0.0.1:$p/mcp/heartbeat" >/dev/null 2>&1; then echo "$p"; return 0; fi
  done
  for f in "$UD_ROOT"/*/Default/.ide; do
    [ -f "$f" ] || continue
    p="$(tr -dc 0-9 < "$f" 2>/dev/null)"
    [ -n "$p" ] && { echo "$p"; return 0; }
  done
  return 1
}

ide_running() { pgrep -f "wechatwebdevtools.app/Contents/MacOS/Electron" >/dev/null; }

do_seed() {
  python3 - "$CLIENT" "$HASH" <<'PY'
import json, os, sys, glob
client, h = sys.argv[1], sys.argv[2]
root = os.path.expanduser("~/Library/Application Support/微信开发者工具")
hits = glob.glob(os.path.join(root, "*", "WeappLocalData", "ls_" + h + ".json"))
if not hits:
    print("未找到白名单文件"); sys.exit(1)
path = hits[0]
try:
    d = json.load(open(path, encoding="utf-8"))
except Exception:
    d = {"trustedClients": []}
names = []
for c in d.get("trustedClients", []):
    n = c.get("name") if isinstance(c, dict) else c
    if n and n not in names:
        names.append(n)
print("已存在" if client in names else "补写", client)
if client not in names:
    names.append(client)
d["trustedClients"] = [{"name": n, "authorizedAt": "2026-09-22T04:31:18.705Z"} for n in names]
open(path, "w", encoding="utf-8").write(json.dumps(d, separators=(",", ":"), ensure_ascii=False))
print("当前名单:", names)
print("文件:", path)
PY
}

do_check() {
  local kf portnum
  kf="$(keyfile)"
  echo "白名单文件: ${kf:-<未找到>}"
  [ -n "$kf" ] && { printf "内容: "; cat "$kf"; echo; }
  portnum="$(port)" || portnum=""
  echo "MCP 端口  : ${portnum:-<未找到>}"
  if [ -n "$portnum" ]; then printf "heartbeat : "; curl -s -m 4 "http://127.0.0.1:$portnum/mcp/heartbeat" | head -c 200; echo; fi
  if ide_running; then echo "IDE 进程  : running"; else echo "IDE 进程  : stopped"; fi
  echo "--- DSH 同款握手 (clientInfo.name=${CLIENT}) ---"
  ( cd "$REPRO_DIR" && node --input-type=module -e "$(cat /tmp/mcp_repro.mjs 2>/dev/null)" 2>&1 \
      | grep -v "^\[wechatide\]" | grep -v "^scrubbed env keys" | grep -v "^has PATH" | tail -4 )
}

case "$MODE" in
  --check) do_check ;;
  --seed)  do_seed; echo "提示：IDE 运行中改文件不会立即生效，需要重启开发者工具（--restart）。" ;;
  --restart)
    echo "== 1) 优雅退出微信开发者工具 =="
    osascript -e 'quit app "wechatwebdevtools"' 2>/dev/null || true
    for _ in $(seq 1 30); do ide_running || break; sleep 2; done
    if ide_running; then echo "   优雅退出超时，改发 TERM"; pkill -TERM -f "wechatwebdevtools.app/Contents/MacOS/Electron" || true; sleep 8; fi
    if ide_running; then echo "   仍在运行，中止"; exit 1; else echo "   已退出"; fi
    echo "== 2) 退出后补写白名单 =="
    do_seed
    echo "== 3) 重新拉起 =="
    open -a "$APP"
    portnum=""
    for _ in $(seq 1 60); do
      portnum="$(port)" || portnum=""
      if [ -n "$portnum" ]; then echo "   MCP 服务已就绪，端口 $portnum"; break; fi
      sleep 3
    done
    [ -n "$portnum" ] || { echo "   MCP 服务未起来"; exit 1; }
    echo "== 4) 握手验证 =="
    do_check
    ;;
  *) echo "用法: bash $0 [--check|--seed|--restart]"; exit 2 ;;
esac
