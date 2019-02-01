//
//  ViewController.m
//  iJSKit
//
//  Created by LJT-iOS-Devloper on 2019/1/31.
//  Copyright © 2019 LJT-iOS-Devloper. All rights reserved.
//

#import "ViewController.h"
#import <iJSKit/iJSKit.h>

@interface ViewController () <WKNavigationDelegate,WKUIDelegate>
@property (strong, nonatomic) IJSWebView *myWebView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    id __weak weakSelf = self;
    
    self.myWebView = [IJSWebView webViewWithHandlers:@[@"NativeMethod",@"myAction"]
                                         Frame:CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y, self.view.bounds.size.width, self.view.bounds.size.height-165.f)
                                       Handler:weakSelf];
    _myWebView.navigationDelegate = self;
    _myWebView.UIDelegate = self;
    [_myWebView loadRequestWithPath:@"webpage/index.html"];
    [self.view addSubview:_myWebView];
    
}

-(void)viewDidAppear:(BOOL)animated {
    
}

-(void)viewDidDisappear:(BOOL)animated {
   [_myWebView removeAllConfig:@[@"NativeMethod",@"myAction"]];
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    // 判断是否是调用原生的
    if ([@"NativeMethod" isEqualToString:message.name]) {
        // 判断message的内容，然后做相应的操作
        NSLog(@"%@",message.body);
    }
    else {
        NSLog(@"%@",message.body);
    }
}

- (IBAction)submitAction:(UIButton *)sender {

    //取出html5表单中的值
//    [_myWebView valueForElementById:@"name"  completionHandler:^(NSString * _Nonnull element_value, NSError * _Nullable error) {
//        if (error) {
//            NSLog(@"%@",error);
//        }
//        else {
//            NSLog(@"%@",element_value);
//        }
//    }];
//
//    [_myWebView valueForElementById:@"identifer"  completionHandler:^(NSString * _Nonnull element_value, NSError * _Nullable error) {
//        if (error) {
//            NSLog(@"%@",error);
//        }
//        else {
//            NSLog(@"%@",element_value);
//        }
//    }];
//
//    [_myWebView valueToElementById:@"name" Velue:@"颜渊" completionHandler:nil];
    [_myWebView executeJavaScriptMathod:@"jsmothod()" completionHandler:^(id _Nonnull return_value, NSError * _Nullable error) {
        NSLog(@"%@",return_value[@"key"]);
    }];
}

#pragma mark -- WKUIDelegate
// 显示一个按钮。点击后调用completionHandler回调
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:message message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        completionHandler();
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}

// 显示两个按钮，通过completionHandler回调判断用户点击的确定还是取消按钮
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:message message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        completionHandler(YES);
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        completionHandler(NO);
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
    
}

// 显示一个带有输入框和一个确定按钮的，通过completionHandler回调用户输入的内容
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        
    }];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        completionHandler(alertController.textFields.lastObject.text);
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma -mark WKNavigationDelegate
// 1 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSLog(@"1-------在发送请求之前，决定是否跳转  -->%@",navigationAction.request);
    
    decisionHandler(WKNavigationActionPolicyAllow);
}

// 2 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"2-------页面开始加载时调用");
}

// 3 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    /// 在收到服务器的响应头，根据response相关信息，决定是否跳转。decisionHandler必须调用，来决定是否跳转，参数WKNavigationActionPolicyCancel取消跳转，WKNavigationActionPolicyAllow允许跳转
    
    NSLog(@"3-------在收到响应后，决定是否跳转");
    
    decisionHandler(WKNavigationResponsePolicyAllow);
}

// 4 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    NSLog(@"4-------当内容开始返回时调用");
}

// 5 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"5-------页面加载完成之后调用");
}

// 6 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation {
    
    NSLog(@"6-------页面加载失败时调用");
}

// 接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"-------接收到服务器跳转请求之后调用");
}

// 数据加载发生错误时调用
- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"----数据加载发生错误时调用");
}

// 需要响应身份验证时调用 同样在block中需要传入用户身份凭证
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler {
    //用户身份信息
    
    NSLog(@"----需要响应身份验证时调用 同样在block中需要传入用户身份凭证");
    
    NSURLCredential *newCred = [NSURLCredential credentialWithUser:@""
                                                          password:@""
                                                       persistence:NSURLCredentialPersistenceNone];
    // 为 challenge 的发送方提供 credential
    [[challenge sender] useCredential:newCred forAuthenticationChallenge:challenge];
    completionHandler(NSURLSessionAuthChallengeUseCredential,newCred);
}

// 进程被终止时调用
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView {
    NSLog(@"----------进程被终止时调用");
}

@end
