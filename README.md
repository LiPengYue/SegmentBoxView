![SegmentBoxView.gif](https://upload-images.jianshu.io/upload_images/4185621-342efbd564276f27.gif?imageMogr2/auto-orient/strip)

### 一、 SegmentBoxView 结构
![image.png](https://upload-images.jianshu.io/upload_images/4185621-4fd94a88fb83b9f0.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## 二、 SegmentBoxView 使用

1、 自定义`SegmentBoxViewController`  子类

2、 设置子类属性 `scrollViewVc`、`backgroundVc`

3、 设置`boxView`、 `scrollViewVc`、`backgroundVc `的`frame`

4、 设置`boxView`的`config`,调整a/b/c/d/e线的位置

4、 调用`[self.boxView reloadUI];` 刷新UI



## 三、 吸附线相关设置

代码示例：

```objective-c
self.boxView.config.segmentPointY_A = 100;// a线
self.boxView.config.segmentPointY_C = self.view.frame.size.height * 0.3;//C线
self.boxView.config.segmentPointSpaceE_F = 300;//e线
[self.boxView reloadUI];
```



结构

```objective-c
/*
 ______________________________> boxView 顶部
 |           ↓           |
 |—————— top吸附点 ———————|——a——> realSegmentPointY_A
 |           ↑           |
 |           ↑           |
 |           ↑           |
 |-----------------------|--b--> realsegmentPointSpace_A_C
 |           ↓           |
 |—————— mid吸附点 ———————|——c——> segmentPointY_C
 |           ↑           |
 |-----------------------|--d--> segmentPointY_D
 |           ↓           |
 |           ↓           |
 |           ↓           |
 |                       |
 |———— bottom吸附点 ——————|——e——> realSegmentPointY_E
 |           ↑           |
 |           ↑           |
 |           ↑           |
 |_______________________|——f——> boxView 底部
 * 1、 ↑↓： 吸附点流向
 * 2、 [a,b) 吸附 realSegmentPointY_A
 * 3、 [b,d] 吸附 segmentPointY_C
 * 4、 (d,f] 吸附 realSegmentPointY_E
 */
```

属性

| 属性                    | 类型      | 读写权限   | 描述                                                         |
| ----------------------- | --------- | ---------- | ------------------------------------------------------------ |
| `segmentPointY_A`       | `CGFloat` | Read/Write | scrollContainerView顶部吸附的距离，默认为0。应小于 `segmentPointY_C`。当`segmentPointY_A == segmentPointY_C`时，`segmentPointY_C`即为top吸附，状态为 `SegmentBoxViewFixedPointStatus_c`。 |
| `realSegmentPointY_A`   | `CGFloat` | Read-Only  | 计算后的 `segmentPointY_A`。                                 |
| `segmentPointSpace_A_C` | `CGFloat` | Read/Write | c线的上吸附范围，默认为100。                                 |
| `realSegmentPointY_B`   | `CGFloat` | Read-Only  | a线与b线的最大y值，注意a线与b线的关系。                      |
| `segmentPointY_C`       | `CGFloat` | Read/Write | mid吸附点c线的默认值，为`self.frame.size.height * 0.3`。     |
| `segmentPointSpace_C_D` | `CGFloat` | Read/Write | c线的下吸附范围，默认为100。                                 |
| `realSegmentPointY_D`   | `CGFloat` | Read-Only  | e线与d线的最小y值，注意e线与d线的关系。                      |
| `realSegmentPointY_E`   | `CGFloat` | Read-Only  | self.height - `segmentPointSpaceE_F`与c线的最大y值，注意e线与c线的关系。 |
| `segmentPointSpaceE_F`  | `CGFloat` | Read/Write | e线到f线的距离，默认为200。                                  |
| `ePullUpTopSpace`       | `CGFloat` | Read/Write | 手势向上拉时，e线到超过这个距离就会吸附到c线。即`boxView.frame.size.height - self.config.segmentPointSpaceE_F + self.config.ePullUpTopSpace`，默认为100。 |
| `verticalOffset`        | `CGFloat` | Read/Write | 手势垂直判定方向的滚动距离，默认为10。                       |
| `isShowDebugLine`       | `BOOL`    | Read/Write | 是否展示辅助线，默认为`NO`。                                 |

## 四、demo 

https://github.com/LiPengYue/SegmentBoxView.git
