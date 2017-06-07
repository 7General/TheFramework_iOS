//
//  PhoneAndSexCell.m
//  LongFor
//
//  Created by ZZG on 17/5/31.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "PhoneAndSexCell.h"
#import "ConfigUI.h"

@interface PhoneAndSexCell()
@property (nonatomic, weak) UILabel * phoneLabel;
@property (nonatomic, weak) UILabel * sexLabel;

@end

@implementation PhoneAndSexCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

-(void)initView {
    CGFloat padding = 20;
    
    CGFloat pX = padding;
    CGFloat pY = 0;
    CGFloat pW = 25;
    CGFloat pH = 44;
    
    UIButton * phoneImage = [[UIButton alloc] init];
    [phoneImage setImage:[UIImage imageNamed:@"phone"] forState:UIControlStateNormal];
    phoneImage.frame = CGRectMake(pX, pY, pW, pH);
    [self.contentView addSubview:phoneImage];
    
    CGFloat cX = CGRectGetMaxX(phoneImage.frame) + 15;
    CGFloat cY = 0;
    CGFloat cH = 44;
    CGFloat cW = 56;
    
    UILabel * phones = [[UILabel alloc] initWithFrame:CGRectMake(cX, cY, cW, cH)];
    phones.textColor = SColor(0, 0, 0);
    phones.text = @"手机号码";
    phones.font = FONTWITHSIZE_LIGHT(14);
    [self.contentView addSubview:phones];
    
    CGFloat sX = CGRectGetMaxX(phones.frame) + 26;
    CGFloat sY = 0;
    CGFloat sW = 100;
    CGFloat sH = 44;
    UILabel * showPhone = [[UILabel alloc] initWithFrame:CGRectMake(sX, sY, sW, sH)];
    showPhone.textColor = SColor(0, 0, 0);
    showPhone.text = @"15010206793";
    showPhone.font = FONTWITHSIZE_LIGHT(14);
    [self.contentView addSubview:showPhone];
    self.phoneLabel = showPhone;
    
    
    CGFloat callW = 25;
    CGFloat callX = SCREEN_WIDTH - callW - 15;
    CGFloat callY = 0;
    CGFloat callH = 44;
    UIButton * callBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    callBtn.frame = CGRectMake(callX, callY, callW, callH);
    [callBtn setImage:[UIImage imageNamed:@"phone_call"] forState:UIControlStateNormal];
    [callBtn addTarget:self action:@selector(callClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:callBtn];
    
    UIView * line = [[UIView alloc] initWithFrame:CGRectMake(0, 44,SCREEN_WIDTH , 1)];
    line.backgroundColor = SColor(235, 235, 235);
    [self.contentView addSubview:line];
    
    CGFloat gX = pX;
    CGFloat gY = 44;
    CGFloat gW = 25;
    CGFloat gH = 44;
    UIButton * genderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    genderBtn.frame = CGRectMake(gX, gY, gW, gH);
    [genderBtn setImage:[UIImage imageNamed:@"sex"] forState:UIControlStateNormal];
    [self.contentView addSubview:genderBtn];
    
    CGFloat xbX = cX;
    CGFloat xbY = 44;
    CGFloat xbW = cW;
    CGFloat xbH = 44;
    UILabel * xbl = [[UILabel alloc] initWithFrame:CGRectMake(xbX, xbY, xbW, xbH)];
    xbl.text = @"性别";
    xbl.textColor = SColor(0, 0, 0);
    xbl.font = FONTWITHSIZE_LIGHT(14);
    [self.contentView addSubview:xbl];
    
    CGFloat xbsX = sX;
    CGFloat xbsY = 44;
    CGFloat xbsW = sW;
    CGFloat xbsH = 44;
    UILabel * xbsl = [[UILabel alloc] initWithFrame:CGRectMake(xbsX, xbsY, xbsW, xbsH)];
    xbsl.text = @"男";
    xbsl.textColor = SColor(0, 0, 0);
    xbsl.font = FONTWITHSIZE_LIGHT(14);
    [self.contentView addSubview:xbsl];
    self.sexLabel = xbsl;
    
}

-(void)setcellGender:(NSString *)gend forTel:(NSString *)tel {
    self.sexLabel.text = gend;
    self.phoneLabel.text = tel;
}

-(void)callTel:(NSString *)tel {
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",tel];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.contentView addSubview:callWebview];
}

-(void)callClick {
    [self callTel:self.phoneLabel.text];
}

+(instancetype)phoneCellWithTableView:(UITableView *)tableView {
  static NSString * ID = @"phoneID";
    PhoneAndSexCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[PhoneAndSexCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;

}

@end
