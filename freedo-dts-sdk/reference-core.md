# Freedo 核心：Player / API / 异步 / 事件 / 相机 / 设置 / 坐标

官方：https://sdk.freedo3d.com/doc/DigitalTwinPlayer.html
https://sdk.freedo3d.com/doc/DigitalTwinAPI.html
https://sdk.freedo3d.com/doc/Camera.html

## DigitalTwinPlayer

```js
new DigitalTwinPlayer(host, option)
```

`host`：`IP:Port`，对应 CloudMaster「服务设置」端口。

### option

| 字段 | 说明 |
|------|------|
| `domId` | 视频父节点 id。不设则只调 API、不推流 |
| `iid` | 云渲染实例 ID。有 `domId` 时可省略（自动空闲实例）；纯 API 必须指定 |
| `pid` | 工程 ID。实例若锁定工程，再指定别的 pid 会切换失败 |
| `reset` | `true` 则每次连接/刷新都重启全新实例 |
| `password` | 实例访问密码 |
| `useHttps` | Nginx HTTPS 反代时设 `true` |
| `keyEventTarget` | `'video'`（默认）/ `'document'` / `'none'` |
| `registerEvents` | 默认 true。图表设计模式拖拽视频组件时设 false |
| `useBuiltinCursors` | 默认 true |
| `urlExtraInfo` | 给 WS URL 附加认证等 |
| `customString` | 自定义信息 |
| `apiOptions` | 传给内部 DigitalTwinAPI（`onReady`/`onEvent`/`onLog`/`onApiVersion`/`onBeforeRequest`） |
| `ui` | 见下 |
| `events` | 见下 |

`ui`：`startupInfo`(默认 true)、`statusIndicator`(true)、`statusButton`(false)、`fullscreenButton`、`homeButton`、`taskListBar`(0/1/2)、`debugEventsPanel`、`mainUI`、`campass`。

`events`：`onConnClose`、`onVideoLoaded`、`onRtcStatsReport`、`onLoginRequired`、`touchListener`、`mouseKeyListener`。

`mouseKeyListener` 键名（文档现用驼峰）：`onMouseEnter` / `onMouseLeave` / `onMouseMove` / `onMouseDown` / `onMouseUp` / `onKeyDown` / `onKeyUp` / `onKeyPress`。旧教程曾写 `onmousedown` 全小写。

### 方法

| 方法 | 作用 |
|------|------|
| `getAPI()` | 拿 fdapi |
| `destroy(reason)` | 关播放器 |
| `resize()` | 容器尺寸变了要调 |
| `setResolution(w,h)` | 改视频分辨率 |
| `getVideoElement()` / `getVideoSize()` / `getVideoStreamSize()` / `getVideoElementSize()` | 视频 DOM/尺寸 |
| `getHost()` / `getInstanceInfo()` | 连接信息 |
| `setInstanceOptions(o)` | 运行中改 iid 等 |
| `setKeyEventTarget(v)` | 改键盘目标 |
| `setActionEventEnabled(b)` | 开关鼠标键盘监听 |
| `setEnableEventSync(b)` | 多端事件同步 |
| `screen2World(x,y,fn)` / `world2Screen(x,y,z,fn)` | 屏幕 ↔ 场景 |
| `fullscreen` | 读写全屏 |

多实例：每个窗口自己的 `domId` + `iid`。显卡需支持 Cloud 多实例。

## DigitalTwinAPI（fdapi）

有视频流时不要自己 `new`，用 `player.getAPI()`。

构造选项：`onReady`、`onLog`、`onEvent`、`onApiVersion`、`onBeforeRequest`（改场景命令发出前，可拿原始 JSON）。

| 方法 | 作用 |
|------|------|
| `checkApiReady()` | 是否可调 |
| `destroy()` | 关 WS；调了之后不会自动重连 |
| `reset(type, fn)` | 重置。`type` 见 `ResetType`，默认清接口加的对象 |
| `setEventCallback(fn)` | **覆盖**事件回调 |
| `setHost(ip, port)` | 改服务器 |
| `getPlayer()` | 关联的 Player，纯 API 为 null |
| `getProjectInfo()` / `getVersion()` | 工程 / SDK 大版本 |
| `saveProject(fn)` | 存工程 |
| `registerTick(url, options, fn)` / `removeTick` / `showTickWindow` / `executeJsInTickPage` | 每帧同步调用（见下） |
| `registerSyncObjects()` | 同步对象 |
| `setEnableAliases(b)` | 别名 |

子对象属性（`fdapi.xxx`）完整表见 [api-index.md](api-index.md)。

## 异步（三种，不可混用）

同一函数体内只选一种。

```js
// 1) callback
fdapi.camera.get((cam) => { fdapi.marker.add({...}); });

// 2) then
fdapi.camera.get().then((cam) => fdapi.marker.add({...}));

// 3) await（推荐）
const cam = await fdapi.camera.get();
await fdapi.marker.add({...});
```

不 await 时请求会并发乱序：`camera.get` 的坐标还没回来，`marker.add` 已发出 `coordinate: [null,null,z]`。

成功响应常见字段：`result===0`、`resultMessage:"OK"`。错误码见 `APIErrorCode`。

## 事件

场景事件走 `apiOptions.onEvent` 或 `setEventCallback`。字段：

- `eventtype`：事件名
- `Type`：图层类型（`TileLayer` 等）
- `Id` / `ID`：图层 id
- `ObjectID`：Actor id
- `MouseClickPoint`：点击坐标

需手动打开的事件：

```js
fdapi.settings.setMousePickMask(7); // Click|Move|Hover
fdapi.settings.setEnableCameraMovingEvent(true);
```

页面 DOM 级鼠标键盘 ≠ 场景拾取，走 Player `events.mouseKeyListener`。

## Camera（`fdapi.camera`）

`set` 三种等价写法：

```js
fdapi.camera.set(x, y, z, pitch, yaw, flyTime);
fdapi.camera.set({ x, y, z, pitch, yaw }, flyTime); // roll 忽略
fdapi.camera.set([x, y, z, pitch, yaw, roll], flyTime); // 末位忽略
```

`get()` 返回 `{ x,y,z,pitch,yaw,roll, camera:[...] }`。

| 方法 | 作用 |
|------|------|
| `lookAt(x,y,z, distance, pitch, yaw, flyTime)` | 看向点 |
| `lookAtBBox(bbox, pitch, yaw, flyTime)` | `bbox=[minX,minY,minZ,maxX,maxY,maxZ]` |
| `lockByBBox(bbox)` / `unlock()` | 限制漫游范围 |
| `flyAround(location, rotation, distance, time)` | 环绕一周 |
| `enterWorld()` / `exitWorld()` | 场景 ↔ 地球（本仓库会 sleep 等飞完） |
| `playAnimation(ids, mask)` / `pause` / `resume` / `stopAnimation` | 导览。`mask`=`AnimationMask` |
| `getAnimationList()` / `getAnimationImage(name)` | 导览列表 / 缩略图 base64 |
| `stop()` | 停当前飞行动画 |
| `moveForward/Back/Left/Right/Up/Down` `turnLeft/Right/Up/Down` | 步进 |
| `cancelFollow()` | 取消跟随 CustomObject/载具 |
| `getEulerAngle(start, end)` | 两点算 `[Pitch,Yaw,Roll]` |
| `exportOrthoImage(...)` | 正交投影出图 |
| `useOldDataFormat(b)` | 旧数据格式 |

`focus` 不在 Camera 上，在各对象：`tileLayer.focus`、`marker.focus`、`customObject.focus`。

### 方向换算（欧拉角 ↔ 世界方向）

相机、`camera.set` / `lookAt` / `focus(rotation)`、`customObject.rotation` / `localRotation` 用的是**同一套欧拉角** `[Pitch, Yaw, Roll]`（度）。场景坐标东 +X、北 +Y、上 +Z（[tutorial-API_Introduction](https://sdk.freedo3d.com/doc/tutorial-API_Introduction.html)、[tutorial-API_Camera](https://sdk.freedo3d.com/doc/tutorial-API_Camera.html)）。

| 要求 | 公式 |
|------|------|
| yaw → 水平方向 | `0` 正东(+X)、`-90` 正北(+Y)、`90` 正南(−Y)；罗盘方位角 = `yaw + 90` |
| 相机视线向量 | `(cos(pitch)·cos(yaw), -cos(pitch)·sin(yaw), sin(pitch))` |
| 两点定方向 | `yaw = atan2(Δx, Δy)·180/π - 90`；`pitch = atan2(Δz, √(Δx²+Δy²))·180/π` |

`getEulerAngle(startPoint, endPoint)` — 官方说明"根据空间两点计算欧拉角"，返回 `[Pitch,Yaw,Roll]`（Pitch∈[-90,90]、Yaw∈[-180,180]、Roll 恒为 0）。

- **同步返回**：签名里没有 `fn`，ac.min 里就是三行纯数学，不发请求、不用 await（拿 `fdapi.camera` 本身仍需 `onReady`）。
- 自检：`getEulerAngle(C, C + 100 × 视线向量)` 必定回出相机自己的 `[pitch, yaw, 0]`。
- `ac.min_6.0.js` 与 `ac.min_6.1.js` 实现完全一致：

```js
getEulerAngle(a, b){
  const c = 360 / (2 * Math.PI);
  let e = b[0] - a[0], d = b[1] - a[1];
  return [Math.atan2(b[2] - a[2], Math.sqrt(e * e + d * d)) * c, Math.atan2(e, d) * c - 90, 0];
}
```

#### 对齐人物 / 模型朝向（fi-dts-bs 实战踩坑）

`customObject` 的 yaw 与相机 yaw **同向**（正北 0°、顺时针增大），所以"背对镜头"≈ `yaw = cameraYaw`。每个 asset 另有自己的**零朝向偏差**（模型在 yaw=0 时朝哪边），只能实测标定，而且**一整个 asset 一个常量**，所有点位共用：

```ts
// 该 asset 实测：背对镜头时 ψ = cameraYaw - 37
export const WORKER_YAW_OFFSET = -37;
const getWorkerYaw = (cameraYaw: number) => normalizeYaw(cameraYaw + WORKER_YAW_OFFSET);
```

- ✅ `ψ = cameraYaw + 标定常量`。
- ❌ 不要写 `ψ = 180 - cameraYaw` 这类**镜像式**：误差 `≈ 180 - 2·cameraYaw + 标定值`，**随点位 yaw 变化**——yaw≈−80 的点位只偏 20°，yaw≈+29 的点位差 159°。现象就是"整体偏一点 + 某个点位怎么调都不对"；出现按点位打补丁的冲动时，先怀疑公式镜像了。
- **面向镜头** = `getEulerAngle(模型位置, 相机位置)[1]`（含取景侧偏造成的视差）；**背对镜头** = 相机 yaw 本身，不含视差、深俯仰也稳。
- 标定一次即可：同一位置摆 4 个探针（`localRotation` yaw 取 0/90/180/270），截图看哪个正对镜头，把差值固化成常量。
- 参考实现：`fi-dts-bs` 的 `src/pages/Inspect/plantWorker.ts`。

## Settings（`fdapi.settings`）

| 方法 | 作用 |
|------|------|
| `setMousePickMask(mask)` | 1 click / 2 move / 4 hover；7=全开 |
| `setEnableCameraMovingEvent(b, period)` | 相机移动事件 |
| `setEnableInteract(b)` | 总交互开关 |
| `setInteractiveMode(mode)` / `getInteractiveMode` | 交互模式 |
| `setMainUIVisibility(b)` `setToolbarVisible` `setScreenControlsVisible` `setCampassVisible` `setCampassPosition` | 内置 UI |
| `setMapMode(mode, options)` | 罗盘/鹰眼/大地图 `MapMode` |
| `setFovX(val)` | 视场 |
| `setHighlightColor(color)` | 高亮色 |
| `setGroundHeight(h)` | 地面高 |
| `setMouseHoverTime` / `setMouseMoveTime` | 悬停/移动判定时间 |
| `enableRightClickMousePick(b)` | 右键拾取 |
| `setCharacterRoaming` / `setCharacterRotation` / `setCharacterAssetPath` | 人物漫游 |
| `setDroneAssetPath` | 无人机资产 |
| `getProjectWKT()` | 工程投影 |
| `showPropertiesPanel(id)` / `hidePropertiesPanel` | 属性面板 |
| `setLabelLayer` / `removeLabelLayer` / `setLabelLayerScaleRatio` | 注记层 |
| `setWMTSLayerVisible` / `setWMTSLayerOpacity` | WMTS |
| `setOceanColor` `setTerrainAlpha` `setImageryLayerEnableDecal` | 地球/影像 |

## Coord（`fdapi.coord`）

`gcs2pcs`、`pcs2gcs`、`screen2World`、`world2Screen`。

Player 上也有 `screen2World` / `world2Screen`。

## 坐标数组维度

- 单点：`[x,y,z?]`
- 单环：`[[x,y,z], ...]` 顺/逆时针
- 单 Part 带内环：`[外环, 内环1, ...]`
- 多 Part：再包一层

## 颜色

`Color.Red` | `'RGB(r,g,b)'` | `'#RRGGBB'` | `[r,g,b,a]`（0–1，唯这种带透明）

## 外部资源

`@path:/images/demo.png`、`@path:/3dt/demo.3dt`、`@path:/shapefile/demo.shp`。`@path:` = CloudMaster 资源根。

弹窗页：内置精简浏览器，用原生 JS，少用 ES6/CSS3。

## ontick（每帧同步）

常规调用：浏览器 → 网络 → 渲染进程线程切换，高频会卡。

`fdapi.registerTick(absoluteUrl, { x,y,width,height,visible }, fn)`：渲染进程内嵌 CEF，每帧同步调 C++。全局只能一个 tick 页。

tick 页：`new DigitalTwinAPI()` 无参。实现 `tick(frameNo)`，可选 `tick_next(o, frameNo)`。要同步结果时最后一个参数必须传 `null`（否则又变异步，失去 tick 意义）。

客户端 ↔ tick 页：`executeJsInTickPage(code)`；tick 页 `ue.internal.postevent(str)` 回客户端。

## 多窗口 / Explorer

- iframe 多 player.html
- 同页多 `DigitalTwinPlayer`（不同 `iid`）
- Explorer：进程内 JS↔C++ 见 `FdExternal`（`tutorial-Explorer_Guidline.html`）
