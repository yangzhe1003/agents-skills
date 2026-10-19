# AMap / Loca 参考

## Loca 2.0 图层选型

| 图层类 | 用途 | 数据 |
|--------|------|------|
| `LineLayer` | 管段、追踪路径、高亮线 | GeoJSON LineString / MultiLineString |
| `ScatterLayer` | 海量圆点（节点） | GeoJSON Point |
| `IconLayer` | 图标点（水厂/泵站/阀门/监测） | GeoJSON Point + `properties.style.src` |
| `PulseLineLayer` | 流向箭头、脉冲动画 | LineString + 纹理 |
| `PolygonLayer` | 面状区域（按需） | GeoJSON Polygon |

zIndex 建议：底图管段 < 节点/图标 < 高亮/追踪 < 流向动画。

## GeoJSONSource

```ts
const source = new window.Loca.GeoJSONSource({ data: geojson });
layer.setSource(source);
// 更新数据
source.setData(newGeojson);
```

Feature `properties` 约定（水利模型常见）：

- `sid`：唯一标识，拾取与详情联动
- `facilityType`：设施类型，图层筛选
- `color` / `gradeIdx` / `width`：分级着色与线宽
- `style.src`：IconLayer 图标 URL

## AMap 原生覆盖物（少量点）

适用：选中态 Marker、阀门临时标记、InfoWindow（<500 点）。

```ts
new AMap.Marker({ position, map });
new AMap.InfoWindow({ content, offset }).open(map, position);
```

## 暗色地图样式

```ts
map.setMapStyle('amap://styles/<customStyleId>');
// 或初始化
new AMap.Map(container, { mapStyle: 'amap://styles/...' });
```

## TypeScript 声明片段

```ts
// vite-env.d.ts
interface Window {
  Loca?: {
    Container: new (opts: { map: unknown }) => unknown;
    GeoJSONSource: new (opts: { data?: unknown }) => {
      setData: (data: unknown) => void;
    };
    LineLayer: new (opts?: Record<string, unknown>) => LocaLayerLike;
    ScatterLayer: new (opts?: Record<string, unknown>) => LocaLayerLike;
    IconLayer: new (opts?: Record<string, unknown>) => LocaLayerLike;
    PulseLineLayer: new (opts?: Record<string, unknown>) => LocaLayerLike;
  };
  _AMapSecurityConfig?: { securityJsCode: string };
}

interface LocaLayerLike {
  setSource: (source: unknown) => void;
  setStyle: (style: Record<string, unknown>) => void;
  show: () => void;
  hide: () => void;
  on: (event: string, handler: (e: unknown) => void) => void;
  destroy?: () => void;
}
```

## @fid/amap-water

团队封装包；**通用原则**仍适用，额外注意：

### 可直接复用（子路径 import）

```tsx
import { AMapContainer } from '@fid/amap-water/es/components/AMap/AMap';
import { useAMapContext } from '@fid/amap-water/es/components/AMap/hooks/useAMapContext';
// 按需：AMapEvent、AMapMarker、useFocus、eventBus
```

### 能力边界

| 可用 | 不可用 / 需自建 |
|------|----------------|
| `AMapContainer` + `useAMapContext` | `enableLoca={true}`（Loca 2.0 内部初始化失败） |
| `AMapMarker` / `InfoWindow` / `AMapEvent` | 包内 `GeoJSONSource` / `PolygonLayer` React 组件（依赖 `useAMapContext().loca`，不开 enableLoca 时为 null） |
| `useFocus` / `eventBus` 跨面板定位 | 线/点/图标/流向 Loca 图层（包内仅 PolygonLayer 示例） |

### 推荐组合

```
AMapContainer（仅 AMap/map）
  └── LocaBootstrap（动态 Loca SDK + Loca.Container + LocaContext）
        └── LocaLayer 工厂（LineLayer / ScatterLayer / IconLayer / …）
              └── GeoJSONSource（window.Loca.GeoJSONSource）
```

### Vite 片段

```ts
// optimizeDeps.include
'@fid/amap-water/es/components/AMap/AMap',
'@fid/amap-water/es/components/AMap/hooks/useAMapContext',

// manualChunks
if (id.includes('node_modules/@fid/amap-water')) return 'amap-water';

// SVGR exclude
/node_modules\/@fid\/amap-water\/.+\/icons\/(left|right)_light_icon\.svg$/
```

### 传递依赖

`@fid/amap-water` 可能带入 `@antv/l7`、`@antv/larkmap`、`gcoord`、`@turf/turf`。**业务代码禁止 import L7/LarkMap**；坐标转换可用 `gcoord`（传递依赖，不必单独安装）。

## 环境变量模板

```env
VITE_AMAP_KEY=
VITE_AMAP_SECURITY_JS_CODE=
```

## 与 OL / @fid/gis 迁移对照

| 源（OpenLayers） | 目标（AMap + Loca） |
|------------------|---------------------|
| `Map` + VectorLayer | `AMapContainer` + `Loca.LineLayer` |
| WebGLPoints | `Loca.ScatterLayer` / `IconLayer` |
| `ol/Overlay` | React Portal + `lngLatToContainer` |
| `forEachFeatureAtPixel` | `layer.on('click', e => e.feature)` |
| hox store | Zustand slices（map / layer / selection） |
