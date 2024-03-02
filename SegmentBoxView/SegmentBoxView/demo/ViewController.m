//
//  ViewController.m
//  TableView
//
//  Created by 李鹏跃 on 2018/9/12.
//  Copyright © 2018年 13lipengyue. All rights reserved.
//

#import "ViewController.h"

#import <WebKit/WebKit.h>
#import "BoxViewController.h"
#import "VRWebViewController.h"


@interface ViewController ()

<
UITableViewDelegate,
UITableViewDataSource,
WKNavigationDelegate,
WKUIDelegate
>
@property (nonatomic,strong) WKWebView *webView;

@property (nonatomic,strong) UIView *headerView;
@property (nonatomic,strong) UIDynamicAnimator *dynamic;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    UIButton *button = [[UIButton alloc]init];
    [self.view addSubview:button];
    button.frame = CGRectMake(100, 100, 100, 100);
    button.backgroundColor = UIColor.redColor;
    [button setTitle:@"jump" forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(clickButton) forControlEvents:UIControlEventTouchUpInside];
    
}


- (void) clickButton {
    [self.navigationController pushViewController:[BoxViewController new] animated:true];
}
@end
