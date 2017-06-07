//
//  CheckDataViewController.m
//  NingboSat
//
//  Created by 王会洲 on 16/11/28.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "CheckDataViewController.h"
#import "Config.h"
#import "RequestBase.h"
#import "URLSwitchManager.h"
#import "CommanFunc.h"
#import "UIView+UIViewUtils.h"


@interface CheckDataViewController ()<UIWebViewDelegate>
//<UITableViewDataSource,UITableViewDelegate>
//@property (nonatomic, weak) UITableView * checkDataTableView;
// 数据源
@property (nonatomic, strong) NSMutableArray * checkDataArry;
// 加载网页
@property (nonatomic, weak) UIWebView * chcekDataWebView;


@end

@implementation CheckDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    [self initData];
    self.title = self.titles;
}

-(void)initView {
    self.view.backgroundColor = YSColor(245, 245, 245);
    
    UIWebView * checkDataWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    checkDataWebView.delegate = self;
    [self.view addSubview:checkDataWebView];
    self.chcekDataWebView = checkDataWebView;
    
}
-(void)initData {
    NSDictionary * dict = @{@"cnnid":self.cpnid,@"docid": self.docid};
    NSDictionary * param = @{@"jsonParam":[dict JSONParamString]};
    
    [RequestBase requestWith:APITypeCheckData Param:param Complete:^(YSResponseStatus status, id object) {
        if (status == 0) {
            NSString * url = object[@"content"][0][@"url"];
            NSURLRequest * reques = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
            [self.chcekDataWebView loadRequest:reques];
        }
    } ShowOnView:self.view];
}

#pragma mark - webViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView {
    [self.view showHUDIndicatorViewAtCenter:@"加载中..."];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.view hideHUDIndicatorViewAtCenter];
    CGSize contentSize = webView.scrollView.contentSize;
    CGSize viewSize = self.view.bounds.size;
    
    float rw = viewSize.width / contentSize.width;
    
    webView.scrollView.minimumZoomScale = rw;
    webView.scrollView.maximumZoomScale = rw;
    webView.scrollView.zoomScale = rw;
}
- (void)dealloc {
    _chcekDataWebView.delegate = nil;
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}



@end
