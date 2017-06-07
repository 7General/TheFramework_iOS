//
//  YSProgressHUD.m
//  eTax
//
//  Created by ysyc_liu on 16/4/8.
//  Copyright © 2016年 ysyc. All rights reserved.
//

#import "YSProgressHUD.h"

@implementation YSProgressHUD

NSTimeInterval timeInterval = 1.0;

+ (instancetype)showHUDOnView:(UIView *)view {
    YSProgressHUD * ysHud = [[self alloc] init];
    ysHud.progressHUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
    MBProgressHUD *hud = ysHud.progressHUD;
    hud.mode = MBProgressHUDETax;
    hud.dimBackground = NO;
    hud.color = [[UIColor whiteColor] colorWithAlphaComponent:0.9];
    [hud show:YES];
    ysHud.progressHUD = hud;
    return ysHud;
}

+ (void)showSuccessHUDOnView:(UIView *)view Message:(NSString *)message {
    MBProgressHUD * hud = [[MBProgressHUD alloc] initWithView:view];
    hud.removeFromSuperViewOnHide = YES;
    [view addSubview:hud];
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabelText = message;
    hud.color = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    [hud show:YES];
    [hud hide:YES afterDelay:timeInterval];
}
+ (void)showSuccessWithIconOnView:(UIView *)view Message:(NSString *)message {
    MBProgressHUD * hud = [[MBProgressHUD alloc] initWithView:view];
    hud.removeFromSuperViewOnHide = YES;
    [view addSubview:hud];
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ResponSuccessIcon"]];

    hud.detailsLabelText = message;
    hud.color = [[UIColor blackColor] colorWithAlphaComponent:1];
    [hud show:YES];
    [hud hide:YES afterDelay:timeInterval];
}
+ (MBProgressHUD *)showOnView:(UIView *)view Message:(NSString *)message {
    MBProgressHUD * hub = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hub.labelText = message;
    return hub;
}

+ (void)dismis:(UIView *)view {
    [MBProgressHUD hideHUDForView:view animated:YES];
}

+ (void)showErrorHUDOnView:(UIView *)view Message:(NSString *)message {
    MBProgressHUD * hud = [[MBProgressHUD alloc] initWithView:view];
    hud.removeFromSuperViewOnHide = YES;
    [view addSubview:hud];
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabelText = message;
    hud.color = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    [hud show:YES];
    [hud hide:YES afterDelay:timeInterval * 2];
}

+ (void)showShockHUDOnView:(UIView *)view Message:(NSString *)message {
    MBProgressHUD * hud = [[MBProgressHUD alloc] initWithView:view];
    hud.removeFromSuperViewOnHide = YES;
    [view addSubview:hud];
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabelText = message;
    hud.color = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    [hud show:YES];
    [hud hide:YES afterDelay:timeInterval];
}


+ (void)showErrorHUDOnView:(UIView *)view Message:(NSString *)message offsetScal:(CGFloat)scal {
    MBProgressHUD * hud = [[MBProgressHUD alloc] initWithView:view];
    hud.removeFromSuperViewOnHide = YES;
    [view addSubview:hud];
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabelText = message;
    [hud show:YES];
    [hud hide:YES afterDelay:timeInterval * 2];
}

- (void)show:(BOOL)animated {
    [self.progressHUD show:animated];
}

- (void)hide:(BOOL)animated {
    [self.progressHUD hide:animated];
}

@end
