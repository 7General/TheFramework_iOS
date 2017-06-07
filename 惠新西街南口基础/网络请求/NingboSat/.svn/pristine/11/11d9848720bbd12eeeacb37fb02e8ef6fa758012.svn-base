//
//  InteractiveViewController.m
//  NingboSat
//
//  Created by 王会洲 on 16/9/6.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "InteractiveViewController.h"
#import "Config.h"
#import "Masonry.h"
#import "UIButton+ImageAndTitle.h"
#import "UIButton+FillColor.h"
#import "UIImage+AlphaSet.h"
#import "MatrixView.h"
#import "UIButton+ImageAndTitle.h"
#import "JSWebDelegate.h"
#import "YSWebController.h"
#import "YSAlertView.h"
#import "LoginViewController.h"

#define ICON_TITLE @"title"
#define ICON_IMG @"icon"
#define ICON_LINK @"link"

@interface InteractiveViewController ()

@property (nonatomic,strong)NSArray *typeInfoArray;
@property (nonatomic, strong)UIView *bannerView;
@property (nonatomic, strong)MatrixView *typeView;
@property (nonatomic,strong)UIWebView *webView;

@property (nonatomic, strong)JSWebDelegate *webDelegate;

@end

@implementation InteractiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"互动";
    self.typeInfoArray = @[@{ICON_TITLE:@"税务新闻",ICON_IMG:@"hd_taxnews",ICON_LINK:INTERACTION_SWXW_URL},
                           @{ICON_TITLE:@"最热咨询",ICON_IMG:@"hd_consult_red",ICON_LINK:INTERACTION_ZRZX_URL},
                           @{ICON_TITLE:@"最新咨询",ICON_IMG:@"hd_consult_green",ICON_LINK:INTERACTION_ZXZX_URL},
                           @{ICON_TITLE:@"我有话说",ICON_IMG:@"feedbackIcon",ICON_LINK:MINE_FEEDBACK_URL},
                           ];
    [self initView];
    [self initData];
    [self initObserver];
}

-(void)initData{
    
}

-(void)initView{
    self.view.backgroundColor = YSColor(0xf5, 0xf5, 0xf5);
    [self addBannerView];
    [self addTypeView];
    [self addWebView];
}

- (void)addBannerView {
    UIImageView *bannerView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hd_banner"]];
    [self.view addSubview:bannerView];
    [bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.and.right.equalTo(self.view);
        make.height.mas_equalTo(bannerView.image.size.height * KWidthScale);
    }];
    self.bannerView = bannerView;
}

- (void)addTypeView {
    CGFloat rowHeight = 0;
    NSInteger colNum = 4;
    NSMutableArray *btnItems = [NSMutableArray array];
    for (NSInteger i = 0; i < self.typeInfoArray.count; i++) {
        NSDictionary *dict = self.typeInfoArray[i];
        UIButton *button = [self buttonWithDict:dict];
        button.tag = i;
        [button addTarget:self action:@selector(typeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        CGFloat width = CGRectGetWidth(self.view.bounds) / colNum;
        CGFloat height = button.currentImage.size.height + button.titleLabel.font.lineHeight + 5 * 3;
        button.bounds = CGRectMake(0, 0, width, height);
        [btnItems addObject:button];
        [button setContentAlignment:ButtonContentAlignmentVertical withGap:5];
        
        if (rowHeight < height) {
            rowHeight = height;
        }
    }
    
    UIView *matrixBgView = [[UIView alloc] init];
    [self.view addSubview:matrixBgView];
    matrixBgView.backgroundColor = [UIColor whiteColor];
    [matrixBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bannerView.mas_bottom);
        make.left.and.right.equalTo(self.view);
        make.height.mas_equalTo(20 + rowHeight * (((NSInteger)(self.typeInfoArray.count - 1) / colNum) + 1));
    }];
    
    CGRect matrixFrame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), rowHeight);
    MatrixView * matrixView = [[MatrixView alloc] initWithFrame:matrixFrame items:btnItems cols:colNum splitColor:[UIColor clearColor] maxSize:CGSizeMake(MAXFLOAT, CGRectGetHeight(self.view.bounds))];
    matrixView.backgroundColor = [UIColor whiteColor];
    [matrixBgView addSubview:matrixView];
    self.typeView = matrixView;
    [matrixView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(matrixBgView).insets(UIEdgeInsetsMake(10, 0, 10, 0));
    }];
}

-(void)addWebView {
    self.webView = [[UIWebView alloc] init];
    self.webView.backgroundColor = YSColor(0xf5, 0xf5, 0xf5);
    NSURLRequest *webRequst = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:self.typeInfoArray[0][ICON_LINK]] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30.0f];
    [self.webView loadRequest:webRequst];
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.typeView.superview.mas_bottom);
        make.left.and.right.equalTo(self.view);
        make.bottom.mas_offset(-49);
    }];
    
    self.webDelegate = [[JSWebDelegate alloc] init];
    self.webDelegate.viewController = self;
    self.webView.delegate = self.webDelegate;
}

- (void)initObserver {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (UIButton *)buttonWithDict:(NSDictionary *)dict {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:dict[ICON_TITLE] forState:UIControlStateNormal];
    [button setTitleColor:YSColor(0x50, 0x50, 0x50) forState:UIControlStateNormal];
    button.titleLabel.font = FONT_BY_SCREEN(15);
    button.titleLabel.numberOfLines = 0;
    UIImage *image = [UIImage imageNamed:dict[ICON_IMG]];
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:[UIImage imageByApplyingAlpha:0.5 image:image] forState:UIControlStateHighlighted];
    return button;
}

#pragma mark - get and set
- (void)setUrlStr:(NSString *)urlStr {
    [self loadWebView:urlStr];
}

- (void)loadWebView:(NSString *)urlStr {
    if (!self.webView) {
        return;
    }
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

#pragma mark - button click action
- (void)typeButtonClick:(UIButton *)sender {
    NSInteger index = sender.tag;
    if (index == 3) {
        if (![NSObject isLogin]) {
            [self unReachable];
            return;
        }
        YSWebController *vc = [[YSWebController alloc] init];
        vc.urlStr = self.typeInfoArray[index][ICON_LINK];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else {
        NSURLRequest *webRequst = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:self.typeInfoArray[index][ICON_LINK]] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30.0f];
        [self.webView loadRequest:webRequst];
    }
}


#pragma mark - notification observer action

- (void)keyboardWillShow:(NSNotification *)sender {
    if (!(self.tabBarController.selectedViewController == self.navigationController) || !(self.navigationController.topViewController == self)) {
        NSLog(@"isnot first responder");
        return;
    }
    NSValue *boundsValue = sender.userInfo[UIKeyboardFrameEndUserInfoKey];
    CGRect bounds = boundsValue.CGRectValue;
    [self.bannerView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(-CGRectGetHeight(bounds) + 50);
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
        make.top.equalTo(self.view);
    }];
    
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}

#pragma mark - other methods
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

@end
