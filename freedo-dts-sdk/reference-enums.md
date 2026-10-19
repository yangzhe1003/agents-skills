# Freedo 枚举、事件、错误码

官方 Global：https://sdk.freedo3d.com/doc/global.html
全局实例：`fdapi`（`new DigitalTwinAPI` 或 Player.getAPI 之后可用）。
`VERSION`：JS-API 版本字符串。

## 场景事件 `event.eventtype`

| 名称 | 何时 | 前置 |
|------|------|------|
| `LeftMouseButtonClick` | 左键点 | — |
| `MouseHovered` | 悬停 | `settings.setMousePickMask` 含 Hover(4) |
| `MouseMoved` | 移动拾取 | mask 含 Move(2) |
| `CameraStartMove` / `CameraMoving` / `CameraStopMove` | 相机飞 | `setEnableCameraMovingEvent(true)` |
| `CameraChanged` | set/lookAt/focus | — |
| `CameraTourFinished` | 导览结束 | `camera.playAnimation` 或 `cameraTour.play` |
| `Measurement` | 测量完成 | `tools.startMeasurement` |
| `PlaneClipEdit` / `VolumeClipEdit` | 剖切编辑 | 面/体剖切模式 |

事件对象常见字段：`Type` `Id`/`ID` `ObjectID` `MouseClickPoint`；相机事件还有 `Pitch` `Yaw` `Position`。

## MousePickMask

`MouseClick=1` `MouseMove=2` `MouseHover=4`。全开：`7` 或三者按位或。

## ResetType

`ClearObjects=1` 清接口对象  
`ResetSettings=2` 重置设置  
`ResetCamera=4` 相机回初始  
可组合。不传默认清对象。

## AnimationMask（播导览）

`Camera=1` `Environment=2` `ProjectTree=4` `Settings=8`

## ActionMode（CustomObject.focus 跟随）

`None=0` 不跟随  
`Follow=1`  
`FollowBehindAndAbove=2` 后上  
`FollowBehind=3` 后方  
`FollowAbove` 上方

## coordinateType（覆盖物通用）

`0` Projection（默认）`1` WGS84 `2` GCJ-02 `3` BD09

## Color

预定义常量 `Color.Red` 等（无透明）。接口也接受 `'RGB(r,g,b)'`、`'#hex'`、`[r,g,b,a]`（0–1）。

## PolylineStyle

`Arrow=0` `Arrow1=1` `Flow=2` `Beam=3` `Normal`（文档后续还有更多取值，以类页为准）

## PolygonStyle

`SingleColor=0` `CirclePoint=1` `Volume=2`（别名 `Volumn`）`Gradual`

## Polygon3DStyle

`Wave=0` `LoopLine=1` `Gradual=2` `DynamicGradual=3` `WaveTransparent`

## HeatMapStyle

`Normal=-1` `CustomColor=0` 贴地 `CustomWave=1` 波形

## HydroDynamic2DStyle / WaterMode / WaterFlowFieldStyle

二维：`TrueWater=0` `HeatMap=1` `Flow=2`  
真实水：`Animation=0` `Simulation=1` `Arrow=2`  
流场：`HeatMap=0` `Water=1` `Particle=2`

## MapMode

`Campass=0` 罗盘 `SmallMap=1` 鹰眼 `BigMap=2` 大地图

## MeasurementMode

`Coordinate=1` 点 `Linear=2` 直线 `Horizontal=3` 水平 `Vertical=4` 垂直 `MultiPoint`…

## PanelType / UIPanelType

分析面板：`ViewshedAnalysis=0` `SkylineAnalysis=1` `ViewDomeAnalysis=2` `VisiblityAnalysis=3` `FloodFillAnalysis`…  
系统 UI：`MainUI=0` `NewACP=1` `OpenACP=2` `MergeACP=3` `SaveACP`…

## Viewport 掩码

`V1=1` `V2=2` `V3=4` `V4=8` `All`

## VehicleViewMode

`FirstPerson=0` `ThirdPerson=1`

## DroneTrailStyle

`None=0` `Cylinder=1` `Strip=2` `Dot_Dash_Line=3` `Square_Dash_Line`

## PlotStyle / SplineMeshStyle / OceanHeatMapStyle / VectorFieldStyle

标绘：`Polyline=0` `Circle=1` `Triangle=2` `Rectangle=3` `Polygon`  
路径模型：`Fence_1=0` `Fence_2=1` `Wall_1=2` `Wall_2=3` `Road_0`…  
海洋热力：`Arrow=0` `Flow=1` `Wave=2`  
向量场：`Typhoon="DTS_TPHOON"` `Waves="DTS_WAVE"` `Ocean="DTS_OCEAN"` `Fluid="DTS_STYLE_FLUID"`

## GeoJSON

`RendererType`：`Simple=0` `UniqueValue=1` `ClassBreaks=2` `Visible=3`  
`VisualType`：`Color=0`；Size/Height/Opacity 文档里都标 1（按字段语义用）  
`FieldType`：`String=0` `Number=1`

## BPFuncParamType（蓝图参数）

`Bool=0` `UInt8=1` `Int32=2` `Float=3` `Double`… 顺序、类型必须与蓝图一致。

## AssetType / 图层 type 字符串

数值：`EPT_Scene=1` `EPT_ModelActor=2` `EPT_Measurement=3` `EPT_Cut=4` `EPT_DynamicWater`  
infoTree.get 的 `type` 字段是字符串：`EPT_Folder` `EPT_Scene` `EPT_ModelActor`…

## ForwardAxis

`X=0` `Y=1` `Z=2`

## CloudStatus（左上角圆点）

`WS_Disconnected=0` 红  
`WS_Connecting=1` 灰  
`WS_Connected=2` 黄（WS 通，正在 WebRTC）  
`RTC_Opened=3` 蓝

## APIErrorCode

`OK=0` `InvalidParameters=1` `InternalError=2` `ResourceNotFound=3` `AcpProjWKTNotSet`…

## WSErrorCode

标准 WebSocket 关闭码。`1000` 正常；`1001` 离开；`1006` 异常断开。详见 global 页。

## 工具函数（包内）

`buildURL(url, params)` `get(url, options)` `post(url, data, options)` `request(config)`  
`SM3()` / `sm3Digest(msg)` 国密摘要。

## CommandType

内部命令枚举（tick_next 里用 `o.command` 判断是哪个接口返回）。不要在业务里拼 command 号，走 fdapi 方法。
