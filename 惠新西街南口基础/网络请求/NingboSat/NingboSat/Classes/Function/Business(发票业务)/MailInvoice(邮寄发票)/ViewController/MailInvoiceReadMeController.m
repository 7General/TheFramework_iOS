//
//  MailInvoiceReadMeController.m
//  NingboSat
//
//  Created by ysyc_liu on 16/9/20.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "MailInvoiceReadMeController.h"
#import "Config.h"
#import "Masonry.h"
#import "UIButton+YSSolidColorButton.h"
#import "MailInvoiceController.h"

@interface MailInvoiceReadMeController()

@end

@implementation MailInvoiceReadMeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"邮寄发票申请";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initView];
}

- (void)initView {
    CGRect frame = self.view.bounds;
    frame.size.height = CGRectGetHeight(frame) - 64 * 2;
    UIWebView *webView = [[UIWebView alloc] initWithFrame:frame];
    [self.view addSubview:webView];
    webView.backgroundColor = [UIColor whiteColor];
    NSString* path = [[NSBundle mainBundle] pathForResource:@"MailInvoiceReadMe" ofType:@"html"];
    NSURL* url = [NSURL fileURLWithPath:path];
    NSURLRequest* request = [NSURLRequest requestWithURL:url] ;
    [webView loadRequest:request];
    
    {
        UIView * view = [[UIView alloc] init];
        [self.view addSubview:view];
        view.backgroundColor = YSColor(0xf5, 0xf5, 0xf5);
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.bottom.and.right.equalTo(self.view);
            make.height.mas_equalTo(64);
        }];
        
        UIButton *button = [UIButton buttonWithColor:YSColor(0x4b, 0xc4, 0xfb) title:@"我已阅读并知晓以上申领须知"];
        [view addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(44);
            make.width.equalTo(view).offset(-35 * 2);
            make.center.equalTo(view);
        }];
        
        [button addTarget:self action:@selector(commitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
}

#pragma mark - button click action
- (void)commitBtnClick {
    [MailInvoiceController pushMailInvoiceControllerByController:self];
}

@end
