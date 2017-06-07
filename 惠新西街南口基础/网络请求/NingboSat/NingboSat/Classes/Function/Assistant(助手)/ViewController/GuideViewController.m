//
//  GuideViewController.m
//  NingboSat
//
//  Created by 王会洲 on 16/9/26.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "GuideViewController.h"
#import "Config.h"
#import "UIView+UIViewUtils.h"


@interface GuideViewController ()
/**表格*/
@property (nonatomic, weak) UITableView * reluresTable;
@property (nonatomic, strong) NSMutableArray  * DataDict;
@end

@implementation GuideViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = YSColor(245, 245, 245);
    self.DataDict = @[
                      @{@"title":@"税务登记",@"url":ASSISTANT_GUIDE_REGISTER},
                      @{@"title":@"税务认定",@"url":ASSISTANT_GUIDE_IDENTIFIED},
                      @{@"title":@"发票办理",@"url":ASSISTANT_GUIDE_INVOICE},
                      @{@"title":@"申报纳税",@"url":ASSISTANT_GUIDE_DECLARE},
                      @{@"title":@"优惠办理",@"url":ASSISTANT_GUIDE_PREFERENTIAL},
                      @{@"title":@"证明办理",@"url":ASSISTANT_GUIDE_PROVE}
                      ].mutableCopy;
    
    
    [self initView];
    
}
-(void)initView {
    UITableView * reluresTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 47) style:UITableViewStylePlain];
    reluresTable.backgroundColor = YSColor(245, 245, 245);
    reluresTable.delegate = self;
    reluresTable.dataSource = self;
    [self.view addSubview:reluresTable];
    reluresTable.tableFooterView = [[UIView alloc] init];
}

#pragma mark -TABLEVIEW DELEGATE
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.DataDict.count;
}

-(UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * ID = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = self.DataDict[indexPath.row][@"title"];
    cell.textLabel.textColor = YSColor(80, 80, 80);
    cell.textLabel.font = FONT_BY_SCREEN(15);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.delegate && [self.delegate respondsToSelector:@selector(customPusviewController:)]) {
        NSString * url = self.DataDict[indexPath.row][@"url"];
        [self.delegate customPusviewController:url];
    }

}



//- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
//    NSString * url = [[request URL] absoluteString];
//    NSLog(@"-----url%@",url);
//    if ([url containsString:@".html"]) {
//        NSLog(@"---跳转");
//        if (self.delegate && [self.delegate respondsToSelector:@selector(customPusviewController:)]) {
//            [self.delegate customPusviewController:url];
//        }
//        return NO;
//    }else {
//        return YES;
//    }
//}


//-(void)OpenWeb {
//    // http://www.nb-n-tax.gov.cn/wzgl/ystApp/bszn/
//    // http://192.168.1.170:3000/guidesArticleList.html
//    NSString * dateURL = @"http://www.nb-n-tax.gov.cn/wzgl/ystApp/bszn/";
//    [self.loadWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:dateURL]]];
//    
//}

//- (void)dealloc
//{
//    _loadWebView.delegate = nil;
//    
//    [[NSURLCache sharedURLCache] removeAllCachedResponses];
//}
//
//-(void)webViewDidStartLoad:(UIWebView *)webView {
//    [self.view showHUDIndicatorViewAtCenter:@"加载中...."];
//}
//-(void)webViewDidFinishLoad:(UIWebView *)webView {
//    [self.view hideHUDIndicatorViewAtCenter];
//}



@end
