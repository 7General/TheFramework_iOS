//
//  LoginViewController.m
//  NingboSat
//
//  Created by 田广 on 16/9/21.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "LoginViewController.h"
#import "Config.h"
#import <Masonry.h>
#import "PlaceholderAnimationTextField.h"
#import "UIButton+countdown.h"
#import "UIButton+FillColor.h"
#import "NSString+ruleCheck.h"
#import "RequestBase.h"
#import "YSAlertView.h"
#import "UIButton+YSSolidColorButton.h"
#import "UIImage+SolidColor.h"

#import "NSObject+UserInfoState.h"
#import "YSProgressHUD.h"

@interface LoginViewController ()

@property (nonatomic,strong)UIScrollView *bgScrollView;
@property (nonatomic,strong)UIButton *verifyButton;
@property (nonatomic,strong)UIView *inputView;
@property (nonatomic,strong)UIButton *loginButton;

@end

@implementation LoginViewController

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    
}
-(void)initData{
    {
        PlaceholderAnimationTextField *textField = [_inputView viewWithTag:(0+100)];
        textField.text = [NSObject getTaxNumber];
    }
    {
        UITextField *textField = [_inputView viewWithTag:(2+100)];
        textField.text = [NSObject getMobile];
    }

//    NSArray *array = @[@"330282761467035", @"GT3-Nbgs", @"13567434056", @"945665"];
//    for (NSInteger i = 0; i < 3; i++) {
//        UITextField *textField = [_inputView viewWithTag:(i+100)];
//        textField.text = array[i];
//    }
}

-(void)initView{
    self.view.backgroundColor = [UIColor whiteColor];
    self.bgScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.bgScrollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_bgScrollView];
    
    self.bgScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 600);

    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0,-20, SCREEN_WIDTH, 240 + 20)];
    bgView.backgroundColor = [UIColor clearColor];
    [_bgScrollView addSubview:bgView];

    //添加渐变
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = bgView.frame;
    gradient.colors = [NSArray arrayWithObjects:(id)YSColor(0, 155, 255).CGColor,(id)YSColor(9, 209, 255).CGColor,nil];
    gradient.locations = @[@0.0, @0.6];
    [bgView.layer insertSublayer:gradient atIndex:0];
    
    UIButton *backWhiteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backWhiteButton.frame = CGRectMake(0, 40, 60, 44);
    [backWhiteButton setImage:[UIImage imageNamed:@"backWhite"] forState:UIControlStateNormal];
    [backWhiteButton addTarget:self action:@selector(backWhiteButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    backWhiteButton.adjustsImageWhenHighlighted = NO;
    CGFloat diff =  (CGRectGetWidth(backWhiteButton.bounds) - backWhiteButton.currentImage.size.width) / 2 - 10; // 设置图标离左边距10.
    [backWhiteButton setImageEdgeInsets:UIEdgeInsetsMake(0,-diff, 0, diff)];
    [bgView addSubview:backWhiteButton];
    
    UIImageView *headView = [[UIImageView alloc]init];
    [bgView addSubview:headView];
    headView.backgroundColor = [UIColor whiteColor];
    headView.image = [UIImage imageNamed:@"headIocon"];
    headView.layer.cornerRadius = 47;
    headView.layer.masksToBounds = YES;
    
    UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [titleButton setTitle:@"宁波国税·纳税人登录" forState:UIControlStateNormal];
    [titleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    titleButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [bgView addSubview:titleButton];
    
    self.inputView = [[UIView alloc]init];
    _inputView.backgroundColor = [UIColor clearColor];
    [_bgScrollView addSubview:_inputView];
    
    NSArray *contentArray = [NSArray arrayWithObjects:@"纳税人识别号",@"密码",@"备案手机号",@"手机动态码", nil];
    
    CGFloat inputHeight = 55;
    
    for (int i=0 ; i < contentArray.count; i++) {
        PlaceholderAnimationTextField *placeholderTextField = [[PlaceholderAnimationTextField alloc]initWithFrame:CGRectMake(40,i*inputHeight,SCREEN_WIDTH - 80,inputHeight)];
        placeholderTextField.placeholder = contentArray[i];
        placeholderTextField.tag = i+100;
        [placeholderTextField addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventEditingChanged];
//        placeholderTextField.clearButtonMode = UITextFieldViewModeAlways;
        [_inputView addSubview:placeholderTextField];
        UIImageView* closeImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"closeGrayButton"]];
        closeImageView.frame = CGRectMake(10, 0,14,14);
        
        placeholderTextField.rightView = closeImageView;
        placeholderTextField.rightViewMode = UITextFieldViewModeWhileEditing;
        closeImageView.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *closeImageViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(xImageViewClick:)];
        [closeImageView addGestureRecognizer:closeImageViewTap];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(40, i*inputHeight + inputHeight - 0.5, SCREEN_WIDTH - 80, 0.5)];
        line.backgroundColor = YSColor(230, 230, 230);
        [_inputView addSubview:line];

        switch (i) {
            case 0:
                placeholderTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
                break;
            case 1:
                placeholderTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
                placeholderTextField.secureTextEntry = YES;
                
                break;
            case 2:
                placeholderTextField.keyboardType = UIKeyboardTypeNumberPad;
                break;
            case 3:{
                placeholderTextField.keyboardType = UIKeyboardTypeNumberPad;
                placeholderTextField.frame = CGRectMake(40,i*inputHeight,SCREEN_WIDTH - 80 - 100,inputHeight);
                line.frame = CGRectMake(40, i*inputHeight + inputHeight - 0.5, SCREEN_WIDTH - 80 - 100, 0.5);
                
                //添加获取验证码
                self.verifyButton = [UIButton buttonWithType:UIButtonTypeCustom];
                _verifyButton.frame = CGRectMake(SCREEN_WIDTH -40 - 100 + 10, i*inputHeight + inputHeight - 35, 90, 35);
                [_verifyButton setTitle:@"获取动态码" forState:UIControlStateNormal];
                _verifyButton.titleLabel.font = [UIFont systemFontOfSize:15];
                [_verifyButton setBackgroundColor:YSColor(75, 196, 251)forState:UIControlStateNormal];
                [_verifyButton setBackgroundColor:YSColor(242, 242, 242)forState:UIControlStateSelected];
                [_verifyButton setTitleColor:YSColor(180, 180, 180) forState:UIControlStateSelected];

                _verifyButton.layer.cornerRadius = 2;
                [_verifyButton addTarget:self action:@selector(verifyButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
                
                [_inputView addSubview:_verifyButton];
                
            }
                break;
                
            default:
                break;
        }
        
    }
    //添加获取验证码
    UIButton *loginButton = [UIButton buttonWithColor:YSColor(0x4b, 0xc4, 0xfb) title:@"登录"];
    [loginButton setBackgroundImage:[UIImage imageWithColor:YSColor(255, 255, 255) size:CGSizeMake(10, 10)] forState:UIControlStateDisabled];
    loginButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [loginButton setTitleColor:YSColor(180, 180, 180) forState:UIControlStateDisabled];
    loginButton.layer.cornerRadius = 5;
    loginButton.layer.borderWidth = 0.5;
    loginButton.layer.borderColor = YSColor(180, 180, 180).CGColor;
    [loginButton addTarget:self action:@selector(loginButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_bgScrollView addSubview:loginButton];
    loginButton.enabled = NO;
    self.loginButton = loginButton;
    
    UILabel *alertLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 40, SCREEN_WIDTH, 30)];
    alertLabel.text = @"请使用您在宁波国税网上办税大厅的账号密码登录";
    alertLabel.font = FONT_BY_SCREEN(13);
    alertLabel.textColor = YSColor(180, 180, 180);
    alertLabel.textAlignment = NSTextAlignmentCenter;
    [_bgScrollView addSubview:alertLabel];

    //激活
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:@"无密码？获取初始密码"];
    [attributeString addAttribute:NSForegroundColorAttributeName value:YSColor(180, 180, 180) range:NSMakeRange(0, 4)];
    [attributeString addAttribute:NSForegroundColorAttributeName value:YSColor(0x4b, 0xc4, 0xfb) range:NSMakeRange(4,6)];

    UIButton *activateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [activateButton setAttributedTitle:attributeString forState:UIControlStateNormal];
    activateButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [activateButton addTarget:self action:@selector(activateButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_bgScrollView addSubview:activateButton];
    
    [headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(12 + 60);
        make.centerX.equalTo(bgView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(94, 94));
    }];
    
    [titleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headView.mas_bottom).mas_offset(3);
        make.centerX.equalTo(bgView.mas_centerX);
        
    }];
    [_inputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView.mas_bottom).mas_offset(-20);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(SCREEN_WIDTH);

        make.height.mas_equalTo(inputHeight * 4);
    }];
    [loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_inputView.mas_bottom).mas_offset(25);
        make.leading.mas_equalTo(_inputView).mas_offset(40);
        make.trailing.mas_equalTo(_inputView).mas_offset(-40);

        make.height.mas_equalTo(40);
    }];
    [activateButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(loginButton.mas_bottom).mas_offset(2);
        make.leading.mas_equalTo(_inputView).mas_offset(40);
        make.trailing.mas_equalTo(_inputView).mas_offset(-40);
        make.height.mas_equalTo(30);

    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self initView];
    [self initData];
    
}

#pragma mark - 点击事件

-(void)backWhiteButtonClicked{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
-(void)activateButtonClicked:(UIButton *)sender{
    [self activateUserAccount];
}

-(void)verifyButtonClicked:(UIButton *)sender{
    UITextField *textField = [_inputView viewWithTag:(2+100)];
    if (textField.text.length < 1) {
        [[YSAlertView alertWithTitle:nil message:@"请输入备案手机号" buttonTitles:@"确定", nil] show];
        return;
    }
    if ([textField.text ruleCheckMobile]) {
        NSDictionary *paramDict = @{@"mobileNo":textField.text};//@{@"jsonParam":[paramDict JSONParamString]}
        [RequestBase requestWith:APITypeSecurityCode Param:@{@"jsonParam":[paramDict JSONParamString]} Complete:^(YSResponseStatus status, id object) {
            if (status == 0) {
                [sender countdownWithNumber:[NSNumber numberWithInt:99]];
            }
        } ShowOnView:self.view];
    }
}


-(void)loginButtonClicked:(UIButton *)sender{
    NSArray *msgArray = @[@"请输入纳税人识别号", @"请输入密码", @"请输入备案手机号", @"请输入验证码"];
    NSArray *keyArray = @[@"account_number", @"password", @"mobileNo", @"virification_code"];
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionary];
    for (NSInteger i = 0; i < 4; i++) {
        UITextField *textField = [_inputView viewWithTag:(i+100)];
        if (textField.text.length < 1) {
            [[YSAlertView alertWithTitle:nil message:msgArray[i] buttonTitles:@"确定", nil] show];
            return;
        }
        
        [paramDict setObject:textField.text forKey:keyArray[i]];
    }
    [paramDict setObject:@"5" forKey:@"flag"];
    [paramDict setObject:@"" forKey:@"device_token"];
    //
    [paramDict setObject:@"" forKey:@"user_name"];
    [paramDict setObject:@"1" forKey:@"sex"];
    [paramDict setObject:@"1" forKey:@"client_type"];
    [paramDict setObject:@"330200" forKey:@"area_code"];
    [paramDict setObject:@"0" forKey:@"serialVersionUID"];
    
    [RequestBase requestWith:APITypeUserLogin Param:paramDict Complete:^(YSResponseStatus status, id object) {
        if (status == 0) {
            if ([[self class] addUserInfo:object]) {
                [self dismissViewControllerAnimated:YES completion:^{
                    
                }];
            }
        }
    } ShowOnView:self.view];
    
    
}


- (void)xImageViewClick:(UITapGestureRecognizer *) tap
{
    UIView *view = [tap view];

    NSLog(@"%@",view.superview);
    if ([view.superview isKindOfClass:[UITextField class]]) {
        UITextField *text = (UITextField *)view.superview;
        text.text = @"";
        self.loginButton.enabled = NO;
        self.loginButton.layer.borderWidth = 0.5;
    }
}

///用户账号激活
-(void)activateUserAccount{
    UITextField *textField = [_inputView viewWithTag:(0+100)];

    if (textField.text.length == 0) {
        [YSProgressHUD showShockHUDOnView:self.view Message:@"请输入纳税人识别号"];
        return;
    }
    
    NSDictionary * param = @{@"jsonParam":[@{@"taxpayer_code":textField.text}JSONParamString]};

    [RequestBase requestWith:APITypeUserActivate Param:param Complete:^(YSResponseStatus status, id object) {
        if (status == 0) {
            YSAlertView *alertView = [YSAlertView alertWithMessage:object[@"message"] sureButtonTitle:@"确定"];
            [alertView show];
        }
        
    } ShowOnView:self.view];
}

#pragma mark - 输入值变化
- (void)valueChange:(UITextField *)sender {
    
    for (NSInteger i = 0; i < 4; i++) {
        UITextField *textField = [_inputView viewWithTag:(i+100)];
        if (textField.text.length < 1) {
            self.loginButton.enabled = NO;
            self.loginButton.layer.borderWidth = 0.5;
            return;
        }
    }
    self.loginButton.enabled = YES;
    self.loginButton.layer.borderWidth = 0;
    
}
@end
