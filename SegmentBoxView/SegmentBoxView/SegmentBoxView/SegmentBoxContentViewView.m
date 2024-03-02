//
//  DampingTableHeaderView.m
//  TableView
//
//  Created by 李鹏跃 on 2018/9/13.
//  Copyright © 2018年 13lipengyue. All rights reserved.
//

#import "SegmentBoxContentViewView.h"
@interface SegmentBoxContentViewView()

@end

@implementation SegmentBoxContentViewView
@synthesize currentY = _currentY;

- (CGFloat)currentY {
    return self.frame.origin.y;
}

- (void)setCurrentY:(CGFloat)currentY {
    _currentY = currentY;
    CGRect frame = self.frame;
    frame.origin.y = currentY;
    self.frame = frame;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        [self addGestureRecognizer:self.trasnparent_base_pan];
    }
    return self;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    
    CGFloat touchY = point.y;
    CGFloat responsY = self.topTransparentSpace;
    BOOL respons = touchY  >= responsY;
    if (!respons) {
        return respons;
    }
    return [super pointInside:point withEvent:event];
}

//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
//    UIView *view = [super hitTest:point withEvent:event];
//    if ([view isEqual:self]) {
//        return nil;
//    }
//    return view;
//}


-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (void)dealloc {
    NSLog(@"✅✅✅✅%@",NSStringFromClass(self.class));
}
@end
