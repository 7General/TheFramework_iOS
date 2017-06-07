//
//  QueryViewController.m
//  NingboSat
//
//  Created by 王会洲 on 16/9/6.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "QueryViewController.h"
#import "Config.h"
#import "Masonry.h"
#import "UIButton+ImageAndTitle.h"
#import "UIButton+FillColor.h"
#import "UIImage+AlphaSet.h"
#import "MatrixView.h"
#import "UIButton+ImageAndTitle.h"
#import "JSWebDelegate.h"
#import "YSNotificationManager.h"

#define ICON_TITLE @"title"
#define ICON_IMG @"icon"
#define ICON_LINK @"link"

@interface QueryViewController (){
    UIButton *invoiceTypePreButton;
}

@property (nonatomic,strong)NSArray *typeInfoArray;
@property (nonatomic, strong)UIView *bannerView;
@property (nonatomic, strong)MatrixView *typeView;
@property (nonatomic,strong)UIWebView *webView;

@property (nonatomic, strong)JSWebDelegate *webDelegate;
@end

@implementation QueryViewController

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
    UIImageView *bannerView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"query_banner"]];
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
    NSMutableArray *btnItems = [NSMutableArray array];
    for (NSInteger i = 0; i < self.typeInfoArray.count; i++) {
        NSDictionary *dict = self.typeInfoArray[i];
        UIButton *button = [self buttonWithDict:dict];
        button.tag = i;
        [button addTarget:self action:@selector(typeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        CGFloat width = CGRectGetWidth(self.view.bounds) / 4;
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
        make.height.mas_equalTo(20 + rowHeight * (((NSInteger)(self.typeInfoArray.count - 1) / 4) + 1));
    }];
    
    CGRect matrixFrame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), rowHeight);
    MatrixView * matrixView = [[MatrixView alloc] initWithFrame:matrixFrame items:btnItems cols:4 splitColor:[UIColor clearColor] maxSize:CGSizeMake(MAXFLOAT, CGRectGetHeight(self.view.bounds))];
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
    self.webView.delegate = self.webDelegate;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"查询";
    self.typeInfoArray = @[@{ICON_TITLE:@"普通发票",ICON_IMG:@"query_normal",ICON_LINK:INVOICE_SEARCH_URL},
                           @{ICON_TITLE:@"纳税人查询",ICON_IMG:@"query_taxer",ICON_LINK:TAXER_SEARCH_URL},
                           @{ICON_TITLE:@"车购税查询",ICON_IMG:@"query_car",ICON_LINK:CAR_TAXER_SEARCH_URL},
                           @{ICON_TITLE:@"发票票样",ICON_IMG:@"query_invoice",ICON_LINK:INVOICE_TYPE_SEARCH_URL},
                           @{ICON_TITLE:@"税种税率",ICON_IMG:@"query_taxRate",ICON_LINK:TAX_RATE_TYPE_SEARCH_URL},
                           @{ICON_TITLE:@"出口退税率",ICON_IMG:@"query_export",ICON_LINK:TAX_REBATES_SEARCH_URL},
                           ];
    [self initView];
    [self initData];
    [self initObserver];
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

#pragma mark - button click action
- (void)typeButtonClick:(UIButton *)sender {
    NSInteger index = sender.tag;
    NSURLRequest *webRequst = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:self.typeInfoArray[index][ICON_LINK]] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30.0f];
    [self.webView loadRequest:webRequst];
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
        make.top.equalTo(self.view).offset(-CGRectGetHeight(bounds) + 100);
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


@end
