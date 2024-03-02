//
//  SegmentBoxViewController.m
//  TableView
//
//  Created by 李鹏跃 on 2022/4/13.
//  Copyright © 2022 13lipengyue. All rights reserved.
//

#import "SegmentBoxViewController.h"

@interface SegmentBoxViewController ()

@end

@implementation SegmentBoxViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview: self.boxView];
    self.boxView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}

- (void) private_appendVc: (UIViewController  *)vc {
    [self addChildViewController:vc];
    [vc didMoveToParentViewController:self];
}

- (void)setBackgroundVc:(UIViewController *)backgroundVc{
    _backgroundVc = backgroundVc;
    [self private_appendVc: backgroundVc];
    [self.boxView.backgroundView addSubview:self.backgroundVc.view];
}

- (void)setScrollViewVc:(UIViewController<SegmentBoxViewScrollViewVcDelegate> *)scrollViewVc {
    _scrollViewVc = scrollViewVc;
    self.boxView.scrollViewVc = scrollViewVc;
    [self private_appendVc: scrollViewVc];
}

- (SegmentBoxView *)boxView {
    if (!_boxView) {
        _boxView = [[SegmentBoxView alloc]init];
        _boxView.fixedPointDelegate = self;
    }
    return _boxView;
}

- (void)dealloc {
    NSLog(@"✅✅✅✅%@",NSStringFromClass(self.class));
}
@end
