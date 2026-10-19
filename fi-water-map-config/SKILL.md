---
name: fi-water-map-config
description: Use when 配置、创建、修改或审阅 fi 水务大屏地图，或调整综合态势挤出厚度/extrudeLayerSize、租户 mock、罗盘偏移。适用于 AMapWaterPro、ComprehensiveSituationFloatMap、@fid/amap-water、地图中心点、行政边界、监测点、WFS/GeoJSON、WMS、L7 管线、3D 建筑、标点聚合、底部图层控制；用户提到“fi 水务地图配置”“水务大屏地图”“AMapWaterPro”“ComprehensiveSituationFloatMap”或“挤出厚度”时使用。
---

# fi 水务地图配置

本技能用于在 fi 项目中配置或调整水务地图。当前支持 `AMapWaterPro` 与 `ComprehensiveSituationFloatMap`。两者的配置模型不同，必须先确认页面实际使用的组件，再读取对应参考；禁止将两套字段混用。

## 支持范围与扩展约定

| 地图类型                                              | 状态           | 配置模型                                                         | 参考资料                                          |
| ----------------------------------------------------- | -------------- | ---------------------------------------------------------------- | ------------------------------------------------- |
| `AMapWaterPro`（`@fid/amap-water`）                   | 已支持         | `boundaries`、`monitorLayers`、`wmsLayers`、`geojsonLayers` 分组 | `references/amap-water-pro.md`                    |
| `ComprehensiveSituationFloatMap`（`@fid/amap-water`） | 已支持         | 统一 `layerConfigs`，包含点、面、管线三类图层                    | `references/comprehensive-situation-float-map.md` |
| 其他 fi 地图组件                                      | 预留，尚未支持 | —                                                                | 后续在 `references/` 增加专属文档，并在此表登记   |

`ComprehensiveSituationFloatMap` 不使用 `AMapWaterPro` 的 `boundaries`、`monitorLayers`、`wmsLayers`、`geojsonLayers` 分组配置；它只读取 `layerConfigs` 中 `FloatMapMarkerLayer`、`FloatPolygonLayer` 与 `AMapWaterL7PipeLineLayers` 三种 `compName`。

当用户提出尚未被覆盖的地图组件配置需求时，先说明它不在本技能支持范围；只有拿到对应组件的配置文档或项目实现后，才扩展本技能。不要根据其他组件的 API 猜测字段。

## 工作流程

1. 定位页面使用的地图组件和配置对象，再选择对应参考：
   - `AMapWaterPro`：读取 `references/amap-water-pro.md`。
   - `ComprehensiveSituationFloatMap`：读取 `references/comprehensive-situation-float-map.md`。
2. 修改现有项目配置前，先阅读调用处和现有配置；保持该项目既有的命名、代理路径、鉴权方式、坐标系和配置风格。
3. 配置 `AMapWaterPro` 时，按需求选择分组图层：
   - 行政范围：`boundaries`。
   - 厂站、监测点、事件、人员、工单等点位：`monitorLayers`。
   - 仅展示且无需拾取的瓦片底图：`wmsLayers`。
   - 需要动画或要素拾取的管线、3D 建筑白模：`geojsonLayers`。
4. 配置 `ComprehensiveSituationFloatMap` 时，在一个 `layerConfigs` 数组中选择正确的 `compName`：
   - 行政区或服务范围面：`FloatPolygonLayer`。
   - 厂站、监测点、事件等点位：`FloatMapMarkerLayer`。
   - 供水管网等线：`AMapWaterL7PipeLineLayers`。
   - `showToggle: true` 的图层会进入底部控制器，且所有可切换图层强制单选；面图层通常设为 `showToggle: false`。
   - 行政区挤出厚度用顶层 `extrudeLayerSize`（默认 `30000`），不要写进 `mapConfig` 或某个 `FloatPolygonLayer` 项。
5. 根据数据来源配置 `source`：
   - GeoServer 要素用 WFS 请求参数，如 `service: 'WFS'`、`request: 'GetFeature'`、`outputFormat: 'application/json'`、`srsName: 'EPSG:4326'`。
   - `AMapWaterPro` 的实时业务数据使用动态 API 时，明确 `method: 'POST'` 与 `keyType`。
   - 静态 GeoJSON 使用文件 URL，并传 `params: {}`；综合态势地图的面图层实际只读取 `source.url`。
6. 校验配置与展示目标是否一致：
   - 所有地图中心点均为 `[lng, lat]`，不要颠倒经纬度。
   - 高德底图使用 GCJ-02；综合态势地图不会自动转换点位和面 GeoJSON 的 WGS84/CGCS2000 坐标。
   - 3D 行政区面或建筑效果需要 `mapConfig.viewMode: '3D'`。
   - `AMapWaterPro` 的 `zooms`、聚合和图层交互性遵循其专属参考。
   - `ComprehensiveSituationFloatMap` 的 `key` 必须全局唯一，且不可把希望同时显示的点位/管线都纳入底部单选图层。
7. 在 `@fid/amap-water` 改综合态势文档 demo 时：租户配置放 `demos/mock-<tenant>.ts`，登记到 `demos/base.tsx` 的下拉和 JSON 编辑器；`index.md` 里仅展示的 `tsx`/`ts` 代码块必须加 `| pure`。详见参考第 6 节。
8. 如果执行代码变更，完成后运行项目已有的类型检查、lint 或相关测试；如缺少运行条件，应清楚说明未验证项。

## 配置输出规范

- 用户要求“配置”而未要求改代码时，先给出与目标组件匹配、可直接粘贴的 TypeScript 对象或 JSON，并说明需要替换的业务值：坐标、行政区名称、服务地址、`typeName`、图标路径、业务弹窗组件及接口字段。
- 用户没有说明组件类型时，先从现有调用处确认；无法确认时，给出 `AMapWaterPro` 与 `ComprehensiveSituationFloatMap` 的最小差异并要求明确组件，不输出混合配置。
- 综合态势地图的 `marker.compName` 必须是项目 `BizComp` 中已注册的组件键名；`marker.compProps` 只由对应业务弹窗解释。
- 对没有实现或文档证明的属性，标记为待确认，不能当作已支持 API 输出。例如当前综合态势地图的 `compassBackgroundOpacity` 已声明但实际不会改变罗盘透明度。
- 用户没有指定地图高度时，不凭空写死样式；沿用调用处现有的 `style`。

## 速查：ComprehensiveSituationFloatMap 结构

```ts
const config = {
  appKey: "fi-big-screen",
  busKey: "map-default",
  mapConfig: {
    center: [116.102249, 38.704216],
    zoom: 13,
    viewMode: "3D",
    pitch: 45,
    mapStyle: "amap://styles/19721f2b1f35ffb6c64e92580162b982",
    mapTexture: "/assets/maps/service-area.png",
  },
  layerConfigs: [
    {
      key: "station",
      title: "营业厅",
      compName: "FloatMapMarkerLayer",
      showToggle: true,
      toggleVisible: true,
      source: { url: "/geoserver/workspace/wfs", params: {} },
      marker: {
        icon: "/assets/icons/station.png",
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
      source: { url: "/assets/maps/service-area.geojson", params: {} },
    },
  ],
  footerLayerControllerStyle: { top: 150, right: 450 },
  extrudeLayerSize: 30000,
};
```

这是结构模板而非通用业务配置。实际项目的 `appKey`、`busKey`、地图中心、服务路径、图层名称、图标资源和弹窗组件应来自现有配置或用户提供的业务资料。

## 参考资料导航

### AMapWaterPro

在处理 `AMapWaterPro` 需求前，按问题阅读 `references/amap-water-pro.md` 的相关部分：

- 地图视角、底图、卫星图、聚合：第 1.1、1.6 节。
- 行政边界：第 1.2 节。
- 点位、弹窗及三类数据源：第 1.3 节。
- WMS 瓦片：第 1.4 节。
- L7 管线、动画与建筑白模：第 1.5 节。
- 事件总线：第 6 节。
- 组合配置模板与典型场景：第 2 至 4 节。

### ComprehensiveSituationFloatMap

处理综合态势地图需求时，读取 `references/comprehensive-situation-float-map.md`：

- 顶层 Props、地图视角、罗盘和挤出厚度：第 1 节。
- 统一 `layerConfigs`、点/面/管线图层：第 2 节。
- 底部单选、默认选中与可见性限制：第 3 节。
- WFS、GeoJSON、坐标系及无效字段：第 4 节。
- 可直接改造的组合模板：第 5 节。
- `@fid/amap-water` 文档 demo 与租户 mock：第 6 节。

## 完成检查清单

### AMapWaterPro

- [ ] `mapConfig.center` 是 `[经度, 纬度]`。
- [ ] 每个图层 `key` 在同一地图配置内唯一。
- [ ] WFS 图层包含正确的请求参数、空间参考与 `typeName`。
- [ ] 动态 API 图层同时设置 `method: 'POST'`、`keyType` 与业务 URL。
- [ ] 需要开关的监测点图层设置 `toggleVisible: true`。
- [ ] 不进底栏的图层设置 `enable: false`，并用 `toggleVisible` 控制地图默认显隐。
- [ ] 使用白模时已开启 3D 视图。
- [ ] `zooms`、聚合、图层交互性满足用户的展示和性能目标。

### ComprehensiveSituationFloatMap

- [ ] `appKey`、`busKey`、`mapConfig`、`layerConfigs` 已提供，且地图容器有有效高度。
- [ ] `mapConfig.center` 是 `[经度, 纬度]`，点位和面数据已与高德底图坐标系对齐。
- [ ] 每个 `layerConfigs[].key` 唯一，`compName` 仅使用该组件支持的三种图层类型。
- [ ] `FloatMapMarkerLayer`、`AMapWaterL7PipeLineLayers` 的可见图层已设置 `showToggle: true`，并接受底部图层强制单选。
- [ ] `FloatPolygonLayer` 有可访问的 `source.url`，通常设置 `showToggle: false`，并已启用 `viewMode: '3D'`。
- [ ] 点位 WFS 返回 Point GeoJSON 和业务标识；`marker.compName` 已在 `BizComp` 注册。
- [ ] 需要罗盘背景时，已提供有效面图层或显式 `compassBackgroundExtent`；不依赖当前无效的 `compassBackgroundOpacity` 调整透明度。
- [ ] 需要调整立体面高度时，只改顶层 `extrudeLayerSize`，不要写在 `mapConfig` 或 `layerConfigs` 里。
- [ ] 在 `@fid/amap-water` 增加租户 mock 时，只加 `demos/mock-<tenant>.ts` 并登记到 `demos/base.tsx` 下拉，不另建 `base-<tenant>.tsx`。
