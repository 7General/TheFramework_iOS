//
//  YSWebController.m
//  NingboSat
//
//  Created by ysyc_liu on 16/9/26.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "YSWebController.h"
#import "Masonry.h"
#import "Config.h"
#import "JSWebDelegate.h"


@interface YSWebController ()

@property (nonatomic, strong)UIWebView *webView;
@property (nonatomic, strong)JSWebDelegate *webDelegate;
@property (nonatomic, weak)UIViewController *viewController;
@property (nonatomic, assign)BOOL enableScale;

@end

@implementation YSWebController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:!self.showNavigation animated:NO];
}

- (instancetype)initWithController:(UIViewController *)viewController {
    self = [super init];
    if (self) {
        self.viewController = viewController;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = YSColor(0xf5, 0xf5, 0xf5);
    [self initView];
    
    if (self.showNavigation) {
        self.hideStatusCover = YES;
    }
    
    if (!self.hideStatusCover) {
        UIView *view = [[UIView alloc] init];
        [self.view addSubview:view];
        view.backgroundColor = [UIColor whiteColor];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.and.left.and.right.equalTo(self.view);
            make.height.mas_equalTo(FIT_HEIGHT);
        }];
    }
}

- (void)initView {
    UIWebView *webView = [[UIWebView alloc] init];
    [self.view addSubview:webView];
    webView.backgroundColor = [UIColor whiteColor];
    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    self.webView = webView;
    if (self.enableScale) {
        self.webView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
        self.webView.scalesPageToFit=YES;
        self.webView.multipleTouchEnabled=YES;
        self.webView.userInteractionEnabled=YES;
    }
    
    JSWebDelegate *webDelegate = [[JSWebDelegate alloc] init];
    self.webDelegate = webDelegate;
    webDelegate.viewController = self.viewController ? self.viewController : self;
    webView.delegate = webDelegate;
    
    [self loadWebView];
}

- (void)loadWebView {
    if (!self.webView) {
        return;
    }
    NSURL *url = [NSURL URLWithString:self.urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

- (void)setUrlStr:(NSString *)urlStr {
    _urlStr = urlStr;
    
    [self loadWebView];
}

- (void)setEnableScale {
    self.enableScale = YES;
}

@end
