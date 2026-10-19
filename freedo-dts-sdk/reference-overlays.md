# Freedo 图层与覆盖物：infoTree / tileLayer / marker / customObject / 线面

## InfoTree（`fdapi.infoTree`）— 工程图层树

`get()` 返回图层树。本仓库取 `res.infotree`，节点主键 **`iD`**。

节点 `type`：`EPT_Folder` 文件夹、`EPT_Scene` 场景、`EPT_ModelActor` 模型、`EPT_Measurement`、`EPT_Cut`、`EPT_DynamicWater`。另有 `name`、`visiblity`、`index`、`parentIndex`。

| 方法 | 作用 |
|------|------|
| `get()` | 整树 |
| `show(ids)` / `hide(ids)` / `setVisibility(data)` | 显隐 |
| `showByGroupId` / `hideByGroupId` / `deleteByGroupId` / `highlightByGroupId` | 按组 |
| `focus(ids)` | 定位 |
| `enableXRay(ids, color)` / `disableXRay(ids)` | 树节点 X 光 |
| `callBPFunction(data)` / `getBPFunction(ids)` | 蓝图 |

XRay 也可在 `tileLayer` 上对 3DT 做，本仓库建筑透视多用 `tileLayer.enableXRay`。

## TileLayer（`fdapi.tileLayer`）— 3DT

`add({ id, fileName, password, wkt, visible, location, rotation, scale, viewHeightRange, releaseWhenHidden })`。`fileName` 推荐 `@path:/3dt/xxx.3dt`。球面工程里 `location` 是米偏移，不是绝对坐标。

### 图层级

`show`/`hide`/`delete`/`clear`/`get`/`update`/`focus(ids, distance, flyTime, rotation)`
`enableXRay(ids, color)` / `disableXRay`
`enableClip` / `disableClip`
`setStyle(ids, style, color, saturation, brightness, contrast, ...)`
`setLocation` / `setRotation` / `setScale` / `setFileName` / `setViewHeightRange` / `setViewportVisible`
`setCollision` / `getCollision`
`setAltitudeHeatMap` `setPointCloudStyle` `setPointCloudSize` `setPointCloudBoxVisible`
`enableDecal` `enableFluid` `enableImageLayerDecal`

### Actor 级

`showActor(id, objectId)` / `hideActor` / `showActors` / `hideActors` / `showAllActors` / `hideAllActors`
`focusActor(id, objectId, distance, flyTime, rotation)` / `focusActors`
`highlightActor` / `highlightActorWithColor` / `highlightActors` / `highlightActorsWithColor`
`unHighlightActor` / `unHighlightActors` / `unHighlightAllActors`
`highlightPoints` / `unHighlightPoints` / `unHighlightAllPoints`
`getActorInfo` / `getActorInfoFromDB` / `getObjectIDs` / `getDBTabID`
`query(queryOption)` / `createQuery` / `updateRecord`

### 挖洞 / 压平

`addHole` / `addHoleByShapeFile` / `updateHole` / `deleteHole` / `clearHole`
`addModifier` / `addModifiers` / `addModifierByShapeFile` / `updateModifier` / `deleteModifier` / `clearModifier` / `getAllFlattenInfo`

批量改：`updateBegin()` … `updateEnd()`。

`focus` 的 `rotation` 为 `[Pitch,Yaw,Roll]`。本仓库常用 `focus(id, 20, 2, [-45,-90,0])`。

## Marker（`fdapi.marker`）— 2D 标注（推荐）

单次 `add` ≤ 5000，工程内总量 ≤ 20 万。Tag/CustomTag 已停更。

```js
await fdapi.marker.add({
  id: "p1",
  groupId: "出水泵站设备",
  coordinateType: 0,
  coordinate: [x, y, z],
  imagePath: "@path:/images/tag.png",
  imageSize: [32, 32],
  text: "名称",
  showLine: true,
  lineSize: [2, 20],
  popupURL: "@path:/html/popup.html",
  popupSize: [600, 400],
  range: [10, 10000],
});
```

关键字段：`id` `groupId` `userData` `coordinateType` `coordinate` `anchors` `range` `textRange` `viewHeightRange` `rangeRatio` `imageSize` `fixedSize` `imagePath` `hoverImagePath` `hoverImageSize` `text` `useTextAnimation` `textOffset` `fontSize` `fontOutlineSize` `textBackgroundColor` `fontColor` `fontOutlineColor` `popupBackgroundColor` `popupURL` `popupSize` `popupOffset` `showLine` `lineSize` `lineColor` `lineOffset` `autoHidePopupWindow` `autoHideText` `autoHeight` `displayMode` `clusterByImage` `priority` `occlusionCull`。

`displayMode`：0 移动时藏+聚合；1 移动时显+聚合；2 显不聚合；3 藏不聚合；4 智能 LOD（默认）；5 聚合点击返回被聚合 ids。

CRUD：`add` `update` `delete` `deleteByGroupId` `clear` `get`
显隐：`show` `hide` `showAll` `hideAll` `showByGroupId` `hideByGroupId`
弹窗：`showPopupWindow` `hidePopupWindow` `showAllPopupWindow` `hideAllPopupWindow`
定位：`focus` `focusAll`
跟随：`setAttachMovingObject(data)`（本仓库旧码可能是 `setAttachCustomObject`）
聚合：`setClusterStyle`
单字段 setter：`setCoordinate` `setImagePath` `setText` `setPopupURL` `setRange` …

## Marker3D（`fdapi.marker3d`）

3D 动态标注。方法：`add` `update` `delete` `deleteByGroupId` `clear` `get` `show`/`hide`/`showAll`/`hideAll`/`ByGroupId` `focus` `setAttachCustomObject` `setViewHeightRange` `callBPFunction` `getBPFunction`。

## CustomObject（`fdapi.customObject`）— 场景内可动模型

必须是 **蓝图 Actor**。`pakFilePath` + `assetPath`（UE 工程内相对路径）。

```js
await fdapi.customObject.add({
  id: "car1",
  pakFilePath: "@path:/pak/xxx.pak",
  assetPath: "/Game/...",
  location: [x, y, z],
  coordinateType: 0,
  rotation: [pitch, yaw, roll],
  localRotation: [0, 0, 0],
  range: [0, 10000],
  isEffectRotation: true,
});
```

从 3DT 复制 Actor（仅默认样式图层）：

```js
fdapi.customObject.addByTileLayer({
  id, tileLayerId, objectId, location, rotation, scale,
});
```

轨迹（`time` 必须从 0 起）：

```js
fdapi.customObject.startMove(id, 0, [
  { time: 0, coordinate: [x1, y1, z1], rotation: [0, 90, 0] },
  { time: 5, coordinate: [x2, y2, z2] },
]);
```

`pause` / `resume` / `stop` / `moveTo` / `setMoveRate` / `setSmoothMotion` / `setSmoothTime`

蓝图：

```js
fdapi.customObject.callBPFunction([{
  id: "truck",
  functionName: "状态",
  parameters: [
    { paramType: 0, paramValue: 1 }, // BPFuncParamType
  ],
}]);
```

本仓库有的封装叫 `callBatchBPFunction`，官方方法名是 `callBPFunction`（支持数组即批量）。

其他：`glow`/`stopGlow` `highlight`/`unHighlight` `setTintColor` `overrideMaterial`/`restoreMaterial` `showGrowth` `setLocation`/`setRotation`/`setScale` `focus(ids, distance, flyTime, rotation, actionMode, offset)` — `actionMode` 见 `ActionMode`（跟随）。

## Polyline（`fdapi.polyline`）

```js
fdapi.polyline.add({
  id, coordinates: [[x,y,z], ...], coordinateType: 0,
  color, thickness: 20, intensity: 0.5,
  style: /* PolylineStyle: Arrow=0, Flow=2, Beam=3 */,
});
```

`setCoordinates` `setColor` `setThickness` `setStyle` `setShape` `setFlowRate` `setBrightness` `setDepthTest` `setViewHeightRange`
`show`/`hide`/`showAll`/`hideAll` `focus` `clear` `delete` `update`

自定义材质：`await fdapi.misc.getMaterial(materialPath)` 看 `params`。

## Polygon / Polygon3D

`fdapi.polygon` / `fdapi.polygon3d`：`add`/`update`/`delete`/`clear`/`show`/`hide`/`focus`/`get`。
样式：`PolygonStyle`（单色/圆点/体积/渐变）、`Polygon3DStyle`（Wave/LoopLine/Gradual…）。
坐标带洞用「单 Part + 内环」或「多 Part」，见 core 分册。

## 其他覆盖物（方法都是 add/update/delete/show/hide/focus）

| `fdapi.` | 类 | 用途 |
|----------|----|------|
| `odline` | ODLine | 迁徙/OD |
| `beam` | Beam | 光流/车流粒子 |
| `highlightArea` | HighlightArea | 区域高亮 |
| `radiationPoint` | RadiationPoint | 辐射圈 |
| `customMesh` | CustomMesh | 自定义三角网 |
| `decal` | Decal | 贴花 |
| `splineMesh` | SplineMesh | 路径模型（围挡/墙/路） |
| `topologyLine` | TopologyLine | 连图层树模型的拓扑线 |
| `markerLayer` | MarkerLayer | 三级聚合标注层 |
| `light` | Light | 光源 |
| `tag` / `customTag` | 停更 | 用 marker |

## GeoJSON / Shapefile / Cesium3DTiles / 影像

- `geoJSONLayer`：符号化加载，`RendererType` + `VisualType`；`highlightFeature*` / `focusFeature`
- `shapeFileLayer`：矢量 shp
- `cesium3DTileset`：3D Tiles
- `imageryLayer`：WMS/WMTS/MapServer（平面）
- `imageryLayer2`：球面 WMTS/WMS/MVT/TMS
- `globeTerrain`：球面地形影像
- `gaussianSplatting`：3D 高斯

## 通用 CRUD 习惯

多数对象：`add(data|array)`、`update`、`delete(ids)`、`clear()`、`get(ids)`、`show`/`hide`、`focus(ids, distance, flyTime, rotation)`。
批量 setter 夹在 `updateBegin()` 与 `updateEnd()` 之间，减少往返。
