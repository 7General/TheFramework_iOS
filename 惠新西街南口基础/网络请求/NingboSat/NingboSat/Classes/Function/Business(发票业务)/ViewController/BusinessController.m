//
//  BusinessController.m
//  NingboSat
//
//  Created by ysyc_liu on 2016/12/1.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "BusinessController.h"
#import "Config.h"
#import "Masonry.h"
#import "UIButton+ImageAndTitle.h"
#import "UIButton+FillColor.h"
#import "UIImage+AlphaSet.h"
#import "MatrixView.h"
#import "UIButton+ImageAndTitle.h"
#import "YSAlertView.h"

#import "YSWebController.h"
#import "MailInvoiceController.h"
#import "LoginViewController.h"
#import "RequestBase.h"
#import "SecurityUtil.h"
@interface BusinessController ()

@property (nonatomic, strong)NSArray *typeInfoArray;
@property (nonatomic, strong)UIView *bannerView;
@property (nonatomic, strong)MatrixView *typeView;

@end

@implementation BusinessController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = YSColor(0xf5, 0xf5, 0xf5);
    self.navigationItem.title = @"涉税信息查询";
    self.typeInfoArray = @[@{@"title":@"发票申领",@"subTitle":@"发票邮寄申请", @"icon":@"business_icon0"},
                           @{@"title":@"发票代开",@"subTitle":@"增值税专用发票", @"icon":@"business_icon1"},
                           @{@"title":@"发票开具",@"subTitle":@"电子普通发票", @"icon":@"business_icon2"},
                           @{@"title":@"开票设置",@"subTitle":@"常用信息编辑", @"icon":@"business_icon3"},
                           @{@"title":@"我的发票",@"subTitle":@"增值税普通发票", @"icon":@"business_icon4"},
                           ];
    [self initView];
    [self initData];
    [self initObserver];
}

- (void)initData {

}

-(void)initView{
    self.view.backgroundColor = YSColor(0xf5, 0xf5, 0xf5);
    [self addBannerView];
    [self addTypeView];
}

- (void)addBannerView {
    UIImageView *bannerView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"business_banner"]];
    [self.view addSubview:bannerView];
    [bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.and.right.equalTo(self.view);
        make.height.mas_equalTo(bannerView.image.size.height * KWidthScale);
    }];
    self.bannerView = bannerView;
}

- (void)addTypeView {
    CGFloat rowHeight = 124 * KWidthScale;
    NSInteger colNum = 2;
    NSMutableArray *btnItems = [NSMutableArray array];
    for (NSInteger i = 0; i < self.typeInfoArray.count; i++) {
        NSDictionary *dict = self.typeInfoArray[i];
        UIButton *button = [self buttonWithDict:dict];
        button.tag = i;
        [button addTarget:self action:@selector(typeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        CGFloat width = CGRectGetWidth(self.view.bounds) / colNum;
        CGFloat height = rowHeight;
        button.bounds = CGRectMake(0, 0, width, height);
        [btnItems addObject:button];
    }
    [self setButtonLayout:btnItems maxWidth:CGRectGetWidth(self.view.frame) / colNum];
    
    UIView *matrixBgView = [[UIView alloc] init];
    [self.view addSubview:matrixBgView];
    matrixBgView.backgroundColor = [UIColor whiteColor];
    [matrixBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bannerView.mas_bottom);
        make.left.and.right.equalTo(self.view);
        make.height.mas_equalTo(rowHeight * (((NSInteger)(self.typeInfoArray.count - 1) / colNum) + 1));
    }];
    
    CGRect matrixFrame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), rowHeight);
    MatrixView * matrixView = [[MatrixView alloc] initWithFrame:matrixFrame items:btnItems cols:colNum maxSize:CGSizeMake(MAXFLOAT, CGRectGetHeight(self.view.bounds))];
    matrixView.backgroundColor = [UIColor whiteColor];
    [matrixBgView addSubview:matrixView];
    self.typeView = matrixView;
    [matrixView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(matrixBgView).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}


- (void)initObserver {
    
}

- (UIButton *)buttonWithDict:(NSDictionary *)dict {
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
        NSAttributedString *title = [[NSAttributedString alloc] initWithString:[dict[@"title"] stringByAppendingString:@"\n"] attributes:@{NSFontAttributeName:FONT_BY_SCREEN(15), NSForegroundColorAttributeName:YSColor(80, 80, 80)}];
        NSAttributedString *subTitle = [[NSAttributedString alloc] initWithString:dict[@"subTitle"] attributes:@{NSFontAttributeName:FONT_BY_SCREEN(13), NSForegroundColorAttributeName:YSColor(180, 180, 180)}];
        NSMutableAttributedString *result = [[NSMutableAttributedString alloc] init];
        [result appendAttributedString:title];
        [result appendAttributedString:subTitle];
        NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.paragraphSpacing = 0;
        paragraphStyle.lineHeightMultiple = 1;
        [result addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, result.length)];
        [button setAttributedTitle:result forState:UIControlStateNormal];
        button.titleLabel.numberOfLines = 0;
    }
    
    return button;
}

- (void)setButtonLayout:(NSArray *)buttons maxWidth:(CGFloat)maxWidth {
    CGFloat minBtnWidth = MAXFLOAT;
    CGFloat maxBtnWidth = 0;
    for (NSInteger i = 0; i < buttons.count; i++) {
        UIButton * btn = buttons[i];
        CGSize size = [btn sizeThatFits:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        size.width += 10;
        if (minBtnWidth > size.width) {
            minBtnWidth = size.width;
        }
        if (maxBtnWidth < size.width) {
            maxBtnWidth = size.width;
        }
    }
    
    CGFloat firstGap = (maxWidth - minBtnWidth) / 2;
    if ((firstGap + maxBtnWidth) > maxWidth) {
        firstGap = (maxWidth - maxBtnWidth) / 2;
    }
    if (firstGap < 0) {
        NSLog(@"%@ buttons gap error.", [self class]);
        return;
    }
    
    for (NSInteger i = 0; i < buttons.count; i++) {
        UIButton * btn = buttons[i];
        [btn setLineAlignment:ButtonContentAlignmentHorizontal withFirstGap:firstGap secondGap:10];
    }
}


#pragma mark - get and set


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

#pragma mark - button click action
- (void)typeButtonClick:(UIButton *)sender {
    if (![NSObject isLogin]) {
        [self unReachable];
        return;
    }
    NSInteger index = sender.tag;
    switch (index) {
        case 0: {
            [MailInvoiceController pushMailInvoiceControllerByController:self];
            break;
        }
        case 1: {
            YSWebController *vc = [[YSWebController alloc] init];
            vc.urlStr = INVOICE_MAKEOUT_DELEGATE_URL;
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 2: {//发票开具
            [self taxerType:2];

            break;
        }
        case 3: {//发票设置
            [self taxerType:3];
            break;
        }
        case 4:{//我的发票
            YSWebController *vc = [[YSWebController alloc] init];
            vc.urlStr = MINE_INVOICE_URL;
            [self.navigationController pushViewController:vc animated:YES];
        }
        default:
            break;
    }
}
// 纳税人类型判断
-(void)taxerType:(int)type{
    NSDictionary *dict = @{@"taxpayer_code":TAXPAYER_CODE};
    [RequestBase requestWith:APITypeTaxInfo Param:@{@"jsonParam" : [dict JSONParamString]} Complete:^(YSResponseStatus status, id object) {
        if (status == 0) {
            @try {
                NSString *taxerType = object[@"content"][@"Jbxx"][0][@"nsrzglxmc"];
                if ([taxerType isEqualToString:@"小规模纳税人"]) {
                    if (type == 3) {
                        YSWebController *vc = [[YSWebController alloc] init];
                        vc.urlStr = INVOICE_MAKEOUT_SET_URL;
                        [self.navigationController pushViewController:vc animated:YES];
                    }else{
                        [self invoiceOpenKpr];
                    }

                }else{
                    YSAlertView *alertView = [YSAlertView alertWithTitle:@"该功能仅对小规模纳税人开放" message:nil buttonTitles:@"我知道了", nil];

                    [alertView show];
                }
                
            } @catch (NSException *exception) {
                NSLog(@"[EXCEPTION] %@ : %@", [self class], exception);
            }
        }
    } ShowOnView:self.view];
}



//开票人判断
-(void)invoiceOpenKpr{
    
    NSDictionary *base64Dic = [NSDictionary dictionaryWithObjectsAndKeys:[SecurityUtil encodeBase64String:TAXPAYER_CODE],@"taxpayer_code",nil];
    NSDictionary *urlDic = [NSDictionary dictionaryWithObject:[self dictionaryToJson:base64Dic] forKey:@"jsonParam"];
    [RequestBase requestWith:APITypeQueryInvoiceOpenKpr Param:urlDic Complete:^(YSResponseStatus status, id object) {
        if (status == YSResponseStatusSuccess) {
            id lastArray = object[@"content"][@"addresses"];
            if ([lastArray isKindOfClass:[NSNull class]]) {
                YSAlertView *alertView = [YSAlertView alertWithTitle:@"您尚未设置过开票人信息无法开票请在开票设置中录入开票人信息。" message:nil buttonTitles:@"我知道了", nil];
                [alertView alertButtonClick:^(NSInteger buttonIndex) {
                    YSWebController *vc = [[YSWebController alloc] init];
                    vc.urlStr = INVOICE_MAKEOUT_SET_URL;
                    [self.navigationController pushViewController:vc animated:YES];                }
                 ];
                [alertView show];
            }else {
                if([(NSArray *)lastArray count] > 0){
                    NSString *kprJsonString = [self dictionaryToJson:[lastArray lastObject]];
                    [[NSUserDefaults standardUserDefaults]setObject:kprJsonString forKey:@"kpr"];
                    YSWebController *vc = [[YSWebController alloc] init];
                    vc.urlStr = INVOICE_MAKEOUT_SELF_URL;

                    [self.navigationController pushViewController:vc animated:YES];
                    
                }else{
                    YSAlertView *alertView = [YSAlertView alertWithTitle:@"您尚未设置过开票人信息无法开票请在开票设置中录入开票人信息。" message:nil buttonTitles:@"我知道了", nil];
                    [alertView alertButtonClick:^(NSInteger buttonIndex) {
                        YSWebController *vc = [[YSWebController alloc] init];
                        vc.urlStr = INVOICE_MAKEOUT_SET_URL;
                        [self.navigationController pushViewController:vc animated:YES];                }
                     ];
                    [alertView show];
                }
            }

        }
    } ShowOnView:self.view AnimationOption:0];
    
}
-(NSString*)dictionaryToJson:(NSDictionary *)dic

{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}
@end
