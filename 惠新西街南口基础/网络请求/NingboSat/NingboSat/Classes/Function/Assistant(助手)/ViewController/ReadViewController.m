//
//  ReadViewController.m
//  NingboSat
//
//  Created by 王会洲 on 16/9/28.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "ReadViewController.h"
#import "UIView+UIViewUtils.h"
#import "Config.h"
#import "PhoneJSContact.h"

@interface ReadViewController ()
@property (nonatomic, strong) UIWebView * loadWebView;
@end

@implementation ReadViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (UIWebView *)loadWebView{
    if (!_loadWebView) {
        _loadWebView = [[UIWebView alloc]init];
        _loadWebView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        _loadWebView.delegate = self;
        _loadWebView.backgroundColor = [UIColor clearColor];
        _loadWebView.scalesPageToFit = YES;
        [self.view addSubview:_loadWebView];
    }
    return _loadWebView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self OpenWeb];
}


-(void)OpenWeb {
    [self.loadWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.ReadUrl]]];
    UIView * stateView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
    stateView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:stateView];
}

- (void)dealloc {
    _loadWebView.delegate = nil;
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    if (navigationType == UIWebViewNavigationTypeLinkClicked) {
        NSArray *array = @[NINGBO_GOV_SERVER, NINGBO_SEARCH_SERVER];
        for (NSString *preStr in array) {
            if ([request.URL.absoluteString hasPrefix:preStr] && [request.URL.absoluteString rangeOfString:@"html"].location != NSNotFound) {
                return YES;
            }
        }
        [[UIApplication sharedApplication] openURL:request.URL];
        return NO;
    }
    return YES;
}
-(void)webViewDidStartLoad:(UIWebView *)webView {
    [self.view showHUDIndicatorViewETaxAtCenter];
    [self addJSContactMethodForWebView:webView];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.view hideHUDIndicatorViewAtCenter];
    [self addJSContactMethodForWebView:webView];
}


- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    if([error code] == NSURLErrorCancelled)
    {
        return;
    }
}

#pragma mark -
- (void)addJSContactMethodForWebView:(UIWebView *)webView {
    __weak typeof(self) weakSelf = self;
    JSContext *context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    if (context) {
        NSString * phoneType = [webView stringByEvaluatingJavaScriptFromString:@"typeof phone"];
        
        if (![phoneType isEqualToString:@"object"]) {
            PhoneJSContact * phoneJsContact = [[PhoneJSContact alloc] init];
            phoneJsContact.viewController = weakSelf;
            context[@"phone"] = phoneJsContact;
        }
    }
}

@end
