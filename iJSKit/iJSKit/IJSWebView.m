//
//  IJSWebView.m
//  iJSKit
//
//  Created by LJT-iOS-Devloper on 2019/1/31.
//  Copyright © 2019 LJT-iOS-Devloper. All rights reserved.
//

#import "IJSWebView.h"

@implementation IJSWebView

+(IJSWebView *)webViewWithHandlers:(NSArray *)names Frame:(CGRect)frame Handler:(id <WKScriptMessageHandler>)scriptMessageHandler {
    WKWebViewConfiguration *configuration = [IJSWebView configScriptMessageHandler:names Handler:scriptMessageHandler];
    IJSWebView *webView = [[IJSWebView alloc] initWithFrame:frame configuration:configuration];
    
    return webView;
}

+(WKWebViewConfiguration *)configScriptMessageHandler:(NSArray *)names Handler:(id <WKScriptMessageHandler>)scriptMessageHandler {
    // 创建配置
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    // 创建UserContentController（提供JavaScript向webView发送消息的方法）
    WKUserContentController* userContent = [[WKUserContentController alloc] init];
    // 添加消息处理，注意：self指代的对象需要遵守WKScriptMessageHandler协议，结束时需要移除
    [names enumerateObjectsUsingBlock:^(NSString*  _Nonnull name, NSUInteger idx, BOOL * _Nonnull stop) {
        [userContent addScriptMessageHandler:scriptMessageHandler name:name];
    }];
    // 将UserConttentController设置到配置文件
    configuration.userContentController = userContent;
    
    return configuration;
}

-(void)removeAllConfig:(NSArray *)names {
    [names enumerateObjectsUsingBlock:^(NSString*  _Nonnull name, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.configuration.userContentController removeScriptMessageHandlerForName:name];
    }];
}

-(void)removeConfig:(NSString *)name {
    [self.configuration.userContentController removeScriptMessageHandlerForName:name];
}

-(void)loadRequestWithPath:(NSString *)pathString {
    NSString *path = [[NSBundle mainBundle] pathForResource:pathString ofType:nil];
    [self loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]]];
}

-(void)loadRequestWithURL:(NSString *)urlString {
    [self loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
}

@end
