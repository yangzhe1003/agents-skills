---
name: freedo-dts-sdk
description: >-
  Use when working with Freedo / 飞渡 DTS 云渲染二次开发：DigitalTwinPlayer、fdapi、
  ac.min.js、infoTree、tileLayer、marker、customObject、camera、weather、XRay、
  三维视频流、CloudMaster、3DT、ACP、AirCity。适用于初始化播放器、场景图层显隐、
  标注/模型/折线、相机飞入、事件拾取、天气、水动力/热力等分析接口。
---

# Freedo DTS 二次开发 SDK

官方文档：https://sdk.freedo3d.com/doc/（JSDoc，2026-03-14 生成）
JS 包：`ac.min.js`（本仓库由 `src/components/Player/index.tsx` 引 `src/assets/js/ac.min_6.1.js`；6.0/6.1 接口一致）

**先读本文件**，再按任务打开分册，不要整本塞进上下文。

| 任务 | 打开 |
|------|------|
| 初始化 / 异步 / 事件 / 坐标 / 颜色 | [reference-core.md](reference-core.md) |
| Marker / Polyline / CustomObject / 图层树 / 3DT | [reference-overlays.md](reference-overlays.md) |
| 天气 / 测量剖切 / 热力 / 杂项 | [reference-scene.md](reference-scene.md) |
| 水动力、载具、无人机、影像、付费模块 | [reference-modules.md](reference-modules.md) |
| 枚举、事件名、错误码 | [reference-enums.md](reference-enums.md) |
| 按类名找方法签名 | [api-index.md](api-index.md) |
| 原文某方法参数 | 打开 `https://sdk.freedo3d.com/doc/<Class>.html` |

## 它是什么

浏览器里播 **云渲染三维视频流**，用 JS 调引擎。不是 WebGL 自绘，也不是 Cesium 本体。

```
DigitalTwinPlayer(host, options)  →  视频流 + 交互
        └── getAPI() → fdapi (DigitalTwinAPI)
              ├── camera / infoTree / tileLayer / settings
              ├── marker / marker3d / polyline / polygon / customObject
              └── weather / tools / misc / 各类仿真对象
```

有画面：只 `new DigitalTwinPlayer`，再 `getAPI()`。不要再 `new DigitalTwinAPI`。
无画面纯接口：`new DigitalTwinAPI(host, options)`，必须带实例 `iid`。

## 硬规则

1. **`onReady` 之前禁止调 fdapi**。工程没打开就调会崩或静默失败。
2. **接口几乎全是异步**。同一函数体内只能用一种：`callback` / `.then` / `async-await`，禁止混用。
3. **不要 fire-and-forget 再读返回值**。`const cam = fdapi.camera.get()` 没有 await 时 `cam.x` 是 undefined。
4. **`setEventCallback` 会覆盖**上次事件回调。要叠加就自己在回调里分发。
5. **Tag / CustomTag 已停更**，新代码用 `marker`。
6. 外部资源用 `@path:/images/xxx.png`（相对 CloudMaster 资源根）。弹窗 HTML 走内置简化浏览器，避免 ES6/CSS3 新特性。
7. 本仓库（fi-dts-bs）：子页 **不要** `new Player`，从 `useSceneRuntime()` / `config.getAPI()` 拿 `fdapi`。卸载时 **不要** `destroy()` 全局播放器。

## 初始化（最小可用）

```js
import * as acapi from "@/assets/js/ac.min_6.1.js";

const player = new acapi.DigitalTwinPlayer("192.168.1.27:8081", {
  domId: "player",
  keyEventTarget: "none", // 页面有输入框时不要抢键盘
  apiOptions: {
    onReady() {
      // 从此刻才能调 API
    },
    onEvent(event) {
      // event.eventtype / Type / Id|ID / ObjectID / MouseClickPoint
    },
  },
  ui: { startupInfo: true, statusButton: true },
  events: {
    onVideoLoaded() {},
    onConnClose() {},
  },
});
const fdapi = player.getAPI();
```

卸载：`fdapi.destroy()`（断开且不再重连）。重置对象：`fdapi.reset()` / `fdapi.reset(ResetType.ClearObjects)`。

多窗口：每个实例一个 `domId` + `iid`，各自 `getAPI()`。或用 iframe。

## 坐标系（写坐标前先定 type）

| 值 | 含义 |
|----|------|
| 0 | Projection / 本地投影（工程默认，本仓库相机/模型常用） |
| 1 | WGS84 |
| 2 | GCJ-02 |
| 3 | BD09 |

场景坐标：东 +X、北 +Y、上 +Z。欧拉角：`[Pitch, Yaw, Roll]`，Pitch [-90,90]，Yaw [-180,180]。
yaw 指向：`0` = 正东(+X)、`-90` = 正北(+Y)、`90` = 正南(−Y)；罗盘方位角 = `yaw + 90`。
视线向量 = `(cos p·cos y, -cos p·sin y, sin p)`；两点定方向用 `camera.getEulerAngle(A, B)`（**同步返回**，不是异步）。模型朝向标定见 [reference-core.md](reference-core.md) 的「方向换算」。
转换：`fdapi.coord.gcs2pcs` / `pcs2gcs` / `screen2World` / `world2Screen`。
点/环/面数组维度见 [reference-core.md](reference-core.md)。

## 颜色

- `Color.Red`（无透明度）
- `'RGB(255,255,255)'`
- `'#FFFEEE'`
- `[r,g,b,a]`，每分量 0–1（要透明用这个）

## 事件

`onEvent` 或 `fdapi.setEventCallback`。常用 `event.eventtype`：

| 事件 | 前提 |
|------|------|
| `LeftMouseButtonClick` | 默认 |
| `MouseHovered` / `MouseMoved` | 先 `settings.setMousePickMask(7)` |
| `CameraStartMove` / `CameraMoving` / `CameraStopMove` | 先 `settings.setEnableCameraMovingEvent(true)` |
| `CameraChanged` | `focus` / `camera.set` / `lookAt` |
| `CameraTourFinished` | 导览播完 |
| `Measurement` / `PlaneClipEdit` / `VolumeClipEdit` | 测量/剖切 |

图层点击字段：`Type`（如 `TileLayer`）、`Id`/`ID`、`ObjectID`、`MouseClickPoint`。
本仓库 infoTree 节点主键是 **`iD`**（注意大小写）。

页面级鼠标键盘走 Player `events.mouseKeyListener`（`onMouseDown` 等），与场景 `onEvent` 不是同一套。

## 本仓库高频写法

```ts
const res = await fdapi.infoTree.get();
const trees = res.infotree; // [{ iD, name, type, visiblity, ... }]

await fdapi.infoTree.hide([idA, idB]);
await fdapi.infoTree.show([CRAFT_EXTERNAL_BUILDING_MODEL]);

await fdapi.tileLayer.enableXRay(ids, [0, 1, 1, 1]);
await fdapi.tileLayer.disableXRay(ids);
await fdapi.tileLayer.focus(id, 20, 2, [-45, -90, 0]);

await fdapi.camera.set(x, y, z, pitch, yaw, flyTime);
// 或 fdapi.camera.set({ x, y, z, pitch, yaw }, flyTime)
// 或 fdapi.camera.set([x, y, z, pitch, yaw, roll], flyTime)

fdapi.marker.add(list);
fdapi.marker.showByGroupId(group);
fdapi.marker.setAttachCustomObject({ id, objectId }); // 跟随模型；新文档名可能是 setAttachMovingObject

fdapi.customObject.add({ id, pakFilePath, assetPath, location, rotation });
fdapi.customObject.startMove(id, 0, [{ time: 0, coordinate: [x,y,z] }, ...]);
fdapi.customObject.callBatchBPFunction([{ id, functionName, parameters }]);

fdapi.weather.setDateTime(2024, 2, 1, 12, 0);
fdapi.weather.setRainParam(0.38, 0, 0.21);
fdapi.weather.disableRainSnow();
```

切页清理常见组合：`customObject.clear()` + `marker.clear()` + `marker3d.clear()` + `polyline.clear()` + `camera.stopAnimation()`。

## 对象选型

| 要做的事 | 用 |
|----------|----|
| 工程树显隐 / 按组 XRay | `infoTree` |
| 3DT 图层、Actor 高亮/定位/挖洞 | `tileLayer` |
| 2D 标注、弹窗、聚合 | `marker` |
| 3D 动态标注 | `marker3d` |
| 路径/流向线 | `polyline`（`PolylineStyle.Flow`） |
| 场景里走动的人/车/无人机模型 | `customObject`（pak + 蓝图 Actor） |
| 相机飞入 / 地球进出 | `camera.set` / `enterWorld` / `exitWorld` |
| 测量、剖切、通视等 | `tools`（部分要授权） |
| 每帧高频改属性 | `registerTick`，见 core 分册 |

CRUD 通式（多数图层对象）：`add` / `update` / `delete` / `clear` / `show`/`hide` / `focus` / `get`，批量改属性用 `updateBegin` + `updateEnd`。

## 付费模块（未授权会失败）

高级分析：`HeatMap3D`、`FloodFill`、`Antenna`、`SignalWave`、`FiniteElement2`，以及 `tools.start*Analysis`。
水仿真：`WaterFlowField`、`Fluid`、`HydroDynamic1D/2D`。
交通：`Vehicle2`、`Train`、`TrafficSimulation`、`Drone`。
军事：`BattlefieldSimulation`、`Plot`。

## 调试

| 现象 | 查 |
|------|----|
| 调了没反应 / 崩 | 是否在 `onReady` 之后；host 端口是否 Cloud WebSocket 口 |
| 坐标全 null | 缺 await / 同一函数混了三种异步 |
| 点击无拾取 | `setMousePickMask`；看 `event.Type` 与 `Id` |
| 标注不显 | `range` / `viewHeightRange` / `coordinateType` / `@path` |
| 模型不出现 | `assetPath` 必须是蓝图 Actor；pak 路径 |
| 人物/模型朝向不对 | `customObject` 的 yaw 与相机 yaw 同向：`ψ = cameraYaw + asset 标定常量`；**别写 `180 - cameraYaw` 镜像式**，见 core 分册「方向换算」 |
| 左上角圆点红/灰/黄 | `CloudStatus`：断线 / 连 WS / 建 WebRTC |
| ac.min 与服务器版本不一致 | 控制台会警告，接口可能错 |

细节以官方类页为准：https://sdk.freedo3d.com/doc/DigitalTwinAPI.html
