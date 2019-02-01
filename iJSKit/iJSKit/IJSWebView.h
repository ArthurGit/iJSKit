//
//  IJSWebView.h
//  iJSKit
//
//  Created by LJT-iOS-Devloper on 2019/1/31.
//  Copyright © 2019 LJT-iOS-Devloper. All rights reserved.
//

#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface IJSWebView : WKWebView
+(IJSWebView *)webViewWithHandlers:(NSArray *)names Frame:(CGRect)frame Handler:(id <WKScriptMessageHandler>)scriptMessageHandler;
+(WKWebViewConfiguration *)configScriptMessageHandler:(NSArray *)names Handler:(id <WKScriptMessageHandler>)scriptMessageHandler;
-(void)removeAllConfig:(NSArray *)names;
-(void)removeConfig:(NSString *)name;
-(void)loadRequestWithPath:(NSString *)pathString;
-(void)loadRequestWithURL:(NSString *)urlString;
@end

NS_ASSUME_NONNULL_END
