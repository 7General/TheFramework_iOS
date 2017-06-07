//
//  UIButton+YSSolidColorButton.m
//  eTax
//
//  Created by ysyc_liu on 16/5/20.
//  Copyright © 2016年 ysyc. All rights reserved.
//

#import "UIButton+YSSolidColorButton.h"
#import "UIImage+SolidColor.h"

@implementation UIButton (YSSolidColorButton)

+ (instancetype)buttonWithColor:(UIColor *)color title:(NSString *)title {
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    UIImage * image = [UIImage imageWithColor:color size:CGSizeMake(44, 44)];
    UIImage * imageHL = [UIImage imageWithColor:[color colorWithAlphaComponent:0.5] size:CGSizeMake(44, 44)];
    UIImage * imageUnabel = [UIImage imageWithColor:[UIColor colorWithRed:0xdc/255.0 green:0xdc/255.0 blue:0xdc/255.0 alpha:1] size:CGSizeMake(44, 44)];
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button setBackgroundImage:imageHL forState:UIControlStateHighlighted];
    [button setBackgroundImage:imageUnabel forState:UIControlStateDisabled];
    button.layer.cornerRadius = 4;
    button.clipsToBounds = YES;
    
    return button;
}

@end
