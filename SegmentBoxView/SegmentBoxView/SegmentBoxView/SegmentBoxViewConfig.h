//
//  SegmentBoxViewConfig.h
//  TableView
//
//  Created by 李鹏跃 on 2022/4/15.
//  Copyright © 2022 13lipengyue. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SegmentBoxView;
NS_ASSUME_NONNULL_BEGIN

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




@interface SegmentBoxViewConfig : NSObject
/**
 *（top吸附点： a线）
 * scrollContainerView顶部 吸附的距离
 * 默认为 0
 *
 * 这个值应该小于 segmentPointY_C（即c线）
 * @warning 如果 a线与c线重合（即 segmentPointY_A == segmentPointY_C）
 * 则 c线即是top吸附，返回的state为 SegmentBoxViewFixedPointStatus_c
 */
@property (nonatomic,assign) CGFloat segmentPointY_A;

/**
 *（top吸附点：a线）
 * 经过计算后的 segmentPointY_A
 */
@property (nonatomic, readonly) CGFloat realSegmentPointY_A;

/**
 * （a到c线的距离）
 *  c线的上吸附范围
 *  默认是 100
 */
@property (nonatomic, assign) CGFloat segmentPointSpace_A_C;

/**
 * （b线）
 * @warning 此值为 a线 与 b线 的最大y值
 */
@property (nonatomic, readonly) CGFloat realSegmentPointY_B;


/**
 *（mid吸附点：c线）
 * 默认为 self.frame.size.height * 0.3
 */
@property (nonatomic,assign) CGFloat segmentPointY_C;



/**
 * （c到d线的距离）
 *  c线的下吸附范围
 *  默认是 100
 */
@property (nonatomic, assign) CGFloat segmentPointSpace_C_D;

/**
 * （d线）
 * @warning 此值为 e线 与 d线 的最小y值
 */
@property (nonatomic, readonly) CGFloat realSegmentPointY_D;

/**
 * （e线）
 * @warning 此值为 self.height-segmentPointSpaceE_F 与 c线 的最大y值
 */
@property (nonatomic, readonly) CGFloat realSegmentPointY_E;

/**
 * e线到f线的距离
 * 默认为 200 segmentPointSpaceE_F
 */
@property (nonatomic, assign) CGFloat segmentPointSpaceE_F;

/**
 * pan 手势 向上拉时，e线 到超过这个距离就会吸附到 c线
 * 即： boxView.frame.size.height - self.config.segmentPointSpaceE_F + self.config.ePullUpTopSpace
 * 默认为 100
 */
@property (nonatomic, assign) CGFloat ePullUpTopSpace;


/**
 * 手势 垂直判定方向的 滚动距离 默认为10
 */
@property (nonatomic,assign) CGFloat verticalOffset;


/**
 * 是否展示辅助线
 */
@property (nonatomic, assign) BOOL isShowDebugLine;

// 以下不能被外界使用
- (void)setRealSegmentPointY_A: (CGFloat)y;
- (void)setRealSegmentPointY_B: (CGFloat)y;
- (void)setRealSegmentPointY_D: (CGFloat)y;
- (void)setRealSegmentPointY_E: (CGFloat)y;
@end

NS_ASSUME_NONNULL_END
