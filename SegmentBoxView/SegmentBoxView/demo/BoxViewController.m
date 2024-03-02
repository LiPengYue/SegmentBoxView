//
//  BoxViewController.m
//  TableView
//
//  Created by 李鹏跃 on 2022/4/13.
//  Copyright © 2022 13lipengyue. All rights reserved.
//

#import "BoxViewController.h"
#import "TableViewViewController.h"
#import "SegmentBoxView.h"
#import "VRWebViewController.h"



@interface BoxViewController ()
<
SegmentBoxViewFixedPointDelegate
>

@property (nonatomic,strong) VRWebViewController *webVc;
@property (nonatomic, strong) TableViewViewController  *vc;
//@property (nonatomic, strong) SegmentBoxView *boxView;
@property (nonatomic, strong) UIView *maskView;
@property (nonatomic,strong) UIButton *reloadStatusButton;
@property (nonatomic,strong) UIButton *callBackButton;
@property (nonatomic,strong) UIButton *scrollToC;
@end

@implementation BoxViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
   
    [self.navigationController setNavigationBarHidden:true animated:true];
    NSLog(@"BoxViewController- viewWillAppear");
}

- (void) setupViews {
    [self.view addSubview: self.boxView];
    self.boxView.config.isShowDebugLine = true;
    self.boxView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    self.maskView.frame = self.view.bounds;

    self.backgroundVc = self.webVc;
    self.scrollViewVc = self.vc;
    self.webVc.view.frame = self.view.bounds;
    [self.boxView.backgroundView addSubview:self.maskView];

    [self.boxView reloadUI];
    [self.view addSubview:self.reloadStatusButton];
    [self.view addSubview:self.callBackButton];
    self.callBackButton.frame = CGRectMake(0, 0, 100, 100);
    self.reloadStatusButton.frame = CGRectMake(self.view.frame.size.width - 100, 0, 100, 100);
    [self.view addSubview:self.scrollToC];
    self.scrollToC.frame = CGRectMake(self.view.frame.size.width - 100, 100, 100, 100);
}

//- (SegmentBoxView *)boxView {
//    if (!_boxView) {
//        _boxView = [[SegmentBoxView alloc]init];
//        _boxView.fixedPointDelegate = self;
//    }
//    return _boxView;
//}

- (TableViewViewController *)vc {
    if (!_vc) {
        _vc = [[TableViewViewController alloc]init];
    }
    return _vc;
}

- (VRWebViewController *)webVc {
    if (!_webVc) {
        _webVc = [[VRWebViewController alloc]init];
    }
    return _webVc;
}

- (UIView *)maskView {
    if (!_maskView){
        _maskView = [[UIView alloc]init];
        _maskView.userInteractionEnabled = false;
        _maskView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    }
    return _maskView;
}

- (void)SegmentBoxView:(SegmentBoxView *)boxView didChangedScrollViewVcHeight:(CGFloat)height {
}

- (void) SegmentBoxView:(SegmentBoxView *)boxView didChangedScrollViewVcY:(CGFloat)y andTopFixedPointOffsetY:(CGFloat)topFixedPointOffsetY{
    CGFloat alpha = (100.f - topFixedPointOffsetY) / 100.f;
    alpha = MAX(alpha, 0);
    alpha = MIN(alpha, 1);
//    NSLog(@"alpha = %.2lf",alpha);
    self.maskView.alpha = alpha;
}

- (void) SegmentBoxView: (SegmentBoxView *)boxView andFixedPointStatusDidChanged: (SegmentBoxViewFixedPointStatus) status {
    NSLog(@"status = %ld",status);
    
//    switch (status) {
//
//        case SegmentBoxViewFixedPointStatus_top:
//            break;
//        case SegmentBoxViewFixedPointStatus_mid:
//            self.maskView.backgroundColor = UIColor.blueColor;
//            break;
//        case SegmentBoxViewFixedPointStatus_bottom:
//            self.maskView.backgroundColor = UIColor.clearColor;
//            break;
//    }
}

/// - reloadStatusButton Button
- (UIButton *) reloadStatusButton {
    if (!_reloadStatusButton) {
        _reloadStatusButton = [[UIButton alloc]init];
        [_reloadStatusButton setTitleColor:UIColor.redColor forState:UIControlStateNormal];
        [_reloadStatusButton addTarget:self action:@selector(click_reloadStatusButton) forControlEvents:UIControlEventTouchUpInside];
        [_reloadStatusButton setTitle:@"更新 状态" forState:UIControlStateNormal];
    }
    return _reloadStatusButton;
}
- (void)click_reloadStatusButton {
    self.boxView.config.segmentPointY_C = self.view.frame.size.height * 0.3;
    self.boxView.config.segmentPointY_A = 100;
    self.boxView.config.segmentPointSpaceE_F = 300;
    [self.boxView reloadUI];
}



- (UIButton *) callBackButton {
    if (!_callBackButton) {
        _callBackButton = [[UIButton alloc]init];
        [_callBackButton setTitleColor:UIColor.redColor forState:UIControlStateNormal];
        [_callBackButton addTarget:self action:@selector(callBackButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [_callBackButton setTitle:@"返回" forState:UIControlStateNormal];
    }
    return _callBackButton;
}
- (void)callBackButtonClick {
    [self.navigationController popViewControllerAnimated:true];
}

- (UIButton *) scrollToC {
    if (!_scrollToC) {
        _scrollToC = [[UIButton alloc]init];
        [_scrollToC setTitleColor:UIColor.redColor forState:UIControlStateNormal];
        [_scrollToC addTarget:self action:@selector(scrollToCClick) forControlEvents:UIControlEventTouchUpInside];
        [_scrollToC setTitle:@"滚动到c" forState:UIControlStateNormal];
    }
    return _scrollToC;
}
- (void)scrollToCClick {
    [self.boxView scrollToStatus:SegmentBoxViewFixedPointStatus_e animated:true];
}
@end
