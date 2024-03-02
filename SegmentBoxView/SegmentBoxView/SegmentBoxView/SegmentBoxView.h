//
//  TableView.h
//  TableView
//
//  Created by 李鹏跃 on 2018/9/12.
//  Copyright © 2018年 13lipengyue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SegmentBoxContentViewView.h"
#import "SegmentBoxViewConfig.h"

typedef enum : NSUInteger {
    SegmentBoxViewFixedPointStatus_a,
    SegmentBoxViewFixedPointStatus_c,
    SegmentBoxViewFixedPointStatus_e
} SegmentBoxViewFixedPointStatus;

@protocol
SegmentBoxViewScrollViewVcDelegate,
SegmentBoxViewFixedPointDelegate;

@interface SegmentBoxView : UIView

/**
 * 懒加载属性
 * 包含了一些必要参数
 */
@property (nonatomic, strong) SegmentBoxViewConfig *config;

/**
 * 刷新UI
 * 需要在配置好 self.config后调用
 */
- (void) reloadUI;

/**
 * fixedPoint 相关时机 监听
 */
@property (nonatomic,weak) id <SegmentBoxViewFixedPointDelegate> fixedPointDelegate;

/**
 * 里面必须含有scrollView
 */
@property (nonatomic,strong) UIViewController <SegmentBoxViewScrollViewVcDelegate>*scrollViewVc;

/**
 * scrollViewVc.view就添加到了这个view上面
 */
@property (nonatomic,strong) SegmentBoxContentViewView *scrollContainerView;

/**
 * 位于scrollView底部的视图
 */
@property (nonatomic,strong) UIView *backgroundView;

/**
 * scrollViewVc.scrollView
 * 通过代理获取 SegmentBoxViewScrollViewVcDelegate
 */
@property (nonatomic,readonly) UIScrollView *scrollView;

/**
 * 当前 定点的状态
 */
@property (nonatomic,assign) SegmentBoxViewFixedPointStatus fixedPointStatus;

/**
 * 更新状态到指定状态
 * #return: 返回状态实际高度
 */
- (CGFloat) scrollToStatus:(SegmentBoxViewFixedPointStatus) status;
/**
 * 更新到指定状态
 * @param status 状态
 * @param animated 北京是否执行动画
 * #return: 返回状态实际高度
 */
- (CGFloat) scrollToStatus:(SegmentBoxViewFixedPointStatus) status animated:(BOOL) animated;

/**
 * backgroundView view修改的时候调用
 */
- (void) didChangeBackgroundViewFrameFunc:(void(^)(CGRect frame))block;
@end


@protocol SegmentBoxViewScrollViewVcDelegate <SegmentBoxViewFixedPointDelegate>
@optional
/**
 * 获取scrollView
 */
- (UIScrollView *)scrollView;
@end


@protocol SegmentBoxViewFixedPointDelegate <NSObject>
@optional
/**
 * 吸附状态改变的时候进行回调
 */
- (void) SegmentBoxView: (SegmentBoxView *)boxView andFixedPointStatusDidChanged: (SegmentBoxViewFixedPointStatus) status;

/**
 * 改变scrollViewVc.view 的y 的时候调用
 * @param boxView boxView
 * @param scrollViewVcY 传入的scrollViewVc的view的Y，这个y是距离 boxView 顶部计算的
 * @param topFixedPointOffsetY 这个是scrollViewVcY 距离 第一个吸附点的距离
 *
 */
- (void) SegmentBoxView: (SegmentBoxView *)boxView
    didChangedScrollViewVcY: (CGFloat) scrollViewVcY
    andTopFixedPointOffsetY: (CGFloat) topFixedPointOffsetY;

/**
 * 改变scrollViewVc.view 的 height 调用
 */
- (void) SegmentBoxView: (SegmentBoxView *)boxView didChangedScrollViewVcHeight: (CGFloat) height;
@end
