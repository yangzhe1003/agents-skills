# Freedo 扩展模块与授权

未授权对象调用会失败。对照官方：https://sdk.freedo3d.com/doc/tutorial-API_AuthSDK.html

## 授权对照

| 模块 | 对象 / 方法 |
|------|-------------|
| 高级分析 | `HeatMap3D` `FloodFill` `Antenna` `SignalWave` `FiniteElement2`；`tools.startContourLineAnalysis` `startCutFillAnalysis` `startFloodFill` `startSkylineAnalysis` `exportSkyline` `startSunshineAnalysis` `startTerrainSlopeAnalysis` `startViewDomeAnalysis` `startViewshedAnalysis` `startVisiblityAnalysis` |
| 水仿真 | `WaterFlowField` `Fluid` `HydroDynamic1D` `HydroDynamic2D` |
| 海洋气象 | `VectorField` |
| 交通仿真 | `Vehicle2` `Train` `TrafficSimulation` `Drone` |
| 军事仿真 | `BattlefieldSimulation` `Plot` |

不在表里的（`Vehicle` 基础载具、`customObject` 模拟车/人/无人机、`HeatMap` 二维）一般随基础 SDK。

## 交通

### Vehicle（`fdapi.vehicle`）基础载具

`add` `start` `stop` `pause` `resume` `moveTo` `setWayPoint` `callBatchFunction` `show`/`hide` `focus`

### Vehicle2（`fdapi.vehicle2`）**交通授权**

高级载具：`add` `moveTo` `setFollow` `setViewportVisible`。视角 `VehicleViewMode`：0 第一人称，1 第三人称。

### Train（`fdapi.train`）**交通授权**

`add` `moveTo` `pause` `resume` `setFollow`

### TrafficSimulation（`fdapi.trafficSimulation`）**交通授权**

城市级（文档称十万级车辆）：`add` `highlight`/`unHighlight`/`autoHighlight` `showHeatMap`/`hideHeatMap` `showTextLabel`/`hideTextLabel`

### Drone（`fdapi.drone`）**交通授权**

SDK 无人机对象（与本仓库用 `customObject` 扮无人机不是同一套）。

`add` `moveTo` `show`/`hide` `focus`。轨迹样式 `DroneTrailStyle`：无 / 圆柱 / 条带 / 虚线。

本仓库巡检无人机走 `customObject.add` + `startMove` + `marker`/`polyline`/`marker3d` 画航线，不依赖本类。

## 军事

`battlefieldSimulation`：装甲车/坦克/无人机/士兵等作战单元。
`plot`：态势标绘，`PlotStyle`（折线/圆/三角/矩形/多边形…）。
`satellite`：卫星仿真。
`boxTrigger`：CustomObject 或相机进出盒子热区触发事件。

## 水 / 海洋（接口细节见 scene 分册）

优先 `hydrodynamicModel`（新），避免 `hydrodynamicModel2`。
`river` ≡ `hydrodynamic1d`。
`vectorField` 样式 `VectorFieldStyle`：台风 / 波浪 / 洋流 / 流体。

## 地球与影像

球面工程：`globeTerrain.init` + `addImageryLayer*`；`imageryLayer2.addByUrl` / `addBySchemaParams`。
平面工程：`imageryLayer`（WMS/WMTS/MapServer/VTPK）。
`settings.setMapMode` 切罗盘/鹰眼/大地图。
`camera.enterWorld` / `exitWorld` 进出本地场景。

## 视频融合

`videoProjection`：把视频投到场景几何。
`daHuaVideoFusion`：大华，字段 `serverIP` `serverPort` `accessToken` `labelVisible`；`update` 可设 `triggerType`（碰撞/距离）。

## 相机导览对象

除 `camera.playAnimation`（工程内已录导览）外，还有可编程：

`fdapi.cameraTour`：`add` `setKeyFrames` `play` `pause` `resume` `stop` `setDuration` `setTime` `exportVideo` `setMouseClickToPause`

关键帧类型 `CameraTourKeyFrame`，数据包 `CameraTourData`。播完事件 `CameraTourFinished`。

## Explorer / FdExternal

Explorer WebUI 或进程内页：`FdExternal.execute` `getData` `setData` `postEvent` `getViewportSize` `valid` `close`。
与浏览器端 Player 不是同一条链路。指南：`tutorial-Explorer_Guidline.html`。

## QueryOption

`tileLayer.createQuery()` / `query(queryOption)` 用。属性见 https://sdk.freedo3d.com/doc/QueryOption.html
