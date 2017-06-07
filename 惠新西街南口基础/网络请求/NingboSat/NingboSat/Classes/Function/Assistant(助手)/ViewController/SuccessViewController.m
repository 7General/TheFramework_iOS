//
//  SuccessViewController.m
//  NingboSat
//
//  Created by 王会洲 on 16/11/24.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "SuccessViewController.h"
#import "Config.h"
#import "Masonry.h"
#import "NSString+AttributeOrSize.h"
#import "GetWeakDay.h"
#import "NSObject+UserInfoState.h"

@interface SuccessViewController ()

@end

@implementation SuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}


-(void)initView {
    self.view.backgroundColor = YSColor(245, 245, 245);
    self.title  = @"预约成功";
    UIView * navView = [[UIView alloc] init];
    navView.layer.masksToBounds = YES;
    navView.layer.cornerRadius = 5;
    navView.backgroundColor = YSColor(221, 221, 221);
    [self.view addSubview:navView];
    [navView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(6);
        make.right.equalTo(self.view.mas_right).with.offset(-6);
        make.top.equalTo(self.view.mas_top).with.offset(10 * KHeightScale);
        make.height.mas_equalTo(10);
    }];
    
    UIImageView * backImageView = [[UIImageView alloc] init];
    backImageView.image = [UIImage imageNamed:@"suc_cont_normal"];
    [self.view addSubview:backImageView];
    [backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(13);
        make.right.equalTo(self.view.mas_right).with.offset(-13);
        make.top.equalTo(navView.mas_centerY);
        CGFloat paddB = SCREEN_WIDTH == 320 ? 50 : 75;
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-paddB  * KHeightScale);
    }];
    
    /**纳税人名称*/
    UILabel * taxerName = [[UILabel alloc] init];
    taxerName.textAlignment = NSTextAlignmentCenter;
    taxerName.textColor = YSColor(80, 80, 80);
    taxerName.font = FONTMedium(17);
    taxerName.text = [NSObject getTaxName]; //@"宁海百丰磨具加工厂";// 
    [backImageView addSubview:taxerName];
    [taxerName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(backImageView.mas_centerX);
        make.top.equalTo(backImageView.mas_top).with.offset(15 * KHeightScale);
        make.left.equalTo(backImageView.mas_left);
        make.right.equalTo(backImageView.mas_right);
    }];
    
    
    /**纳税人名称*/
    UILabel * bookTime = [[UILabel alloc] init];
    bookTime.backgroundColor = YSColor(242, 242, 242);
    bookTime.layer.cornerRadius =2;
    bookTime.layer.masksToBounds = YES;
    bookTime.textAlignment = NSTextAlignmentCenter;
    bookTime.textColor = YSColor(80, 80, 80);
    bookTime.font =  FONT_BY_SCREEN(13);//FONTLIGHT(13);
    
    GetWeakDay * weak = [[GetWeakDay alloc] init];
    NSString * weStr = [weak calculateWeek:self.bookTime];
    NSString * times = [NSString stringWithFormat:@"%@-%@",self.bookTimeModel.yysj_q,self.bookTimeModel.yysj_z];
    NSString * timeText = [NSString stringWithFormat:@"预约时间：%@ %@ %@",self.bookTime,weStr,times];
    bookTime.text = timeText; //@"预约时间：2016-10-28 星期五 08:00-09:00"; //
    [backImageView addSubview:bookTime];
    [bookTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(backImageView.mas_centerX);
        make.top.equalTo(taxerName.mas_bottom).with.offset(13 * KHeightScale);
        CGFloat padding = SCREEN_WIDTH == 320 ? 20.0 : 38.0;
        make.left.equalTo(backImageView.mas_left).with.offset(padding * KWidthScale);
        make.right.equalTo(backImageView.mas_right).with.offset(-padding * KWidthScale);
    }];
    
    UIImageView * logoSuc = [[UIImageView alloc] init];
    logoSuc.image = [UIImage imageNamed:@"suc_logo_normal"];
    [backImageView addSubview:logoSuc];
    [logoSuc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(backImageView.mas_centerX);
        make.top.equalTo(bookTime.mas_bottom).with.offset(20 * KHeightScale);
        make.size.mas_equalTo(logoSuc.image.size);
    }];
    
    
    
    UIImageView * nuImageView = [[UIImageView alloc] init];
    nuImageView.image = [UIImage imageNamed:@"suc_msg_normal"];
    [backImageView addSubview:nuImageView];
    [nuImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(backImageView.mas_centerX);
        make.top.equalTo(logoSuc.mas_bottom).with.offset(20 * KHeightScale);
        make.left.equalTo(backImageView.mas_left).with.offset(40);
        make.right.equalTo(backImageView.mas_right).with.offset(-40);
        make.height.mas_equalTo(50 * KHeightScale);
    }];
    
    /**富文本*/
    UILabel * fixLabel  = [[UILabel alloc] init];
    fixLabel.font = FONTLIGHT(15);
    self.bookNumber = IsStrEmpty(self.bookNumber) ? @"" : self.bookNumber;
    NSString * resStr = [NSString stringWithFormat:@"您的预约码为:%@",self.bookNumber];
    /**富文本编辑*/
    NSDictionary * normalAttr = @{NSForegroundColorAttributeName:YSColor(80, 80, 80) ,NSFontAttributeName:FONT_BY_SCREEN(16)};
    NSDictionary * selectAttr = @{NSForegroundColorAttributeName:YSColor(255, 126, 0) ,NSFontAttributeName:FONT_BY_SCREEN(19)};
    
    fixLabel.attributedText = [resStr stringWithParagraphlineSpeace:0 NormalAttributeFC:normalAttr withKeyTextColor:@[self.bookNumber] KeyAttributeFC:selectAttr];
    
    [nuImageView addSubview:fixLabel];
    [fixLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nuImageView.mas_top).with.offset(14);
        make.bottom.equalTo(nuImageView.mas_bottom).with.offset(-14);
        if (SCREEN_WIDTH == 320) {
            make.left.equalTo(nuImageView.mas_left).with.offset(20);
            make.right.equalTo(nuImageView.mas_right).with.offset(-10);
        }else {
            make.left.equalTo(nuImageView.mas_left).with.offset(40);
            make.right.equalTo(nuImageView.mas_right).with.offset(-36);
        }
    }];
    
    UILabel * acctionLabel  = [[UILabel alloc] init];
    acctionLabel.textAlignment = NSTextAlignmentCenter;
    acctionLabel.numberOfLines = 0;
    acctionLabel.font = FONT_BY_SCREEN(13);
    acctionLabel.textColor = YSColor(80, 80, 80);
    acctionLabel.text = [NSString stringWithFormat:@"*请您于预约时间到%@办理",self.bookAddress];
    [backImageView addSubview:acctionLabel];
    [acctionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nuImageView.mas_bottom).with.offset(7);
        make.left.equalTo(nuImageView.mas_left).with.offset(0);
        make.right.equalTo(nuImageView.mas_right).with.offset(0);
    }];
    
    UILabel * maxAction = [[UILabel alloc] init];
    maxAction.textColor = YSColor(80, 80, 80);
    maxAction.font = FONTMedium(16);
    maxAction.text = @"重要提醒";
    [backImageView addSubview:maxAction];
    [maxAction mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(backImageView.mas_centerX);
        CGFloat padT = SCREEN_WIDTH == 320 ? 20 : 30;
        make.top.equalTo(acctionLabel.mas_bottom).with.offset(padT * KHeightScale);
        make.size.mas_equalTo(CGSizeMake(68, 17));
    }];
    
    UIView * leftLine = [[UIView alloc] init];
    leftLine.backgroundColor = YSColor(221, 221, 221);
    [backImageView addSubview:leftLine];
    [leftLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(maxAction.mas_centerY);
        make.left.equalTo(backImageView.mas_left).with.offset(22);
        make.right.equalTo(maxAction.mas_left).with.offset(-29);
        make.height.mas_equalTo(0.5);
    }];
    UIView * rightLine = [[UIView alloc] init];
    rightLine.backgroundColor = YSColor(221, 221, 221);
    [backImageView addSubview:rightLine];
    [rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(maxAction.mas_centerY);
        make.left.equalTo(maxAction.mas_right).with.offset(29);
        make.right.equalTo(backImageView.mas_right).with.offset(-22);
        make.height.mas_equalTo(0.5);
    }];
    
    
    UILabel * msgAction = [[UILabel alloc] init];
    msgAction.numberOfLines = 0;
    msgAction.textColor = YSColor(136, 136, 136);
    msgAction.font = FONT_BY_SCREEN(15);
    msgAction.text = @"1、如您未按时到达办理，将会记为违约，您将3个月内无法在手机进行办税预约。\n2、如需取消，请您于预约办理时间前一天24点前取消。";
    [backImageView addSubview:msgAction];
    [msgAction mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backImageView.mas_left).with.offset(22);
        make.right.equalTo(backImageView.mas_right).with.offset(-22);
        make.top.equalTo(maxAction.mas_bottom).with.offset(12 * KHeightScale);
    }];

}

@end
