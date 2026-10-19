# Freedo DTS SDK 完整方法索引

官方文档：https://sdk.freedo3d.com/doc/

按类名检索。属性挂在 `fdapi.<属性>`。

## Antenna  (`fdapi.antenna`)
天线方向图对象，提供Antenna对象的操作方法 一般通过api.antenna调用
- `new Antenna ()`
- `add (data, fn)` — 添加一个或多个天线方向图对象
- `clear (fn)` — 清空场景中所有的天线方向图对象
- `delete (ids, fn)` — 删除一个或多个天线方向图对象
- `focus (ids, distance, flyTime, rotation, fn)` — 自动定位到合适的观察距离
- `get (ids, fn)` — 根据天线方向图ID获取天线方向图的详细信息
- `hide (ids, fn)` — 隐藏天线方向图
- `show (ids, fn)` — 显示天线方向图
- `update (data, fn)` — 修改一个或多个天线方向图对象
- `updateBegin ()` — 用于批量多次修改对象的属性
- `updateEnd (fn)` — 用于批量多次修改对象的属性，与updateBegin配套使用

## BaseObject
三维对象的父类
- `<protected> new BaseObject ()`
- `updateBegin ()` — 用于批量多次修改对象的属性
- `updateEnd (fn)` — 用于批量多次修改对象的属性，与updateBegin配套使用

## BattlefieldSimulation  (`fdapi.battlefieldSimulation`)
BattlefieldSimulation类，提供军事领域战场仿真对象相关的操作，包含装甲车、坦克、无人机、士兵等作战单元 一般通过api.battlefieldSimulation调用其方法
- `<protected> new BattlefieldSimulation ()`
- `add (battlefieldSimulation, fn)` — 初始化一个BattlefieldSimulation对象
- `delete (ids, fn)` — 删除一个或多个BattlefieldSimulation对象
- `focus (ids, distance, flyTime, rotation, distanceRotation, fn)` — 自动定位到合适的观察距离
- `update (battlefieldSimulation, fn)` — 更新一个时刻的BattlefieldSimulation对象
- `updateBegin ()` — 用于批量多次修改对象的属性
- `updateEnd (fn)` — 用于批量多次修改对象的属性，与updateBegin配套使用

## Beam  (`fdapi.beam`)
Beam相关的操作 一般通过api.beam调用其方法
- `<protected> new Beam ()`
- `add (data, fn)` — 添加一个或多个Beam对象
- `clear (fn)` — 删除场景中所有的Beam
- `delete (ids, fn)` — 删除一个或多个Beam对象
- `focus (ids, distance, flyTime, rotation, fn)` — 自动定位到合适的观察距离
- `get (ids, fn)` — 根据ID获取Beam的详细信息
- `hide (ids, fn)` — 隐藏Beam
- `hideAll (fn)` — 隐藏所有Beam
- `setColor (id, newVal, fn)` — 设置Color
- `setCoordinates (id, newVal, fn)` — 设置Coordinates
- `setDuration (id, newVal, fn)` — 设置Duration
- `setInterval (id, newVal, fn)` — 设置Interval
- `setThickness (id, newVal, fn)` — 设置Thickness
- `setVelocity (id, newVal, fn)` — 设置Velocity
- `show (ids, fn)` — 显示Beam
- `showAll (fn)` — 显示所有Beam
- `update (data, fn)` — 修改一个或多个Beam对象
- `updateBegin ()` — 用于批量多次修改对象的属性
- `updateEnd (fn)` — 用于批量多次修改对象的属性，与updateBegin配套使用

## BoxTrigger  (`fdapi.boxTrigger`)
BoxTrigger类的对象，提供当CustomObject对象或相机Camera对象进入和退出盒子热区范围触发事件相关的操作 一般通过api.BoxTrigger调用其方法
- `<protected> new BoxTrigger ()`
- `add (data, fn)` — 添加一个或多个BoxTrigger对象，当CustomObject对象或相机Camera对象进入和退出盒子热区范围触发事件相关的操作
- `clear (fn)` — 清空场景中所有的BoxTrigger对象
- `delete (ids, fn)` — 删除一个或多个BoxTrigger对象，注意：删除对象后热区和对应触发事件均会删除
- `updateBegin ()` — 用于批量多次修改对象的属性
- `updateEnd (fn)` — 用于批量多次修改对象的属性，与updateBegin配套使用

## Camera  (`fdapi.camera`)
Camera, 相机相关的操作 一般通过api.camera调用其方法
- `<protected> new Camera ()`
- `cancelFollow (fn)` — 取消相机自动跟随，支持取消CustomObject、Vehicle、Vehicle2、Train等对象的自动跟随
- `enterWorld (fn)` — 进入世界（三维场景），即从地球飞入到三维场景
- `exitWorld (fn)` — 退出世界（三维场景），即从三维场景飞入到地球
- `exportOrthoImage (path, imageSize, orthoWidth, location, rotation, backGroundColor, fn)` — 根据传入的参数导出相机位置对应的正交投影图片
- `flyAround (location, rotation, distance, time, fn)` — 相机环绕指定位置旋转一周
- `get (fn)` — 获取当前的相机位置
- `getAnimationImage (name, fn)` — 根据导览名称获取对应导览缩略图的base64字符串，默认图片格式png，尺寸：128*128
- `getAnimationList (fn)` — 获取当前acp里所有导览的信息
- `getEulerAngle (startPoint, endPoint)` — 根据空间两点计算欧拉角；**同步返回** `[Pitch,Yaw,Roll]`（没有 fn 回调、不发请求）
- `lockByBBox (bbox, fn)` — 锁定相机的交互范围，仅允许在BBox内交互
- `lookAt (x, y, z, distance, pitch, yaw, flyTime, fn)` — 通过观察点设置相机位置
- `lookAtBBox (bbox, pitch, yaw, flyTime, fn)` — 通过BBox设置相机
- `moveBackward (fn)` — 后退
- `moveDown (fn)` — 下降
- `moveForward (fn)` — 前进
- `moveLeft (fn)` — 左移
- `moveRight (fn)` — 右移
- `moveUp (fn)` — 上升
- `pauseAnimation (fn)` — 暂停播放动画导航
- `playAnimation (ids, mask, fn)` — 按传入索引序号的顺序播放一个或多个动画导览
- `resumeAnimation (fn)` — 恢复播放动画导航
- `set (x, y, z, pitch, yaw, flyTime, fn)` — 设置相机位置，这是最常见的参数形式，另外两种参数形式，请参考 二次开发：关于设置相机位置的三种形式
- `stop (fn)` — 停止
- `stopAnimation (fn)` — 停止播放动画导航
- `turnDown (fn)` — 低头
- `turnLeft (fn)` — 左转
- `turnRight (fn)` — 右转
- `turnUp (fn)` — 抬头
- `unlock (fn)` — 解锁相机的交互范围，恢复自由交互
- `useOldDataFormat (bUse)` — 设置是否使用旧版本的数据格式（2021.03.17之前的版本），这是一个全局的设置。

## CameraTour  (`fdapi.cameraTour`)
相机导览动画对象
- `<protected> new CameraTour ()` — Extends
- `add (data, fn)` — 创建一个或多个CameraTour对象
- `delete (ids, fn)` — 删除一个或多个CameraTour对象
- `exportVideo (id, path)` — 根据CameraTour的ID导出视频文件，注意：导出的视频文件默认格式为*.mp4，分辨率：1920X1080，帧速率：30
- `pause ()` — 暂停播放导览动画
- `play (id, fn)` — 开始播放导览动画
- `resume ()` — 恢复播放导览动画
- `setDuration (id, val, fn)` — 设置时间长度
- `setKeyFrames (id, val, fn)` — 设置导览动画关键帧
- `setMouseClickToPause (id, bool, fn)` — 设置播放导览时点击鼠标是否暂停
- `setName (id, val, fn)` — 设置名称
- `setTime (id, time, fn)` — 设置导览从某时刻开始播放
- `setUserData (id, val, fn)` — 设置用户数据
- `stop (fn)` — 停止播放导览动画
- `update (data, fn)` — 修改一个或多个CameraTour对象
- `updateBegin ()` — 用于批量多次修改对象的属性
- `updateEnd (fn)` — 用于批量多次修改对象的属性，与updateBegin配套使用

## CameraTourData
相机导览数据对象
- `new CameraTourData (id, name, keyFrames)` — 构造函数

## CameraTourKeyFrame
相机导览关键帧
- `new CameraTourKeyFrame (index, time, location, rotation)` — 构造函数

## Cesium3DTileset  (`fdapi.cesium3DTileset`)
Cesium3DTileset 相关的操作 一般通过api.cesium3DTileset调用其方法
- `new Cesium3DTileset ()` — protected
- `add (data, fn)` — 添加一个或多个Cesium3DTileset对象
- `clear (fn)` — 删除场景中所有的Cesium3DTileset
- `delete (ids, fn)` — 删除一个或多个Cesium3DTileset对象
- `focus (ids, distance, flyTime, rotation, fn)` — 自动定位到合适的观察距离
- `get (ids, fn)` — 根据ID获取Cesium3DTileset的详细信息
- `hide (ids, fn)` — 隐藏Cesium3DTileset
- `hideAll (fn)` — 隐藏所有Cesium3DTileset
- `setTileURL (id, newVal, fn)` — 设置URL
- `show (ids, fn)` — 显示Cesium3DTileset
- `showAll (fn)` — 显示所有Cesium3DTileset
- `update (data, fn)` — 修改一个或多个Cesium3DTileset对象
- `updateBegin ()` — 用于批量多次修改对象的属性
- `updateEnd (fn)` — 用于批量多次修改对象的属性，与updateBegin配套使用

## Coord  (`fdapi.coord`)
Coord, 坐标转换相关的操作 一般通过api.coord调用其方法
- `<protected> new Coord ()`
- `gcs2pcs (coordinates, coordinateType, fn)` — 地理坐标转投影坐标 请参考 二次开发：四种坐标的区别
- `pcs2gcs (coordinates, coordinateType, fn)` — 投影坐标转地理坐标 请参考 二次开发：四种坐标的区别
- `screen2World (x, y, fn)` — 屏幕坐标转为投影坐标 请参考 二次开发：四种坐标的区别
- `world2Screen (x, y, z, fn)` — 投影坐标转为屏幕坐标 请参考 二次开发：四种坐标的区别

## CustomMesh  (`fdapi.customMesh`)
CustomMesh类 一般通过api.customMesh调用其方法
- `<protected> new CustomMesh ()`
- `add (data, fn)` — 添加一个或多个CustomMesh对象
- `clear (fn)` — 删除场景中所有的CustomMesh
- `delete (ids, fn)` — 删除一个或多个CustomMesh对象
- `focus (ids, distance, flyTime, rotation, fn)` — 自动定位到合适的观察距离
- `get (ids, fn)` — 根据ID获取CustomMesh的详细信息
- `hide (ids, fn)` — 隐藏CustomMesh
- `setColor (id, newVal, fn)` — 设置颜色
- `setCoordinates (id, newVal, fn)` — 设置顶点坐标
- `setIndices (id, newVal, fn)` — 设置顶点索引
- `show (ids, fn)` — 显示CustomMesh
- `update (data, fn)` — 修改一个或多个CustomMesh对象

## CustomObject  (`fdapi.customObject`)
CustomObject类，提供用户自定义对象相关的操作 一般通过api.customObject调用其方法
- `<protected> new CustomObject ()`
- `add (data, fn)` — 添加一个或多个CustomObject对象
- `addByTileLayer (data, fn)` — 把TileLayer图层中包含的一个或多个(Actor)模型复制为一个CustomObject对象
- `callBPFunction (data, fn)` — 批量方法，调用多个CustomObject对象的多个蓝图函数
- `clear (fn)` — 删除场景中所有的CustomObject
- `delete (ids, fn)` — 删除一个或多个CustomObject对象
- `focus (ids, distance, flyTime, rotation, actionMode, offset, fn)` — 自动定位到合适的观察距离
- `get (ids, fn)` — 根据ID获取CustomObject的详细信息
- `getBPFunction (ids, fn)` — 根据自定义模型id查询自定义模型包含的蓝图函数信息
- `glow (data, fn)` — 闪烁
- `hide (ids, fn)` — 隐藏CustomObject
- `hideByGroupId (groupId, fn)` — 根据分组ID隐藏自定义对象自定义对象
- `highlight (ids, fn)` — 高亮
- `moveTo (data, fn)` — 设置CustomObject对象运动（根据实时获取的GPS数据运动）
- `overrideMaterial (data, fn)` — 替换CustomObject对象材质
- `pause (ids, fn)` — 暂停指定自定义对象按轨迹点移动
- `restoreMaterial (ids, fn)` — 恢复指定自定义对象的材质
- `resume (ids, fn)` — 恢复指定自定义对象按轨迹点移动
- `setLocalRotation (id, newVal, fn)` — 设置模型自身的旋转
- `setLocation (id, newVal, smoothTime, fn)` — 设置位置
- `setMoveRate (data, fn)` — 设置指定自定义对象对应的移动倍速
- `setRotation (id, newVal, fn)` — 设置世界坐标系旋转
- `setScale (id, newVal, fn)` — 设置缩放
- `setSmoothMotion (id, newVal, fn)` — 设置是平滑插值还是跳跃， 0：跳跃， 1：平滑差值
- `setSmoothTime (id, smoothTime, fn)` — 设置平滑移动的插值时间
- `setTintColor (ids, newColor, fn)` — 设置模型叠加颜色
- `setViewportVisible (id, vp, fn)` — 多视口状态下，设置CustomObject对象在各视口的可见性
- `show (ids, fn)` — 显示CustomObject
- `showByGroupId (groupId, fn)` — 根据分组ID显示自定义对象
- `showGrowth (data, fn)` — 模拟从3dt中复制的CustomObject对象的生长动画效果
- `startMove (id, coordinateType, pathPointArr, fn)` — 自定义对象按轨迹点移动
- `stop (ids, fn)` — 结束指定自定义对象按轨迹点移动
- `stopGlow (ids, fn)` — 停止闪烁
- `unHighlight (ids, fn)` — 取消高亮
- `update (data, fn)` — 修改一个或多个CustomObject对象
- `updateBegin ()` — 用于批量多次修改对象的属性
- `updateEnd (fn)` — 用于批量多次修改对象的属性，与updateBegin配套使用

## CustomTag  (`fdapi.customTag`)
CustomTag已停止更新，推荐使用功能更丰富的标注对象Marker
- `<protected> new CustomTag ()` — Deprecated:
- `add (data, fn)` — 添加一个或多个CustomTag对象
- `clear (fn)` — 删除场景中所有的CustomTag
- `delete (ids, fn)` — 删除一个或多个CustomTag对象
- `focus (ids, distance, flyTime, rotation, fn)` — 自动定位到合适的观察距离
- `focusAll (distance, flyTime, rotation, fn)` — 自动定位到能观察所有CustomTag对象的合适距离
- `get (ids, fn)` — 根据ID获取CustomTag的详细信息
- `hide (ids, fn)` — 隐藏CustomTag
- `hideAll (fn)` — 隐藏所有CustomTag
- `setAutoHidePopupWindow (id, newVal, fn)` — 设置是否自动关闭标签的弹出窗口
- `show (ids, fn)` — 显示CustomTag
- `showAll (fn)` — 显示所有CustomTag
- `update (data, fn)` — 修改一个或多个CustomTag对象
- `updateBegin ()` — 用于批量多次修改对象的属性
- `updateEnd (fn)` — 用于批量多次修改对象的属性，与updateBegin配套使用

## DaHuaVideoFusion  (`fdapi.daHuaVideoFusion`)
大华视频融合对象，提供DaHuaVideoFusion对象的操作方法 一般通过api.daHuaVideoFusion调用
- `new DaHuaVideoFusion ()`
- `add (data, fn)` — 添加一个或多个大华视频融合对象
- `clear (fn)` — 清空场景中所有的大华视频融合对象
- `delete (ids, fn)` — 删除一个或多个大华视频融合对象
- `focus (data, distance, flyTime, rotation, fn)` — 自动定位到合适的观察距离
- `get (ids, fn)` — 根据大华视频融合ID获取包含的摄像头列表
- `hide (data, fn)` — 隐藏大华视频融合对象内指定的摄像头列表
- `show (data, fn)` — 显示大华视频融合对象内指定的摄像头列表
- `update (data, fn)` — 修改一个或多个大华视频融合对象及包含的摄像头信息
- `updateBegin ()` — 用于批量多次修改对象的属性
- `updateEnd (fn)` — 用于批量多次修改对象的属性，与updateBegin配套使用

## Decal  (`fdapi.decal`)
Decal类，提供贴花相关的操作 一般通过api.decal调用其方法
- `<protected> new Decal ()`
- `add (data, fn)` — 添加一个或多个Decal对象
- `clear (fn)` — 删除场景中所有的Decal
- `delete (ids, fn)` — 删除一个或多个Decal对象
- `focus (ids, distance, flyTime, rotation, fn)` — 自动定位到合适的观察距离
- `focusAll (distance, flyTime, rotation, fn)` — 自动定位到能观察所有Decal对象的合适距离
- `get (ids, fn)` — 根据ID获取Decal的详细信息
- `update (data, fn)` — 修改一个或多个Decal对象
- `updateBegin ()` — 用于批量多次修改对象的属性
- `updateEnd (fn)` — 用于批量多次修改对象的属性，与updateBegin配套使用

## DigitalTwinAPI  (`fdapi`)
JS SDK的总类 一般通过全局变量 fdapi 来调用其接口。
- `new DigitalTwinAPI (host, options)` — 构造一个DigitalTwinAPI类的对象，用于API接口的初始化。
- `antenna` — 天线方向图对象，提供Antenna对象的操作方法
- `battlefieldSimulation` — BattlefieldSimulation类的对象，提供军事领域战场仿真对象相关的操作，包含装甲车、坦克、无人机、士兵等作战单元
- `beam` — Beam类的对象，提供光流相关的操作
- `boxTrigger` — BoxTrigger类的对象，提供当CustomObject对象或相机Camera对象进入和退出盒子热区范围触发事件相关的操作
- `camera` — Camera类的对象，提供相机相关的操作
- `cameraTour` — CameraTour相机导览动画类，提供相机导览动画操作方法
- `cesium3DTileset` — Cesium3DTileset类的对象，提供Cesium3DTileset的相关操作
- `coord` — Coord类的对象，提供坐标转换相关的操作
- `customMesh` — CustomMesh类的对象，提供自定义网格相关的操作
- `customObject` — CustomObject类的对象，提供用户自定义对象相关的操作
- `customTag` — CustomTag，提供对用户自定义标签相关的操作
- `daHuaVideoFusion` — DaHuaVideoFusion类的对象，提供大华视频融合相关的操作
- `decal` — Decal类的对象，提供贴花相关的操作
- `drone` — Drone类的对象，提供无人机对象相关的操作
- `dynamicWater` — DynamicWater类的对象，提供动态水的相关操作
- `editHelper` — EditHelper类的对象，提供编辑助手相关操作
- `excavationAnalysis` — 超欠挖分析类对象，提供超挖欠挖分析相关操作
- `finiteElement` — FiniteElement类的对象，提供有限元分析对象相关的操作
- `finiteElement2` — FiniteElement2类的对象，提供有限元仿真对象相关的操作，支持从VTK文件创建
- `floodFill` — FloodFill类的对象，提供水淹分析的相关操作
- `fluid` — Fluid类的对象，提供流体仿真对象相关的操作
- `gaussianSplatting` — GaussianSplatting类对象，提供3D高斯泼溅相关操作
- `geoJSONLayer` — GeoJSONLayer类的对象，提供GeoJSON类型图层符号化加载及相关操作
- `globeTerrain` — GlobeTerrain类的对象，提供对Cesium球面地形影像的相关操作
- `heatmap` — HeatMap类的对象，提供热力图相关的操作
- `heatmap3d` — HeatMap3D类的对象，提供三维热力图相关的操作
- `highlightArea` — HighlightArea类的对象，提供高亮区域相关的操作
- `hydrodynamic1d` — HydroDynamic1D类的对象，实现对一维水动力模型对象的操作接口
- `hydrodynamic2d` — HydroDynamic2D类的对象，实现对二维水动力模型对象的操作接口
- `hydrodynamicModel` — HydrodynamicModel类的对象，提供二维水动力模型相关的操作
- `hydrodynamicModel2` — HydrodynamicModel2类的对象，提供二维水动力模型相关的操作（过时版本待移除）
- `imageryLayer` — ImageryLayer类的对象，提供网络类型图层的相关操作
- `imageryLayer2` — ImageryLayer2类的对象，提供球面坐标系下网络图层服务的相关操作
- `infoTree` — InfoTree类的对象，提供图层相关的操作
- `light` — Light类的对象，实现对光源的操作接口
- `marker` — Marker类的对象，实现对标注的操作方法
- `marker3d` — Marker3D类的对象，实现对三维标注的操作方法
- `markerLayer` — MarkerLayer类的对象，提供MarkerLayer标记图层相关操作
- `misc` — Misc类的对象，提供一些杂项功能
- `oceanHeatmap` — OceanHeatMap类的对象，提供海洋热力图相关的操作
- `odline` — ODLine类的对象，提供迁徙线相关的操作
- `panorama` — Panorama类的对象，提供全景图相关的操作
- `plot` — 军事态势标绘对象，提供绘制作战态势图标的相关操作
- `polygon` — Polygon类的对象，提供多边形相关的操作
- `polygon3d` — Polygon3D类的对象，提供三维多边形相关的操作
- `polyline` — Polyline类的对象，提供线段相关的操作
- `radiationPoint` — RadiationPoint类的对象，提供辐射圈相关的操作
- `river` — River类的对象，实现对河道对象的操作接口
- `satellite` — Satellite类的对象，提供卫星仿真相关的操作
- `settings` — Settings类的对象，提供三维参数设置相关的接口
- `settingsPanel` — 设置面板对象，提供对设置面板里的参数进行操作的接口
- `shapeFileLayer` — ShapeFileLayer类的对象，提供ShapeFileLayer对象的相关操作
- `signalWave` — SignalWave类的对象，实现对信号波束的操作接口
- `smoothedParticleHydrodynamics` — SmoothedParticleHydrodynamics类的对象，实现对光滑粒子流体动力学对象的操作接口
- `splineMesh` — SplineMesh类的对象，提供绘制路径模型相关操作
- `tag` — Tag类的对象，实现标签对象的增、删、改、查相关的功能
- `tileLayer` — TileLayer类的对象，提供TileLayer增、删、改、查相关的功能
- `tools` — Tools类的对象，提供一些工具类的接口
- `topologyLine` — 拓扑线对象，提供绘制连接图层树上模型的拓扑线的相关操作
- `trafficSimulation` — TrafficSimulation类的对象，提供城市级交通仿真对象相关操作，支持十万级的城市车辆交通仿真。
- `train` — 火车对象，模拟火车移动
- `vectorField` — VectorField类的对象，提供向量场相关的操作
- `vehicle` — Vehicle类的对象，提供车辆载具对象相关的操作
- `vehicle2` — Vehicle2类的对象，提供车辆载具对象相关的操作 优化版本
- `videoProjection` — VideoProjection类的对象，提供视频投影相关的操作
- `waterFlowField` — WaterFlowField类的对象，提供流场相关的操作
- `waterMesh` — WaterMesh类的对象，提供水体网格相关的操作
- `weather` — Weather类的对象，提供天气相关的操作接口
- `checkApiReady ()` — 检查API调用是否就绪
- `destroy ()` — 关闭WebSocket连接
- `executeJsInTickPage (code, fn)` — 在tick页面里执行Javascript代码
- `getPlayer ()` — 获取DigitalTwinAPI所关联的DigitalTwinPlayer对象，如果只是纯接口调用，则返回null.
- `getProjectInfo ()` — 获取工程信息
- `getVersion ()` — 获取SDK的完整版本号，例如：5.3.0413
- `registerSyncObjects ()` — 注册要进行同步的对象
- `registerTick (url, options, fn)` — 注册每帧渲染时要执行的JS脚本
- `removeTick (fn)` — 移除每帧渲染时执行的JS脚本
- `reset (type, fn)` — 对三维场景执行重置操作
- `saveProject (fn)` — 保存场景（只保存场景设置，不保存接口创建的对象）
- `setEnableAliases ()` — 开启接口别名（不建议使用）
- `setEventCallback (fn)` — 设置三维事件（例如相机飞行开始、结束、Actor的点击等）的回调函数
- `setHost (ip, port)` — 设置主机地址
- `showTickWindow (visible, fn)` — 显示/隐藏tick调试窗口。 该方法既可以在客户端调用，也可以在tick调试窗口调用

## DigitalTwinPlayer  (Player)
- `new DigitalTwinPlayer (host, option)` — DigitalTwinPlayer类的构造函数
- `fullscreen :boolean` — 设置是否进入全屏状态，如果为true则全屏显示视频流，如果为false则退出全屏
- `fullscreen :boolean` — 获取当前是否处于全屏状态
- `destroy (reason)` — 销毁
- `getAPI ()` — 获取DigitalTwinAPI接口
- `getHost ()` — 获取服务器的地址（ip:port）
- `getInstanceInfo ()` — 获取当前所连接的实例信息
- `getVideoElement ()` — 获取用于播放Cloud视频流的video元素
- `getVideoElementSize ()` — 获取Video元素的尺寸
- `getVideoSize ()` — Deprecated:
- `getVideoStreamSize ()` — 获取视频流的尺寸
- `resize ()` — 重新调整布局
- `screen2World (x, y, fn)` — 屏幕坐标转为投影坐标 请参考 二次开发：四种坐标的区别 。
- `setActionEventEnabled (bEnable)` — 设置是否开启键盘、鼠标交互事件的回调功能
- `setEnableEventSync (bEnabled)` — 用于开关交互事件同步功能
- `<async> setInstanceOptions (o)` — 设置实例选项，调用此接口可以实现在不刷新页面的情况下切换使用的实例或工程文件
- `setKeyEventTarget (newVal)` — 设置键盘交互事件的目标对象
- `setResolution (w, h)` — 设置视频流的尺寸，如果云渲染后台启用了自适应，那么视频流的分辨率也会自动调整。 如果没有启用自适应，则调用不起作用。
- `<async> world2Screen (x, y, z, fn)` — 投影坐标转为屏幕坐标 请参考 二次开发：四种坐标的区别

## Drone  (`fdapi.drone`)
Drone类，提供无人机对象相关的操作 一般通过api.Drone调用其方法
- `<protected> new Drone ()`
- `add (data, fn)` — 添加一个或多个无人机对象
- `clear (fn)` — 清空场景中所有的无人机对象
- `delete (ids, fn)` — 删除一个或多个无人机对象
- `focus (ids, followEnable, distance, flyTime, viewPitch, viewYaw, sensitivity, offset, fn)` — 自动定位到合适的观察距离
- `get (ids, fn)` — 根据ID获取无人机对象的详细信息
- `hide (ids, fn)` — 隐藏一个或多个无人机对象
- `moveTo (data, fn)` — 设置无人机对象飞行移动
- `show (ids, fn)` — 显示一个或多个无人机对象
- `update (data, fn)` — 修改一个或多个无人机对象
- `updateBegin ()` — 用于批量多次修改对象的属性
- `updateEnd (fn)` — 用于批量多次修改对象的属性，与updateBegin配套使用

## DynamicWater  (`fdapi.dynamicWater`)
DynamicWater类，提供动态水面相关的操作 一般通过api.dynamicWater调用其方法
- `<protected> new DynamicWater ()` — Extends
- `add (data, fn)` — 添加一个或多个DynamicWater对象
- `clear (fn)` — 删除场景中所有的DynamicWater
- `delete (ids, fn)` — 删除一个或多个DynamicWater对象
- `focus (ids, distance, flyTime, rotation, fn)` — 自动定位到合适的观察距离
- `focusAll (distance, flyTime, rotation, fn)` — 自动定位到能观察所有DynamicWater对象的合适距离
- `get (ids, fn)` — 根据ID获取DynamicWater的详细信息
- `setCoordinates (id, newVal, fn)` — 设置DynamicWater的坐标信息
- `setStyle (id, newVal, fn)` — 设置动态水的样式
- `update (data, fn)` — 修改一个或多个DynamicWater对象
- `updateBegin ()` — 用于批量多次修改对象的属性
- `updateEnd (fn)` — 用于批量多次修改对象的属性，与updateBegin配套使用

## EditHelper  (`fdapi.editHelper`)
EditHelper类，提供用户手动绘制接口
- `<protected> new EditHelper ()`
- `cancel (fn)` — 取消绘制模式
- `finish (withOffset, fn)` — 绘制结束。调用此方法会结束当前的绘制，并在回调函数中返回绘制类型和坐标点，然后根据这些坐标点再创建相关的几何图形。
- `setParam (lineType, buildType, color, fn)` — 设置绘制参数
- `start (fn)` — 进入绘制模式

## ExcavationAnalysis  (`fdapi.excavationAnalysis`)
超欠挖分析类对象，提供超挖欠挖分析相关操作 一般通过api.excavationAnalysis调用其方法
- `<protected> new ExcavationAnalysis ()`
- `add (excavationAnalysis, fn)` — 添加一个ExcavationAnalysis对象
- `clear (fn)` — 删除场景中所有的ExcavationAnalysis
- `delete (ids, fn)` — 删除一个或多个ExcavationAnalysis对象
- `focus (ids, distance, flyTime, rotation, fn)` — 自动定位到合适的观察距离
- `get (ids, fn)` — 根据ID获取ExcavationAnalysis的详细信息
- `hide (ids, fn)` — 隐藏ExcavationAnalysis对象
- `show (ids, fn)` — 显示ExcavationAnalysis对象
- `update (excavationAnalysis, fn)` — 修改一个ExcavationAnalysis对象
- `updateBegin ()` — 用于批量多次修改对象的属性
- `updateEnd (fn)` — 用于批量多次修改对象的属性，与updateBegin配套使用

## FdExternal
FdExternal类封装了进程内JS与C++的互操作功能，用于以下几种场景： Explorer的WebUI页面里 Marker的弹出窗口页面 JSTick调试窗口页面 以上几种场景的共同点是都使用了cef显示html页面，在这些html页面里， 可以通过使用FdExternal类，直接调用底层C++功能，从而实现高性能、更直接的接口调用方式。
- `new FdExternal ()`
- `<static> close ()` — 用于关闭当前的窗口
- `<static> execute (json)` — 用于通过JSON的方式调用JS接口
- `<static> getData (key)` — 用于实现类似localStorage的功能
- `<static> getViewportSize ()` — 之所以增加此功能是因为 当WebUI 在某种情况下已加在页面但是内部的WebWidget组件尚未显示（被隐藏）的情况下，
- `<static> postEvent (msg)` — 用于向主页面发送事件通知
- `<static> setData (key, value)` — 用于实现类似localStorage的功能
- `<static> valid ()` — 检查是否在指定的环境里调用，FdExternal可以在以下环境调用：

## FiniteElement  (`fdapi.finiteElement`)
FiniteElement有限元分析对象，实现对有限元分析对象的操作 一般通过api.finiteElement调用其方法
- `new FiniteElement ()`
- `add (data, fn)` — 添加一个或多个有限元分析对象
- `clear (fn)` — 清空场景中所有的有限元分析对象
- `delete (ids, fn)` — 删除一个或多个有限元分析对象
- `focus (ids, distance, flyTime, rotation, fn)` — 自动定位到合适的观察距离
- `get (ids, fn)` — 根据有限元分析ID获取有限元分析的详细信息
- `hide (ids, fn)` — 隐藏有限元分析
- `show (ids, fn)` — 显示有限元分析
- `update (data, fn)` — 修改一个或多个有限元分析对象
- `updateBegin ()` — 用于批量多次修改对象的属性
- `updateEnd (fn)` — 用于批量多次修改对象的属性，与updateBegin配套使用

## FiniteElement2  (`fdapi.finiteElement2`)
FiniteElement2有限元仿真对象，实现对有限元仿真对象的操作 一般通过api.finiteElement2调用其方法
- `new FiniteElement2 ()`
- `add (data, fn)` — 根据VTK文件添加一个或多个有限元仿真对象
- `applyBoxClipFilter (data, fn)` — 盒子过滤器
- `applyContourFilter (data, fn)` — 根据等值线对应的数值添加过滤器并展示过滤后的有限元模型分析结果
- `applyCylinderClipFilter (data, fn)` — 圆柱过滤器
- `applyPlaneClipFilter (data, fn)` — 切面过滤器
- `applySphereClipFilter (data, fn)` — 球型过滤器
- `applyThresholdFilter (data, fn)` — 根据模型属性字段对应的区间值添加过滤器并展示过滤后的有限元模型分析结果
- `clear (fn)` — 清空场景中所有的有限元仿真对象
- `clearFilter (ids, fn)` — 清空指定的有限元模型对象添加的所有过滤器
- `delete (ids, fn)` — 删除一个或多个有限元仿真对象
- `focus (ids, distance, flyTime, rotation, fn)` — 自动定位到合适的观察距离
- `get (ids, fn)` — 根据有限元分析ID获取有限元分析的详细信息
- `hide (ids, fn)` — 隐藏有限元分析
- `removeFilter (data, fn)` — 移除指定的有限元模型对象添加的相关过滤器
- `show (ids, fn)` — 显示有限元分析
- `update (data, fn)` — 修改一个或多个有限元仿真对象
- `updateBegin ()` — 用于批量多次修改对象的属性
- `updateEnd (fn)` — 用于批量多次修改对象的属性，与updateBegin配套使用

## FloodFill  (`fdapi.floodFill`)
FloodFill 水淹分析相关的操作 一般通过api.floodFill调用其方法
- `new FloodFill ()` — protected
- `add (data, fn)` — 添加一个或多个FloodFill对象，
- `clear (fn)` — 删除场景中所有的FloodFill
- `delete (ids, fn)` — 删除一个或多个FloodFill对象
- `focus (ids, distance, flyTime, rotation, fn)` — 自动定位到合适的观察距离
- `get (ids, fn)` — 根据ID获取FloodFill的详细信息
- `hide (ids, fn)` — 隐藏FloodFill
- `hideAll (fn)` — 隐藏所有FloodFill
- `setColor (id, newVal, fn)` — 设置水颜色
- `setElevation (id, newVal, fn)` — 设置水位高度
- `setPrecision (id, newVal, fn)` — 设置水淹模拟精度
- `setRange (id, minArr, maxArr, fn)` — 设置水淹分析范围 注意：出水点[x,y]一定要在新设置的水淹分析范围[min~max]内
- `setSeed (id, newVal, fn)` — 设置出水点
- `show (ids, fn)` — 显示FloodFill
- `showAll (fn)` — 显示所有FloodFill
- `update (data, fn)` — 修改一个或多个FloodFill对象
- `updateBegin ()` — 用于批量多次修改对象的属性
- `updateEnd (fn)` — 用于批量多次修改对象的属性，与updateBegin配套使用

## Fluid  (`fdapi.fluid`)
Fluid流体仿真对象，实现对流体仿真对象的操作 一般通过api.fluid调用其方法
- `new Fluid ()`
- `add (data, fn)` — 添加一个或多个流体仿真对象
- `addSource (data, fn)` — 添加一个或多个流体仿真对象的源数据
- `clear (fn)` — 清空场景中所有的流体仿真对象
- `continue (ids, fn)` — 继续流体仿真
- `continueSource (data, fn)` — 继续仿真
- `delete (ids, fn)` — 删除一个或多个流体仿真对象
- `focus (ids, distance, flyTime, rotation, fn)` — 自动定位到合适的观察距离
- `get (ids, fn)` — 根据流体仿真ID获取流体仿真的详细信息
- `hide (ids, fn)` — 隐藏流体仿真
- `pause (ids, fn)` — 暂停流体仿真
- `removeSource (data, fn)` — 移除一个或多个流体仿真对象的源数据
- `reset (ids, fn)` — 重置流体仿真
- `show (ids, fn)` — 显示流体仿真
- `stopSource (data, fn)` — 停止仿真
- `update (data, fn)` — 修改一个或多个流体仿真对象
- `updateBegin ()` — 用于批量多次修改对象的属性
- `updateEnd (fn)` — 用于批量多次修改对象的属性，与updateBegin配套使用

## GaussianSplatting  (`fdapi.gaussianSplatting`)
GaussianSplatting类对象，提供3D高斯泼溅相关操作 一般通过api.gaussianSplatting调用其方法
- `<protected> new GaussianSplatting ()`
- `add (gaussianSplatting, fn)` — 添加一个GaussianSplatting对象
- `clear (fn)` — 删除场景中所有的GaussianSplatting
- `delete (ids, fn)` — 删除一个或多个GaussianSplatting对象
- `focus (ids, distance, flyTime, rotation, fn)` — 自动定位到合适的观察距离
- `get (ids, fn)` — 根据ID获取GaussianSplatting的详细信息
- `hide (ids, fn)` — 隐藏GaussianSplatting对象
- `show (ids, fn)` — 显示GaussianSplatting对象
- `update (gaussianSplatting, fn)` — 修改一个GaussianSplatting对象
- `updateBegin ()` — 用于批量多次修改对象的属性
- `updateEnd (fn)` — 用于批量多次修改对象的属性，与updateBegin配套使用

## GeoJSONLayer  (`fdapi.geoJSONLayer`)
GeoJSONLayer图层类，提供操作GeoJSONLayert图层符号化加载和操作相关的方法 一般通过api.geoJSONLayer调用其方法
- `new GeoJSONLayer ()` — protected
- `add (option, fn)` — 从GeoJSON文件或者url下载链接加载GeoJSON并进行符号化展示
- `clear (fn)` — 清空场景中所有的GeoJSONLayer图层对象
- `delete (ids, fn)` — 删除一个或多个GeoJSONLayer图层对象
- `focus (ids, distance, flyTime, rotation, fn)` — 自动定位到GeoJSONLayer图层对象
- `focusFeature (id, featureId, distance, flyTime, rotation, fn)` — 定位到GeoJSONLayer图层的某一块要素区域
- `hide (ids, fn)` — 隐藏一个或多个GeoJSONLayer图层对象
- `highlightFeature (id, featureId, fn)` — 高亮GeoJSONLayer图层对象内部的某一块要素区域
- `highlightFeatureByProperty (object, fn)` — 根据要素包含的属性字段名称和对应的值来高亮GeoJSONLayer图层对象内部对应的要素区域
- `highlightFeatures (data, fn)` — 高亮GeoJSONLayer图层对象内部的多块要素区域
- `setViewHeightRange (id, minViewHeight, maxViewHeight, fn)` — 设置GeoJSONLayer对象的可视高度范围，注意：当GeoJSONLayer使用贴地模式时，此方法会失效
- `show (ids, fn)` — 显示一个或多个GeoJSONLayer图层对象
- `unHighlightAllFeaturesById (ids, fn)` — 取消高亮一个或者多个GeoJSONLayer图层的所有高亮要素区域
- `unHighlightFeature (id, featureId, fn)` — 取消高亮GeoJSONLayer图层对象内部的某一块要素区域
- `unHighlightFeatureByProperty (object, fn)` — 根据要素包含的属性字段名称和对应的值来取消高亮GeoJSONLayer图层对象内部对应的要素区域
- `unHighlightFeatures (data, fn)` — 取消高亮GeoJSONLayer图层对象内部的多块要素区域
- `update (option, fn)` — 更新GeoJSONLayer图层对象的符号化显示效果
- `updateBegin ()` — 用于批量多次修改对象的属性
- `updateEnd (fn)` — 用于批量多次修改对象的属性，与updateBegin配套使用

## GlobeTerrain  (`fdapi.globeTerrain`)
GlobeTerrain类，包含球面坐标系下Cesium球面地形影像服务的相关操作方法 一般通过api.globeTerrain调用其方法
- `new GlobeTerrain ()` — protected
- `addImageryLayer (option, fn)` — 在Cesium球面上添加图层服务，支持的服务类型包含WMTS、WMS、MVT和TMS
- `addImageryLayerBySchemaParams (obj, fn)` — 根据自定义参数添加球面网络地图服务，如WMTS/WMS/MVT/TMS服务等网络图层服务
- `clearImageryLayer (fn)` — 清空Cesium球面上添加的所有图层服务
- `deleteImageryLayer (ids, fn)` — 删除Cesium球面上指定的图层服务
- `destroy (fn)` — 销毁Cesium球面的地形和影像
- `hide (fn)` — 隐藏Cesium球面的地形和影像
- `init (terrainUrl, imageryUrl, imageryResourceUrl, alpha, bConvertSRGB, fn)` — 初始化Cesium球面的地形和影像
- `setImagery (imageryUrl, imageryResourceUrl, fn)` — 设置更新初始化加载的影像服务
- `setImageryBySchemaParams (option, fn)` — 根据自定义参数的图层服务来更新初始化球面加载的影像服务，注意：替换初始化的影像服务应是全球影像服务地址
- `setImageryLayerDrawOrder (currentLayerId, targetLayerId, fn)` — 设置Cesium球面上添加的图层服务的绘制顺序，即移动当前图层到目标图层的上方位置显示
- `show (fn)` — 显示Cesium球面的地形和影像
- `updateBegin ()` — 用于批量多次修改对象的属性
- `updateEnd (fn)` — 用于批量多次修改对象的属性，与updateBegin配套使用

## HeatMap  (`fdapi.heatmap`)
HeatMap相关的操作 一般通过api.heatmap调用其方法。 HeatMap效果图如下：
- `<protected> new HeatMap ()`
- `addByHeatPoints (heatmap, fn)` — 根据热力点绘制热力图
- `addByTif (heatmap, fn)` — 根据tif文件加载热力图
- `addPoints (id, data, fn)` — 为HeatMap添加热力点
- `clear (fn)` — 删除场景中所有的HeatMap
- `delete (ids, fn)` — 删除一个或多个HeatMap对象
- `focus (ids, distance, flyTime, rotation, fn)` — 自动定位到合适的观察距离
- `get (ids, fn)` — 根据ID获取HeatMap的详细信息
- `hide (ids, fn)` — 隐藏HeatMap
- `highlightPixels (id, pixelCoords, fn)` — 高亮通过Tif文件加载的热力图中指定的像素点，注意：像素点数组的取值范围必须在Tif文件分辨率内
- `load (heatmap, fn)` — 预加载的热力图动画，包含多个Tif文件，加载后可以使用play()方法进行播放。
- `pause (id, fn)` — 暂停播放热力图动画
- `play (id, fn)` — 播放预加载的热力图动画
- `removePoints (id, pointIds, fn)` — 为HeatMap移除热力点
- `setBBox (id, newVal, fn)` — 设置BoundingBox 热力点坐标的范围
- `setRange (id, newVal, fn)` — 设置热力值的范围
- `setTime (id, startTime, fn)` — 从第几秒开始播放
- `show (ids, fn)` — 显示HeatMap
- `unHighlightAllPixels (id, fn)` — 取消热力图内所有像素点高亮
- `updateBegin ()` — 用于批量多次修改对象的属性
- `updateByHeatPoints (heatmap, fn)` — 更新热力图
- `updateEnd (fn)` — 用于批量多次修改对象的属性，与updateBegin配套使用

## HeatMap3D  (`fdapi.heatmap3d`)
HeatMap3D三维热力图相关的操作，三维热力图有以下几种构建方式： 1、根据16张空间图片构建 addByImages() 2、根据空间离散点和对应的热力值构建 addByHeatPoints() 3、根据三维体素的热力值构建 addByVoxels() 4、根据稀疏体素构建 addBySparseVoxels() 一般通过api.heatmap3d调用
- `<protected> new HeatMap3D ()`
- `addByHeatPoints (data, fn)` — 根据空间离散点和对应热力值构建三维热力图
- `addByImages (data, fn)` — 根据16张空间图片构建三维热力图
- `addBySparseVoxels (data, fn)` — 根据稀疏体素构建三维热力图
- `addByTif (data, fn)` — 根据tif文件构建三维热力图
- `addByVoxels (data, fn)` — 根据纯热力值构建三维热力图
- `addHeatPoints (data, fn)` — 动态往HeatMap3D对象内添加离散热力点，注意：仅支持空间离散点构造方法addByHeatPoints()
- `clear (fn)` — 清空场景中所有的HeatMap3D
- `delete (ids, fn)` — 删除一个或多个HeatMap3D对象
- `focus (ids, distance, flyTime, rotation, fn)` — 自动定位到合适的观察距离
- `get (ids, fn)` — 根据ID获取HeatMap3D的详细信息
- `hide (ids, fn)` — 隐藏HeatMap3D
- `load (data, fn)` — 预加载的三维热力图动画，包含多个Tif文件，加载后可以使用play()方法播放三维热力图动画。
- `pause (id, fn)` — 暂停播放三维热力图动画
- `play (id, fn)` — 播放预加载的三维热力图动画
- `queryVoxel (id, coordinate, fn)` — 根据ID和坐标位置获取对应HeatMap3D对象包含体素块的详细信息
- `setDisplayMode (id, displayMode, fn)` — 设置三维热力图的显示模式
- `setTime (id, startTime, fn)` — 从第几秒开始播放三维热力图动画
- `setViewportVisible (id, vp, fn)` — 设置HeatMap3D对象在进入多视口状态下视口可见性
- `show (ids, fn)` — 显示HeatMap3D
- `update (data, fn)` — 修改HeatMap3D
- `updateBegin ()` — 用于批量多次修改对象的属性
- `updateEnd (fn)` — 用于批量多次修改对象的属性，与updateBegin配套使用

## HighlightArea  (`fdapi.highlightArea`)
HighlightArea(高亮区域)相关的操作 一般通过api.highlightArea调用其方法
- `<protected> new HighlightArea ()`
- `add (data, fn)` — 添加一个或多个HighlightArea对象
- `clear (fn)` — 删除场景中所有的HighlightArea
- `delete (ids, fn)` — 删除一个或多个HighlightArea对象
- `focus (ids, distance, flyTime, rotation, fn)` — 自动定位到合适的观察距离
- `get (ids, fn)` — 根据ID获取HighlightArea的详细信息
- `hide (ids, fn)` — 隐藏HighlightArea
- `setColor (id, newVal, fn)` — 设置颜色
- `setCoordinates (id, newVal, fn)` — 设置坐标
- `setDepthTest (id, newVal, fn)` — 设置是否做深度检测
- `setHeightRange (id, newVal, fn)` — 设置高度范围
- `setIntensity (id, newVal, fn)` — 设置亮度
- `show (ids, fn)` — 显示HighlightArea
- `update (data, fn)` — 修改一个或多个HighlightArea对象
- `updateBegin ()` — 用于批量多次修改对象的属性
- `updateEnd (fn)` — 用于批量多次修改对象的属性，与updateBegin配套使用

## HydroDynamic1D  (`fdapi.hydrodynamic1d`)
HydroDynamic1D类 一般通过api.hydrodynamic1d调用其方法
- `<protected> new HydroDynamic1D ()`
- `add (data, fn)` — 添加一个或多个HydroDynamic1D对象
- `clear (fn)` — 删除场景中所有的HydroDynamic1D
- `delete (ids, fn)` — 删除一个或多个HydroDynamic1D对象
- `focus (ids, distance, flyTime, rotation, fn)` — 自动定位到合适的观察距离
- `get (ids, fn)` — 根据ID获取HydroDynamic1D的详细信息
- `hide (ids, fn)` — 隐藏HydroDynamic1D
- `show (ids, fn)` — 显示HydroDynamic1D
- `update (data, fn)` — 修改一个或多个HydroDynamic1D对象

## HydroDynamic2D  (`fdapi.hydrodynamic2d`)
二维水动力模型对象，基于真实数据驱动生成水动力模型，支持2种格式数据源：.tif文件（栅格） | .shp文件（矢量） 一般通过api.hydrodynamic2d调用其方法
- `<protected> new HydroDynamic2D ()`
- `addByShp (data, fn)` — 添加一个或多个HydroDynamic2D二维水动力模型对象，添加的数据源为(.shp)文件，注意：SHP文件必需是投影坐标系（PCS），同时单位是米。
- `addByTif (data, fn)` — 添加一个或多个HydroDynamic2D二维水动力模型对象，数据源为.tif文件。
- `clear (fn)` — 删除场景中所有的HydroDynamic2D
- `delete (ids, fn)` — 删除一个或多个HydroDynamic2D对象
- `focus (ids, distance, flyTime, rotation, fn)` — 自动定位到合适的观察距离
- `get (ids, fn)` — 根据ID获取HydroDynamic2D的详细信息
- `hide (ids, fn)` — 隐藏HydroDynamic2D
- `show (ids, fn)` — 显示HydroDynamic2D
- `update (data, fn)` — 修改一个或多个HydroDynamic2D对象

## HydrodynamicModel  (`fdapi.hydrodynamicModel`)
二维水动力模型对象，基于真实数据驱动生成水动力模型 一般通过api.HydrodynamicModel调用其方法
- `<protected> new HydrodynamicModel ()` — Deprecated:
- `add (data, fn)` — 添加一个或多个HydrodynamicModel二维水动力模型对象
- `clear (fn)` — 删除场景中所有的HydrodynamicModel
- `delete (ids, fn)` — 删除一个或多个HydrodynamicModel对象
- `focus (ids, distance, flyTime, rotation, fn)` — 自动定位到合适的观察距离
- `get (ids, fn)` — 根据ID获取HydrodynamicModel的详细信息
- `hide (ids, fn)` — 隐藏HydrodynamicModel
- `show (ids, fn)` — 显示HydrodynamicModel
- `update (data, fn)` — 修改一个或多个HydrodynamicModel对象

## HydrodynamicModel2  (`fdapi.hydrodynamicModel2`)
二维水动力模型对象，基于真实数据驱动生成水动力模型（过时版本待移除，推荐使用HydrodynamicModel对象） 一般通过api.HydrodynamicModel2调用其方法
- `<protected> new HydrodynamicModel2 ()` — Deprecated:
- `add (data, fn)` — 添加一个或多个HydrodynamicModel2二维水动力模型对象
- `clear (fn)` — 清空场景中所有的HydrodynamicModel2对象
- `delete (ids, fn)` — 删除一个或多个HydrodynamicModel2对象
- `focus (ids, distance, flyTime, rotation, fn)` — 自动定位到合适的观察距离
- `get (ids, fn)` — 根据ID获取HydrodynamicModel2对象的详细信息
- `hide (ids, fn)` — 隐藏HydrodynamicModel2对象
- `pause (data, fn)` — 暂停播放
- `resume (data, fn)` — 恢复播放
- `setTime (data, fn)` — 设置HydrodynamicModel2对象的当前播放时刻
- `show (ids, fn)` — 显示HydrodynamicModel2对象
- `startPlay (data, fn)` — 开始从某时刻播放
- `stopPlay (data, fn)` — 停止播放
- `update (data, fn)` — 修改一个或多个HydrodynamicModel2对象

## ImageryLayer  (`fdapi.imageryLayer`)
ImageryLayer 网络图层相关的操作方法，包含WMS、WMTS、MapServer等服务类型 一般通过api.imageryLayer调用其方法
- `new ImageryLayer ()` — protected
- `<async> add (data, fn)` — 添加一个或多个网络地图服务，如WMTS/WMS服务等网络图层服务
- `addVTPK (tileLayerId, fn)` — 给图层服务叠加显示对应VTPK标注
- `delete (ids, fn)` — 删除一个或多个ImageryLayer图层对象
- `deleteVTPK (tileLayerId, fn)` — 删除叠加的VTPK标注
- `focus (ids, distance, flyTime, rotation, fn)` — 自动定位到合适的观察距离
- `hide (ids, fn)` — 隐藏一个或多个ImageryLayer图层对象
- `init (option, fn)` — 添加图层服务前需要先初始化相关参数
- `setDrawBottom (id, fn)` — 设置ImageryLayer图层置底显示
- `setDrawOrder (currentLayerId, targetLayerId, fn)` — 设置两个ImageryLayer图层的绘制顺序，即移动当前ImageryLayer图层到目标ImageryLayer图层的上方位置显示
- `setDrawTop (id, fn)` — 设置ImageryLayer图层置顶显示
- `setVTPKVisable (tileLayerId, visible, fn)` — 设置叠加的VTPK标注可见性
- `show (ids, fn)` — 显示一个或多个ImageryLayer图层对象
- `updateBegin ()` — 用于批量多次修改对象的属性
- `updateEnd (fn)` — 用于批量多次修改对象的属性，与updateBegin配套使用

## ImageryLayer2  (`fdapi.imageryLayer2`)
ImageryLayer2 球面坐标系下加载网络图层服务 目前支持WMTS、WMS、MVT和TMS 一般通过api.ImageryLayer2调用其方法
- `new ImageryLayer2 ()` — protected
- `addBySchemaParams (data, fn)` — 根据图层服务的自定义参数添加一个或多个球面网络地图服务，如WMTS/WMS/MVT/TMS服务等网络图层服务
- `addByUrl (data, fn)` — 根据图层服务url包含的切片方案xmlPath添加一个或多个球面网络地图服务，如WMTS/WMS/MVT/TMS服务等网络图层服务
- `clear (fn)` — 清除场景中所有的网络图层对象
- `delete (ids, fn)` — 删除一个或多个ImageryLayer2图层对象
- `hide (ids, fn)` — 隐藏一个或多个ImageryLayer2图层对象
- `hideAll (fn)` — 隐藏所有ImageryLayer2图层对象
- `setDrawOrder (currentLayerId, targetLayerId, fn)` — 设置两个ImageryLayer2图层的绘制顺序，即移动当前ImageryLayer2图层到目标ImageryLayer2图层的上方位置显示
- `show (ids, fn)` — 显示一个或多个ImageryLayer2图层对象
- `showAll (fn)` — 显示所有ImageryLayer2图层对象
- `updateBegin ()` — 用于批量多次修改对象的属性
- `updateEnd (fn)` — 用于批量多次修改对象的属性，与updateBegin配套使用

## InfoTree  (`fdapi.infoTree`)
Layers, 图层树相关的操作 一般通过api.infoTree调用其方法
- `<protected> new InfoTree ()`
- `callBPFunction (data, fn)` — 调用图层树上对象包含的多个蓝图函数，注意：可以根据图层树上的对象id查询包含的所有蓝图函数 fdapi.misc.getBPFunction(id);
- `deleteByGroupId (groupId, fn)` — 通过GroupId删除各类API创建的对象
- `disableXRay (ids, fn)` — 禁用X光
- `enableXRay (ids, color, fn)` — 启用X光
- `focus (ids, fn)` — 自动定位到合适的观察距离
- `get (fn)` — 获取图层树信息
- `getBPFunction (ids, fn)` — 根据图层树对象ID查询其包含的蓝图函数信息，注意：支持批量查询
- `hide (ids, fn)` — 隐藏图层
- `hideByGroupId (groupId, fn)` — 通过GroupId隐藏各类API创建的对象
- `highlightByGroupId (groupId, fn)` — 通过GroupId高亮各类API创建的对象
- `setVisibility (data, fn)` — 设置图层的可见性
- `show (ids, fn)` — 显示图层
- `showByGroupId (groupId, fn)` — 通过GroupId显示各类API创建的对象

## Light  (`fdapi.light`)
Light光源对象，实现对光源对象的操作 一般通过api.light调用其方法
- `new Light ()`
- `add (data, fn)` — 添加一个或多个光源对象 注意：当批量添加多个光源时，渲染阴影效果会非常耗性能，建议默认关闭
- `clear (fn)` — 清空场景中所有的光源对象
- `delete (ids, fn)` — 删除一个或多个光源对象
- `focus (ids, distance, flyTime, rotation, fn)` — 自动定位到合适的观察距离
- `get (ids, fn)` — 根据光源ID获取光源的详细信息
- `hide (ids, fn)` — 隐藏光源
- `hideAll (fn)` — 隐藏所有光源
- `show (ids, fn)` — 显示光源
- `showAll (fn)` — 显示所有光源
- `update (data, fn)` — 修改一个或多个光源对象，支持更新以下属性：
- `updateBegin ()` — 用于批量多次修改对象的属性
- `updateEnd (fn)` — 用于批量多次修改对象的属性，与updateBegin配套使用

## Marker  (`fdapi.marker`)
标注点，实现对标注对象的操作 一般通过api.marker调用其方法 Marker标注点的效果图：
- `new Marker ()`
- `add (data, fn)` — 添加一个或多个标注点 调用时注意：单次创建的Marker对象数量不要超过5000个，在一个工程内创建的Marker对象总数量不要超过20万个。
- `clear (fn)` — 删除场景中所有的标注
- `delete (ids, fn)` — 删除一个或多个标注对象
- `deleteByGroupId (groupIds, fn)` — 根据分组ID删除Marker
- `focus (ids, distance, flyTime, rotation, fn)` — 自动定位到合适的观察距离
- `focusAll (distance, flyTime, rotation, fn)` — 自动定位到能观察所有Marker对象的合适距离
- `get (ids, fn)` — 根据ID获取标注的详细信息
- `hide (ids, fn)` — 隐藏标注
- `hideAll (fn)` — 隐藏所有标注
- `hideAllPopupWindow (fn)` — 隐藏所有标注的弹出窗口
- `hideByGroupId (groupIds, fn)` — 根据分组ID隐藏Marker
- `hidePopupWindow (ids, fn)` — 隐藏指定标注的弹出窗口
- `setAnchors (id, newVal, fn)` — 设置标注的整体偏移量（修改锚点）
- `setAttachMovingObject (data, fn)` — 设置Marker贴合模型对象进行移动，设置贴合后Marker会跟随模型一起平滑运动，支持的对象类型：CustomObject、Vehicle、Vehicle2、Train、Drone
- `setAutoHidePopupWindow (id, newVal, fn)` — 设置是否自动关闭标注的弹出窗口
- `setClusterStyle (style, fn)` — 设置marker聚合样式
- `setCoordinate (id, newVal, fn)` — 设置标注的位置
- `setFontColor (id, newVal, fn)` — 设置标注文本颜色
- `setFontOutlineColor (id, newVal, fn)` — 设置字体轮廓线颜色
- `setFontOutlineSize (id, newVal, fn)` — 设置字体轮廓线大小
- `setFontSize (id, newVal, fn)` — 设置字体大小
- `setGroupId (id, newVal, fn)` — 设置分组
- `setHoverImagePath (id, newVal, fn)` — 设置鼠标悬停时显示的图片路径
- `setImagePath (id, newVal, fn)` — 设置标注的图片
- `setImageSize (id, newVal, fn)` — 设置标注图片的大小
- `setLineColor (id, newVal, fn)` — 设置LineColor
- `setLineOffset (id, newVal, fn)` — 设置LineOffset
- `setLineSize (id, newVal, fn)` — 设置LineSize
- `setOcclusionCull (id, newVal, fn)` — 设置是否参与遮挡剔除
- `setPopupOffset (id, newVal, fn)` — 设置弹窗偏移: [x, y]
- `setPopupSize (id, newVal, fn)` — 设置弹窗大小: [width, height]
- `setPopupURL (id, newVal, fn)` — 设置弹窗HTML链接
- `setPriority (id, newVal, fn)` — 设置避让优先级
- `setRange (id, newVal, fn)` — 设置标注的可见范围
- `setText (id, newVal, fn)` — 设置标注的文本
- `setTextBackgroundColor (id, newVal, fn)` — 设置标注文本的背景颜色
- `setTextOffset (id, newVal, fn)` — 设置文本偏移
- `setTextRange (id, newVal, fn)` — 设置文本可视范围: [近裁距离, 远裁距离]
- `setURL (id, newVal, fn)` — 设置标注的URL
- `setUserData (id, newVal, fn)` — 设置用户数据
- `setViewportVisible (id, vp, fn)` — 多视口状态下，设置Marker对象在各视口的可见性
- `show (ids, fn)` — 显示标注
- `showAll (fn)` — 显示所有标注
- `showAllPopupWindow (fn)` — 显示所有标注的弹出窗口
- `showByGroupId (groupIds, fn)` — 根据分组ID显示Marker
- `showPopupWindow (ids, fn)` — 显示指定标注的弹出窗口
- `update (data, fn)` — 修改一个或多个标注对象
- `updateBegin ()` — 用于批量多次修改对象的属性
- `updateEnd (fn)` — 用于批量多次修改对象的属性，与updateBegin配套使用

## Marker3D  (`fdapi.marker3d`)
动态标记，实现对3D标注对象的操作 一般通过api.marker3d调用其方法
- `new Marker3D ()`
- `add (data, fn)` — 添加一个或多个动态标记
- `callBPFunction (data, fn)` — 调用Marker3D对象包含的多个蓝图函数，注意：可以根据marker3d的对象id查询包含的所有蓝图函数 fdapi.misc.getBPFunction(id);
- `clear (fn)` — 清空场景中所有的3D标注
- `delete (ids, fn)` — 删除一个或多个3D标注对象
- `deleteByGroupId (groupId, fn)` — 根据分组ID删除动态标注
- `focus (ids, distance, flyTime, rotation, fn)` — 自动定位到合适的观察距离
- `get (ids, fn)` — 根据ID获取3D标注的详细信息
- `getBPFunction (ids, fn)` — 根据marker3d对象的id查询其包含的蓝图函数信息
- `hide (ids, fn)` — 隐藏3D标注
- `hideAll (fn)` — 隐藏所有3D标注
- `hideByGroupId (groupId, fn)` — 根据分组ID隐藏动态标注
- `setAttachCustomObject (data, fn)` — 设置Marke3D贴合模型对象CustomObject对象，设置后Marker3D会跟随模型运动
- `setViewHeightRange (id, minVisibleHeight, maxVisibleHeight, fn)` — 设置Marker3D对象的可视高度范围
- `show (ids, fn)` — 显示3D标注
- `showAll (fn)` — 显示所有3D标注
- `showByGroupId (groupId, fn)` — 根据分组ID显示动态标注
- `update (data, fn)` — 修改一个或多个3D标注对象
- `updateBegin ()` — 用于批量多次修改对象的属性
- `updateEnd (fn)` — 用于批量多次修改对象的属性，与updateBegin配套使用

## MarkerLayer  (`fdapi.markerLayer`)
标注图层对象：一共分三个层级，第三层级为圆形标记点，第二层级为标记图片，第一层级为标注Marker 一般通过api.markerLayer调用其方法 MarkerLayer标注点的效果图：
- `new MarkerLayer ()`
- `add (data, fn)` — 添加一个或多个标注图层服务对象
- `clear (fn)` — 删除场景中所有的标注图层对象
- `delete (ids, fn)` — 删除一个或多个标注图层对象
- `focus (ids, distance, flyTime, rotation, fn)` — 自动定位到合适的观察距离
- `focusByMarkerId (id, markerId, distance, flyTime, rotation, fn)` — 自动定位到内部标记点合适的观察距离
- `hide (ids, fn)` — 隐藏标注图层对象
- `hideAll (fn)` — 隐藏所有标注图层对象
- `setViewHeightRange (id, minViewHeight, maxViewHeight, fn)` — 设置标注图层对象的可视高度范围
- `show (ids, fn)` — 显示标注图层对象
- `showAll (fn)` — 显示所有标注图层对象
- `update (data, fn)` — 修改一个或多个标注图层对象
- `updateBegin ()` — 用于批量多次修改对象的属性
- `updateEnd (fn)` — 用于批量多次修改对象的属性，与updateBegin配套使用

## Misc  (`fdapi.misc`)
Misc类，提供一些杂项功能 一般通过api.misc调用其方法
- `<protected> new Misc ()`
- `addAnimatedImageButtons (data, fn)` — 添加动画按钮
- `addImageButtons (data, fn)` — 添加图片按钮
- `callBPFunction (data, fn)` — 调用整个渲染场景内指定的蓝图函数 注意：调用前请先确认被调用的蓝图函数已存在，并和设计蓝图函数的开发人员沟通确认相关参数取值后再调用
- `deleteImageButtons (ids, fn)` — 删除动画按钮
- `enterMultiViewportMode (viewportMode, lineColor, lineSize, fn)` — 进入多视口模式
- `enterReportMode (fn)` — 进入汇报演示模式
- `exitMultiViewportMode (fn)` — 退出多视口模式
- `exitReportMode (fn)` — 退出汇报演示模式
- `getActiveViewport (fn)` — 查询当前激活的视口信息
- `getBPFunction (assetPath, fn)` — 根据模型Actor路径或者对象id查询模型包含的蓝图函数信息，支持查询单个模型和多个模型包含的蓝图函数信息
- `getConvexPolygon (pointArray, fn)` — 从一组离散点中获取凸多边形的顶点索引
- `getMaterial (materialPath, fn)` — 根据材质路径查询材质包含的图片纹理和材质参数信息，同时支持查询单个材质和多个材质包含的信息
- `hideAllFoliages (fn)` — 隐藏Explorer里创建的植物
- `isApiVersionMatched ()` — 判断JS-API的版本和云渲染服务器的接口版本是否一致
- `playMovie (url, loop, fn)` — 全屏播放影片（播放过程中会暂停三维渲染以提高性能）
- `playVideo (id, x, y, width, height, url, fn)` — 播放视频（显示播放窗口）
- `playVideoAlone (url, options, fn)` — 在独立的进程播放视频，注意：此接口仅在基于Explorer进行二次开发时生效
- `projectAssetCount (type, fn)` — 统计ACP工程包含各类资产信息
- `projectAssetCountAll (fn)` — 统计ACP工程包含的全部资产信息
- `reloadPak (fn)` — 从Cloud的文件资源配置中重新挂载新添加的pak文件，避免重启服务引起的实例关闭
- `setActiveViewport (index, fn)` — 激活一个或多个视口，注意：仅在多视口模式下生效
- `setApiVersionReceived (fnCallback)` — 设置服务器返回版本号的回调函数
- `setMultiviewportInteractSync (isSync, fn)` — 多视口模式下设置相机是否同步
- `showAllFoliages (fn)` — 显示Explorer里创建的植物
- `stopMovie (fn)` — 停止全屏播放影片
- `stopPlayVideo (id, fn)` — 停止播放视频（播放窗口会消失）
- `stopPlayVideoAlone (id, fn)` — 停止在独立的进程播放视频，注意：此接口仅在基于Explorer进行二次开发时生效
- `switchShortcutKey (onOff, fn)` — 控制Explorer快捷键的开关，注意：仅针对explorer下webui开发方式生效

## ODLine  (`fdapi.odline`)
ODLine 迁徙线相关的操作 一般通过api.odline调用其方法，效果图如下： 迁徙线样式参数示例
- `new ODLine ()` — protected
- `add (data, fn)` — 添加一个或多个ODLine对象
- `clear (fn)` — 删除场景中所有的ODLine
- `delete (ids, fn)` — 删除一个或多个ODLine对象
- `focus (ids, distance, flyTime, rotation, fn)` — 自动定位到合适的观察距离
- `get (ids, fn)` — 根据ID获取ODLine的详细信息
- `hide (ids, fn)` — 隐藏ODLine
- `hideAll (fn)` — 隐藏所有ODLine
- `setBendDegree (id, newVal, fn)` — 设置新的弯曲度
- `setBrightness (id, newVal, fn)` — 设置新的亮度
- `setColor (id, newVal, fn)` — 设置新的颜色值
- `setCoordinates (id, newVal, fn)` — 设置坐标值
- `setEndLabelShape (id, newVal, fn)` — 设置EndLabel样式
- `setEndPointShape (id, newVal, fn)` — 设置EndPoint样式
- `setflowPointSizeScale (id, newVal, fn)` — 设置运动点的缩放
- `setFlowRate (id, newVal, fn)` — 设置新的流速
- `setFlowShape (id, newVal, fn)` — 设置ODLine发光点样式
- `setLabelSizeScale (id, newVal, fn)` — 设置两端点的缩放值
- `setLineShape (id, newVal, fn)` — 设置ODLine模型样式
- `setLineStyle (id, newVal, fn)` — 设置ODLine材质样式
- `setLineThickness (id, newVal, fn)` — 设置线的厚度
- `setStartLabelShape (id, newVal, fn)` — 设置StartLabel样式
- `setStartPointShape (id, newVal, fn)` — 设置StartPoint样式
- `setTiling (id, newVal, fn)` — 设置材质贴图平铺
- `show (ids, fn)` — 显示ODLine
- `showAll (fn)` — 显示所有ODLine
- `update (data, fn)` — 修改一个或多个ODLine对象
- `updateBegin ()` — 用于批量多次修改对象的属性
- `updateEnd (fn)` — 用于批量多次修改对象的属性，与updateBegin配套使用

## OceanHeatMap  (`fdapi.oceanHeatmap`)
海洋热力图对象，基于真实海洋数据驱动生成热力图，数据源格式：.tif文件 一般通过api.oceanHeatmap调用其方法
- `<protected> new OceanHeatMap ()`
- `add (data, fn)` — 添加一个或多个OceanHeatMap海洋热力图对象，数据源为.tif文件。
- `clear (fn)` — 删除场景中所有的OceanHeatMap
- `delete (ids, fn)` — 删除一个或多个OceanHeatMap对象
- `focus (ids, distance, flyTime, rotation, fn)` — 自动定位到合适的观察距离
- `get (ids, fn)` — 根据ID获取OceanHeatMap的详细信息
- `hide (ids, fn)` — 隐藏OceanHeatMap
- `show (ids, fn)` — 显示OceanHeatMap
- `update (data, fn)` — 修改一个或多个OceanHeatMap对象

## Panorama  (`fdapi.panorama`)
Panorama类，提供全景图相关的操作 一般通过api.panorama调用其方法
- `<protected> new Panorama ()`
- `add (data, fn)` — 添加一个或多个Panorama全景图对象
- `clear (fn)` — 清空场景中所有的Panorama
- `delete (ids, fn)` — 删除一个或多个Panorama对象
- `enter (id, fn)` — 进入全景图模式
- `exit (fn)` — 退出全景图模式
- `focus (ids, distance, flyTime, rotation, fn)` — 自动定位到合适的观察距离
- `get (ids, fn)` — 根据ID获取Panorama的详细信息
- `switchMode (fn)` — 切换显示模式，即全景图模式和三维场景模式切换
- `update (data, fn)` — 修改一个或多个Panorama对象
- `updateBegin ()` — 用于批量多次修改对象的属性
- `updateEnd (fn)` — 用于批量多次修改对象的属性，与updateBegin配套使用

## Plot  (`fdapi.plot`)
军事态势标绘对象，提供绘制作战态势图标的相关操作 一般通过api.plot调用其方法
- `<protected> new Plot ()`
- `add (data, fn)` — 添加一个Plot对象
- `clear (fn)` — 删除场景中所有的Plot
- `delete (ids, fn)` — 删除一个或多个Plot对象
- `focus (ids, distance, flyTime, rotation, fn)` — 自动定位到合适的观察距离
- `get (ids, fn)` — 根据ID获取Plot的详细信息
- `hide (ids, fn)` — 隐藏Plot对象
- `hideAll (fn)` — 隐藏所有Plot对象
- `show (ids, fn)` — 显示Plot对象
- `showAll (fn)` — 显示所有Plot对象
- `update (data, fn)` — 修改一个Plot对象
- `updateBegin ()` — 用于批量多次修改对象的属性
- `updateEnd (fn)` — 用于批量多次修改对象的属性，与updateBegin配套使用

## Polygon  (`fdapi.polygon`)
Polygon 相关的操作， 一般通过api.polygon调用其方法 下面Example代码的运行效果图：
- `<protected> new Polygon ()`
- `add (data, fn)` — 添加一个或多个Polygon对象
- `clear (fn)` — 删除场景中所有的Polygon
- `delete (ids, fn)` — 删除一个或多个Polygon对象
- `focus (ids, distance, flyTime, rotation, fn)` — 自动定位到合适的观察距离
- `get (ids, fn)` — 根据ID获取Polygon的详细信息
- `glow (ids, duration, fn)` — 闪烁
- `hide (ids, fn)` — 隐藏Polygon
- `highlight (ids, fn)` — 高亮
- `setColor (id, newVal, fn)` — 设置颜色
- `setCoordinates (id, newVal, fn)` — 设置坐标
- `setDepthTest (id, newVal, fn)` — 设置是否做深度检测
- `setViewHeightRange (id, minViewHeight, maxViewHeight, fn)` — 设置Polygon对象的可视高度范围，注意：当Polygon对象使用贴地模式时，此方法会失效
- `show (ids, fn)` — 显示Polygon
- `unHighlight (ids, fn)` — 停止高亮
- `update (data, fn)` — 修改一个或多个Polygon对象
- `updateBegin ()` — 用于批量多次修改对象的属性
- `updateEnd (fn)` — 用于批量多次修改对象的属性，与updateBegin配套使用

## Polygon3D  (`fdapi.polygon3d`)
Polygon3D类， 提供三维多边形相关的操作， 一般通过api.polygon3d调用其方法，效果图： 下面Example代码的运行效果图：
- `<protected> new Polygon3D ()`
- `add (data, fn)` — 添加一个或多个Polygon3D对象
- `clear (fn)` — 删除场景中所有的3DPolygon
- `delete (ids, fn)` — 删除一个或多个3DPolygon对象
- `disableClip (ids, fn)` — 禁止Polygon3D参与剖切
- `enableClip (ids, fn)` — 设置Polygon3D参与剖切
- `focus (ids, distance, flyTime, rotation, fn)` — 自动定位到合适的观察距离
- `get (ids, fn)` — 根据ID获取3DPolygon的详细信息
- `glow (data)` — 闪烁
- `hide (ids, fn)` — 隐藏3DPolygon
- `hideAll (fn)` — 隐藏所有3DPolygon
- `highlight (ids, fn)` — 高亮，目前仅部分样式支持高亮，和材质有关
- `setColor (id, newColor, fn)` — 设置颜色
- `setCoordinates (id, newVal, fn)` — 设置坐标
- `setDepthTest (id, newVal, fn)` — 设置是否做深度检测
- `setHeight (id, newVal, fn)` — 设置高度
- `setIntensity (id, newVal, fn)` — 设置亮度
- `setStyle (id, newVal, fn)` — 设置样式
- `setTillingX (id, newVal, fn)` — 设置TillingX
- `setTillingY (id, newVal, fn)` — 设置TillingY
- `setViewHeightRange (id, minViewHeight, maxViewHeight, fn)` — 设置Polygon3D对象的可视高度范围
- `show (ids, fn)` — 显示3DPolygon
- `showAll (fn)` — 显示所有3DPolygon
- `stopGlow (ids, fn)` — 停止闪烁
- `unHighlight (ids, fn)` — 停止高亮
- `update (data, fn)` — 修改一个或多个3DPolygon对象
- `updateBegin ()` — 用于批量多次修改对象的属性
- `updateEnd (fn)` — 用于批量多次修改对象的属性，与updateBegin配套使用

## Polyline  (`fdapi.polyline`)
Polyline 相关的操作 一般通过api.polyline调用其方法
- `new Polyline ()` — protected
- `add (data, fn)` — 添加一个或多个Polyline对象
- `clear (fn)` — 删除场景中所有的Polyline
- `delete (ids, fn)` — 删除一个或多个Polyline对象
- `focus (ids, distance, flyTime, rotation, fn)` — 自动定位到合适的观察距离
- `get (ids, fn)` — 根据ID获取Polyline的详细信息
- `hide (ids, fn)` — 隐藏Polyline
- `hideAll (fn)` — 隐藏所有Polyline
- `setBrightness (id, newVal, fn)` — 设置新的亮度
- `setColor (id, newVal, fn)` — 设置新的颜色值
- `setCoordinates (id, newVal, fn)` — 设置坐标值
- `setDepthTest (id, newVal, fn)` — 设置是否做深度检测
- `setFlowRate (id, newVal, fn)` — 设置新的流速
- `setShape (id, newVal, fn)` — 设置shape新的样式
- `setStyle (id, newVal, fn)` — 设置新的样式
- `setThickness (id, newVal, fn)` — 设置新的厚度
- `setViewHeightRange (id, minViewHeight, maxViewHeight, fn)` — 设置Polyline对象的可视高度范围，注意：当Polyline对象使用贴地模式时，此方法会失效
- `show (ids, fn)` — 显示Polyline
- `showAll (fn)` — 显示所有Polyline
- `update (data, fn)` — 修改一个或多个Polyline对象
- `updateBegin ()` — 用于批量多次修改对象的属性
- `updateEnd (fn)` — 用于批量多次修改对象的属性，与updateBegin配套使用

## QueryOption
数据库查询选项
- `new QueryOption ()` — Members
- `fields` — 获取要查询的字段（列）
- `fields` — 设置要查询的字段（列）
- `id` — 获取TileLayer的ID
- `id` — 设置TileLayer的ID
- `limit` — 用于数据库分页查询，限制取多少条数据（即每页显示多少条记录）
- `limit` — 用于数据库分页查询，限制取多少条数据（即每页显示多少条记录）
- `offset` — 用于数据库分页查询，跳过多少条数据然后取后续数据
- `offset` — 用于数据库分页查询，跳过多少条数据然后取后续数据
- `where` — 获取要查询的条件
- `where` — 设置要查询的条件

## RadiationPoint  (`fdapi.radiationPoint`)
RadiationPoint类，提供辐射圈相关的操作 一般通过api.radiationPoint调用其方法
- `<protected> new RadiationPoint ()`
- `add (data, fn)` — 添加一个或多个RadiationPoint对象
- `clear (fn)` — 删除场景中所有的RadiationPoint
- `delete (ids, fn)` — 删除一个或多个RadiationPoint对象
- `focus (ids, distance, flyTime, rotation, fn)` — 自动定位到合适的观察距离
- `focusAll (distance, flyTime, rotation, fn)` — 自动定位到能观察所有RadiationPoint对象的合适距离
- `get (ids, fn)` — 根据ID获取RadiationPoint的详细信息
- `hide (ids, fn)` — 隐藏RadiationPoint
- `hideAll (fn)` — 隐藏所有RadiationPoint
- `setAutoHeight (id, newVal, fn)` — 设置AutoHeight 自动判断下方是否有物体，设置正确高度
- `setBrightness (id, newVal, fn)` — 设置新的亮度
- `setColor (id, newVal, fn)` — 设置颜色
- `setCoordinate (id, newVal, fn)` — 设置坐标
- `setRadius (id, newVal, fn)` — 设置半径
- `setRippleNumber (id, newVal, fn)` — 设置波纹数量
- `show (ids, fn)` — 显示RadiationPoint
- `showAll (fn)` — 显示所有RadiationPoint
- `update (data, fn)` — 修改一个或多个RadiationPoint对象
- `updateBegin ()` — 用于批量多次修改对象的属性
- `updateEnd (fn)` — 用于批量多次修改对象的属性，与updateBegin配套使用

## River  (`fdapi.river`)
River类 等价于一维水动力模型Hydrodynamic1D类 一般通过api.river调用其方法
- `<protected> new River ()` — Deprecated:
- `add (data, fn)` — 添加一个或多个River对象
- `clear (fn)` — 删除场景中所有的River
- `delete (ids, fn)` — 删除一个或多个River对象
- `focus (ids, distance, flyTime, rotation, fn)` — 自动定位到合适的观察距离
- `get (ids, fn)` — 根据ID获取River的详细信息
- `hide (ids, fn)` — 隐藏River
- `show (ids, fn)` — 显示River
- `update (data, fn)` — 修改一个或多个River对象

## Satellite  (`fdapi.satellite`)
Satellite 卫星仿真对象相关的操作 一般通过api.satellite调用其方法，效果图如下：
- `new Satellite ()` — protected
- `add (data, textRange, modelRange, imageVisibleDistance, fn)` — 添加一个或多个Satellite对象
- `callBPFunction (data, fn)` — 调用卫星模型包含的多个蓝图函数，注意：调用前请使用getBPFunction()函数来查询当前卫星模型包含的蓝图函数参数信息
- `clear (fn)` — 删除场景中所有的Satellite
- `deleteSatellite (ids, fn)` — 删除一个或多个卫星模型和其对应的文字标签
- `focus (ids, distance, flyTime, pitch, yaw, sensitivity, offset, fn)` — 自动定位到合适的观察距离
- `get (ids, fn)` — 根据卫星模型的ID获取卫星的实时位置信息
- `getBPFunction (ids, fn)` — 根据卫星模型ID查询其包含的蓝图函数信息，注意：支持批量查询
- `hideModel (ids, fn)` — 隐藏一个或多个卫星模型
- `hideSatellite (ids, fn)` — 隐藏一个或多个卫星模型和其对应的文字标签
- `hideText (ids, fn)` — 隐藏一个或多个卫星的文字标签
- `setFollow (ids, distance, flyTime, pitch, yaw, fn)` — 设置卫星运动时自动跟随相机
- `showModel (ids, fn)` — 显示一个或多个卫星模型
- `showSatellite (ids, fn)` — 显示一个或多个卫星模型和其对应的文字标签
- `showText (ids, fn)` — 显示一个或多个卫星的文字标签
- `update (data, duration, fn)` — 修改一个或多个Satellite对象
- `updateBegin ()` — 用于批量多次修改对象的属性
- `updateEnd (fn)` — 用于批量多次修改对象的属性，与updateBegin配套使用

## Settings  (`fdapi.settings`)
Settings类，设置面板参数设置相关的接口 一般通过api.settings调用其方法
- `<protected> new Settings ()`
- `enableRightClickMousePick (enable, fn)` — 控制鼠标右键的点击拾取，默认关闭
- `getCharacterAssetPath (fn)` — 查询当前工程已经挂载的pak文件包含的自定义的人物角色模型路径
- `getDroneAssetPath (fn)` — 查询当前工程已经挂载的pak文件包含的自定义的无人机模型路径
- `getInteractiveMode (fn)` — 查询当前交互模式
- `getLabelLayer (fn)` — 获取场景内所有的VTPK标注信息
- `getMapMode (fn)` — 获取地图样式
- `getProjectWKT (fn)` — 获取ACP工程的坐标系配准(wkt字符串)
- `hidePropertiesPanel (fn)` — 隐藏图层树上对象的属性面板
- `removeLabelLayer (fn)` — 移除当前显示的VTPK的标注
- `setCampassPosition (left, top, fn)` — 设置指北针位置
- `setCampassVisible (visible, fn)` — 设置指北针可见性
- `setCharacterAssetPath (assetPath, fn)` — 人物漫游模式下，设置自定义的人物角色模型
- `setCharacterRoaming (location, rotation, distance, fn)` — 设置人物交互模式的落脚点、人物朝向和观察距离
- `setCharacterRotation (rotation, fn)` — 设置角色旋转朝向
- `setDroneAssetPath (assetPath, fn)` — 无人机漫游模式下，设置自定义的无人机模型
- `setEnableCameraMovingEvent (bEnable, period, fn)` — 设置是否触发CameraMoving事件，CameraMoving事件默认是关闭的，如果需要接收相机移动消息，可以调用此方法
- `setEnableInteract (bEnable, fn)` — 设置交互开关，禁用后可以通过API设置交互。
- `setFovX (val, fn)` — 设置水平视场角
- `setGroundHeight (height, fn)` — 设置工程场景的海拔（地面高度）
- `setHighlightColor (color, fn)` — 设置高亮颜色
- `setImageryLayerEnableDecal (receiveDecalMode, fn)` — 设置网络图层服务(WMTS、WMS、MVT等)是否贴合地形或对象
- `setImageryLayerLevelOffset (levelOffset, fn)` — 设置网络图层服务的裂分等级的偏移量，如果图层服务当前某处的裂分等级为6级，参数设置为1则当前图层服务的裂分等级增加1变为7级。
- `setInteractiveMode (mode, fn)` — 设置交互模式
- `setLabelLayer (name, fn)` — 设置显示对应VTPK的标注
- `setLabelLayerLineSpace (lineSpace, fn)` — 设置VTPK线性标注的间隔
- `setLabelLayerScaleRatio (scale, fn)` — 设置VTPK标注的缩放显示百分比
- `setLabelLayerSymbolAvoidance (type, fn)` — 设置VTPK标注符号避让方式
- `setMainPanelPos (left, top, fn)` — 设置左侧资源面板的位置偏移
- `setMainUIVisibility (visible, fn)` — 设置主界面UI元素的可见性
- `setMapMode (mode, options, fn)` — 设置地图样式
- `setMouseHoverTime (time, fn)` — 设置鼠标悬浮事件返回的时间间隔
- `setMouseMoveTime (time, fn)` — 设置鼠标移动事件返回的时间间隔
- `setMousePickMask (mask, fn)` — 设置鼠标拾取功能，目前有三种拾取状态：鼠标左键点击（MouseClick: 0x1)、鼠标移动（MouseMove: 0x2）、鼠标停留（MouseHover: 0x4） *
- `setOceanColor (color, fn)` — 设置海洋颜色
- `setPlayerName (name, size, fn)` — 联网模式（会议室）下设置角色漫游和无人机漫游模式时模型上方显示的文字名称
- `setPropertiesPanelPos (left, top, fn)` — 设置图层树上对象的属性面板的屏幕位置偏移
- `setRenderedCursorVisible (bEnable, fn)` — 设置多客户端访问时渲染鼠标同步显示
- `setScreenControlsVisible (visible, fn)` — 当交互模式为人物或无人机模式时，设置屏幕操纵杆UI的可见性
- `setTerrainAlpha (alpha, fn)` — 设置地形透明度
- `setToolbarVisible (visible, fn)` — 设置屏幕右侧工具栏的可见性
- `setWMTSLayerOpacity (data, fn)` — 设置WMTS图层的透明度
- `setWMTSLayerVisible (data, fn)` — 设置WMTS图层的可见性
- `showPropertiesPanel (id, fn)` — 显示图层树上对象的属性面板

## SettingsPanel  (`fdapi.settingsPanel`)
设置面板类，提供对设置面板里的所有参数进行操作的接口 一般通过api.settingsPanel调用其方法
- `<protected> new SettingsPanel ()`
- `getCameraMode (fn)` — 获取参数 相机面板
- `getControlMode (fn)` — 获取参数 控制面板
- `getMapMode (fn)` — 获取地图样式
- `getPostProcessMode (fn)` — 获取参数 后期面板
- `getReportMode (fn)` — 获取参数 汇报模式面板
- `setCameraMode (nearClipPlane, fovH, minCameraHeight, maxCameraHeight, fn)` — 设置参数 相机面板
- `setControlMode (speed, yawSpeed, isRotateSelf, isUseMaleRole, viewType, fn)` — 设置参数 控制面板
- `setMapMode (mode, options, fn)` — 设置地图样式
- `setPakFile (pakfilePathArr, fn)` — 设置-工程面板自定义资源挂载的pak自定义资源文件
- `setPakFolder (dirArr, fn)` — 设置-工程面板下自定义资源加载的pak自定义资源文件目录
- `setPostProcessMode (postProcessOptions, fn)` — 设置参数，后期面板，注意：支持设置单个参数或同时设置多个参数
- `setReportMode (showAlign, playMode, isLinkage, fn)` — 设置参数 汇报模式面板

## ShapeFileLayer  (`fdapi.shapeFileLayer`)
ShapeFileLayer矢量图层对象相关的操作
- `<protected> new ShapeFileLayer ()` — 一般通过api.ShapeFileLayer调用其方法
- `add (data, fn)` — 添加一个或多个ShapeFileLayer对象
- `clear (fn)` — 删除场景中所有的ShapeFileLayer
- `delete (ids, fn)` — 删除一个或多个ShapeFileLayer对象
- `focus (ids, distance, flyTime, rotation, fn)` — 自动定位到合适的观察距离
- `focusFeature (shapeFileLayerId, featureId, distance, flyTime, rotation, fn)` — 定位到ShapeFileLayer的要素区域
- `get (ids, fn)` — 根据ID获取ShapeFileLayer的详细信息 包含模型属性和值
- `getFeature (data, fn)` — 获取ShapeFileLayer内部要素区域的详细信息
- `hide (ids, fn)` — 隐藏ShapeFileLayer
- `hideAll (fn)` — 隐藏所有ShapeFileLayer
- `highlightFeature (shapeFileLayerId, featureId, fn)` — 高亮ShapeFileLayer对象内部的某一块要素区域
- `highlightFeatures (data, fn)` — 高亮ShapeFileLayer对象内部的多块要素区域
- `open (data, fn)` — 打开ShapeFileLayer 返回模型包含的所有属性
- `show (ids, fn)` — 显示ShapeFileLayer
- `showAll (fn)` — 显示所有ShapeFileLayer
- `unHighlightFeature (shapeFileLayerId, featureId, fn)` — 取消高亮ShapeFileLayer对象内部的某一块要素区域
- `unHighlightFeatures (data, fn)` — 取消高亮ShapeFileLayer对象内部的多块要素区域
- `update (data, fn)` — 修改一个或多个ShapeFileLayer对象
- `updateBegin ()` — 用于批量多次修改对象的属性
- `updateEnd (fn)` — 用于批量多次修改对象的属性，与updateBegin配套使用

## SignalWave  (`fdapi.signalWave`)
信号波束SignalWave对象相关的操作 一般通过api.signalWave调用其方法
- `<protected> new SignalWave ()`
- `add (data, fn)` — 添加一个或多个SignalWave波束对象
- `clear (fn)` — 删除场景中所有的SignalWave
- `delete (ids, fn)` — 删除一个或多个SignalWave对象
- `focus (ids, distance, flyTime, rotation, fn)` — 自动定位到合适的观察距离
- `get (ids, fn)` — 根据ID获取SignalWave的详细信息
- `hide (ids, fn)` — 隐藏SignalWave
- `show (ids, fn)` — 显示SignalWave
- `update (data, fn)` — 修改一个或多个SignalWave对象
- `updateBegin ()` — 用于批量多次修改对象的属性
- `updateEnd (fn)` — 用于批量多次修改对象的属性，与updateBegin配套使用

## SmoothedParticleHydrodynamics  (`fdapi.smoothedParticleHydrodynamics`)
光滑粒子流体动力学仿真对象，实现对光滑粒子流体动力学仿真对象的操作 一般通过api.smoothedParticleHydrodynamics调用其方法
- `new SmoothedParticleHydrodynamics ()`
- `add (data, fn)` — 添加一个或多个光滑粒子流体动力学仿真对象
- `clear (fn)` — 清空场景中所有的光滑粒子流体动力学仿真对象
- `delete (ids, fn)` — 删除一个或多个光滑粒子流体动力学仿真对象
- `focus (ids, distance, flyTime, rotation, fn)` — 自动定位到合适的观察距离
- `get (ids, fn)` — 根据光滑粒子流体动力学仿真对象ID获取光滑粒子流体动力学仿真对象的详细信息
- `hide (ids, fn)` — 隐藏光滑粒子流体动力学仿真对象
- `show (ids, fn)` — 显示光滑粒子流体动力学仿真对象
- `update (data, fn)` — 修改一个或多个光滑粒子流体动力学仿真对象，支持更新以下属性：
- `updateBegin ()` — 用于批量多次修改对象的属性
- `updateEnd (fn)` — 用于批量多次修改对象的属性，与updateBegin配套使用

## SplineMesh  (`fdapi.splineMesh`)
SplineMesh类，提供绘制路径模型对象相关的操作 一般通过api.splineMesh调用其方法
- `<protected> new SplineMesh ()`
- `add (data, fn)` — 添加一个或多个SplineMesh对象，绘制路径模型
- `callBPFunction (data, fn)` — 调用splineMesh对象包含的多个蓝图函数
- `clear (fn)` — 清空场景中所有的SplineMesh对象
- `delete (ids, fn)` — 删除一个或多个SplineMesh对象
- `deleteByGroupId (groupId, fn)` — 根据分组ID删除SplineMesh
- `focus (ids, distance, flyTime, rotation, fn)` — 自动定位到合适的观察距离
- `get (ids, fn)` — 根据ID获取SplineMesh对象的详细信息
- `getBPFunction (ids, fn)` — 根据splineMesh对象的id查询其包含的蓝图函数信息
- `hide (ids, fn)` — 隐藏一个或多个SplineMesh对象
- `hideAll (fn)` — 隐藏所有SplineMesh对象
- `hideByGroupId (groupId, fn)` — 根据分组ID隐藏SplineMesh
- `show (ids, fn)` — 显示一个或多个SplineMesh对象
- `showAll (fn)` — 显示所有SplineMesh对象
- `showByGroupId (groupId, fn)` — 根据分组ID显示SplineMesh
- `update (data, fn)` — 修改一个或多个SplineMesh对象
- `updateBegin ()` — 用于批量多次修改对象的属性
- `updateEnd (fn)` — 用于批量多次修改对象的属性，与updateBegin配套使用

## Tag  (`fdapi.tag`)
Tag已停止更新，推荐使用功能更丰富的标注对象Marker
- `<protected> new Tag ()` — Deprecated:
- `add (data, fn)` — 添加一个或多个Tag对象
- `clear (fn)` — 删除场景中所有的Tag
- `delete (ids, fn)` — 删除一个或多个Tag对象
- `focus (ids, distance, flyTime, rotation, fn)` — 自动定位到合适的观察距离
- `focusAll (distance, flyTime, rotation, fn)` — 自动定位到能观察所有Tag对象的合适距离
- `get (ids, fn)` — 根据ID获取Tag的详细信息
- `hide (ids, fn)` — 隐藏Tag
- `hideAll (fn)` — 隐藏所有Tag
- `hideAllPopupWindow (fn)` — 隐藏所有标签的弹出窗口
- `hidePopupWindow (ids, fn)` — 隐藏指定标签的弹出窗口
- `setAutoHidePopupWindow (id, newVal, fn)` — 设置是否自动关闭标签的弹出窗口
- `setCoordinate (id, newVal, fn)` — 设置标签的位置
- `setImagePath (id, newVal, fn)` — 设置标签的图片
- `setImageSize (id, newVal, fn)` — 设置标签图片的大小
- `setRange (id, newVal, fn)` — 设置标签的可见范围
- `setShowLine (id, newVal, fn)` — 设置标签是否显示垂直牵引线
- `setText (id, newVal, fn)` — 设置标签的文本
- `setTextBackgroundColor (id, newVal, fn)` — 设置标签文本的背景颜色
- `setTextBorderColor (id, newVal, fn)` — 设置标签文本的边框颜色
- `setTextColor (id, newVal, fn)` — 设置标签文本颜色
- `setURL (id, newVal, fn)` — 设置标签的URL
- `show (ids, fn)` — 显示Tag
- `showAll (fn)` — 显示所有Tag
- `showAllPopupWindow (fn)` — 显示所有标签的弹出窗口
- `showPopupWindow (ids, fn)` — 显示指定标签的弹出窗口
- `update (data, fn)` — 修改一个或多个Tag对象
- `updateBegin ()` — 用于批量多次修改对象的属性
- `updateEnd (fn)` — 用于批量多次修改对象的属性，与updateBegin配套使用

## TileLayer  (`fdapi.tileLayer`)
TileLayer增、删、改、查相关的操作 一般通过api.tileLayer调用其方法
- `<protected> new TileLayer ()`
- `add (data, fn)` — 添加一个或多个TileLayer对象
- `addHole (data, fn)` — 根据挖洞多边形的坐标添加一个或多个挖洞操作，注意：同时只能对一个图层id进行挖洞操作
- `addHoleByShapeFile (data, fn)` — 根据shapeFile添加一个或多个挖洞操作
- `addModifier (id, tileLayerId, coordinates, ententBufferSize, fn)` — 添加一个压平操作
- `addModifierByShapeFile (data, fn)` — 根据shapeFile添加一个或多个压平操作
- `addModifiers (data, fn)` — 根据多边形的坐标添加一个或多个压平操作，注意：同时只能对一个图层id进行压平操作
- `clear (fn)` — 清空接口添加的所有图层对象
- `clearHole (ids, fn)` — 清空所有挖洞操作
- `clearModifier (ids, fn)` — 清空所有压平操作
- `createQuery ()` — 创建数据库查询条件对象
- `delete (ids, fn)` — 删除一个或多个TileLayer对象
- `deleteHole (id, tileLayerId, fn)` — 删除一个挖洞操作
- `deleteModifier (id, tileLayerId, fn)` — 删除一个压平操作
- `disableClip (ids, fn)` — 禁止TileLayer图层参与剖切
- `disableXRay (ids, fn)` — 禁用X光
- `enableClip (ids, fn)` — 设置TileLayer图层参与剖切
- `enableDecal (data, fn)` — 设置图层对贴花类型对象的贴合支持，包含Decal对象和HeatMap对象
- `enableFluid (data, fn)` — 设置图层对水流体对象Fluid的支持，注意：设置false不支持时则水流体的物理碰撞会忽略此图层
- `enableImageLayerDecal (data, fn)` — 设置指定图层是否支持对网络图层服务(WMTS、WMS、MVT等)进行贴合
- `enableXRay (ids, color, fn)` — 启用X光，效果图如下：
- `focus (ids, distance, flyTime, rotation, fn)` — 自动定位到合适的观察距离
- `focusActor (id, objectId, distance, flyTime, rotation, fn)` — 定位一个Actor
- `focusActors (data, distance, flyTime, rotation, fn)` — 定位一个或多个Actor
- `get (ids, fn)` — 根据ID获取TileLayer的详细信息
- `getActorInfo (data, fn)` — 通过OID查询Actor的矩阵和bound等信息
- `getActorInfoFromDB (data, fn)` — 从空间数据库获取TileLayer下指定Actor的详细属性信息 注意:调用前需先配置Explorer里空间库的对应信息，配置示例如下图：
- `getAllFlattenInfo (fn)` — 查询所有图层是否支持压平
- `getCollision (tileLayerIds, fn)` — 查询图层包含的碰撞检测信息
- `getDBTabID (data, fn)` — 设置点云盒子的颜色，注意：仅Box渲染模式下生效
- `getObjectIDs (ids, fn)` — 获取指定TileLayer包含的所有Actor对象的ID
- `hide (ids, fn)` — 隐藏TileLayer图层
- `hideActor (id, objectId, fn)` — 隐藏Actor
- `hideActors (data, fn)` — 隐藏一个或多个Actor
- `hideAllActors (tileLayerIds)` — 隐藏指定tilelayer的所有Actor
- `highlightActor (id, objectId, fn)` — 高亮一个Actor，效果图如下：
- `highlightActors (data, fn)` — 高亮多个Actor，同时支持高亮多个图层的Actor
- `highlightActorsWithColor (data, fn)` — 使用颜色去高亮多个Actor，支持设置不同的高亮颜色去高亮不同的Actor
- `highlightActorWithColor (id, objectId, color, bWireframe, fn)` — 使用颜色去高亮一个Actor，支持设置不同的高亮颜色去高亮不同的Actor
- `highlightPoints (data, fn)` — 根据点云的属性字段值高亮点云匹配到点
- `<async> query (queryOption, fn)` — 根据TileLayer的ID在PG数据库中查询
- `setAltitudeHeatMap (tileLayerIds, colors, fn)` — 根据海拔高度设置TileLayer的分层热力样式，注意：如果是球面坐标系工程，则使用Engine发布3dt图层时需要添加 -terUserHotMap 参数才可以支持热力样式
- `setCollision (tileLayerIds, enabled, mouseInteract, mouseFunction, characterCollision, fn)` — 设置TileLayer是否参与碰撞检测
- `setFileName (id, newVal, fn)` — 修改TileLayer图层的3dt文件路径
- `setLocation (id, newVal, fn)` — 设置平移
- `setPointCloudBoxVisible (data, fn)` — 设置点云盒子的可见性，注意：仅Box渲染模式下生效
- `setPointCloudSize (id, pointCloudSize, fn)` — 设置TileLayer图层的点云大小，注意：仅对点云数据转换的3dt图层模型生效
- `setPointCloudStyle (data)` — 根据点云的属性字段来设置点云模型的渲染颜色
- `setRotation (id, newVal, fn)` — 设置旋转
- `setScale (id, newVal, fn)` — 设置缩放
- `setStyle (tileLayerIds, style, color, saturation, brightness, contrast, contrastBase, fn)` — 设置TileLayer的样式
- `setViewHeightRange (id, minViewHeight, maxViewHeight, fn)` — 设置TileLayer图层的可视高度范围
- `setViewportVisible (id, vp, fn)` — 多视口状态下，设置图层在各视口的可见性
- `show (ids, fn)` — 显示TileLayer图层
- `showActor (id, objectId, fn)` — 显示Actor
- `showActors (data, fn)` — 显示一个或多个Actor
- `showAllActors (tileLayerIds)` — 显示指定tilelayer的所有Actor
- `unHighlightActor (id, objectId, fn)` — 取消高亮一个Actor
- `unHighlightActors (data, fn)` — 停止高亮多个Actor，同时支持停止高亮多个图层的Actor
- `unHighlightAllActors (fn)` — 停止高亮所有Actor
- `unHighlightAllPoints (fn)` — 取消高亮点云包含所有点的高亮效果
- `unHighlightPoints (data, fn)` — 根据点云的属性字段值取消高亮
- `update (data, fn)` — 修改一个或多个TileLayer对象，支持更新以下属性：
- `updateBegin ()` — 用于批量多次修改对象的属性
- `updateEnd (fn)` — 用于批量多次修改对象的属性，与updateBegin配套使用
- `updateHole (id, tileLayerId, holeCoordinate, isReverseCut, fn)` — 修改一个挖洞操作
- `updateModifier (id, tileLayerId, coordinates, ententBufferSize, fn)` — 修改一个压平操作
- `<async> updateRecord (id, newValMap, where, fn)` — 更新TileLayer关联的数据库记录

## Tools  (`fdapi.tools`)
工具类 一般通过api.tools调用其方法
- `<protected> new Tools ()`
- `exportSkyline (path, size, options, fn)` — 导出天际线分析图片，注意：需先执行开始天际线分析并在页面交互出现天际线图片后才可以执行导出方法exportSkyline
- `getUIPanel (type, fn)` — 查询系统UI功能操作面板的显示状态
- `hideUIPanel (type, fn)` — 隐藏系统UI功能操作面板
- `lineIntersect (start, end, fn)` — 单条线段求交，如果线段上有多个对象则返回距离折线起点位置最近的对象信息，如果折线上没有对象则返回ResourceNotFound
- `linesIntersect (startEndPointArr, highPrecision, returnDetails, fn)` — 多条线段批量求交
- `replaceTextureByImage (texturePath, imageUrl, fn)` — 使用图片替换纹理
- `replaceTextureByUrl (texturePath, url, fn)` — 使用网页替换纹理
- `replaceTextureByVideo (texturePath, videoUrl, fn)` — 使用视频流替换纹理
- `restoreTexture (texturePathArr, fn)` — 恢复纹理
- `setMeasurement (type, options, fn)` — 设置测量模式及相关参数
- `showClipPanel (clipType, screenPosition, fn)` — 打开剖切功能操作面板
- `showMeasurePanel (measureType, screenPosition, fn)` — 打开测量功能操作面板
- `showUIPanel (type, screenPosition, fn)` — 显示系统UI功能操作面板
- `startContourLineAnalysis (options, fn)` — 开始等高线分析，适用于地形
- `startCutFillAnalysis (options, fn)` — 开始填挖方分析，适用于地形
- `startFloodFill (options, fn)` — 开始水淹分析
- `startGeometryEdit (id, type, fn)` — 开始顶点编辑，目前支持watermesh polygon 3dpolygon polyline RadiationPoint customObject
- `startMeasurement (fn)` — 开始测量，用户可以在三维场景中点击鼠标进行测量
- `startPlaneClip (location, rotation, isShowPlane, isEditable, fn)` — 开始面剖切
- `startPolygonClip (coordinates, isReverseCut, fn)` — TileLayer多边形剖切， 效果图如下：
- `startSkylineAnalysis (options, fn)` — 开始天际线分析
- `startSunshineAnalysis (options, fn)` — 开始日照分析
- `startTerrainSlopeAnalysis (options, fn)` — 开始坡度坡向分析，适用于地形3dt数据
- `startViewDomeAnalysis (options, fn)` — 开始开敞度分析
- `startViewshedAnalysis (options, fn)` — 开始可视域分析
- `startVisiblityAnalysis (options, fn)` — 开始通视分析
- `startVolumeClip (bbox, direction, isShowBBox, isEditable, rotation, fn)` — 开始体剖切
- `stopClip (fn)` — 停止多边形剖切
- `stopContourLineAnalysis (fn)` — 停止等高线分析
- `stopCutFillAnalysis (fn)` — 停止填挖方分析
- `stopFloodFill (fn)` — 停止水淹分析
- `stopGeometryEdit (fn)` — 退出顶点编辑
- `stopMeasurement (fn)` — 停止测量
- `stopPlaneClip (fn)` — 停止面剖切
- `stopPolygonClip (fn)` — 停止多边形剖切
- `stopSkylineAnalysis (fn)` — 结束天际线分析
- `stopSunshineAnalysis (fn)` — 停止日照分析
- `stopTerrainSlopeAnalysis (fn)` — 停止坡度坡向分析
- `stopViewDomeAnalysis (fn)` — 停止开敞度分析
- `stopViewshedAnalysis (fn)` — 停止可视域分析
- `stopVisiblityAnalysis (fn)` — 停止通视分析
- `stopVolumeClip (fn)` — 停止体剖切
- `updateVolumeClip (bbox, direction, isShowBBox, isEditable, rotation, fn)` — 更新体剖切

## TopologyLine  (`fdapi.topologyLine`)
拓扑线对象，提供绘制连接图层树上模型的拓扑线的相关操作方法 一般通过api.topologyLine调用其方法
- `<protected> new TopologyLine ()`
- `add (data, fn)` — 添加一个或多个TopologyLine对象
- `clear (fn)` — 删除场景中所有的TopologyLine
- `delete (ids, fn)` — 删除一个或多个TopologyLine对象
- `focus (ids, distance, flyTime, rotation, fn)` — 自动定位到合适的观察距离
- `get (ids, fn)` — 根据ID获取TopologyLine的详细信息
- `hide (ids, fn)` — 隐藏TopologyLine对象
- `hideAll (fn)` — 隐藏所有TopologyLine对象
- `show (ids, fn)` — 显示TopologyLine对象
- `showAll (fn)` — 显示所有TopologyLine对象
- `update (topologyLine, fn)` — 修改一个或多个·TopologyLine对象
- `updateBegin ()` — 用于批量多次修改对象的属性
- `updateEnd (fn)` — 用于批量多次修改对象的属性，与updateBegin配套使用

## TrafficSimulation  (`fdapi.trafficSimulation`)
TrafficSimulation类，提供城市级交通仿真对象相关的操作，支持十万级别的城市车辆交通仿真。 一般通过api.trafficSimulation调用其方法
- `<protected> new TrafficSimulation ()`
- `add (trafficSimulation, fn)` — 初始化一个TrafficSimulation对象，支持十万级别的城市交通车辆仿真模拟
- `autoHighlight (id, distance, fn)` — 根据相机高度自动高亮TrafficSimulation对象包含的所有车辆
- `delete (ids, fn)` — 删除一个或多个TrafficSimulation对象
- `focus (ids, distance, flyTime, rotation, distanceRotation, fn)` — 自动定位到合适的观察距离
- `hide (id, fn)` — 隐藏TrafficSimulation对象包含的所有车辆
- `hideHeatMap (id, fn)` — 隐藏TrafficSimulation对象的热力图效果
- `hideTextLabel (id, fn)` — 隐藏TrafficSimulation对象包含的所有车辆文字标签
- `highlight (id, fn)` — 高亮TrafficSimulation对象包含的所有车辆
- `show (id, fn)` — 显示TrafficSimulation对象包含的所有车辆
- `showHeatMap (id, fn)` — 显示TrafficSimulation对象的热力图效果
- `showTextLabel (id, fn)` — 显示TrafficSimulation对象包含的所有车辆文字标签
- `unHighlight (id, fn)` — 取消高亮TrafficSimulation对象包含的所有车辆
- `update (trafficSimulation, fn)` — 更新一个时刻的TrafficSimulation对象
- `updateBegin ()` — 用于批量多次修改对象的属性
- `updateEnd (fn)` — 用于批量多次修改对象的属性，与updateBegin配套使用

## Train  (`fdapi.train`)
火车类对象，模拟火车移动 一般通过api.train对象调用
- `<protected> new Train ()`
- `add (data, fn)` — 添加一个或多个Train对象
- `clear (fn)` — 清空场景中所有的Train对象
- `delete (ids, fn)` — 删除一个或多个Train对象
- `focus (ids, distance, flyTime, rotation, offset, fn)` — 自动定位到合适的观察距离
- `get (ids, fn)` — 根据ID获取Train对象的详细信息
- `hide (ids, fn)` — 隐藏一个或多个Train对象
- `moveTo (data, fn)` — 火车按时间和里程移动
- `pause (ids, fn)` — 根据火车ID暂停火车
- `resume (ids, fn)` — 根据火车ID恢复火车移动
- `setFollow (ids, distance, flyTime, pitch, yaw, sensitivity, fn)` — 设置火车行驶时自动跟随相机
- `show (ids, fn)` — 显示一个或多个Train对象
- `update (data, fn)` — 修改一个或多个Train对象
- `updateBegin ()` — 用于批量多次修改对象的属性
- `updateEnd (fn)` — 用于批量多次修改对象的属性，与updateBegin配套使用

## VectorField  (`fdapi.vectorField`)
向量场类对象，基于真实数据对台风、波浪、洋流的形态进行模拟 一般通过api.vectorField调用其方法 说明：目前只支持台风数据，参考以下说明： 流场数据最终提供给程序使用是以三维纹理的方式用于渲染，所以要求在三个维度上采样均匀，也就是采样点间隔均匀，否则会变形甚至错误。 鉴于大部分气象海洋数据的坐标系都是wgs84坐标系，所以支持内部进行坐标重投影。
- `<protected> new VectorField ()`
- `add (data, fn)` — 添加一个或多个VectorField向量场对象
- `clear (fn)` — 清空场景中所有的VectorField对象
- `delete (ids, fn)` — 删除一个或多个VectorField对象
- `focus (ids, distance, flyTime, rotation, fn)` — 自动定位到合适的观察距离
- `get (ids, fn)` — 根据ID获取VectorField对象的详细信息
- `hide (ids, fn)` — 隐藏VectorField对象
- `setViewportVisible (id, vp, fn)` — 设置向量场对象在进入多视口状态下视口可见性
- `show (ids, fn)` — 显示VectorField对象
- `update (data, fn)` — 修改一个或多个VectorField对象

## Vehicle  (`fdapi.vehicle`)
Vehicle类，提供车辆载具对象相关的操作 一般通过api.vehicle调用其方法
- `<protected> new Vehicle ()`
- `add (data, fn)` — 添加一个或多个Vehicle对象
- `callBatchFunction (data, fn)` — 调用多个Vehicle对象的多个蓝图函数
- `clear (fn)` — 清空场景中所有的Vehicle对象
- `delete (ids, fn)` — 删除一个或多个Vehicle对象
- `focus (ids, followEnable, distance, flyTime, rotation, distanceRotation, offset, fn)` — 自动定位到合适的观察距离
- `get (ids, fn)` — 根据ID获取Vehicle对象的详细信息
- `hide (ids, fn)` — 隐藏一个或多个Vehicle对象
- `moveTo (data, fn)` — 设置Vehicle对象行驶（根据实时获取的GPS数据运动）
- `pause (ids, fn)` — 暂停指定的载具运动
- `resume (id, fn)` — 恢复指定的载具运动
- `setWayPoint (data, fn)` — 设置Vehicle对象行驶的路径点（已知路径点 轨迹动画）
- `show (ids, fn)` — 显示一个或多个Vehicle对象
- `start (data, fn)` — 启动指定的载具在某个时刻开始运动
- `stop (ids, fn)` — 停止指定的载具运动
- `update (data, fn)` — 修改一个或多个Vehicle对象
- `updateBegin ()` — 用于批量多次修改对象的属性
- `updateEnd (fn)` — 用于批量多次修改对象的属性，与updateBegin配套使用

## Vehicle2  (`fdapi.vehicle2`)
高级载具类，提供高级载具的相关的操作 一般通过api.Vehicle2调用其方法
- `<protected> new Vehicle2 ()`
- `add (data, fn)` — 添加一个或多个Vehicle2对象
- `clear (fn)` — 清空场景中所有的Vehicle2对象
- `delete (ids, fn)` — 删除一个或多个Vehicle2对象
- `focus (ids, distance, flyTime, rotation, offset, fn)` — 自动定位载具到合适的观察距离
- `get (ids, fn)` — 根据ID查询Vehicle2对象的详细信息
- `hide (ids, fn)` — 隐藏一个或多个Vehicle2对象
- `moveTo (data, fn)` — 设置Vehicle2对象行驶到具体位置（根据实时获取的GPS数据运动）
- `setFollow (ids, distance, flyTime, pitch, yaw, sensitivity, watchControl, offset, fn)` — 设置载具自动跟随相机
- `setViewportVisible (id, vp, fn)` — 多视口状态下，设置Vehicle2对象在各视口的可见性
- `show (ids, fn)` — 显示一个或多个Vehicle2对象
- `update (data, fn)` — 修改一个或多个Vehicle2对象
- `updateBegin ()` — 用于批量多次修改对象的属性
- `updateEnd (fn)` — 用于批量多次修改对象的属性，与updateBegin配套使用

## VideoProjection  (`fdapi.videoProjection`)
VideoProjection类，提供视频投影对象相关的操作 一般通过api.videoProjection调用其方法 VideoProjection的效果图：
- `<protected> new VideoProjection ()`
- `add (data, fn)` — 添加一个或多个VideoProjection对象
- `clear (fn)` — 删除场景中所有的VideoProjection对象
- `delete (ids, fn)` — 删除一个或多个VideoProjection对象
- `focus (ids, distance, flyTime, rotation, fn)` — 自动定位到合适的观察距离
- `get (ids, fn)` — 根据ID获取VideoProjection的详细信息
- `hide (ids, fn)` — 隐藏VideoProjection
- `setAspectRatio (id, newVal, fn)` — 设置纵横比
- `setDepthCulling (id, newVal, fn)` — 设置是否背面剔除
- `setDistance (id, newVal, fn)` — 设置距离
- `setFovy (id, newVal, fn)` — 设置垂直夹角
- `setFrustumColor (id, newVal, fn)` — 设置投影线框颜色
- `setLocation (id, newVal, fn)` — 设置位置
- `setRotation (id, newVal, fn)` — 设置旋转值
- `setVideoURL (id, newVal, fn)` — 设置视频地址
- `show (ids, fn)` — 显示VideoProjection
- `update (data, fn)` — 修改一个或多个VideoProjection对象
- `updateBegin ()` — 用于批量多次修改对象的属性
- `updateEnd (fn)` — 用于批量多次修改对象的属性，与updateBegin配套使用

## WaterFlowField  (`fdapi.waterFlowField`)
WaterFlowField流场类对象，用于精确控制水流单个网格的方向速度等 一般通过api.waterFlowField调用其方法
- `<protected> new WaterFlowField ()`
- `add (data, fn)` — 添加一个或多个WaterFlowField对象
- `clear (fn)` — 清空场景中所有的WaterFlowField对象
- `delete (ids, fn)` — 删除一个或多个WaterFlowField对象
- `focus (ids, distance, flyTime, rotation, fn)` — 自动定位到合适的观察距离
- `get (ids, fn)` — 根据ID获取WaterFlowField对象的详细信息
- `hide (ids, fn)` — 隐藏WaterFlowField对象
- `setViewportVisible (id, vp, fn)` — 设置水流场对象在进入多视口状态下视口可见性
- `show (ids, fn)` — 显示WaterFlowField对象
- `update (data, fn)` — 修改一个或多个WaterFlowField对象

## WaterMesh  (`fdapi.waterMesh`)
WaterMesh类 一般通过api.waterMesh调用其方法
- `<protected> new WaterMesh ()`
- `add (data, fn)` — 添加一个或多个WaterMesh对象
- `clear (fn)` — 删除场景中所有的WaterMesh
- `delete (ids, fn)` — 删除一个或多个WaterMesh对象
- `focus (ids, distance, flyTime, rotation, fn)` — 自动定位到合适的观察距离
- `get (ids, fn)` — 根据ID获取WaterMesh的详细信息
- `hide (ids, fn)` — 隐藏WaterMesh
- `hideAll (fn)` — 隐藏所有WaterMesh
- `setCoordinates (id, newVal, fn)` — 设置WaterMesh顶点坐标
- `setIndices (id, newVal, fn)` — 设置WaterMesh顶点坐标索引
- `setNormals (id, newVal, fn)` — 设置WaterMesh法向
- `setWaterColor (id, newVal, fn)` — 设置颜色
- `setWaterDirection (id, newVal, fn)` — 设置水流方向
- `setWaterSpeed (id, newVal, fn)` — 设置水流速度
- `setWaterUVRepeat (id, newVal, fn)` — 设置水流贴图重复间隔距离
- `setWaterWaveScale (id, newVal, fn)` — 设置水波纹大小
- `show (ids, fn)` — 显示WaterMesh
- `showAll (fn)` — 显示所有WaterMesh
- `update (data, fn)` — 修改一个或多个WaterMesh对象

## Weather  (`fdapi.weather`)
Weather类，提供天气相关的参数设置和获取接口
- `<protected> new Weather ()`
- `disableRainSnow (fn)` — 关闭雨雪效果
- `getDateTime (fn)` — 获取日期时间
- `getOceanWave (fn)` — 查询海浪效果参数
- `getParams (fn)` — 获取天气相关的参数
- `setAmbientLightIntensity (ambientLightIntensity, fn)` — 设置环境光强度
- `setCloudDensity (cloudDensity, fn)` — 设置云层的密度
- `setCloudParam (cloudsColor, cloudsAltitude, cloudShadowStrength, fn)` — 设置云效参数
- `setCloudThickness (cloudThickness, fn)` — 设置云层的厚度
- `setDarkMode (bDark, fn)` — 设置是否进入黑暗模式 效果图：
- `setDateTime (year, month, day, hour, minute, daynightLoop, fn)` — 设置日期时间
- `setEarthCloudIntensity (earthCloudIntensity, fn)` — 球面工程坐标系下，设置地球大气云层的亮度
- `setEarthNightLightIntensity (earthNightLightIntensity, fn)` — 球面工程坐标系下，设置地球夜晚灯光的亮度
- `setEarthStarBackgroundIntensity (earthStarBackgroundIntensity, fn)` — 球面工程坐标系下，设置星空背景的亮度
- `setFogParam (fogDensity, fogColor, fogHeightFalloff, fogStartDistance, fogOpacity, fn)` — 设置雾效参数。 效果图：
- `setHighCloud (highCloudLayerCoverage, highCloudWindSpeed, highCloudWindDirection, cirrusCloudDensity, cirrostratusCloudDensity, cirrocumulusCloudDensity, fn)` — 设置高云层效果参数
- `setLowCloud (lowCloudCoverage, lowCloudDensity, lowCloudHeight, lowCloudWindSpeed, lowCloudWindDirection, fn)` — 设置低云层效果参数
- `setMoonIntensity (moonIntensity, fn)` — 设置月亮光照强度
- `setMoonSize (moonSize, fn)` — 设置月亮尺寸
- `setOceanWave (options, fn)` — 设置海浪效果参数
- `setRainParam (strength, speed, raindropSize, rainColor, alignCamera, overcastStrength, fn)` — 设置雨效。注意：开启雨效前需先设置云层的厚度和密度，效果图：
- `setShadowDistance (shadowDistance, fn)` — 设置阴影可视距离，即相机镜头距离物体阴影的距离
- `setShadowIntensity (shadowIntensity, fn)` — 设置阴影强度，值越大表示阴影越强
- `setShadowQuality (shadowQuality, fn)` — 设置阴影质量，值越大表示阴影越精细，但也越消耗显卡性能
- `setSkyVisibleMaxHeight (maxHeight, fn)` — 设置天空球效果的失效高度，默认值：50000米(50公里)
- `setSnowParam (strength, speed, snowflakeSize, snowColor, alignCamera, overcastStrength, fn)` — 设置雪效。注意：开启雪效前需先设置云层的厚度和密度，效果图：
- `setSunColor (sunColor, fn)` — 设置太阳颜色
- `setSunIntensity (sunIntensity, fn)` — 设置太阳光照射强度
- `setSunSize (sunSize, fn)` — 设置太阳尺寸
- `setTemperature (temperature, fn)` — 设置色温值
- `simulateTime (startTime, endTime, duration, fn)` — 模拟时间播放
