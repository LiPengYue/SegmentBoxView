//
//  SegmentBoxViewController.h
//  TableView
//
//  Created by 李鹏跃 on 2022/4/13.
//  Copyright © 2022 13lipengyue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SegmentBoxView.h"

NS_ASSUME_NONNULL_BEGIN

@interface SegmentBoxViewController : UIViewController
<
SegmentBoxViewFixedPointDelegate
>

/**
 * boxView
 * @bug 🌶 内部设置了 boxView.fixedPointDelegate = self， 不能修改 boxView.fixedPointDelegate
 */
@property (nonatomic, strong) SegmentBoxView *boxView;

/**
 * 可以悬停 的vc
 * 在调用 set 方法时，调用了 SEL(private_appendVc:)
 */
@property (nonatomic, strong) UIViewController <SegmentBoxViewScrollViewVcDelegate>*scrollViewVc;

/**
 * 位于 scrollViewVc底部的vc
 * * 在调用 set 方法时，调用了 SEL(private_appendVc:)
 */
@property (nonatomic, strong) UIViewController *backgroundVc;
@end

NS_ASSUME_NONNULL_END
