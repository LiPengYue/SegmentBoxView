//
//  TableView.m
//  TableView
//
//  Created by 李鹏跃 on 2018/9/12.
//  Copyright © 2018年 13lipengyue. All rights reserved.
//

#import "SegmentBoxView.h"
#import "SegmentBoxContentViewView.h"
#import "SegmentBoxDebugView.h"

@interface SegmentBoxView ()
<
UIGestureRecognizerDelegate
>

@property (nonatomic,strong) CAShapeLayer *box_base_topSpaceShapeLayer;
@property(nonatomic,strong) UIPanGestureRecognizer *trasnparent_base_pan;
@property (nonatomic,assign) CGPoint box_base_scrollViewOriginOffset;
@property (nonatomic,assign) CGFloat box_base_scrollContainerViewTouchOffsetY;
@property (nonatomic,assign) BOOL box_base_isPaning;
@property (nonatomic,assign) BOOL box_base_isFirstLayoutContainerView;
// 是否上拉
@property (nonatomic,assign) BOOL box_base_isPullUp;

@property (nonatomic,copy) void(^didChangeBackgroundViewFrameBlock)(CGRect frame);
@property (nonatomic, strong) SegmentBoxDebugView *debugView;
@end

@implementation SegmentBoxView
@synthesize config = _config;

+ (instancetype) createWithScrollView: (UIViewController <SegmentBoxViewScrollViewVcDelegate>*)scrollViewVc {
    SegmentBoxView *boxView = [[self alloc] initWithFrame:CGRectZero];
    boxView.scrollViewVc = scrollViewVc;
    return boxView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundView.frame = UIScreen.mainScreen.bounds;
        [self box_base_setupViews];
        [self configDefaultProperty];
        self.layer.masksToBounds = true;
        _box_base_isFirstLayoutContainerView = true;
       
    }
    return self;
}

- (void) box_base_setupViews {
    [self addSubview:self.backgroundView];
    [self addSubview:self.scrollContainerView];
    [self.scrollContainerView addGestureRecognizer: self.trasnparent_base_pan];
}

- (void) configDefaultProperty {
    
    // color
    self.backgroundColor = UIColor.clearColor;
    self.scrollContainerView.backgroundColor = UIColor.clearColor;
    self.scrollContainerView.currentY = self.frame.size.height;
    self.backgroundView.backgroundColor = UIColor.clearColor;
}

- (void) reloadUI {
    
    [self box_base_reloadRealSegmentPointY_A];
    [self box_base_reloadRealSegmentPointY_B];
    [self box_base_reloadRealSegmentPointY_D];
    [self box_base_reloadRealSegmentPointY_E];
    
    [self box_base_changeScrollContainerViewHeight];
    [self box_base_setScrollContainerViewY:self.config.realSegmentPointY_E];
    
    [self debugLines];
}

// MARK: properties get && set
- (SegmentBoxViewConfig *)config {
    if (!_config) {
        _config = [[SegmentBoxViewConfig alloc]init];
    }
    return _config;
}

- (void)setConfig:(SegmentBoxViewConfig *)config {
    _config = config;
    [self reloadUI];
}

// 获取 中间点 上限
- (CGFloat) box_base_reloadRealSegmentPointY_B {
    CGFloat topSpace = self.config.segmentPointY_A;
    CGFloat offsetY = self.config.segmentPointY_C - self.config.segmentPointSpace_A_C;
    if (topSpace >= offsetY){
        offsetY = topSpace + MAX(1,self.config.verticalOffset);
        NSLog(@"\n\n\
              🌶 错误：中间点上限，应该大于 segmentPointY_A\n\
              上限的实际值 调整为 %.2lf = segmentPointY_A + MAX(1,self.config.verticalOffset)\n\n\
              ",offsetY);
    }
    if (offsetY > self.config.segmentPointY_C) {
        offsetY = self.config.segmentPointY_C;
    }
    [self.config setRealSegmentPointY_B:offsetY];
    
    return offsetY;
}
// 获取中间点下限
- (CGFloat) box_base_reloadRealSegmentPointY_D {
    
    CGFloat bottomY = self.frame.size.height - self.config.segmentPointSpaceE_F;
    CGFloat bottomOffsetY = self.config.segmentPointY_C + self.config.segmentPointSpace_A_C;
    
    if (bottomY <= bottomOffsetY){
        
        bottomOffsetY = bottomY - (MAX(1,self.config.verticalOffset));
        NSLog(@"\n\n\
              🌶 错误：中间点下限，应该小于 底部固定点（self.frame.size.height - self.config.segmentPointSpaceE_F）\n\
              下限的实际值 调整为 %.2lf \n self.frame.size.height - self.config.segmentPointSpaceE_F - MAX(1,self.config.verticalOffset)\n\n\
              ",bottomOffsetY);
    }
    
    if (bottomOffsetY < self.config.segmentPointY_C) {
        bottomOffsetY = self.config.segmentPointY_C;
    }
    [self.config setRealSegmentPointY_D:bottomOffsetY];
    return bottomOffsetY;
}

// 获取第一个固定点的 y
- (CGFloat) box_base_reloadRealSegmentPointY_A {
    CGFloat midSpace = self.config.segmentPointY_C;
    CGFloat topSpace = self.config.segmentPointY_A;
    if (topSpace > midSpace) {
        topSpace = midSpace;
        NSLog(@"\n\n\
              注意：上吸附点，应该小于等于 中吸附点 \
              上限的实际值 调整为%.2f = segmentPointY_C\n\n\
              ",midSpace);
    }
    
    [self.config setRealSegmentPointY_A:topSpace];
    return topSpace;
}

- (void) box_base_changeScrollContainerViewHeight {
    
    self.scrollContainerView.frame = CGRectMake(0, self.config.realSegmentPointY_E, self.frame.size.width, self.frame.size.height - self.config.realSegmentPointY_A);
    self.scrollViewVc.view.frame = self.scrollContainerView.bounds;
    if ([self.fixedPointDelegate respondsToSelector:@selector(SegmentBoxView:didChangedScrollViewVcHeight:)]) {
        [self.fixedPointDelegate SegmentBoxView:self didChangedScrollViewVcHeight:self.scrollViewVc.view.frame.size.height];
    }
    
    if ([self.scrollViewVc respondsToSelector:@selector(SegmentBoxView:didChangedScrollViewVcHeight:)]) {
        [self.scrollViewVc SegmentBoxView:self didChangedScrollViewVcHeight:self.scrollViewVc.view.frame.size.height];
    }
}

// 获取底部定位点
- (CGFloat) box_base_reloadRealSegmentPointY_E {
    CGFloat realSegmentPointY_E = self.frame.size.height - self.config.segmentPointSpaceE_F;
    if (realSegmentPointY_E < self.config.segmentPointY_C) {
        realSegmentPointY_E = self.config.segmentPointY_C;
    }
    [self.config setRealSegmentPointY_E:realSegmentPointY_E];
    return self.frame.size.height - self.config.segmentPointSpaceE_F;
}

- (CAShapeLayer *)box_base_topSpaceShapeLayer {
    if (!_box_base_topSpaceShapeLayer) {
        _box_base_topSpaceShapeLayer = [CAShapeLayer layer];
        _box_base_topSpaceShapeLayer.backgroundColor = UIColor.clearColor.CGColor;
    }
    return _box_base_topSpaceShapeLayer;
}

- (void)setScrollViewVc:(UIViewController<SegmentBoxViewScrollViewVcDelegate
                         > *)scrollViewVc {
    if ([self.scrollViewVc isEqual:scrollViewVc]) {
        return;
    }
    [self box_base_removeScrollViewObserver];
    
    _scrollViewVc = scrollViewVc;
    [self.scrollContainerView addSubview:self.scrollViewVc.view];
    [self box_base_addScrollViewObserver];
}

- (UIScrollView *)scrollView {
    if ([self.scrollViewVc respondsToSelector:@selector(scrollView)]) {
        return [self.scrollViewVc scrollView];
    }
    return nil;
}
- (UIView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc]init];
    }
    return _backgroundView;
}

- (SegmentBoxContentViewView *)scrollContainerView {
    if (!_scrollContainerView) {
        _scrollContainerView = [[SegmentBoxContentViewView alloc]init];
    }
    if (self.config.isShowDebugLine) {
        _scrollContainerView.layer.cornerRadius = 12;
        _scrollContainerView.layer.borderColor = UIColor.redColor.CGColor;
        _scrollContainerView.layer.borderWidth = 1;
    }
    return _scrollContainerView;
}

// MARK:life cycles

- (void)layoutSubviews {
    [super layoutSubviews];
    [self setupSubViewFrames];
    [self debugLines];
}

- (void) setupSubViewFrames {
    
    if (self.box_base_isFirstLayoutContainerView){
        self.backgroundView.frame = self.bounds;
        if (self.didChangeBackgroundViewFrameBlock) {
            self.didChangeBackgroundViewFrameBlock(self.backgroundView.frame);
        }
        self.scrollViewVc.view.frame = self.bounds;
        if (self.config.segmentPointY_C <= 0) {
            self.config.segmentPointY_C = self.frame.size.height * 0.3f;
        }
        self.box_base_isFirstLayoutContainerView = false;
        [self reloadUI];
    }
}

// MARK: - observer
- (void) box_base_addScrollViewObserver {
    [self.scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
}

- (void) box_base_removeScrollViewObserver {
    @try {
        [self.scrollView removeObserver:self forKeyPath:@"contentOffset"];
    } @catch (NSException *exception) {

    } @finally {

    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if (![keyPath isEqualToString:@"contentOffset"]) {
        return;
    }
    [self scrollingWithScrollView:self.scrollView];
}

-(void) scrollingWithScrollView:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat insertTop = -[self private_scrollViewTopSpace];
    
    if (offsetY < insertTop || round(self.scrollContainerView.currentY * 10)/10.f > round(self.config.realSegmentPointY_A * 10)/10.f) {
        [self.scrollView setContentOffset:CGPointMake(0, -[self private_scrollViewTopSpace]) animated:false];
    }
}

- (void) box_base_endedPan {
    // 如果contentOffsetY > 顶部间距，则
    CGFloat offsetY = self.scrollView.contentOffset.y;
    CGFloat insertTop = -[self private_scrollViewTopSpace];
    BOOL isStatusA = self.scrollContainerView.currentY <= self.config.realSegmentPointY_A;
    if (isStatusA && offsetY > insertTop) {
        return;
    }
    
    [self box_base_reloadScrollContainerViewFrame];
}

- (void) box_base_reloadScrollContainerViewFrame {
    
    SegmentBoxViewFixedPointStatus status = SegmentBoxViewFixedPointStatus_e;
    
    if ([self box_base_should_fixedMaxTop]) {
        status = SegmentBoxViewFixedPointStatus_a;
    } else if ([self box_base_should_stop_c]) {
        status = SegmentBoxViewFixedPointStatus_c;
    } else {
        status = SegmentBoxViewFixedPointStatus_e;
    }
    
    [self scrollToStatus:status
                animated:true];
}

- (CGFloat) scrollToStatus:(SegmentBoxViewFixedPointStatus) status {
    return [self scrollToStatus:status
                       animated:false];
}

- (CGFloat) scrollToStatus:(SegmentBoxViewFixedPointStatus) status animated:(BOOL)animated {
    self.fixedPointStatus = status;
    CGFloat y = [self getBoxViewYWithStatus:self.fixedPointStatus];
//    NSLog(@"status =》 %ld",self.fixedPointStatus);
    if (animated) {
        [UIView animateWithDuration:0.22 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            [self box_base_setScrollContainerViewY:y];
        } completion:^(BOOL finished) {
            self.box_base_isPaning = false;
        }];
    }else {
        [self box_base_setScrollContainerViewY:y];
        self.box_base_isPaning = false;
    }
    // 如果超出scrollView的最大contentSize.height scrollView会自动回弹
    BOOL isSesilience = self.scrollView.contentSize.height - self.scrollView.frame.size.height >= self.scrollView.contentOffset.y;
    if (status != SegmentBoxViewFixedPointStatus_a && isSesilience) {
        [self.scrollView setContentOffset:CGPointMake(0, -[self private_scrollViewTopSpace]) animated:false];
    }

    return y;
}

- (CGFloat) getBoxViewYWithStatus:(SegmentBoxViewFixedPointStatus)status {
    CGFloat y = -1;
    CGFloat maxY = self.frame.size.height;
    switch (status) {
        case SegmentBoxViewFixedPointStatus_a:
            y = self.config.realSegmentPointY_A;
            break;
            
        case SegmentBoxViewFixedPointStatus_c:
            y = self.config.segmentPointY_C;
            break;
            
        case SegmentBoxViewFixedPointStatus_e:
        default:
            y =  maxY - self.config.segmentPointSpaceE_F;
            break;
    }
    return y;
}

- (void) box_base_setScrollContainerViewY: (CGFloat) y {
    self.scrollContainerView.currentY = y;
    CGFloat offsetY = y - self.config.realSegmentPointY_A;
    if ([self.fixedPointDelegate respondsToSelector:@selector(SegmentBoxView:didChangedScrollViewVcY:andTopFixedPointOffsetY:)]) {
        [self.fixedPointDelegate SegmentBoxView:self didChangedScrollViewVcY:y andTopFixedPointOffsetY:offsetY];
    }
    
    if ([self.scrollViewVc respondsToSelector:@selector(SegmentBoxView:didChangedScrollViewVcY:andTopFixedPointOffsetY:)]) {
        [self.scrollViewVc SegmentBoxView:self didChangedScrollViewVcY:y andTopFixedPointOffsetY:offsetY];
    }
}

// MARK: get && set

- (CGFloat) private_scrollViewTopSpace {
    CGFloat topSpace = self.scrollView.contentInset.top;
    return topSpace;
}

- (UIPanGestureRecognizer *)trasnparent_base_pan {
    if (!_trasnparent_base_pan) {
        _trasnparent_base_pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(trasnparent_base_pan_callBack)];
        _trasnparent_base_pan.delegate = self;
    }
    return _trasnparent_base_pan;
}

- (void) trasnparent_base_pan_callBack {
    CGPoint locationPoint = [self.trasnparent_base_pan locationInView:self.trasnparent_base_pan.view];
    CGPoint translation = [self.trasnparent_base_pan translationInView:self];
    
//    NSLog(@"translation->%.2lf",translation.y);
//    NSLog(@"location->%.2lf",locationPoint.y);
   
    switch (self.trasnparent_base_pan.state) {
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:
            [self box_base_endedPan];
            return;
            break;
        default:

            break;
    }
    
    CGFloat oldY = self.scrollContainerView.currentY;
    CGFloat newY = translation.y + oldY;
    self.box_base_isPullUp = oldY - newY > self.config.verticalOffset;
    newY = MAX(self.config.realSegmentPointY_A, newY);
    
    CGFloat offsetY = self.scrollView.contentOffset.y;
    CGFloat insertTop = -[self private_scrollViewTopSpace];
    if (offsetY > insertTop) {
        newY = self.config.realSegmentPointY_A;
    }
    
    [self box_base_setScrollContainerViewY:newY];
    [self.trasnparent_base_pan setTranslation:CGPointZero inView:self.scrollContainerView];
    
    if (self.scrollContainerView.currentY < self.config.segmentPointY_C) {
        
    }
}

/// 是否吸附在最顶部
- (BOOL) box_base_should_fixedMaxTop {
    CGFloat y = self.scrollContainerView.currentY;
    CGFloat topSpace = self.config.realSegmentPointY_B;
    BOOL isFixed = y < topSpace;
    return isFixed;
}

///是否吸附在 segmentPointY_C 这个位置
- (BOOL) box_base_should_stop_c {
    
    CGFloat y = self.scrollContainerView.currentY;
    CGFloat topSpace = self.config.realSegmentPointY_B;
    CGFloat bottomSpace = self.config.realSegmentPointY_D;
    
    if (self.box_base_isPullUp) {
        bottomSpace = self.frame.size.height - self.config.segmentPointSpaceE_F + self.config.ePullUpTopSpace;
    }
    
    BOOL isFixed
    = y >= topSpace
    && y <= bottomSpace;
    
    return isFixed;
}

/// 是否吸附在最底部
- (BOOL) box_base_should_fixedBottom {
    CGFloat y = self.scrollContainerView.currentY;
    CGFloat bottomSpace = self.config.realSegmentPointY_D;
    
    BOOL isFixed = y > self.config.segmentPointY_C + bottomSpace;
    
    return isFixed;
}

- (void)setFixedPointStatus:(SegmentBoxViewFixedPointStatus)fixedPointStatus {
    
    if(_fixedPointStatus == fixedPointStatus) {
        return;
    }
    fixedPointStatus = MAX(fixedPointStatus,SegmentBoxViewFixedPointStatus_a);
    fixedPointStatus = MIN(fixedPointStatus,SegmentBoxViewFixedPointStatus_e);
    
    _fixedPointStatus = fixedPointStatus;
    
    if ([self.fixedPointDelegate respondsToSelector:@selector(SegmentBoxView:andFixedPointStatusDidChanged:)]) {
        [self.fixedPointDelegate SegmentBoxView:self andFixedPointStatusDidChanged:self.fixedPointStatus];
    }
    
    if ([self.scrollViewVc respondsToSelector:@selector(SegmentBoxView:andFixedPointStatusDidChanged:)]) {
        [self.scrollViewVc SegmentBoxView:self andFixedPointStatusDidChanged:self.fixedPointStatus];
    }
}

// MARK: delegates

- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer {
    
    self.box_base_scrollViewOriginOffset = self.scrollView.contentOffset;
    self.box_base_scrollContainerViewTouchOffsetY = self.scrollContainerView.frame.origin.y;
    self.box_base_isPaning = true;
    return true;
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    
    return YES;
}

- (void) didChangeBackgroundViewFrameFunc:(void(^)(CGRect frame))block {
    _didChangeBackgroundViewFrameBlock = block;
}

// MARK: other
- (void)dealloc {
    [self box_base_removeScrollViewObserver];
    NSLog(@"✅✅✅✅%@",NSStringFromClass(self.class));
}

//MARK: - debug
- (void) debugLines {
    if (!self.config.isShowDebugLine) {
        [self.debugView removeFromSuperview];
        self.debugView = nil;
        return;
    }
    
    if (!self.debugView) {
        self.debugView = [[SegmentBoxDebugView alloc]init];
    }
    self.debugView.frame = self.bounds;
    [self addSubview:self.debugView];
    self.debugView.aY = self.config.realSegmentPointY_A;
    self.debugView.bY = self.config.realSegmentPointY_B;
    self.debugView.cY = self.config.segmentPointY_C;
    self.debugView.dY = self.config.realSegmentPointY_D;
    self.debugView.eY = self.config.realSegmentPointY_E;
    [self.debugView reloadLines];
}

@end


