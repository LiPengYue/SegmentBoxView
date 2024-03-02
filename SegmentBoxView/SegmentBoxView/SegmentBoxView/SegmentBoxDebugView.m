//
//  SegmentBoxDebugView.m
//  TableView
//
//  Created by 李鹏跃 on 2023/6/29.
//  Copyright © 2023 13lipengyue. All rights reserved.
//

#import "SegmentBoxDebugView.h"
@interface SegmentBoxDebugView()
@property (nonatomic,strong) UIView *aLineView;
@property (nonatomic,strong) UIView *bLineView;
@property (nonatomic,strong) UIView *cLineView;
@property (nonatomic,strong) UIView *dLineView;
@property (nonatomic,strong) UIView *eLineView;
@end
@implementation SegmentBoxDebugView

// MARK: - debug
- (void) reloadLines {
    self.userInteractionEnabled = false;
    self.backgroundColor = UIColor.clearColor;
    CGFloat width = self.frame.size.width;
    self.aLineView.frame = CGRectMake(0, self.aY, width, 1);
    self.bLineView.frame = CGRectMake(0, self.bY, width, 1);
    self.cLineView.frame = CGRectMake(0, self.cY, width, 1);
    self.dLineView.frame = CGRectMake(0, self.dY, width, 1);
    self.eLineView.frame = CGRectMake(0, self.eY, width, 1);
    [self addSubview:self.aLineView];
    [self addSubview:self.bLineView];
    [self addSubview:self.dLineView];
    [self addSubview:self.cLineView];
    [self addSubview:self.eLineView];
}


- (UIView *)aLineView {
    if (!_aLineView) {
        _aLineView = [self createDebugLineViewWithBgColor:UIColor.redColor andText:@"a"];
    }
    return _aLineView;
}
- (UIView *)bLineView {
    if (!_bLineView) {
        _bLineView = [self createDebugLineViewWithBgColor:UIColor.blueColor andText:@"b"];
    }
    return _bLineView;
}

- (UIView *)cLineView {
    if (!_cLineView) {
        _cLineView = [self createDebugLineViewWithBgColor:UIColor.redColor andText:@"c"];
    }
    return _cLineView;
}
- (UIView *)dLineView {
    if (!_dLineView) {
        _dLineView = [self createDebugLineViewWithBgColor:UIColor.blueColor andText:@"d"];
    }
    return _dLineView;
}
- (UIView *)eLineView {
    if (!_eLineView) {
        _eLineView = [self createDebugLineViewWithBgColor:UIColor.redColor andText:@"e"];
    }
    return _eLineView;
}
- (UIView *) createDebugLineViewWithBgColor:(UIColor *) color andText:(NSString *)text {
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = color;
    UILabel *label = [[UILabel alloc]init];
    label.text = text;
    label.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    label.textColor = UIColor.whiteColor;
    [view addSubview:label];
    label.frame = CGRectMake(12, -7, 14, 14);
    label.textAlignment = NSTextAlignmentCenter;
    view.layer.masksToBounds = false;
    return view;
}

@end
