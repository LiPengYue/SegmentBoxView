//
//  TableViewViewController.m
//  TableView
//
//  Created by 李鹏跃 on 2022/4/13.
//  Copyright © 2022 13lipengyue. All rights reserved.
//

#import "TableViewViewController.h"
#define randomRGBColor RGBCOLOR(arc4random_uniform(256),arc4random_uniform(256),arc4random_uniform(256))
#define RGBCOLOR(r, g, b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
@interface TableViewViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic,strong) UITableView *tableView;
@end

@implementation TableViewViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"TableViewViewController- viewWillAppear");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    self.tableView.frame = self.view.bounds;
    self.tableView.tableHeaderView = [[UIView alloc]init];
    self.tableView.tableHeaderView.frame = CGRectMake(0, 0, 300, 200);
    self.tableView.tableHeaderView.backgroundColor = UIColor.greenColor;
    self.tableView.tableHeaderView = self.tableView.tableHeaderView;
    self.view.backgroundColor = UIColor.clearColor;
    self.tableView.backgroundColor = UIColor.clearColor;
    self.tableView.backgroundView = nil;
    self.tableView.backgroundView.backgroundColor = UIColor.clearColor;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        [_tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"cellId"];
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return _tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 85;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId" forIndexPath:indexPath];
    cell.backgroundColor = randomRGBColor;
    cell.textLabel.text = @(indexPath.row).stringValue;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (![self.scrollView isEqual:scrollView]) {
        return;
    }
    if(scrollView.panGestureRecognizer.state != UIGestureRecognizerStateEnded) {
        return;
    }
//    BOOL isTracking = tableView.isDecelerating || tableView.isDragging || tableView.isTracking;
//    if (isTracking) {
//        return;
//    }
//    CGFloat maxH = scrollView.frame.size.height;
//    CGFloat offsetY = scrollView.contentOffset.y;
//    if (offsetY > - maxH / 3.0) {
//        [self.tableView setContentOffset:CGPointMake(0, 0) animated:true];
//    }
//   else if (offsetY <= - maxH / 3.0 && offsetY > - maxH/2.0f - 20 ) {
//        [self.tableView setContentOffset:CGPointMake(0, - maxH/2.0f) animated:true];
//   } else {
//       [self.tableView setContentOffset:CGPointMake(0, - maxH/1.250f) animated:true];
//   }
}

- (UIScrollView *) scrollView {
    return self.tableView;
}

- (void)SegmentBoxView:(SegmentBoxView *)boxView didChangedScrollViewVcHeight:(CGFloat)height {
    self.view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, height);
    self.tableView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, height);
}

- (void) SegmentBoxView:(SegmentBoxView *)boxView didChangedScrollViewVcY:(CGFloat)y {
//    NSLog(@"y -> %.2f",y);
}





//-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
//{
//    return YES;
//}
@end
