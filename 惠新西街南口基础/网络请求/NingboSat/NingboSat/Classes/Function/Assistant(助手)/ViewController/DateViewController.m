//
//  DateViewController.m
//  NingboSat
//
//  Created by 王会洲 on 16/9/26.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "DateViewController.h"
#import "Config.h"

@interface DateViewController ()
@property (nonatomic, strong) UIWebView * loadWebView;
@end

@implementation DateViewController
- (UIWebView *)loadWebView{
    if (!_loadWebView) {
        _loadWebView = [[UIWebView alloc]init];
        _loadWebView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 47 - 44 + 20);
        _loadWebView.delegate = self;
        _loadWebView.backgroundColor = [UIColor clearColor];
        _loadWebView.scalesPageToFit = YES;
        [self.view addSubview:_loadWebView];
    }
    return _loadWebView;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = YSColor(245, 245, 245);
    [self OpenWeb];

}


-(void)OpenWeb {
    NSString * dateURL = ASSISTANT_CALENDAR;
   [self.loadWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:dateURL]]];
    
}

- (void)dealloc {
    _loadWebView.delegate = nil;
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

@end
