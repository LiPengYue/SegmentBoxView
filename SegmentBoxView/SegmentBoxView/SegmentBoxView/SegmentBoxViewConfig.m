//
//  SegmentBoxViewConfig.m
//  TableView
//
//  Created by 李鹏跃 on 2022/4/15.
//  Copyright © 2022 13lipengyue. All rights reserved.
//

#import "SegmentBoxViewConfig.h"
#import "SegmentBoxView.h"

@interface SegmentBoxViewConfig()

/**
 *（top吸附点：a线）
 * 经过计算后的 segmentPointY_A
 */
@property (nonatomic, assign) CGFloat config_base_realSegmentPointY_A;
/**
 * （b线）
 * @warning 此值为 a线 与 b线 的最大y值
 */
@property (nonatomic, assign) CGFloat config_base_segmentPointY_B;
/**
 * （d线）
 * @warning 此值为 e线 与 d线 的最小y值
 */
@property (nonatomic, assign) CGFloat config_base_segmentPointY_D;
/**
 * （e线）
 * @warning 此值为 e线 与 d线 的最小y值
 */
@property (nonatomic, assign) CGFloat config_base_segmentPointY_E;

@end

@implementation SegmentBoxViewConfig
- (instancetype)init {
    self = [super init];
    if (self) {
        // space
        _segmentPointY_C = 0;
        _segmentPointSpace_A_C = 100;
        _segmentPointSpace_C_D = 100;
        _ePullUpTopSpace = 300;
        _segmentPointSpaceE_F = 200;
        _verticalOffset = 10;
    }
    return self;
}

- (CGFloat) realSegmentPointY_A {
    return  self.config_base_realSegmentPointY_A;
}
- (CGFloat) realSegmentPointY_B {
    return self.config_base_segmentPointY_B;
}
- (CGFloat) realSegmentPointY_D {
    return self.config_base_segmentPointY_D;
}
- (CGFloat) realSegmentPointY_E {
    return self.config_base_segmentPointY_E;
}

- (void)setRealSegmentPointY_A: (CGFloat)y {
    self.config_base_realSegmentPointY_A = y;
}
- (void)setRealSegmentPointY_B: (CGFloat)y {
    self.config_base_segmentPointY_B = y;
}
- (void)setRealSegmentPointY_D:(CGFloat)y {
    self.config_base_segmentPointY_D = y;
}

- (void)setRealSegmentPointY_E: (CGFloat)y {
    self.config_base_segmentPointY_E = y;
}
- (void)setSegmentPointY_C:(CGFloat)segmentPointY_C {
    _segmentPointY_C = segmentPointY_C;
}
@end

