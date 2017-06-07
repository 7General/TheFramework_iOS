//
//  HomeViewController.m
//  NingboSat
//
//  Created by 王会洲 on 16/9/6.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "HomeViewController.h"
// method import
#import "Config.h"
#import "Masonry.h"
#import "UIButton+ImageAndTitle.h"
#import "RequestBase.h"
#import "JSWebDelegate.h"
#import "YSNotificationManager.h"
#import "UIImage+AlphaSet.h"
// view import
#import "EScrollerView.h"
#import "MatrixView.h"
#import "HomeSegment.h"
#import "YSAlertView.h"
// controller import
#import "YSWebController.h"
#import "BusinessController.h"
#import "LoginViewController.h"
#import "TaxSearchController.h"
#import "BookDetailViewController.h"
#import "BookDetailViewController.h"

#import "SuccessViewController.h"

@interface HomeViewController ()<HomeSegmentDelegate, UIGestureRecognizerDelegate, EScrollerViewDelegate>

@property (nonatomic, strong)NSMutableArray * bannerList;
@property (nonatomic, strong)NSMutableArray * functionList;

@property (nonatomic, strong)UIView * bgView;
@property (nonatomic, strong)UIView * bannerView;
@property (nonatomic, strong)UIView * functionView;
@property (nonatomic, strong)UIView * contentView;

@property (nonatomic, strong)NSArray *contentUrlItems;
@property (nonatomic, strong)NSMutableArray *contentViewItems;
@property (nonatomic, strong)NSMutableArray<JSWebDelegate *> *webDelegateItems;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = YSColor(0xf5, 0xf5, 0xf5);
    
    [self initView];
    [self loadBannerView];
    [self loadFunctionView];
    [self loadContentView];
    [self initObserver];
}

- (void)initObserver {
    [YSNotificationManager addUserLoginObserver:self selector:@selector(userLoginLogout)];
    [YSNotificationManager addUserLogoutObserver:self selector:@selector(userLoginLogout)];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)initView {
    // bgView
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:bgView];
    bgView.backgroundColor = self.view.backgroundColor;
    self.bgView = bgView;
    
    // banner
    {
        UIView * view = [[UIView alloc] init];
        [bgView addSubview:view];
        view.backgroundColor = [UIColor whiteColor];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(bgView).offset(0);
            make.left.and.right.equalTo(bgView);
            make.height.mas_equalTo(172 * KWidthScale);
        }];
        self.bannerView = view;
    }
    
    // function
    {
        UIView * view = [[UIView alloc] init];
        [bgView addSubview:view];
        view.backgroundColor = [UIColor whiteColor];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.bannerView.mas_bottom);
            make.left.and.right.equalTo(bgView);
            make.height.mas_equalTo(105);
        }];
        self.functionView = view;
    }
    
    // content
    {
        UIView * view = [[UIView alloc] init];
        [bgView addSubview:view];
        view.backgroundColor = [UIColor whiteColor];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.functionView.mas_bottom).offset(5);
            make.left.and.right.equalTo(bgView);
            make.bottom.equalTo(bgView).offset(-49);
        }];
        self.contentView = view;
    }
}


- (void)loadBannerView {
    [self removeSubviewForView:self.bannerView];
    UIImageView * imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bannerPlaceholder"]];
    [self.bannerView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.bannerView);
    }];
    [RequestBase requestWith:APITypeBanner Param:@{} Complete:^(YSResponseStatus status, id object) {
        if (status == YSResponseStatusSuccess) {
            if (![[NSString stringWithFormat:@"%@",object[@"content"]] isEqualToString:@"<null>"]){
                self.bannerList = object[@"content"];
                if (self.bannerList.count > 0) {
                    EScrollerView * banner = [[EScrollerView alloc] initWithFrameRect:CGRectMake(0, 0, SCREEN_WIDTH, 172 * KWidthScale)
                            ImageArray:[self.bannerList valueForKeyPath:@"@unionOfObjects.appfile"]
                            TitleArray:[self.bannerList valueForKeyPath:@"@unionOfObjects.doctitle"]];
                    banner.delegate = self;
                    [self.bannerView addSubview:banner];
                }
            }

        }
    } ShowOnView:self.view AnimationOption:0];
}

- (void)loadFunctionView {
    self.functionList = [NSMutableArray array];
    {
        NSDictionary *dict = @{@"title":@"纳税申报", @"subTitle":@"纳税申报", @"icon":@"home_declare"};
        [self.functionList addObject:dict];
    }
    {
        NSDictionary *dict = @{@"title":@"发票业务", @"subTitle":@"发票业务", @"icon":@"home_invoice", @"icon_un":@"home_invoice_un"};
        [self.functionList addObject:dict];
    }
    
    {
        NSDictionary *dict = @{@"title":@"预约办税", @"subTitle":@"预约办税", @"icon":@"yybs", @"icon_un":@"home_invoice_un"};
        [self.functionList addObject:dict];
    }
    
    
    CGFloat rowHeight = 105;
    
    [self removeSubviewForView:self.functionView];
    NSMutableArray * items = [NSMutableArray array];
    for (NSInteger i = 0; i < self.functionList.count; i++) {
        NSDictionary * dict = self.functionList[i];
        UIButton * button = [self funtionButtonWith:dict];
        button.bounds = CGRectMake(0, 0, (SCREEN_WIDTH / self.functionList.count), rowHeight);
        [button setContentAlignment:ButtonContentAlignmentVertical withGap:8];
        button.tag = i;
        [button addTarget:self action:@selector(functionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [items addObject:button];

    }
    
    MatrixView * view = [[MatrixView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, rowHeight) items:items cols:self.functionList.count splitColor:[UIColor clearColor] maxSize:CGSizeMake(SCREEN_WIDTH, rowHeight)];
    [self.functionView addSubview:view];
}

- (void)loadContentView {
    [self removeSubviewForView:self.contentView];
    NSArray * array = @[@"通知公告", @"发票查询", @"纳税咨询", @"涉税信息"];
    
    HomeSegment * homeSegment = [HomeSegment segmentWithItems:array];
    [self.contentView addSubview:homeSegment];
    [homeSegment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.equalTo(self.contentView);
        make.height.mas_equalTo(40);
    }];
    homeSegment.delegate = self;
    
    UIScrollView * scrollView = [[UIScrollView alloc] init];
    [self.contentView addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(homeSegment.mas_bottom);
        make.left.and.right.and.bottom.equalTo(self.contentView);
    }];
    scrollView.contentSize = CGSizeMake(array.count * SCREEN_WIDTH, scrollView.contentSize.height);
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.backgroundColor = YSColor(240, 240, 240);
    scrollView.scrollEnabled = NO;
    homeSegment.contentView = scrollView;
    
    {
        UIView * leftView = nil;
        NSArray *urlArray = @[HOME_ANNOUNCEMENT_URL,
                              HOME_INVOICE_SEARCH_URL,
                              HOME_CONSULT_URL];
        self.contentUrlItems = urlArray;
        self.contentViewItems = [NSMutableArray array];
        self.webDelegateItems = [NSMutableArray array];
        for (NSInteger i = 0; i < array.count; i++) {
            if (i == 3) {
                continue;
            }
            
            UIWebView * webView = [[UIWebView alloc] init];
            [scrollView addSubview:webView];
            webView.backgroundColor = YSColor(0xf5, 0xf5, 0xf5);
            [webView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(scrollView);
                make.height.equalTo(scrollView);
                make.width.equalTo(scrollView);
                if (leftView) {
                    make.left.mas_equalTo(leftView.mas_right);
                }
                else {
                    make.left.equalTo(scrollView);
                }
            }];
            if (i == 0) {
                NSURL *url = [NSURL URLWithString:urlArray[i]];
                NSURLRequest *request = [NSURLRequest requestWithURL:url];
                [webView loadRequest:request];
            }
            leftView = webView;
            
            JSWebDelegate *webDelegate = [[JSWebDelegate alloc] init];
            webView.delegate = webDelegate;
            webDelegate.viewController = self;
            [self.webDelegateItems addObject:webDelegate];
            
            [self.contentViewItems addObject:webView];
        }
    }
}

- (UIButton *)funtionButtonWith:(NSDictionary *)dict {
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    if (dict[@"icon"]) {
        UIImage * image = [UIImage imageNamed:dict[@"icon"]];
        [button setImage:image forState:UIControlStateNormal];
        [button setImage:[UIImage imageByApplyingAlpha:0.5 image:image] forState:UIControlStateHighlighted];
    }
    if (dict[@"icon_un"]) {
        UIImage * image = [UIImage imageNamed:dict[@"icon_un"]];
        [button setImage:image forState:UIControlStateDisabled];
    }
    
    {
        NSAttributedString *title = [[NSAttributedString alloc] initWithString:[dict[@"title"] stringByAppendingString:@""] attributes:@{NSFontAttributeName:FONT_BY_SCREEN(15), NSForegroundColorAttributeName:YSColor(80, 80, 80)}];
//        NSAttributedString *subTitle = [[NSAttributedString alloc] initWithString:dict[@"subTitle"] attributes:@{NSFontAttributeName:FONT_BY_SCREEN(13), NSForegroundColorAttributeName:YSColor(80, 80, 80)}];
        NSMutableAttributedString *result = [[NSMutableAttributedString alloc] init];
        [result appendAttributedString:title];
//        [result appendAttributedString:subTitle];
        NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.paragraphSpacing = 0;
        paragraphStyle.lineHeightMultiple = 1;
        [result addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, result.length)];
        [button setAttributedTitle:result forState:UIControlStateNormal];
        button.titleLabel.numberOfLines = 0;
    }
    
    return button;
}

#pragma mark - button click action
- (void)functionBtnClick:(UIButton *)sender {
    //TODO: 功能区按键点击事件.
    if (sender.tag != 1 && ![NSObject isLogin]) {
        [self unReachable];
        return;
    }
    
    if (sender.tag == 0 ) {
        YSWebController *webVc = [[YSWebController alloc] init];
        webVc.urlStr = DECLARE_URL;
        [self.navigationController pushViewController:webVc animated:YES];
    }
    if (sender.tag == 1) {
        BusinessController * bvc = [[BusinessController alloc] init];
        [self.navigationController pushViewController:bvc animated:YES];
    }
    if (sender.tag == 2) {
        BookDetailViewController * bok = [[BookDetailViewController alloc] init];
        [self.navigationController pushViewController:bok animated:YES];
    }
}

#pragma mark - HomeSegmentDelegate
- (void)segment:(HomeSegment *)segment selected:(NSInteger)index {
    static NSInteger lastIndex = 0;
    NSInteger tmplastIndex = lastIndex;
    lastIndex = index;
    
    if (tmplastIndex == 3) {
        //从1区 点击3区, 又重定向回原来的1区, 不作处理(即为了不重复刷新1区页面).
        return;
    }
    //TODO: 页面切换.
    if (index == 3) {
        if (![NSObject isLogin]) {
            [self unReachable];
        }
        else {
            TaxSearchController *vc = [[TaxSearchController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
        // 3区 当前层没有页面, 弹窗或者跳转至下层页面, 之后需要重定向回上次分区页面.
        [segment setSelectIndex:tmplastIndex];
    }
    else {
        UIWebView *webView = self.contentViewItems[index];
        NSURL *url = [NSURL URLWithString:self.contentUrlItems[index]];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [webView loadRequest:request];
    }
    
}

- (void)unReachable {
    YSAlertView *alertView = [YSAlertView alertWithTitle:nil message:@"该模块需要登录才能使用，是否立即登录？" buttonTitles:@"稍后", @"立即登录", nil];
    [alertView show];
    [alertView alertButtonClick:^(NSInteger buttonIndex) {
        if (buttonIndex == 1) {
            [self presentViewController:[LoginViewController new] animated:YES completion:^{
                
            }];
        }
    }];
}

#pragma mark - EScrollerViewDelegate
-(void)EScrollerViewDidClicked:(NSUInteger)index {
    YSWebController *vc = [[YSWebController alloc] init];
    vc.urlStr = self.bannerList[index][@"docpuburl"];
//    vc.title = self.bannerList[index][@"doctitle"];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark remove subview
- (void)removeSubviewForView:(UIView *)view {
    for (UIView * subView in view.subviews) {
        [subView removeFromSuperview];
    }
}

#pragma mark - notification observer action
- (void)userLoginLogout {
    
}

- (void)keyboardWillShow:(NSNotification *)sender {
    if (!(self.tabBarController.selectedViewController == self.navigationController) || !(self.navigationController.topViewController == self)) {
        NSLog(@"isnot first responder");
        return;
    }
    NSValue *boundsValue = sender.userInfo[UIKeyboardFrameEndUserInfoKey];
    CGRect bounds = boundsValue.CGRectValue;
    [self.bannerView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgView).offset(-CGRectGetHeight(bounds) + 100);
    }];
    
    [UIView animateWithDuration:2.5 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)keyboardWillHide:(NSNotification *)sender {
    if (!(self.tabBarController.selectedViewController == self.navigationController) || !(self.navigationController.topViewController == self)) {
        NSLog(@"isnot first responder");
        return;
    }
    [self.bannerView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgView).offset(0);
    }];
    
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}

@end
