# AMapWaterPro 组件配置完整指南

## 配置项详解

### 1.1 mapConfig — 地图配置

定义地图的初始视角、样式和交互行为。

```ts
interface I_MapConfig {
  /**
   * @description 地图初始中心点坐标
   * @params [number, number] 格式：[经度, 纬度]
   * @required 是
   * @example [116.102249, 38.704216]
   */
  center: [number, number];

  /**
   * @description 初始缩放级别
   * @params number 值越大离地面越近，通常 10~18 之间，13 为城市级
   * @default 13
   * @example 13
   */
  zoom: number;

  /**
   * @description 缩放范围
   * @params [number, number] [最小允许级别, 最大允许级别]
   * @default [3, 18]
   * @example [9.6, 18]
   */
  zooms: [number, number];

  /**
   * @description 俯仰角
   * @params number 范围 0~60。0 为俯视，30~60 为倾斜透视效果
   * @requires 需配合 viewMode: '3D' 才生效
   * @default 0
   * @example 30
   */
  pitch?: number;

  /**
   * @description 视图模式
   * @params '2D' | '3D'。'3D' 模式下可倾斜旋转视角
   * @requires 建筑白模（BuildingPolyonLayers）需要 '3D' 模式
   * @default '2D'
   * @example '3D'
   */
  viewMode?: '2D' | '3D';

  /**
   * @description 高德地图样式 ID
   * @params string 以 'amap://styles/...' 格式传入，控制地图底图配色
   * @default 'amap://styles/9f339bd64d866702030eeb603ad68c25'
   * @see 下方常用 mapStyle 表格
   */
  mapStyle?: string;

  /**
   * @description 默认显示卫星图
   * @params boolean true=启动时切换到卫星图，false=普通矢量地图
   * @notice 用户仍可通过底栏在地图/卫星模式间切换
   * @default false
   * @example true
   */
  defaultSatellite?: boolean;

  /**
   * @description 监测点聚合行为配置
   * @params I_L7MarkerClusterConfig 控制相邻监测点是否自动合并为数量气泡
   * @notice 不传则使用 L7 引擎的默认聚合参数
   */
  clusterConfig?: I_L7MarkerClusterConfig;
}
```

**常用 mapStyle：**

| 样式 ID                                          | 表现效果   | 适用场景   |
| ------------------------------------------------ | ---------- | ---------- |
| `amap://styles/9f339bd64d866702030eeb603ad68c25` | 深色系     | 默认       |
| `amap://styles/19721f2b1f35ffb6c64e92580162b982` | 深色系     | 大屏展示   |
| `amap://styles/df4874d449af036d085984ebb8512181` | 深色系变体 | 南阳等案例 |
| `amap://styles/a2c3a46187b045b0cff11600fb6436b6` | 深色系变体 | 凯里等案例 |
| `amap://styles/light`                            | 浅色系     | 白天场景   |
| `amap://styles/dark`                             | 暗色系     | 夜间场景   |

---

### 1.2 boundaries — 行政边界配置

在地图上用半透明色块 + 描边勾勒指定行政区划的轮廓，用于标识水务管辖范围。

```ts
interface I_BoundariesConfig {
  /**
   * @description 行政区划名称
   * @params string 高德据此名称自动获取边界经纬度数据
   * @required 是
   * @example "任丘市"
   */
  districtName: string;

  /**
   * @description 区域填充颜色
   * @params string 十六进制颜色值，作用于区域内部的底色，不影响边界线
   * @required 是
   * @example "#000"
   */
  fillColor: string;

  /**
   * @description 填充透明度
   * @params number 范围 0~1，值越低越透明
   * @default 0.3
   * @example 0.3
   */
  fillOpacity: number;

  /**
   * @description 边界描边宽度
   * @params number 单位像素，值越大轮廓越粗越醒目
   * @default 2
   * @example 3
   */
  strokeWeight: number;

  /**
   * @description 边界线颜色
   * @params string 支持十六进制和 rgba 格式
   * @required 是
   * @example "rgba(97, 139, 254, 1)"
   */
  strokeColor: string;

  /**
   * @description 边界线样式
   * @params 'solid' 实线 | 'dashed' 虚线
   * @default 'solid'
   */
  strokeStyle: 'solid' | 'dashed';
}
```

> 若不需要行政边界，将此 prop 设为 `null` 或 `undefined` 即可。

---

### 1.3 monitorLayers — 监测点图层配置

每个监测点图层对应一个**数据源**和一套**标点样式**。组件从各图层的 WFS/API 数据源读取 GeoJSON 要素，渲染为地图上的标点。一个项目通常有 3~8 个监测点图层（水厂、加压站、压力监测点、流量监测点、隐患事件等）。

```ts
interface I_MonitorLayerConfig {
  /**
   * @description 图层唯一标识
   * @params string 用于图层开关控制、点位 layer 字段关联、事件通信中的图层过滤
   * @required 是
   * @example "xiaohuoshuan"
   */
  key: string;

  /**
   * @description 图层显示名称
   * @params string 出现在底栏监测点开关按钮上，供用户识别图层
   * @required 是
   * @example "消火栓"
   */
  title: string;

  /**
   * @description 标点在地图上的视觉样式与弹窗行为
   * @params object 控制标点图标、聚合行为、点击弹窗等
   * @required 是
   */
  marker: {
    /**
     * @description 标点图标 URL
     * @params string 支持 PNG/SVG 格式，推荐 28×28 或 32×32 尺寸
     * @required 是
     * > **项目中常用的标点图标：**
>
> | 图标文件名 | 对应场景 | 完整 URL |
> |-----------|---------|---------|
> | `marker_fire_hydrant.png` | 消火栓 | `https://fi-gis.oss-cn-beijing.aliyuncs.com/fi-gis/icon_bs_new/marker_fire_hydrant.png` |
> | `marker_liuliang_new.png` | 流量监测 / 农村监测 / 城区监测 | `https://fi-gis.oss-cn-beijing.aliyuncs.com/fi-gis/icon_bs_new/marker_liuliang_new.png` |
> | `marker_yali_new.png` | 压力监测点 | `https://fi-gis.oss-cn-beijing.aliyuncs.com/fi-gis/icon_bs_new/marker_yali_new.png` |
> | `marker_water_quality_new.png` | 水质监测点 | `https://fi-gis.oss-cn-beijing.aliyuncs.com/fi-gis/icon_bs_new/marker_water_quality_new.png` |
> | `marker_xielou_new.png` | 泄漏监测点 | `/oss/fi-gis/icon_bs_new/marker_xielou_new.png` |
> | `marker_gas-gate-station.png` | 厂站 | `/oss/fi-gis/icon_bs_new/marker_gas-gate-station.png` |
> | `marker_hidden-dangers-event.png` | 隐患 | `/oss/fi-gis/icon_bs_new/marker_hidden-dangers-event.png` |
> | `marker_third-building.png` | 施工 | `/oss/fi-gis/icon_bs_new/marker_third-building.png` |
> | `marker_field-staff.png` | 外勤人员 | `/oss/fi-gis/icon_bs_new/marker_field-staff.png` |
> | `marker_work-order.png` | 工单 | `/oss/fi-gis/icon_bs_new/marker_work-order.png` |
> | `marker_reservoir.png` | 水库/监测点 | `/oss/marker/marker_reservoir.png` |
> | `plant-marker.svg` | 水厂/加压泵站 | `/oss/plant-marker.svg` |
> | `source.png` | 水源地 | `https://fi-gis.oss-cn-beijing.aliyuncs.com/fi-gis/water/source.png` |
> | `workshop.png` | 水厂 | `https://fi-gis.oss-cn-beijing.aliyuncs.com/fi-gis/water/workshop.png` |
> | `booster_pump_station.png` | 加压站 | `https://fi-gis.oss-cn-beijing.aliyuncs.com/fi-gis/water/booster_pump_station.png` |
> | `second_supply_pump.png` | 二供泵站 | `https://fi-gis.oss-cn-beijing.aliyuncs.com/fi-gis/water/second_supply_pump.png` |
     */
    icon: string;

    /**
     * @description 弹窗组件名称
     * @params string 点击标点时弹出的详情组件
     * @default 'MonitorModal'
     * @see 下方"内置弹窗组件"列表
     */
    compName?: string;

    /**
     * @description 弹窗组件额外属性
     * @params object 传递给弹窗组件的配置参数，不同组件接受不同参数
     */
    compProps?: {
      /**
       * @description 默认显示指标卡
       * @params boolean true=标点始终展开指标卡片；false=鼠标 hover 时才显示
       * @default false
       */
      defaultVisible?: boolean;

      /**
       * @description iframe 嵌入 URL
       * @params string 用于 WorkshopModal 等组件内嵌第三方页面
       * @example "https://workshop-pc.mps.f-insight.com/workshop/detail?theme=dark"
       */
      modalUrl?: string;

      /**
       * @description 自定义列表型字段配置
       * @params Array<{label: string, valueKey: string}> 控制弹窗中展示哪些字段及其显示名
       * @example [{ label: "隐患类型", valueKey: "typeName" }]
       */
      labelConfig?: I_LabelConfig[];

      /** @params any 其他自定义属性透传给弹窗组件 */
      [key: string]: any;
    };

    /**
     * @description 是否启用聚合
     * @params boolean true=同区域多点自动聚合成数字气泡；false=始终独立显示图标
     * @default true
     */
    defaultCluster: boolean;

    /**
     * @description 图标显示宽度
     * @params number 单位像素
     * @default 28
     * @example 32
     */
    iconWidth?: number;

    /**
     * @description 图标显示高度
     * @params number 单位像素
     * @default 28
     * @example 32
     */
    iconHeight?: number;

    /**
     * @description 标点层级
     * @params number z-index，值越大标点越靠上显示，用于控制不同图层标点的叠放顺序
     */
    zIndex?: number;
  };

  /**
   * @description 图层开关按钮配置
   * @params boolean 直接传 true 即可，组件按数组顺序渲染
   * @notice 控制地图上默认是否显示；不传或 false 则默认关闭
   */
  toggleVisible?: boolean;

  /**
   * @description 是否在底部图层工具栏展示开关
   * @params boolean false=不进底栏，图层仍按 toggleVisible 渲染
   * @default true
   * @example false
   */
  enable?: boolean;

  /**
   * @description 数据源配置
   * @params object 决定从何处获取该图层的监测点坐标数据
   * @required 是
   */
  source: {
    /**
     * @description 服务地址
     * @params string WFS 服务 URL 或动态 API 地址
     * @required 是
     * @example "/geoserver/renqiu/wms/ows"
     */
    url: string;

    /**
     * @description WFS 图层名称
     * @params string 仅 WFS 数据源需要
     * @example "renqiu:任丘_大屏_消火栓"
     */
    layerName?: string;

    /**
     * @description 请求参数
     * @params Record<string, any> WFS GetFeature 请求参数，包括 typeName、outputFormat、srsName 等
     * @required 是
     */
    params: Record<string, any>;

    /**
     * @description 请求方式
     * @params 'GET' | 'POST'。'GET' 适用于 WFS，'POST' 适用于动态 API
     * @default 'GET'
     */
    method?: 'GET' | 'POST';

    /**
     * @description 动态数据标识
     * @params string 设置此字段则走 API 接口而非 WFS 服务
     * @example "hiddenDangersEvent"
     */
    keyType?: string;
  };

  /**
   * @description 缩放级别可见范围
   * @params [number, number] [最小级别, 最大级别]，超出范围自动隐藏（即使开关处于开启状态）
   * @example [11, 18]
   */
  zooms?: [number, number];
}
```

#### 三种数据源类型

| 类型             | 典型 source 配置                                                     | 适用场景                               |
| ---------------- | -------------------------------------------------------------------- | -------------------------------------- |
| **WFS 矢量要素** | `url: '/geoserver/.../ows'` + `params.service:'WFS'`                 | 从 GeoServer 加载固定的厂站/监测点     |
| **动态 API**     | `url: '/bs/prod-api/map/dynamic-data'` + `method:'POST'` + `keyType` | 从业务系统获取隐患/施工/工单等实时数据 |
| **静态 GeoJSON** | `url: '/oss/xyz.geojson'`                                            | 直接加载静态 GeoJSON 文件中的点位      |

#### 内置弹窗组件 (marker.compName)

| 组件名                     | 用途说明                                  | 特殊属性      |
| -------------------------- | ----------------------------------------- | ------------- |
| `MonitorModal`             | 通用监测点指标卡                          | —             |
| `WorkshopModal`            | 厂站/泵站详情，支持 iframe 嵌入第三方系统 | `modalUrl`    |
| `PersonModal`              | 外勤人员位置弹窗                          | `labelConfig` |
| `WarningDynamicModal`      | 隐患/施工/工单动态信息弹窗                | `labelConfig` |
| `RiskDynamicModal`         | 隐患风险详细信息弹窗                      | `labelConfig` |
| `ConstructionDynamicModal` | 第三方施工信息弹窗                        | `labelConfig` |
| `OrderDynamicModal`        | 工单详情弹窗                              | `labelConfig` |
| `PipeModal`                | 管线要素信息弹窗（配合 WMS 图层点击事件） | —             |

---

### 1.4 wmsLayers — WMS 位图瓦片图层

以位图瓦片叠加 WMS 服务渲染的图层，通常用作管线底图。这类图层**不可交互点击**，性能开销小。

```ts
interface I_MapDataWMSLayers {
  /**
   * @description 图层唯一标识
   * @params string 用于开关控制和事件标识
   * @required 是
   * @example "pipes-trunk"
   */
  key: string;

  /**
   * @description 图层显示名称
   * @params string 出现在底栏图层开关按钮上
   * @required 是
   * @example "燃气管网"
   */
  title: string;

  /**
   * @description WMS 服务地址与请求参数
   * @params object
   * @required 是
   */
  source: {
    /**
     * @description WMS 服务 URL
     * @params string
     * @required 是
     * @example "/geoserver/pujiang/wms/"
     */
    url: string;

    /**
     * @description WMS 请求参数
     * @params object 含 LAYERS、FORMAT、CRS 等标准 WMS 参数
     * @required 是
     */
    params: {
      /**
       * @description WMS 图层名
       * @params string GeoServer 中发布的图层名称
       * @required 是
       */
      LAYERS: string;
      /** @params 'image/png' */
      FORMAT: 'image/png';
      /** @params 'true' */
      TRANSPARENT: 'true';
      /** @params '1.1.0' */
      VERSION: '1.1.0';
      /** @params 'WMS' */
      SERVICE: 'WMS';
      /** @params 'GetMap' */
      REQUEST: 'GetMap';
      /**
       * @description 瓦片坐标系
       * @params 'EPSG:3857' WMS 瓦片通常使用 EPSG:3857
       */
      CRS?: 'EPSG:3857';
      /** @params any 其他 WMS 标准参数 */
      [key: string]: any;
    };
  };

  /**
   * @description 缩放级别可见范围
   * @params [number, number] [最小级别, 最大级别]
   * @notice 超出范围自动隐藏以节省渲染资源
   * @example [16, 20]
   */
  zooms?: [number, number];

  /**
   * @description 是否在底部图层工具栏展示开关
   * @params boolean false=不进底栏，图层仍按 toggleVisible 渲染
   * @default true
   * @example false
   */
  enable?: boolean;
}
```

---

### 1.5 geojsonLayers — 矢量图层配置

以 L7 引擎渲染的矢量图层，支持**管线**和 **3D 建筑白模**两种类型。矢量图层可交互点击，管线可配置流动动画。

```ts
interface I_MapDataGeojsonLayers {
  /**
   * @description 图层唯一标识
   * @params string 用于开关控制和事件标识
   * @required 是
   * @example "line_shushui"
   */
  key: string;

  /**
   * @description 图层显示名称
   * @params string 出现在底栏图层开关按钮上
   * @required 是
   * @example "输水干管"
   */
  title: string;

  /**
   * @description 渲染组件名称
   * @params 'AMapWaterL7PipeLineLayers' | 'AMapWaterL7BuildingPolyonLayers'
   * @required 是
   */
  compName: 'AMapWaterL7PipeLineLayers' | 'AMapWaterL7BuildingPolyonLayers';

  /**
   * @description WFS 数据源
   * @params object 从 GeoServer 获取 GeoJSON 矢量数据
   * @required 是
   */
  source: {
    /**
     * @description WFS 服务 URL
     * @params string
     * @required 是
     * @example "/geoserver/renqiu/ows"
     */
    url: string;

    /**
     * @description WFS GetFeature 请求参数
     * @params Record<string, any> 包括 typeName、outputFormat、srsName 等
     * @required 是
     */
    params: Record<string, any>;
  };

  /**
   * @description 缩放级别可见范围
   * @params [number, number] [最小级别, 最大级别]
   * @notice 超出范围自动隐藏并释放渲染资源
   * @example [11, 18]
   */
  zooms?: [number, number];

  /**
   * @description 是否在底部图层工具栏展示开关
   * @params boolean false=不进底栏，图层仍按 toggleVisible 渲染
   * @default true
   * @example false
   */
  enable?: boolean;

  /**
   * @description 启用动画的最小缩放级别
   * @params number 低于此级别时不走流动动画以提升性能
   * @notice 仅对 AMapWaterL7PipeLineLayers 有效
   * @example 14
   */
  enableAnimateZoom?: number;

  /**
   * @description 渲染组件额外属性
   * @params Record<string, any> 传给 compName 指定的渲染组件，不同组件接受不同参数
   */
  compProps?: Record<string, any>;
}
```

#### AMapWaterL7PipeLineLayers — compProps 说明

```ts
compProps: {
  /**
   * @description 管线颜色
   * @params string 十六进制颜色值
   * @example '#EA9901'
   */
  color?: string;

  /**
   * @description 管线粗细
   * @params number 单位像素
   * @example 10
   */
  size?: number;

  /**
   * @description 管线样式类型
   * @params 'arrow' 箭头流动 | 'flow' 流光 | 'solid' 实线
   * @default 'solid'
   */
  pipeStyleKey?: 'arrow' | 'flow' | 'solid';

  /**
   * @description 自定义渐变样式
   * @params { targetColor: string, sourceColor: string }
   * @notice 配合箭头动画使用
   */
  style?: {
    /**
     * @description 渐变终点颜色
     * @params string
     * @example '#FFD382'
     */
    targetColor: string;

    /**
     * @description 渐变起点颜色
     * @params string
     * @example '#EA9901'
     */
    sourceColor: string;
  };
}
```

#### AMapWaterL7BuildingPolyonLayers — compProps 说明

```ts
compProps: {
  /**
   * @description 建筑拉伸配置
   * @params { field: string, value: [number, number] }
   * @notice 根据 GeoJSON 中的楼层数字段，将建筑拉伸为立体白模
   * @required 是
   */
  size: {
    /**
     * @description 楼层数字段名
     * @params string GeoJSON 属性中记录楼层数的字段名称
     * @example 'floor'
     */
    field: string;

    /**
     * @description 拉伸高度范围
     * @params [number, number] [最小值(px), 最大值(px)]
     * @notice 根据 field 值在此区间线性映射高度
     * @example [10, 100]
     */
    value: [number, number];
  }
}
```

---

### 1.6 clusterConfig — 监测点聚合配置

控制相邻监测点自动合并为数量气泡的行为，避免标点过密重叠。

```ts
interface I_L7MarkerClusterConfig {
  /**
   * @description 是否启用聚合
   * @params boolean true=启用聚合，false=所有点独立显示不合并
   * @default true
   */
  cluster?: boolean;

  /**
   * @description 聚合半径
   * @params number 单位像素，此半径范围内的点会被合并为一个气泡
   * @notice 值越大越容易聚合
   * @default 150
   * @example 100
   */
  radius?: number;

  /**
   * @description 聚合统计字段
   * @params string 气泡上可显示此字段的统计值
   */
  field?: string;

  /**
   * @description 统计方法
   * @params 'sum' 求和 | 'max' 最大值 | 'min' 最小值 | 'mean' 平均值
   */
  method?: 'sum' | 'max' | 'min' | 'mean';

  /**
   * @description 最小聚合缩放级别
   * @params number 低于此级别全部独立显示，不再聚合
   * @default 0
   */
  minZoom?: number;

  /**
   * @description 最大聚合缩放级别
   * @params number 高于此级别全部独立显示
   * @default 16
   */
  maxZoom?: number;
}
```

---

## 2. 完整示例（无注释 JSON）

### 示例：水务地图（任丘市）— 纯 JSON 配置

将以下 JSON 作为 props 传入 `AMapWaterPro` 组件：

```json
{
  "boundaries": {
    "fillColor": "#000",
    "strokeStyle": "solid",
    "districtName": "任丘市",
    "fillOpacity": 0.3,
    "strokeWeight": 3,
    "strokeColor": "rgba(97, 139, 254, 1)"
  },
  "mapConfig": {
    "mapStyle": "amap://styles/19721f2b1f35ffb6c64e92580162b982",
    "center": [116.102249, 38.704216],
    "zoom": 13,
    "zooms": [9.6, 18],
    "pitch": 30,
    "viewMode": "3D",
    "clusterConfig": {
      "radius": 100
    }
  },
  "monitorLayers": [
    {
      "title": "消火栓",
      "key": "xiaohuoshuan",
      "marker": {
        "defaultCluster": true,
        "icon": "https://fi-gis.oss-cn-beijing.aliyuncs.com/fi-gis/icon_bs_new/marker_fire_hydrant.png",
        "compName": "MonitorModal",
        "compProps": { "defaultVisible": true }
      },
      "toggleVisible": true,
      "source": {
        "url": "/geoserver/renqiu/wms/ows",
        "params": {
          "service": "WFS",
          "version": "2.0.0",
          "request": "GetFeature",
          "typeName": "renqiu:任丘_大屏_消火栓",
          "outputFormat": "application/json",
          "srsName": "EPSG:4326"
        }
      }
    },
    {
      "title": "农村监测点",
      "key": "nongcun",
      "marker": {
        "defaultCluster": true,
        "icon": "https://fi-gis.oss-cn-beijing.aliyuncs.com/fi-gis/icon_bs_new/marker_liuliang_new.png",
        "compName": "MonitorModal",
        "compProps": { "defaultVisible": true }
      },
      "toggleVisible": true,
      "source": {
        "url": "/geoserver/renqiu/wms/ows",
        "params": {
          "service": "WFS",
          "version": "2.0.0",
          "request": "GetFeature",
          "typeName": "renqiu:任丘_大屏_农村监测点",
          "outputFormat": "application/json",
          "srsName": "EPSG:4326"
        }
      }
    },
    {
      "title": "城区监测点",
      "key": "chengqu",
      "marker": {
        "defaultCluster": true,
        "icon": "https://fi-gis.oss-cn-beijing.aliyuncs.com/fi-gis/icon_bs_new/marker_liuliang_new.png",
        "compName": "MonitorModal",
        "compProps": { "defaultVisible": true }
      },
      "toggleVisible": true,
      "source": {
        "url": "/geoserver/renqiu/wms/ows",
        "params": {
          "service": "WFS",
          "version": "2.0.0",
          "request": "GetFeature",
          "typeName": "renqiu:任丘_大屏_城市监测点",
          "outputFormat": "application/json",
          "srsName": "EPSG:4326"
        }
      }
    }
  ],
  "geojsonLayers": [
    {
      "enableAnimateZoom": 14,
      "title": "输水干管",
      "key": "line_shushui",
      "compName": "AMapWaterL7PipeLineLayers",
      "source": {
        "url": "/geoserver/renqiu/ows",
        "params": {
          "service": "WFS",
          "version": "2.0.0",
          "request": "GetFeature",
          "typeName": "renqiu:任丘_大屏_输水干管",
          "outputFormat": "application/json",
          "srsName": "EPSG:4326"
        }
      },
      "zooms": [11, 18],
      "compProps": {
        "style": { "targetColor": "#FFD382", "sourceColor": "#EA9901" }
      }
    },
    {
      "enableAnimateZoom": 14,
      "title": "配水干管",
      "key": "line_peishui",
      "compName": "AMapWaterL7PipeLineLayers",
      "source": {
        "url": "/geoserver/renqiu/ows",
        "params": {
          "service": "WFS",
          "version": "2.0.0",
          "request": "GetFeature",
          "typeName": "renqiu:任丘_大屏_配水干管",
          "outputFormat": "application/json",
          "srsName": "EPSG:4326"
        }
      },
      "zooms": [10, 18]
    },
    {
      "title": "城市建筑",
      "key": "polygon_building",
      "compName": "AMapWaterL7BuildingPolyonLayers",
      "source": {
        "url": "/oss/3d/rq3_with_floor_compressed.geojson",
        "params": {}
      },
      "compProps": {
        "size": { "field": "floor", "value": [10, 100] }
      }
    }
  ],
  "wmsLayers": [],
  "appKey": "fi-big-screen",
  "busKey": "map-default",
  "style": { "height": 800 }
}
```

> 在代码中使用时，将上述 JSON 作为 props 传入组件：
>
> ```tsx
> import { AMapWaterPro } from '@fid/amap-water';
> import config from './config.json';
>
> export default () => <AMapWaterPro {...config} style={{ height: 800 }} />;
> ```

---

## 3. 完整示例（带注释 TS 配置）

### 示例：水务地图（任丘市）— 含字段说明的完整配置

以下为 TypeScript 对象写法，**每个字段上方附有作用说明**，可直接在项目中使用。该示例覆盖了绝大部分配置字段，可作为实际开发时的参考模板。

```ts
import { AMapWaterPro } from '@fid/amap-water';

// =====================================================
// 完整配置模板 —— 涵盖所有常用字段
// =====================================================
const config = {
  // ---- 行政边界 ----
  /** 高德根据名称自动获取边界坐标，在此区域上覆盖半透明色块+描边 */
  boundaries: {
    districtName: '任丘市',
    fillColor: '#000',                          // 区域填充色
    fillOpacity: 0.3,                           // 填充透明度 0~1
    strokeWeight: 3,                            // 边界线宽(px)
    strokeColor: 'rgba(97, 139, 254, 1)',       // 边界线颜色
    strokeStyle: 'solid',                       // solid | dashed
  },

  // ---- 地图配置 ----
  mapConfig: {
    center: [116.102249, 38.704216],            // 初始中心点 [lng, lat]
    zoom: 13,                                   // 初始缩放级别(10~18)
    zooms: [9.6, 18],                           // 缩放范围 [min, max]
    pitch: 30,                                  // 俯仰角 0~60，3D效果需 >0
    viewMode: '3D',                             // '2D' | '3D'
    mapStyle: 'amap://styles/19721f2b1f35ffb6c64e92580162b982', // 暗色主题
    // defaultSatellite: true,                  // 设为 true 则默认显示卫星图
    clusterConfig: {                            // 聚合行为配置
      radius: 100,                              // 聚合半径(px)
      // cluster: true,                         // 是否启用聚合，默认 true
      // field: 'value',                        // 气泡显示统计字段
      // method: 'sum',                         // sum | max | min | mean
      // minZoom: 0,                            // 开始聚合的最小缩放级别
      // maxZoom: 16,                           // 停止聚合的最大缩放级别
    },
  },

  // ---- 监测点图层 ----
  monitorLayers: [
    {
      title: '消火栓',
      key: 'xiaohuoshuan',
      toggleVisible: true,                      // 地图上默认开启
      // enable: false,                         // 设为 false 则不进底栏，图层仍按 toggleVisible 渲染
      marker: {
        icon: 'https://fi-gis.oss-cn-beijing.aliyuncs.com/fi-gis/icon_bs_new/marker_fire_hydrant.png',
        compName: 'MonitorModal',               // 点击弹窗组件
        compProps: { defaultVisible: true },    // 默认展开指标卡
        defaultCluster: true,                   // 启用聚合
        iconWidth: 28,                          // 图标宽(px)，默认28
        iconHeight: 28,                         // 图标高(px)，默认28
      },
      source: {
        url: '/geoserver/renqiu/wms/ows',
        params: {
          service: 'WFS',
          version: '2.0.0',
          request: 'GetFeature',
          typeName: 'renqiu:任丘_大屏_消火栓',
          outputFormat: 'application/json',
          srsName: 'EPSG:4326',
        },
      },
    },
    {
      title: '压力监测点',
      key: 'yali',
      toggleVisible: true,
      // zooms: [11, 18],                       // 可选：缩放范围限制
      marker: {
        icon: '/oss/fi-gis/icon_bs_new/marker_yali_new.png',
        compName: 'MonitorModal',
        compProps: { defaultVisible: true },
        defaultCluster: true,
      },
      source: {
        url: '/geoserver/renqiu/wms/ows',
        params: {
          service: 'WFS',
          version: '2.0.0',
          request: 'GetFeature',
          typeName: 'renqiu:任丘_大屏_压力监测点',
          outputFormat: 'application/json',
          srsName: 'EPSG:4326',
        },
      },
    },
    {
      title: '隐患事件',
      key: 'hiddenDangersEvent',
      toggleVisible: true,
      marker: {
        icon: '/oss/fi-gis/icon_bs_new/marker_hidden-dangers-event.png',
        compName: 'WarningDynamicModal',        // 告警弹窗，支持 labelConfig
        compProps: {
          defaultVisible: true,
          labelConfig: [                        // 弹窗自定义字段
            { label: '隐患类型', valueKey: 'typeName' },
            { label: '上报时间', valueKey: 'reportAt' },
          ],
        },
        defaultCluster: false,                  // 隐患不聚合，独立显示
      },
      source: {
        method: 'POST',                         // 动态 API 数据源
        url: '/bs/prod-api/map/dynamic-data',
        params: {},
        keyType: 'hiddenDangersEvent',          // 数据类别标识
      },
    },
  ],

  // ---- 矢量图层 ----
  geojsonLayers: [
    {
      title: '输水干管',
      key: 'line_shushui',
      compName: 'AMapWaterL7PipeLineLayers',    // 管线渲染组件
      source: {
        url: '/geoserver/renqiu/ows',
        params: {
          service: 'WFS',
          version: '2.0.0',
          request: 'GetFeature',
          typeName: 'renqiu:任丘_大屏_输水干管',
          outputFormat: 'application/json',
          srsName: 'EPSG:4326',
        },
      },
      zooms: [11, 18],                          // 仅在 11~18 级可见
      enableAnimateZoom: 14,                    // 14 级以上启流动动画
      compProps: {
        color: '#EA9901',                       // 管线颜色
        size: 6,                                // 管线粗细(px)
        pipeStyleKey: 'arrow',                  // arrow | flow | solid
        // style: {                             // 自定义渐变色（可选）
        //   targetColor: '#FFD382',
        //   sourceColor: '#EA9901',
        // },
      },
    },
    {
      title: '配水干管',
      key: 'line_peishui',
      compName: 'AMapWaterL7PipeLineLayers',
      source: {
        url: '/geoserver/renqiu/ows',
        params: {
          service: 'WFS',
          version: '2.0.0',
          request: 'GetFeature',
          typeName: 'renqiu:任丘_大屏_配水干管',
          outputFormat: 'application/json',
          srsName: 'EPSG:4326',
        },
      },
      zooms: [10, 18],
    },
    {
      title: '城市建筑',
      key: 'polygon_building',
      compName: 'AMapWaterL7BuildingPolyonLayers', // 3D 建筑白模
      source: {
        url: '/oss/3d/rq3_with_floor_compressed.geojson',
        params: {},
      },
      compProps: {
        size: {
          field: 'floor',                       // GeoJSON 中的楼层数字段
          value: [10, 100],                     // 拉伸高度范围(px)
        },
      },
    },
  ],

  // ---- WMS 位图瓦片（可选） ----
  // wmsLayers: [
  //   {
  //     title: '燃气管网底图',
  //     key: 'pipes-trunk',
  //     source: {
  //       url: '/geoserver/tianlun/wms/',
  //       params: {
  //         LAYERS: 'tianlun:天伦_许昌_管线_2',
  //         FORMAT: 'image/png',
  //         TILED: true,
  //         TRANSPARENT: 'true',
  //         VERSION: '1.1.0',
  //         SERVICE: 'WMS',
  //         REQUEST: 'GetMap',
  //         CRS: 'EPSG:3857',
  //         WIDTH: 256,
  //         HEIGHT: 256,
  //       },
  //     },
  //     zooms: [16, 20],                        // 可选：缩放限制
  //   },
  // ],

  // ---- 认证密钥 ----
  appKey: 'fi-big-screen',
  busKey: 'map-default',
};

// 使用
export default () => (
  <AMapWaterPro
    {...config}
    style={{ height: 800 }}
  />
);
```

> 以上配置中，被注释掉的行（`// ...`）表示可选字段，按需启用即可。

---

## 4. 不同场景配置示例

### 4.1 燃气地图（蒲江）

特点：WMS 位图瓦片做管线底图 + 矢量管线做流动动画 + 动态数据源做隐患/施工/人员/工单实时点位。

```ts
mapConfig: {
  center: [103.495843, 30.224014],
  zoom: 12.8,
  zooms: [9.6, 20],
  pitch: 45,
  viewMode: '3D',
  mapStyle: 'amap://styles/19721f2b1f35ffb6c64e92580162b982',
}
```

**动态数据源配置示例（隐患事件）：**

```ts
{
  title: '隐患',
  key: 'hiddenDangersEvent',
  marker: {
    defaultCluster: false,
    icon: '/oss/fi-gis/icon_bs_new/marker_hidden-dangers-event.png',
    compName: 'WarningDynamicModal',
    compProps: {
      defaultVisible: true,
      labelConfig: [
        { label: '隐患类型', valueKey: 'typeName' },
        { label: '上报时间', valueKey: 'reportAt' },
      ],
    },
  },
  source: {
    method: 'POST',
    params: {},
    keyType: 'hiddenDangersEvent',
    url: '/bs/prod-api/map/dynamic-data',
  },
}
```

### 4.2 默认卫星图模式（嘉峪关水投）

```ts
mapConfig: {
  center: [98.277349, 39.790051],
  zoom: 13,
  zooms: [9.6, 18],
  pitch: 60,
  viewMode: '3D',
  defaultSatellite: true,
}
```

### 4.3 仅 WMS 管线底图（天伦燃气/凯里）

管线数据以 WMS 位图瓦片形式提供，不需要矢量管线和建筑白模。

```ts
wmsLayers: [
  {
    key: 'pipes-trunk',
    title: '燃气管网',
    source: {
      url: '/geoserver/tianlun/wms/',
      params: {
        LAYERS: 'tianlun:天伦_许昌_管线_2',
        FORMAT: 'image/png',
        TILED: true,
        TRANSPARENT: 'true',
        VERSION: '1.1.0',
        SERVICE: 'WMS',
        REQUEST: 'GetMap',
        CRS: 'EPSG:3857',
        WIDTH: 256,
        HEIGHT: 256,
      },
    },
  },
],
geojsonLayers: [],
```

---

## 5. 图层架构全景

```
AMapWaterPro
├── AMapContainer
│   ├── AMapL7Scene
│   │   ├── AMapBoundariesLayer              ← 行政边界色块
│   │   ├── AMapTileLayerSatellite           ← 卫星底图（可切换）
│   │   ├── AMapWMSLayers                    ← WMS 位图瓦片图层组
│   │   ├── AMapWaterL7PipeLineLayers        ← 矢量管线（带流动动画）
│   │   ├── AMapWaterL7BuildingPolyonLayers  ← 3D 建筑白模
│   │   ├── AMapWaterL7ClusterMarkerLayer    ← 聚合标点层
│   │   ├── AMapWaterL7StaticMarkerLayer     ← 非聚合标点层
│   │   ├── AMapWaterL7ManualStaticMarkerLayer ← 手动打点层
│   │   └── L7PipeLineWindows                ← 管线要素拾取弹窗
│   ├── OneMapBottomBar
│   │   ├── LayerController                  ← 管线/建筑图层开关
│   │   ├── MonitorController                ← 监测点图层开关
│   │   └── MonitorDisplayControllerPro      ← 指标卡显示配置
│   └── AMapWaterEventBus                    ← 事件总线
```

---

## 6. 事件总线

组件内部通过全局 `eventBus` 通信，外部可通过 `eventBus.useListen` 监听：

| 事件                                                      | 触发时机                                   | 回调参数                       |
| --------------------------------------------------------- | ------------------------------------------ | ------------------------------ |
| `UPDATE_WATER_MAP_MONITOR_POINT_DATA`                     | 指标数据 API 获取完成或 WebSocket 推送更新 | `Record<string, MdInfo[]>`     |
| `DISPATCH_WATER_MAP_MONITOR_DISPLAY_CONTENT_VALUE_CHANGE` | 底栏切换指标卡显示模式                     | `E_MonitorDiplayContentType[]` |
| `DISPATCH_WATER_MAP_MONITOR_DISPLAY_MD_CODE_CHANGE`       | 用户过滤特定指标类型                       | `string[]`                     |
| `DISPATCH_WATER_MAP_ZOOM_CHANGE`                          | 地图缩放级别变化                           | `number`                       |
| `DISPATCH_WATER_MAP_ZOOM_TO_MAX_LEVEL`                    | 缩放到最大级别                             | `number`                       |
| `DISPATCH_WATER_MAP_L7_STATIC_POINT_MANUAL_ADD`           | 外部触发手动添加标点                       | `I_ManualStaticPointPayload`   |
| `DISPATCH_WATER_MAP_L7_STATIC_POINT_MANUAL_CLEAR`         | 外部触发手动清除标点                       | `{ layer?: string }`           |

---

## 7. 常见问题

### Q: 聚合点与非聚合点有什么区别？

A: 聚合点（`defaultCluster: true`）在低缩放级别自动合并为数量气泡，鼠标悬浮可列表轮播查看；非聚合点（`defaultCluster: false`）在任何级别都独立显示图标。

### Q: 如何让图层不出现在底部工具栏？

A: 设置 `enable: false`。图层仍会按 `toggleVisible` 在地图上显示或隐藏，只是底栏不再出现开关。监测点、管线/建筑、WMS 均支持。

### Q: 如何控制某个图层只在特定缩放级别显示？

A: 设置 `zooms: [minZoom, maxZoom]`，如 `[11, 18]` 表示 11~18 级可见，超出自动隐藏。

### Q: WMS 位图瓦片和矢量管线怎么选？

A: WMS 是静态位图，性能好但不可交互，适合底图；矢量管线（`AMapWaterL7PipeLineLayers`）可设动画、配色，点击可弹出详情。

### Q: 如何手动添加/清除标点？

A: 通过 eventBus 发送事件：

```ts
eventBus.emit(EventType.DISPATCH_WATER_MAP_L7_STATIC_POINT_MANUAL_ADD, {
  lnglat: [116.1, 38.7],
  id: 'custom_001',
  layer: 'manual',
  extra: { title: '自定义标记' },
  marker: { icon: '/oss/custom-marker.png' },
});

eventBus.emit(EventType.DISPATCH_WATER_MAP_L7_STATIC_POINT_MANUAL_CLEAR, {
  layer: 'manual',
});
```
