---
name: amap-dev
description: |
  高德 AMap Web JS API 和 Loca 2.0 可视化图层开发指南。适用范围：
  - 项目使用 AMapContainer、@fid/amap-water、webapi.amap.com、Loca
  - 涉及地图图层（LineLayer/ScatterLayer/IconLayer/PulseLineLayer）、数据源、拾取交互
  - 涉及坐标转换（GCJ-02）、高德 Key 配置、暗色地图
  - 讨论地图 hover / click / rightclick 事件处理
  - 提示中出现了 window.AMap、window.Loca、map.lngLatToContainer 等 API
---

# AMap / Loca 开发指南

## 分层架构（先确认再写代码）

| 层 | 职责 | 典型 API |
|----|------|----------|
| AMap 底图 | 容器、交互、少量 DOM 覆盖物 | `AMap.Map`、`AMap.Marker`、`InfoWindow`、`lngLatToContainer` |
| Loca 可视化 | 海量 GeoJSON 线/点/图标/流向 | `Loca.Container`、`LineLayer`、`ScatterLayer`、`IconLayer`、`PulseLineLayer`、`GeoJSONSource` |
| React 胶水 | 生命周期、Context、Portal | 自建 Bootstrap + Layer 工厂，**勿**在 render 里 `new Map` |

**原则**：AMap 管底图与坐标；Loca 管海量图层。少量标记（<500）用 AMap 原生覆盖物；海量管段/节点用 Loca。

## Loca 2.0 初始化

```tsx
// ✅ Loca 2.0 正确写法
const loca = new window.Loca.Container({ map });

// ❌ 旧写法，Loca 2.0 会失败
const loca = new window.Loca({ map });
```

推荐流程：
1. AMap `map` 实例就绪（`complete` 或 context hook）
2. 动态注入 Loca SDK（若 `window.Loca` 不存在）
3. `new Loca.Container({ map })`
4. 通过 React Context 把 `{ loca, AMap, map }` 传给图层子树

**勿依赖**第三方 `enableLoca` + `setTimeout` 时序；自建 Bootstrap 可控可测。

## React 图层工厂模式

```tsx
<LocaLayer
  layerClass={() => window.Loca?.LineLayer}
  options={{ zIndex: 10 }}
  styles={{ color: (_, f) => f.properties.color, lineWidth: (_, f) => f.properties.width }}
  visible={visible}
  onLayerReady={(layer) => { /* setSource / on('click') */ }}
/>
```

生命周期 checklist：
- `useEffect` 内创建图层，`return` 中 `layer.destroy()` / 移除
- `styles` / `visible` 变化时更新，不重建 map
- `layerClass` 用函数形式 `() => window.Loca?.XxxLayer`
- 数据源用 `new window.Loca.GeoJSONSource({ data })`，`layer.setSource(source)`

## 拾取与交互

### Loca 层拾取（click）

```ts
// Loca 图层 click 事件携带 e.feature.properties
layer.on('click', (e) => {
  const sid = e.feature?.properties?.sid;
});
```

- Loca `click` 事件可靠，支持所有图层类型（LineLayer / ScatterLayer / IconLayer）
- 事件回调用 `ref` 存 `onPick`，避免父组件 setState 导致反复解绑
- feature 必须有 `properties.sid`（字符串类型）才能通过 `useFeaturePick` 的过滤

### ⚠️ Loca 层 mousemove hover（不可靠）

**Loca 层的 `mousemove` 事件在 `ScatterLayer`（普通节点）和 `IconLayer`（图标节点）上可能不携带 feature 数据或不触发。** 只有 `LineLayer`（管段）相对稳定。

❌ **不要依赖** 在 Loca 层上绑 `mousemove` / `mouseover` 事件做 hover 交互。

### ✅ 推荐 hover 方案：AMap mousemove + 像素空间查询

始终使用 AMap 原生 `mousemove` 事件 + `map.lngLatToContainer()` 做像素级最近要素查询，不依赖 Loca 层事件：

```ts
map.on('mousemove', (e) => {
  const lngLat = e.lnglat || e.lngLat;
  const mousePx = map.lngLatToContainer([lng, lat]);

  for (const feature of features) {
    if (feature.geometry.type === 'Point') {
      const px = map.lngLatToContainer(coords);
      const dist = Math.hypot(mousePx.x - px.x, mousePx.y - px.y);
    } else if (feature.geometry.type === 'LineString') {
      // 计算点到线段的最短像素距离
    }
  }
});
```

**优势**：统一处理 Point / LineString / Icon 所有类型；不依赖 Loca 事件；像素精度可控。

详情见下方[第 4 单元 — Hover 交互最佳实践](#4-悬停-hover-交互最佳实践)。

### AMap 原生空白点击

```ts
map.on('click', (e) => console.log('空白点击', e.lnglat));
map.on('rightclick', (e) => console.log('右键', e.lnglat));
```

- `map.on('click')` 与 Loca `layer.on('click')` 独立：要素点击走 Loca，空白点击走 AMap
- 用 `locaPickedRef` 标记 Loca 拾取命中，在 AMap click 中跳过已处理的要素

## UI 叠加（替代 OL Overlay）

```tsx
const pixel = map.lngLatToContainer(lngLat);
// React Portal 定位到 pixel.x / pixel.y
```

FuncMenu、Popover、监测面板等跟手 UI 一律 Portal + 屏幕坐标，勿混用 Loca 图层画 DOM。

## 坐标系

- 高德底图与 Loca 使用 **GCJ-02（火星坐标）**
- 后端 WGS84 / CGCS2000 数据须转换后再上图
- 统一转换入口（推荐 `gcoord`），勿在业务层散落 `transform`

```ts
import gcoord from 'gcoord';
const [lng, lat] = gcoord.transform([x, y], gcoord.WGS84, gcoord.GCJ02);
```

上线前用已知基准点校验偏移。

## Key 与安全密钥

```ts
window._AMapSecurityConfig = { securityJsCode: '<securityJsCode>' };
```

- Key 走环境变量（如 `VITE_AMAP_KEY`），**禁止**硬编码到源码仓库
- Loca SDK URL：`https://webapi.amap.com/loca?v=2.0.0&key=${key}`
- 开发可临时 fallback；生产必须配 Key + securityJsCode

## Vite 集成要点

- 地图仅客户端挂载（`useEffect`，不做 SSR）
- 子路径 import 避免拉入无关样式/业务包
- `optimizeDeps.include` 加入实际引用的 amap 子路径
- `manualChunks` 拆 `amap-water` / `l7` / `larkmap` 减主包
- SVGR 排除 amap 包内用作 CSS `url()` 的 svg
- 补全 `window.Loca` / `window._AMapSecurityConfig` 类型（`vite-env.d.ts`）

## Loca 图层选型与 zIndex 约定

| 图层类 | 用途 | zIndex 建议 |
|--------|------|------------|
| `LineLayer` | 管段、追踪路径、高亮线 | 130 |
| `ScatterLayer` | 海量圆点（节点） | 140 |
| `IconLayer` | 图标点（水厂/泵站/阀门/监测） | 150–155 |
| `PulseLineLayer` | 流向箭头、脉冲动画 | 160 |

zIndex 建议：底图管段 < 节点/图标 < 高亮/追踪 < 流向动画。

### Feature properties 约定

- `sid`：唯一标识，拾取与详情联动（必须为 string）
- `facilityType`：设施类型（PIPE / JUNCTION / VALVE / FLOW / PRESSURE / RESERVOIR / CUSTOMER）
- `color` / `gradeIdx` / `width`：分级着色与线宽
- `style.src`：IconLayer 图标 URL

## 补充说明（项目实战总结）

### 1. 事件路由策略

```
用户交互 → AMap map 原生事件（click / rightclick / mousemove）
          ├── 要素点击 → Loca layer.on('click')，经 locaPickedRef 标记
          ├── 要素右键 → AMap rightclick + hoverNode
          ├── 空白点击 → AMap click（跳过 locaPickedRef 标记的）
          └── 悬停 → AMap mousemove + 像素空间查询（不用 Loca 层事件）
```

### 2. 空间查询用于空白点击选中

空白点击区域不做像素查询，而是用 turf buffer（缓冲区分析）以点击点为中心搜索附近要素，按距离排序：

```ts
const radius = calculateBufferRadius(zoom); // 缩放越大半径越小
const buffer = turf.buffer(turf.point([lng, lat]), radius, { units: 'meters' });
// 筛选 + 按距离排序
```

### 3. 细线拾取提示

管段（LineString）在低缩放级别细如发丝，hover/click 几乎无法命中。解决方案：
- 高 zoom 加粗高亮层或单独放大容差
- 或在空白点击的 buffer 分析中自然命中

### 4. 悬停（Hover）交互最佳实践

综合最佳实践：

```ts
// useMapHover.ts — 核心逻辑

import { useEffect, useRef } from 'react';
import { useHydraulicStore } from '@/stores/hydraulic';
import { useLoca } from '../layers/_internal/loca-layer';

const PIXEL_THRESHOLD = 10; // 10px 容差

export function useMapHover(enabled: boolean = true) {
  const { map } = useLoca();
  const nodeSource = useHydraulicStore((s) => s.nodeSource);
  const setHoverNode = useHydraulicStore((s) => s.setHoverNode);
  const featuresRef = useRef(nodeSource?.features ?? null);
  featuresRef.current = nodeSource?.features ?? null;

  useEffect(() => {
    if (!map || !enabled) return;

    // 用 featuresRef 避免数据变化时频繁重绑事件
    let hoveredSid: string | null = null;

    const handler = (e: any) => {
      const lngLat = e.lnglat || e.lngLat;
      if (!lngLat) return;

      const features = featuresRef.current;
      if (!features?.length) return;

      // 鼠标坐标 → 像素
      const mousePx = map.lngLatToContainer([
        typeof lngLat.getLng === 'function' ? lngLat.getLng() : lngLat.lng,
        typeof lngLat.getLat === 'function' ? lngLat.getLat() : lngLat.lat,
      ]);
      if (!mousePx) return;

      // 遍历 features，找最近命中
      let nearest: { ... } | null = null;
      for (const feature of features) {
        // Point：坐标像素距离；LineString：点到线段距离
        // < PIXEL_THRESHOLD 即为命中
      }

      if (nearest) {
        setHoverNode(nearest.feature);
        console.log('[Hover]', {
          facilityType: nearest.feature.properties.facilityType,
          geometryType: nearest.feature.geometry.type,
          sid: nearest.feature.properties.sid,
        });
      } else if (hoveredSid) {
        hoveredSid = null;
        setHoverNode(null);
      }
    };

    map.on('mousemove', handler);
    return () => map.off('mousemove', handler);
  }, [map, enabled, setHoverNode]);
}
```

## 明确避免

| 避免 | 原因 |
|------|------|
| L7 / LarkMap 与 Loca 混用同一业务图层 | 双渲染栈、bundle 膨胀、状态难同步 |
| 在 render 创建 Map / Loca / Layer | 内存泄漏、重复实例 |
| 用 `enableLoca={true}`（@fid/amap-water） | Loca 2.0 内部初始化不可控 |
| 直接改 `@fid/amap-water` 源码 | 走 PR；本仓库用 thin wrapper |
| 白底地图样式 | 大屏暗色项目用 `amap://styles/...` 暗色主题 |
| 忽略坐标转换 | 偏移 100–500m，拾取与定位全错 |
| 依赖 Loca 层 mousemove 做 hover | ScatterLayer / IconLayer 不可靠 |

## 实现前检查

1. 底图用 AMap 还是别的引擎？（Leaflet/Mapbox/OL → 不走本 skill）
2. 海量数据走 Loca 还是 AMap VectorLayer？
3. 数据源坐标系？谁负责 GCJ-02 转换？
4. Key 从哪注入？生产 securityJsCode 是否已配？
5. 图层 destroy 是否在 unmount 清理？
6. Hover 用 AMap mousemove + 像素查询还是 Loca 事件？

## 调试速查

| 现象 | 排查 |
|------|------|
| 地图空白 | Key / 域名白名单 / securityJsCode / 控制台 403 |
| Loca 不渲染 | 是否用 `Loca.Container`；SDK 是否加载完 |
| 点击无响应 | `layer.on` 是否绑定；feature 是否有 `properties.sid`（string）|
| Hover 不触发 | 是否误用 Loca 层 `mousemove` → 改用 AMap `mousemove` + 像素查询 |
| 位置偏移 | WGS84 未转 GCJ-02 |
| 内存涨 | 图层 / source 未 destroy；切换数据未清旧层 |

## TypeScript 声明片段

```ts
// vite-env.d.ts
interface Window {
  Loca?: {
    Container: new (opts: { map: unknown }) => unknown;
    GeoJSONSource: new (opts: { data?: unknown }) => { setData: (data: unknown) => void; };
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

## 环境变量

```env
VITE_AMAP_KEY=
VITE_AMAP_SECURITY_JS_CODE=
```

## 与 OL 迁移对照

| 源（OpenLayers） | 目标（AMap + Loca） |
|------------------|---------------------|
| `Map` + VectorLayer | `AMapContainer` + `Loca.LineLayer` |
| WebGLPoints | `Loca.ScatterLayer` / `IconLayer` |
| `ol/Overlay` | React Portal + `lngLatToContainer` |
| `forEachFeatureAtPixel` | AMap mousemove + 像素空间查询（非 Loca 层事件） |
| hox store | Zustand slices（map / layer / selection） |
