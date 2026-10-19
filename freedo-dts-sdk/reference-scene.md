# Freedo 场景：天气 / 工具 / 杂项 / 热力 / 水 / 编辑

## Weather（`fdapi.weather`）

本仓库 LayerControl 常用：`setDateTime`、`setRainParam`、`setSnowParam`、`disableRainSnow`、`setSunIntensity`。

```js
fdapi.weather.setDateTime(year, month, day, hour, minute, daynightLoop);
// daynightLoop=true：约 3 分钟循环一天
fdapi.weather.setRainParam(strength, speed, raindropSize, rainColor?, alignCamera?, overcastStrength?);
fdapi.weather.setSnowParam(strength, speed, snowflakeSize, snowColor?, alignCamera?, overcastStrength?);
fdapi.weather.disableRainSnow();
fdapi.weather.setSunIntensity(4);
```

| 方法 | 作用 |
|------|------|
| `getDateTime` / `getParams` / `getOceanWave` | 读当前 |
| `setSunColor` `setSunSize` `setMoonIntensity` `setMoonSize` | 日月 |
| `setAmbientLightIntensity` `setShadowDistance` `setShadowIntensity` `setShadowQuality` | 光影 |
| `setCloudDensity` `setCloudThickness` `setCloudParam` `setLowCloud` `setHighCloud` | 云 |
| `setFogParam(density, color, heightFalloff, startDistance, opacity)` | 雾 |
| `setDarkMode(b)` | 暗色 |
| `setTemperature` | 温度 |
| `setOceanWave(options)` | 海浪 |
| `setEarthCloudIntensity` `setEarthNightLightIntensity` `setEarthStarBackgroundIntensity` | 地球 |
| `setSkyVisibleMaxHeight` | 天空最大可见高 |
| `simulateTime(start, end, duration)` | 时间推移动画 |

## Tools（`fdapi.tools`）— 测量 / 剖切 / 分析

测量完成事件：`eventtype === "Measurement"`。剖切编辑：`PlaneClipEdit` / `VolumeClipEdit`。

| 方法 | 作用 |
|------|------|
| `setMeasurement(type, options)` `startMeasurement` `stopMeasurement` | 测量。`type`=`MeasurementMode` |
| `showMeasurePanel(type, screenPos)` | 测量面板 |
| `startPlaneClip` `stopPlaneClip` `startVolumeClip` `updateVolumeClip` `stopVolumeClip` `startPolygonClip` `stopPolygonClip` `stopClip` `showClipPanel` | 剖切 |
| `startGeometryEdit(id, type)` `stopGeometryEdit` | 几何编辑 |
| `lineIntersect` / `linesIntersect` | 线相交 |
| `replaceTextureByImage/Url/Video` `restoreTexture` | 换贴图 |
| `showUIPanel` `hideUIPanel` `getUIPanel` | `UIPanelType` |

### 需「高级分析」授权

`startContourLineAnalysis` 等高线  
`startCutFillAnalysis` 填挖方  
`startFloodFill` 水淹  
`startSkylineAnalysis` / `exportSkyline` 天际线  
`startSunshineAnalysis` 日照  
`startTerrainSlopeAnalysis` 坡度坡向  
`startViewDomeAnalysis` 开敞度  
`startViewshedAnalysis` 视域  
`startVisiblityAnalysis` 通视  

各有对应 `stop*`。面板类型见 `PanelType`。

## Misc（`fdapi.misc`）

| 方法 | 作用 |
|------|------|
| `isApiVersionMatched()` | ac.min 与服务器是否一致 |
| `playMovie` / `stopMovie` `playVideo` / `stopPlayVideo` `playVideoAlone` / `stopPlayVideoAlone` | 视频 |
| `addImageButtons` `addAnimatedImageButtons` `deleteImageButtons` | 屏幕按钮 |
| `enterMultiViewportMode` / `exit` / `setActiveViewport` / `getActiveViewport` / `setMultiviewportInteractSync` | 多视口 `Viewport` 掩码 |
| `enterReportMode` / `exitReportMode` | 报告模式 |
| `callBPFunction` / `getBPFunction` | 工程级蓝图 |
| `getMaterial(path)` | 材质参数（给 polyline 等） |
| `getConvexPolygon(points)` | 凸包 |
| `hideAllFoliages` / `showAllFoliages` | 植被 |
| `reloadPak` `projectAssetCount` `projectAssetCountAll` | 资产 |
| `switchShortcutKey(onOff)` | 快捷键 |
| `setApiVersionReceived(cb)` | 版本回调 |

## EditHelper（`fdapi.editHelper`）

用户手绘：`start` → `setParam` → `finish` / `cancel`。

## HeatMap / HeatMap3D

`fdapi.heatmap`：`addByHeatPoints` `addByTif` `addPoints` `removePoints` `play`/`pause` `setBBox` `setRange` `setTime` `highlightPixels` `load`。样式 `HeatMapStyle`。

`fdapi.heatmap3d`：**付费**。`addByHeatPoints` `addByImages` `addByTif` `addByVoxels` `addBySparseVoxels` `queryVoxel` `setDisplayMode`。

`fdapi.oceanHeatmap`：海洋 tif 热力，`OceanHeatMapStyle`。

## FloodFill（`fdapi.floodFill`）**付费**

水淹：`add` `setSeed` `setElevation` `setRange` `setPrecision` `setColor`。也可用 `tools.startFloodFill`。

## 水相关（部分付费）

| `fdapi.` | 说明 |
|----------|------|
| `dynamicWater` | 动态水面 |
| `waterMesh` | 网格水面（色/速/方向/UV/浪） |
| `waterFlowField` | 网格水流场 **水仿真授权** |
| `fluid` | 三维流体 **水仿真** |
| `hydrodynamic1d` / `river` | 一维水动力（二者等价）**水仿真** |
| `hydrodynamic2d` | 二维，tif/shp **水仿真** |
| `hydrodynamicModel` | 推荐的二维水动力 |
| `hydrodynamicModel2` | 过时，待移除 |
| `smoothedParticleHydrodynamics` | SPH |

二维样式 `HydroDynamic2DStyle`：真实水 / 热力 / 流场。真实水子模式 `WaterMode`：动画 / 仿真 / 流向箭头。

## 其他分析对象

| `fdapi.` | 用途 | 授权 |
|----------|------|------|
| `finiteElement` / `finiteElement2` | 有限元；2 带盒/面/球裁剪与阈值 | 2 要高级分析 |
| `excavationAnalysis` | 超欠挖 | |
| `vectorField` | 台风/浪/洋流 | 海洋气象 |
| `antenna` | 天线方向图 | 高级分析 |
| `signalWave` | 信号波束 | 高级分析 |

## SettingsPanel（`fdapi.settingsPanel`）

操作内置设置面板全部参数（与 `settings` 单接口互补）。方法见 [api-index.md](api-index.md)。

## Panorama / Video / 大华

- `panorama`：全景图
- `videoProjection`：视频投影（`setVideoURL` `setFovy` `setLocation` `setRotation`）
- `daHuaVideoFusion`：大华 ICC，`serverIP`/`serverPort`/`accessToken`
