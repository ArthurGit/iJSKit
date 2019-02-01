//
//  WKWebView+ValueProcess.h
//  iJSKit
//
//  Created by 颜渊 on 2019/1/31.
//  Copyright © 2019 YXJ. All rights reserved.
//

#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WKWebView (ValueProcess)
-(void)valueForElementById:(NSString *)element_id completionHandler:(void (^ _Nullable)(NSString* element_value, NSError * _Nullable error))completionHandler;
-(void)valueToElementById:(NSString *)element_id Velue:(NSString *)element_value completionHandler:(void (^ _Nullable)(NSString* element_value, NSError * _Nullable error))completionHandler;
-(void)submitByFormId:(NSString *)form_id completionHandler:(void (^ _Nullable)(NSString* element_value, NSError * _Nullable error))completionHandler;
-(void)executeJavaScriptMathod:(NSString *)mathod completionHandler:(void (^ _Nullable)(_Nullable id return_value, NSError * _Nullable error))completionHandler;
@end

NS_ASSUME_NONNULL_END
