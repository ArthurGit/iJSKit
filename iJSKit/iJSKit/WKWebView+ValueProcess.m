//
//  WKWebView+ValueProcess.m
//  iJSKit
//
//  Created by LJT-iOS-Devloper on 2019/1/31.
//  Copyright © 2019 LJT-iOS-Devloper. All rights reserved.
//

#import "WKWebView+ValueProcess.h"

@implementation WKWebView (ValueProcess)

-(void)valueForElementById:(NSString *)element_id completionHandler:(void (^ _Nullable)(NSString* element_value, NSError * _Nullable error))completionHandler {
    NSString *js = [NSString stringWithFormat:@"document.getElementById('%@').value",element_id];
    [self evaluateJavaScript:js completionHandler:^(NSString* _Nullable obj, NSError * _Nullable error) {
        if (completionHandler != nil) {
            completionHandler(obj,error);
        }
    }];
}

-(void)valueToElementById:(NSString *)element_id Velue:(NSString *)element_value completionHandler:(void (^ _Nullable)(NSString* element_value, NSError * _Nullable error))completionHandler {
    NSString *js = [NSString stringWithFormat:@"document.getElementById('%@').value='%@'",element_id,element_value];
    [self evaluateJavaScript:js completionHandler:^(NSString* _Nullable obj, NSError * _Nullable error) {
        if (completionHandler != nil) {
            completionHandler(obj,error);
        }
    }];
}

-(void)submitByFormId:(NSString *)form_id completionHandler:(void (^ _Nullable)(NSString* element_value, NSError * _Nullable error))completionHandler {
    NSString *js = [NSString stringWithFormat:@"document.getElementById('%@').submit()",form_id];
    [self evaluateJavaScript:js completionHandler:^(NSString* _Nullable obj, NSError * _Nullable error) {
        if (completionHandler != nil) {
            completionHandler(obj,error);
        }
    }];
}

-(void)executeJavaScriptMathod:(NSString *)mathod completionHandler:(void (^ _Nullable)(_Nullable id return_value, NSError * _Nullable error))completionHandler {
    NSString *js = mathod;
    [self evaluateJavaScript:js completionHandler:^(id _Nullable obj, NSError * _Nullable error) {
        if (completionHandler != nil) {
            completionHandler(obj,error);
        }
    }];
}

@end
