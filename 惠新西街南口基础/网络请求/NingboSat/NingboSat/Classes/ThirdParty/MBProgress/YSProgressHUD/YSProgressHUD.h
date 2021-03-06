//
//  YSProgressHUD.h
//  eTax
//
//  Created by ysyc_liu on 16/4/8.
//  Copyright © 2016年 ysyc. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface YSProgressHUD : NSObject

@property (nonatomic, strong)id progressHUD;

+ (instancetype)showHUDOnView:(UIView *)view;

+ (void)showSuccessHUDOnView:(UIView *)view Message:(NSString *)message;
+ (void)showSuccessWithIconOnView:(UIView *)view Message:(NSString *)message;
+ (void)showErrorHUDOnView:(UIView *)view Message:(NSString *)message;

+ (void)showShockHUDOnView:(UIView *)view Message:(NSString *)message;

+ (MBProgressHUD *)showOnView:(UIView *)view Message:(NSString *)message;

+ (void)showErrorHUDOnView:(UIView *)view Message:(NSString *)message offsetScal:(CGFloat)scal;

- (void)show:(BOOL)animated;

- (void)hide:(BOOL)animated;

@end
