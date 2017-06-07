//
//  MineHeadView.m
//  NingboSat
//
//  Created by 田广 on 16/9/20.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "MineHeadView.h"
#import "Config.h"
#import <Masonry.h>
#import "NSObject+UserInfoState.h"
#import "YSNotificationManager.h"

@interface MineHeadView ()

@property (nonatomic, strong)UIImageView *headView;
@property (nonatomic, strong)UIButton *loginButton;

@end

@implementation MineHeadView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
        [YSNotificationManager addUserLogoutObserver:self selector:@selector(notificationRefresh)];
        [YSNotificationManager addUserLoginObserver:self selector:@selector(notificationRefresh)];

    }
    
    return self;
}
-(void)notificationRefresh{
    if ([[self class] isLogin]) {
        [self.loginButton setTitle:[[self class] getTaxName] forState:UIControlStateNormal];
        
    }else{
        [self.loginButton setTitle:@"点击登录" forState:UIControlStateNormal];
        
    }
}
-(void)initView{
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0,-20, SCREEN_WIDTH, self.bounds.size.height + 20)];
    bgView.backgroundColor = [UIColor clearColor];
    [self addSubview:bgView];
    
    //添加渐变
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = bgView.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)YSColor(0, 155, 255).CGColor,(id)YSColor(9, 209, 255).CGColor,nil];
    gradient.locations = @[@0.0, @0.6];
    [bgView.layer insertSublayer:gradient atIndex:0];
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"个人中心";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [bgView addSubview:titleLabel];
    
    UIImageView *headView = [[UIImageView alloc]init];
    [bgView addSubview:headView];
    headView.backgroundColor = [UIColor whiteColor];
    headView.image = [UIImage imageNamed:@"headIocon"];
    headView.layer.cornerRadius = 47;
    headView.layer.masksToBounds = YES;
    self.headView = headView;

    self.loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    if ([[self class] isLogin]) {
        [_loginButton setTitle:[[self class] getTaxName] forState:UIControlStateNormal];

    }else{
        [_loginButton setTitle:@"点击登录" forState:UIControlStateNormal];

    }
    [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _loginButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [_loginButton addTarget:self action:@selector(loginButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:_loginButton];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(12 + 20);

        make.centerX.equalTo(bgView.mas_centerX);
        
    }];
    
    [headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).mas_offset(30);
        make.centerX.equalTo(bgView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(94, 94));
    }];
    
    [_loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headView.mas_bottom).mas_offset(3);
        make.centerX.equalTo(bgView.mas_centerX);

    }];

}

#pragma mark - 点击事件

-(void)loginButtonClicked:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(loginButtonClicked:)]) {
        [self.delegate loginButtonClicked:sender];
    }
}

@end
