//
//  JSWebDelegate.m
//  NingboSat
//
//  Created by ysyc_liu on 16/9/27.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "JSWebDelegate.h"
#import "Config.h"
#import "UIView+UIViewUtils.h"
#import "WebImageDetailView.h"
#import "UIWebView+TS_JavaScriptContext.h"

@implementation NSURLRequest (NSURLRequestWithIgnoreSSL)

+ (BOOL)allowsAnyHTTPSCertificateForHost:(NSString *)host {
    return YES;
}

@end


@interface JSWebDelegate()<TSWebViewDelegate>

@property (nonatomic, weak)UIWebView *webView;

@end

@implementation JSWebDelegate


#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    if (navigationType == UIWebViewNavigationTypeLinkClicked) {
        NSArray *array = @[NINGBO_GOV_SERVER, NINGBO_SEARCH_SERVER];
        for (NSString *preStr in array) {
            if (([request.URL.absoluteString hasPrefix:preStr]
                && [request.URL.absoluteString rangeOfString:@"html"].location != NSNotFound)
                ) {
                return YES;
            }
            else if ([request.URL.absoluteString rangeOfString:@"/guoshui/content/nb_viewContent.jsp?id="].location != NSNotFound) {
                NSString *js = [NSString stringWithFormat:@"phone.eventFromJS('{\"type\":\"6\",\"data\":{\"url\":\"%@\"}}')", request.URL.absoluteString];
                [webView stringByEvaluatingJavaScriptFromString:js];
                return NO;
            }
        }
        [[UIApplication sharedApplication] openURL:request.URL];
        return NO;
    }
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView {
    self.webView = webView;
//    [self addJSContactMethodForWebView:webView];
    [webView showHUDIndicatorViewETaxAtCenter];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
//    [self addJSContactMethodForWebView:webView];
    [webView hideHUDIndicatorViewAtCenter];
    [self addDetailImageClick:webView];
    
    // 兼容context创建交互未建立时调用的代码.
    {
        NSString *changeViewType = [webView stringByEvaluatingJavaScriptFromString:@"typeof changeview"];
        if ([changeViewType isEqualToString:@"function"]) {
            [webView stringByEvaluatingJavaScriptFromString:@"changeView()"];
        }
    }
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [webView hideHUDIndicatorViewAtCenter];
}
#pragma mark - 
- (void)addJSContactMethodForWebView:(UIWebView *)webView {
    __weak typeof(self) weakSelf = self;
    JSContext *context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    if (context) {
        NSString * phoneType = [webView stringByEvaluatingJavaScriptFromString:@"typeof phone"];
        
        if (![phoneType isEqualToString:@"object"]) {
            PhoneJSContact * phoneJsContact = [[PhoneJSContact alloc] init];
            phoneJsContact.viewController = weakSelf.viewController;
            phoneJsContact.callDelegate = weakSelf;
            context[@"phone"] = phoneJsContact;
        }
    }
}
- (void)addJSContactMethodForContext:(JSContext *)context {
    __weak typeof(self) weakSelf = self;
    if (context) {
        JSValue * phoneType = [context evaluateScript:@"typeof phone"];
        if (![[phoneType toString] isEqualToString:@"object"]) {
            PhoneJSContact * phoneJsContact = [[PhoneJSContact alloc] init];
            phoneJsContact.viewController = weakSelf.viewController;
            phoneJsContact.callDelegate = weakSelf;
            context[@"phone"] = phoneJsContact;
        }
    }
}

- (void)addDetailImageClick:(UIWebView *)webView {
    JSContext *context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    if (context) {
        NSBundle *bundle = [NSBundle mainBundle];
        NSString *filePath = [bundle pathForResource:@"WebViewDetailImage.js" ofType:@"txt"];
        NSString *js = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
        [context evaluateScript:js];
    }
}

#pragma mark - PhoneJSCallDelegate

- (void)eventFromJSResponse:(NSString *)jsonStr type:(JSEventType)type {
    @try {
        JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
        if (context) {
            NSString *script = [NSString stringWithFormat:@"eventFromJS('%@')", jsonStr];
            [context evaluateScript:script];
        }
    } @catch (NSException *exception) {
        NSLog(@"[EXCEPTION] %@ : %@", [self class], exception);
    }
    
}

#pragma mark - TSWebViewDelegate
- (void)webView:(UIWebView *)webView didCreateJavaScriptContext:(JSContext*) ctx {
    [self addJSContactMethodForContext:ctx];
}

@end
