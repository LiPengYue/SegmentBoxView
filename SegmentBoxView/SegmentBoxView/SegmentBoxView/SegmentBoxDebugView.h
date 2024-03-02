//
//  SegmentBoxDebugView.h
//  TableView
//
//  Created by 李鹏跃 on 2023/6/29.
//  Copyright © 2023 13lipengyue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SegmentBoxDebugView : UIView
@property (nonatomic,assign) CGFloat aY;
@property (nonatomic,assign) CGFloat bY;
@property (nonatomic,assign) CGFloat cY;
@property (nonatomic,assign) CGFloat dY;
@property (nonatomic,assign) CGFloat eY;
- (void) reloadLines;
@end

NS_ASSUME_NONNULL_END
