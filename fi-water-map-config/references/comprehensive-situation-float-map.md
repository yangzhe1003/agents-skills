# ComprehensiveSituationFloatMap 配置指南

## 1. 组件与顶层配置

`ComprehensiveSituationFloatMap` 是 `@fid/amap-water` 的综合态势地图组件。它在一张高德/L7 地图中组合三类图层：

- `FloatPolygonLayer`：立体行政区或服务范围面，并为罗盘背景提供自动范围。
- `FloatMapMarkerLayer`：营业厅、水厂、泵站、监测点等业务点位。
- `AMapWaterL7PipeLineLayers`：供水管网等 GeoJSON 线图层。

它与 `AMapWaterPro` 的配置模型不同：**只使用统一的 `layerConfigs`，不能传入 `boundaries`、`monitorLayers`、`wmsLayers`、`geojsonLayers` 分组配置。**

```tsx
import {
  ComprehensiveSituationFloatMap,
  type I_ComprehensiveSituationFloatMapProps,
} from "@fid/amap-water";

const props: I_ComprehensiveSituationFloatMapProps = {
  appKey: "fi-big-screen",
  busKey: "map-default",
  mapConfig: {
    center: [116.397428, 39.90923],
    zoom: 11,
    viewMode: "3D",
    pitch: 45,
    mapStyle: "amap://styles/19721f2b1f35ffb6c64e92580162b982",
    mapTexture: "/assets/maps/service-area-texture.png",
  },
  layerConfigs: [],
  footerLayerControllerStyle: { top: 150, right: 450 },
};

<ComprehensiveSituationFloatMap {...props} style={{ height: "100%" }} />;
```

### 1.1 必填 Props

| 字段           | 类型                                    | 说明                                  |
| -------------- | --------------------------------------- | ------------------------------------- |
| `appKey`       | `string`                                | 点位业务数据请求使用的应用标识。      |
| `busKey`       | `string`                                | 点位业务数据请求使用的事件/业务标识。 |
| `mapConfig`    | `I_MapConfig & { mapTexture?: string }` | 高德地图初始选项与面贴图。            |
| `layerConfigs` | `any[]`                                 | 点、面、管线统一图层配置数组。        |

`style` 可选，但地图容器必须最终获得有效高度。不要在未查看调用处时任意设置固定高度。

### 1.2 mapConfig

`mapConfig` 会透传给 `AMapContainer`，可使用高德地图支持的基础选项。综合态势地图直接使用以下字段：

| 字段         | 说明                                                           | 示例                                               |
| ------------ | -------------------------------------------------------------- | -------------------------------------------------- |
| `center`     | 初始中心点，严格按 `[lng, lat]` 填写。                         | `[116.397428, 39.90923]`                           |
| `zoom`       | 初始缩放级别；未提供时综合态势地图内部缩放状态以 `13` 初始化。 | `11`                                               |
| `viewMode`   | 行政区立体效果应设为 `'3D'`。                                  | `'3D'`                                             |
| `pitch`      | 3D 俯仰角。                                                    | `45`                                               |
| `mapStyle`   | 高德地图样式 ID。                                              | `'amap://styles/19721f2b1f35ffb6c64e92580162b982'` |
| `mapTexture` | 行政区面顶部贴图 URL。                                         | `'/assets/maps/service-area-texture.png'`          |

### 1.3 底部控制器与罗盘 Props

| 字段                             | 默认值   | 说明                                                                                       |
| -------------------------------- | -------- | ------------------------------------------------------------------------------------------ |
| `footerLayerControllerStyle`     | —        | 底部控制器外层内联样式，可使用 `top`、`right`、`bottom`、`left`、`transform` 等 CSS 属性。 |
| `footerLayerControllerClassName` | —        | 底部控制器外层附加 className。                                                             |
| `showCompassBackground`          | `true`   | 是否显示内置罗盘图片。                                                                     |
| `compassBackgroundExtent`        | 自动计算 | 显式罗盘范围 `[minLng, minLat, maxLng, maxLat]`。传入后不再根据面图层计算。                |
| `compassBackgroundPaddingRatio`  | `0.3`    | 自动计算罗盘范围时的外扩留白比例。                                                         |
| `compassBackgroundOffsetX`       | `-5000`  | X 方向偏移，单位米；正数向东，负数向西。                                                   |
| `compassBackgroundOffsetY`       | `-10000` | Y 方向偏移，单位米；正数向北，负数向南。                                                   |
| `compassBackgroundOpacity`       | —        | 当前版本无效：罗盘图层样式固定为不透明，不能用该字段改变透明度。                           |

### 1.4 行政区挤出厚度

| 字段               | 默认值  | 说明                                                                                         |
| ------------------ | ------- | -------------------------------------------------------------------------------------------- |
| `extrudeLayerSize` | `30000` | 顶层 Props。透传给 `FloatPolygonLayer`，同时控制三层挤出高度与顶面抬升。只认这一处，不是图层项字段。 |

```ts
{
  mapConfig: { viewMode: '3D', mapTexture: '/assets/maps/service-area.png' },
  layerConfigs: [/* FloatPolygonLayer */],
  extrudeLayerSize: 15000,
}
```

- 必须写在与 `mapConfig`、`layerConfigs` 同级的顶层。
- 不要写进 `mapConfig`，也不要写进某个 `FloatPolygonLayer` 的 `compProps` 或图层项。
- 未传时组件内部默认 `30000`。数值变小则立体面更矮，变大则更高。
- 挤出颜色仍由综合态势地图写死，不能按图层覆盖。

罗盘图片是组件内置资源，与 `mapTexture` 无关。若未提供 `compassBackgroundExtent`，组件会请求全部 `FloatPolygonLayer.source.url`，合并各 GeoJSON 的 bbox 后按留白比例扩展范围。没有面图层且又未传显式范围时，不会显示罗盘背景。

---

## 2. layerConfigs

`layerConfigs` 是统一数组。组件只识别以下三个 `compName`，未知类型不会渲染：

| `compName`                  | 用途                                  | `source`                               | 可见性                             |
| --------------------------- | ------------------------------------- | -------------------------------------- | ---------------------------------- |
| `FloatMapMarkerLayer`       | 厂站、监测点、事件等业务 Point 要素。 | WFS 或返回 Point GeoJSON 的接口。      | 依赖底部控制器状态。               |
| `AMapWaterL7PipeLineLayers` | 供水管网等线要素。                    | WFS 或返回 LineString GeoJSON 的接口。 | 依赖底部控制器状态和可选 `zooms`。 |
| `FloatPolygonLayer`         | 行政区、服务范围等面要素。            | 静态或动态 GeoJSON URL。               | 不依赖底部控制器，始终渲染。       |

所有图层 `key` 必须在同一数组中唯一。`title` 用作底部按钮文本；非可切换图层的 `title` 不影响渲染。

### 2.1 点位：FloatMapMarkerLayer

```ts
{
  key: 'station',
  title: '营业厅',
  compName: 'FloatMapMarkerLayer',
  showToggle: true,
  toggleVisible: true,
  source: {
    layerName: 'workspace:business_station',
    url: '/geoserver/workspace/wfs',
    params: {
      service: 'WFS',
      version: '2.0.0',
      request: 'GetFeature',
      typeName: 'workspace:business_station',
      outputFormat: 'application/json',
      srsName: 'EPSG:4326',
    },
  },
  marker: {
    icon: '/assets/icons/station.png',
    clusterIcon: '/assets/icons/station-cluster.png',
    iconWidth: '36px',
    iconHeight: '36px',
    defaultCluster: true,
    compName: 'StationModal',
    compProps: {
      defaultVisible: true,
    },
  },
}
```

#### source

- `source.url` 必填，必须返回 GeoJSON。
- WFS 请求参数放入 `source.params`；点位层会以 GET 方式携带这些参数，并补充 GeoServer 鉴权参数。
- `source.layerName` 可作为配置元数据保留，但当前点位请求逻辑不读取它。
- 响应中只有 `Point` 几何会参与渲染；解析后的业务属性还必须包含 `biz_data_id`，否则不会进入实际点位列表。

#### marker

| 字段                       | 说明                                                                              |
| -------------------------- | --------------------------------------------------------------------------------- |
| `icon`                     | 非聚合点图标 URL；缺省时使用默认 marker 图片。                                    |
| `clusterIcon`              | 聚合点图标 URL。                                                                  |
| `iconWidth` / `iconHeight` | 图标尺寸，例如 `'36px'`；聚合点使用宽高，静态点当前只会读取已传宽度。             |
| `defaultCluster`           | `true` 使用聚合点图层，`false` 使用静态点图层。                                   |
| `compName`                 | 业务弹窗组件键名，必须已在项目 `BizComp` 中注册。未注册会导致对应弹窗不可用。     |
| `compProps`                | 原样传给业务弹窗组件。`defaultVisible`、`modalUrl` 等是否生效由业务组件自身决定。 |

> `marker.compName` 是业务弹窗组件；顶层 `compName: 'FloatMapMarkerLayer'` 才是地图图层类型。两者职责不同，不可互换。

### 2.2 管线：AMapWaterL7PipeLineLayers

```ts
{
  key: 'pipeline',
  title: '供水管网',
  compName: 'AMapWaterL7PipeLineLayers',
  showToggle: true,
  toggleVisible: false,
  source: {
    url: '/geoserver/workspace/wfs',
    params: {
      service: 'WFS',
      version: '2.0.0',
      request: 'GetFeature',
      typeName: 'workspace:water_pipeline',
      outputFormat: 'application/json',
      srsName: 'EPSG:4326',
    },
  },
  zooms: [10, 18],
  enableAnimateZoom: 13,
  compProps: {},
}
```

- `source.url` 必填；请求以 GET 发出，`source.params` 会与 GeoServer 鉴权参数合并。
- `zooms: [minZoom, maxZoom]` 表示仅在当前缩放级别落在该闭区间时显示；它会进一步限制底部选择产生的可见状态。
- `enableAnimateZoom` 的含义：`true`/`false` 固定开关动画；数值表示 `zoom >= 该值` 时启用动画；未配置时默认启用。
- `compProps` 会透传给下游 `L7PipeLineLayer`。其中 `visible` 会被综合态势地图自身的可见状态覆盖，不要通过 `compProps.visible` 控制显示。
- 线数据如果标有 `EPSG:3857` CRS，管线图层有专门转换逻辑；不要因此假设点位和面图层也会自动转换。

### 2.3 行政区面：FloatPolygonLayer

```ts
{
  key: 'service-area',
  title: '服务范围',
  compName: 'FloatPolygonLayer',
  showToggle: false,
  source: {
    url: '/assets/maps/service-area.geojson',
    params: {},
  },
}
```

- `source.url` 必填，必须返回 GeoJSON 面数据。
- 组件以 GET 请求面数据；当前不读取 `source.params`、`source.layerName`、`marker`、`compProps`、`toggleVisible`。
- 综合态势地图使用专属三层挤出颜色，并把 `mapConfig.mapTexture` 用作面贴图。挤出尺寸由顶层 `extrudeLayerSize` 控制，默认 `30000`；不支持通过每个面图层配置覆盖颜色或尺寸。
- 面图层不依赖底部开关，通常设为 `showToggle: false`，仍会持续显示，并可供罗盘自动计算范围。

---

## 3. 底部图层单选与可见性

综合态势地图的底部控制器对所有 `showToggle: true` 的图层执行**强制单选**，不区分点位层还是管线层。

1. 只有 `showToggle: true` 的配置生成按钮，并写入可见状态。
2. 若多个 `toggleVisible` 为 `true`，组件按 `layerConfigs` 数组顺序仅保留第一个为选中状态。
3. 若没有图层初始选中，组件自动选中第一个可切换图层。
4. 点击按钮会隐藏其他所有可切换图层，只显示当前图层。
5. `FloatPolygonLayer` 即使 `showToggle: false` 仍会渲染；点位和管线图层若 `showToggle: false` 没有可见状态，会被隐藏。

因此：

- 将需要**互斥**展示的业务点、管网或其他可切换层设置为 `showToggle: true`。
- 不要期望两个可切换点位层或点位层与管线层同时展示。
- 将需要恒定展示的行政区面设置为 `showToggle: false`。
- 如果业务要求“多个点位和管线始终同时显示”，当前组件的单选机制不适用，不能只靠设置 `toggleVisible` 解决。

---

## 4. 数据源、坐标系与字段限制

### 4.1 WFS 和静态 GeoJSON

WFS 常用参数：

```ts
{
  service: 'WFS',
  version: '2.0.0',
  request: 'GetFeature',
  typeName: 'workspace:layer_name',
  outputFormat: 'application/json',
  srsName: 'EPSG:4326',
}
```

- 点位和管线会读取 `source.params`；面图层当前只读取 `source.url`。
- 用静态 GeoJSON 时使用资源 URL，例如 `'/assets/maps/service-area.geojson'`，可保留 `params: {}` 以统一配置结构。
- 确认代理路径、鉴权参数和 `typeName` 与现有项目保持一致；不要把示例中的工作区名直接带入业务项目。

### 4.2 坐标系

高德底图使用 GCJ-02。综合态势地图当前：

- 不会自动将点位和行政区面 GeoJSON 的 WGS84/CGCS2000 坐标转换为 GCJ-02。
- `srsName: 'EPSG:4326'` 只是 WFS 请求参数，不会触发客户端坐标转换。
- 应在上线前用已知点位验证服务坐标是否与底图重合；若不重合，在统一数据入口转换，避免把转换逻辑散落到各业务图层。
- 仅管线图层对响应的 `EPSG:3857` CRS 有专门处理，不能作为点位、面图层的坐标转换依据。

### 4.3 已知字段限制

| 字段                                                           | 实际行为                                                              |
| -------------------------------------------------------------- | --------------------------------------------------------------------- |
| `source.layerName`                                             | 不决定网络请求，可作为业务元数据保留。                                |
| 点位层外层 `compProps`                                         | 当前点位渲染器不读取；应使用 `marker.compProps` 传给业务弹窗。        |
| 面图层 `source.params`、`marker`、`compProps`、`toggleVisible` | 当前面图层不读取。                                                    |
| `compassBackgroundOpacity`                                     | Props 中存在，但罗盘内部样式固定为 `opacity: 1`，当前无法配置透明度。 |
| `mapConfig.extrudeLayerSize`、面图层项上的 `extrudeLayerSize` / `compProps.extrudeLayerSize` | 当前不读取；挤出厚度只认顶层 `extrudeLayerSize`。                     |
| 未知 `compName`                                                | 不会被综合态势地图的点、面、管线渲染器消费。                          |

---

## 5. 组合模板

下面的模板只含“一个可切换点位层 + 一个恒定显示面图层”。若要加管线，将管线加入 `layerConfigs` 并接受它与点位层互斥选择的行为。

```ts
export const comprehensiveSituationMapProps = {
  appKey: "fi-big-screen",
  busKey: "map-default",
  mapConfig: {
    center: [116.397428, 39.90923],
    zoom: 11,
    viewMode: "3D",
    pitch: 45,
    mapStyle: "amap://styles/19721f2b1f35ffb6c64e92580162b982",
    mapTexture: "/assets/maps/service-area-texture.png",
  },
  layerConfigs: [
    {
      key: "station",
      title: "营业厅",
      compName: "FloatMapMarkerLayer",
      showToggle: true,
      toggleVisible: true,
      source: {
        url: "/geoserver/workspace/wfs",
        params: {
          service: "WFS",
          version: "2.0.0",
          request: "GetFeature",
          typeName: "workspace:business_station",
          outputFormat: "application/json",
          srsName: "EPSG:4326",
        },
      },
      marker: {
        icon: "/assets/icons/station.png",
        clusterIcon: "/assets/icons/station-cluster.png",
        iconWidth: "36px",
        iconHeight: "36px",
        defaultCluster: true,
        compName: "StationModal",
        compProps: { defaultVisible: true },
      },
    },
    {
      key: "service-area",
      title: "服务范围",
      compName: "FloatPolygonLayer",
      showToggle: false,
      source: {
        url: "/assets/maps/service-area.geojson",
        params: {},
      },
    },
  ],
  footerLayerControllerStyle: {
    top: 150,
    right: 450,
  },
  extrudeLayerSize: 30000,
};
```

配置完成后依次检查：地图中心是否为 `[经度, 纬度]`、所有 `key` 是否唯一、GeoJSON 是否可访问、点位是否有业务标识、弹窗组件是否注册、行政区是否使用 3D 视图、挤出厚度是否写在顶层 `extrudeLayerSize`，以及可切换图层是否满足“只显示一个”的产品要求。

---

## 6. `@fid/amap-water` 文档 demo 与租户 mock

综合态势组件的文档页只挂**一张**地图。租户差异用 mock 文件 + 下拉切换，不要再为每个租户建独立 demo 页。

| 文件 | 作用 |
| ---- | ---- |
| `src/components/ComprehensiveSituationFloatMap/demos/base.tsx` | 唯一文档 demo：左上角下拉选租户，下方 JSON 可编辑，点「更新」后重建地图。 |
| `src/components/ComprehensiveSituationFloatMap/demos/mock.ts` | 铁岭 mock。 |
| `src/components/ComprehensiveSituationFloatMap/demos/mock-huailai.ts` | 怀来 mock；挤出厚度等顶层字段写在这里。 |
| `src/components/ComprehensiveSituationFloatMap/index.md` | 组件文档；底部只用 `<code src="./demos/base.tsx"></code>`。 |

新增租户 mock 时：

1. 新增 `demos/mock-<tenant>.ts`，导出一份可直接 spread 给组件的对象。
2. 把该对象登记进 `base.tsx` 的 `MOCK_OPTIONS`。
3. 需要挤出厚度、罗盘偏移时写在 mock **顶层**，例如 `extrudeLayerSize`、`compassBackgroundOffsetX`。
4. 不要新增 `demos/base-<tenant>.tsx`，也不要在 `index.md` 再加一个 `<code src>`。
5. `index.md` 里仅作说明的 `tsx`/`ts` 代码块必须写成 `tsx \| pure` / `ts \| pure`。普通 `tsx` 会被 dumi 当 live demo 执行，未定义的 `mapConfig` 会报 `ReferenceError`。
6. 删除已被 `index.md` 引用过的 demo 文件前，先确认文档服务已停，并清掉 `.dumi/tmp` 与 `node_modules/.cache/dumi`，否则会 `ENOENT`。
