//
//  VRWebViewController.m
//  TableView
//
//  Created by 李鹏跃 on 2022/4/20.
//  Copyright © 2022 13lipengyue. All rights reserved.
//

#import "VRWebViewController.h"
#import <WebKit/WebKit.h>
@interface VRWebViewController ()
@property (nonatomic,strong) WKWebView *webView;
@end

@implementation VRWebViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
  
    NSLog(@"VRWebViewController- viewWillAppear");
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.webView];
    self.webView.frame = self.view.bounds;
    
    NSURL*url = [NSURL URLWithString:@"https://www.jianshu.com/u/d41e51daf400"];

    NSURLRequest*request = [NSURLRequest requestWithURL:url];

    [self.webView loadRequest:request];
}

- (WKWebView *)webView
{
    if (nil == _webView) {
        // 可以做一些初始化配置定制
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        configuration.selectionGranularity = WKSelectionGranularityDynamic;
        configuration.allowsInlineMediaPlayback = YES;
        
        WKPreferences *preferences = [WKPreferences new];
        //是否支持JavaScript
        preferences.javaScriptEnabled = YES;
        //不通过用户交互，是否可以打开窗口
        preferences.javaScriptCanOpenWindowsAutomatically = YES;
        configuration.preferences = preferences;
        
        // 初始化WKWebView
        _webView = [[WKWebView alloc] initWithFrame:[UIScreen mainScreen].bounds configuration:configuration];

        // 有两种代理，UIDelegate负责界面弹窗，navigationDelegate负责加载、跳转等
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
    }
    return _webView;
}

/* 页面开始加载 */
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
}
/* 开始返回内容 */
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
     
}
/* 页面加载完成 */
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
     
}
/* 页面加载失败 */
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
     
}
/* 在发送请求之前，决定是否跳转 */
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    //允许跳转
    decisionHandler(WKNavigationActionPolicyAllow);
    //不允许跳转
    //decisionHandler(WKNavigationActionPolicyCancel);
}
/* 在收到响应后，决定是否跳转 */
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
     
    NSLog(@"%@",navigationResponse.response.URL.absoluteString);
    //允许跳转
    decisionHandler(WKNavigationResponsePolicyAllow);
    //不允许跳转
    //decisionHandler(WKNavigationResponsePolicyCancel);
}

#pragma mark - WKUIDelegate
/// 处理alert弹窗事件
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    
    [self alert:@"温馨提示" message:message?:@"" buttonTitles:@[@"确认"] handler:^(int index, NSString *title) {
       completionHandler();
    }];
}

/// 处理Confirm弹窗事件
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler{
    
    [self alert:@"温馨提示" message:message?:@"" buttonTitles:@[@"取消", @"确认"] handler:^(int index, NSString *title) {
       completionHandler(index != 0);
    }];
}

/// 处理TextInput弹窗事件
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:prompt preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.text = defaultText;
    }];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(nil);
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSString *text = [alert.textFields firstObject].text;
        NSLog(@"字符串：%@", text);
        completionHandler(text);
    }]];
//    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - 弹窗
- (void)alert:(NSString *)title message:(NSString *)message {
    [self alert:title message:message buttonTitles:@[@"确定"] handler:nil];
}

- (void)alert:(NSString *)title message:(NSString *)message buttonTitles:(NSArray *)buttonTitles handler:(void(^)(int, NSString *))handler {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    for (int i = 0; i < buttonTitles.count; i++) {
        [alert addAction:[UIAlertAction actionWithTitle:buttonTitles[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (handler) {
                handler(i, action.title);
            }
        }]];
    }
//    [self presentViewController:alert animated:YES completion:nil];
}


@end
