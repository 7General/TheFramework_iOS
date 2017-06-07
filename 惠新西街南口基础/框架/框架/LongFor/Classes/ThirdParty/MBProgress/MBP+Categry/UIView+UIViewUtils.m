//
//  UIView+UIViewUtils.m
//  HZProgress
//
//  Created by 王会洲 on 16/4/8.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "UIView+UIViewUtils.h"

@implementation UIView (UIViewUtils)

@dynamic HUDCase;

#pragma mark hud
/**显示错误信息带角标提示 */
-(void)showHUDIndicatorViewErrorAtCenter:(NSString *)error {
    [self showHUDIndicatorViewAtCenter:error icon:@"error.png" MBPCase:HUDCaseSucErr];
    [self hide:YES afterDelay:1.0];
}

/**显示正确提示带角标提示*/
-(void)showHUDIndicatorViewSuccessAtCenter:(NSString *)success {
    [self showHUDIndicatorViewAtCenter:success icon:@"success.png" MBPCase:HUDCaseSucErr];
    [self hide:YES afterDelay:1.0];
}

-(void)showHUDIndicatorLabelAtCenter:(NSString *)indiTitle {
    [self showHUDIndicatorViewAtCenter:indiTitle icon:nil MBPCase:HUDCaseLabel];
    [self hide:YES afterDelay:1.0];
}

-(void)showHUDIndicatorAtCenter:(NSString *)indiTitle {
    [self showHUDIndicatorViewAtCenter:indiTitle icon:nil MBPCase:HUDCaseIndeterminate];
}


/**延迟加载控制*/
- (void)hide:(BOOL)animated afterDelay:(NSTimeInterval)delay {
    [self performSelector:@selector(hideDelayed:) withObject:[NSNumber numberWithBool:animated] afterDelay:delay];
}
- (void)hideDelayed:(NSNumber *)animated {
    [self hideHUDIndicatorViewAtCenter];
}


/**
 *  显示标题信息带图片(Base)
 *
 *  @param indiTitle 标题
 *  @param iconStr   提示图片
 */
- (void)showHUDIndicatorViewAtCenter:(NSString *)indiTitle icon:(NSString *)iconStr MBPCase:(HUDCaseEnum)caseEnum
{
    MBProgressHUD *hud = [self getHUDIndicatorViewAtCenter];
    if (hud == nil){
        hud = [self createHUDIndicatorViewAtCenter:indiTitle icon:iconStr yOffset:0 MPBCase:caseEnum];
        [hud show:YES];
    }else{
#warning mark-ZZG 此处要做修改！！！！！
        hud.mode = MBProgressHUDModeText;
        hud.dimBackground = NO;
        hud.color = nil;
        hud.labelColor = [UIColor whiteColor];
        hud.labelText = indiTitle;
    }
}





// **********************************************************************************
/**
 *  默认样式显示提示信息标题
 */
- (void)showHUDIndicatorViewAtCenter:(NSString *)indiTitle {
    MBProgressHUD *hud = [self getHUDIndicatorViewAtCenter];
    if (hud == nil){
        hud = [self createHUDIndicatorViewAtCenter:indiTitle icon:nil yOffset:0 MPBCase:HUDCaseDefault];
        [hud show:YES];
    }else{
        hud.labelText = indiTitle;
    }
}

/// e税客所用等待提示
- (void)showHUDIndicatorViewETaxAtCenter {
    MBProgressHUD *hud = [self getHUDIndicatorViewAtCenter];
    if (hud == nil){
        hud = [self createHUDIndicatorViewAtCenter:nil icon:nil yOffset:0 MPBCase:HUDCaseETax];
        [hud show:YES];
    }else{
        hud.labelText = nil;
    }
}

/**默认样式显示提示信息标题，和中间点的偏移*/
- (void)showHUDIndicatorViewAtCenter:(NSString *)indiTitle yOffset:(CGFloat)y
{
    MBProgressHUD *hud = [self getHUDIndicatorViewAtCenter];
    if (hud == nil){
        hud = [self createHUDIndicatorViewAtCenter:indiTitle icon:nil yOffset:y MPBCase:HUDCaseLabel];
        [hud show:YES];
    }else{
        hud.labelText = indiTitle;
    }
}

/**隐藏弹层*/
- (void)hideHUDIndicatorViewAtCenter
{
    MBProgressHUD *hud = [self getHUDIndicatorViewAtCenter];
    
    [hud hide:YES];
}


/**
 *  改类的基类，用于CreateHUD
 */
- (MBProgressHUD *)createHUDIndicatorViewAtCenter:(NSString *)indiTitle
                                                                                          icon:(NSString *)icon
                                                                                     yOffset:(CGFloat)y
                                                                                MPBCase:(HUDCaseEnum)caseEnum {
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self];
    hud.layer.zPosition = 10;
    hud.yOffset = y;
    hud.removeFromSuperViewOnHide = YES;
    hud.labelText = indiTitle;
    
    /**如果有图片名称*/
    if (icon) {
        hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]]];
    }
    switch (caseEnum) {
        case HUDCaseDefault:
        {
            // 默认
            hud.mode = MBProgressHUD25X;
            hud.dimBackground = NO;
            hud.color = nil;
            hud.labelColor = [UIColor whiteColor];
        }
            break;
        case HUDCaseSucErr:
        {
            hud.mode = MBProgressHUDModeCustomView;
            hud.dimBackground = NO;
            hud.color = nil;
            hud.labelColor = [UIColor whiteColor];
        }
            break;
        case HUDCaseLabel:
        {
            hud.mode = MBProgressHUDModeText;
            hud.dimBackground = NO;
            hud.color = nil;
            hud.labelColor = [UIColor whiteColor];
        }
            break;
        case HUDCaseIndeterminate:
        {
            hud.mode = MBProgressHUDModeIndeterminate;
            hud.dimBackground = YES;
            hud.color = [UIColor whiteColor];
            hud.labelColor = [UIColor blackColor];
        }
            break;
        case HUDCaseETax:
        {
            hud.mode = MBProgressHUDETax;
            hud.dimBackground = NO;
            hud.color = [UIColor whiteColor];
            hud.labelColor = [UIColor blackColor];
        }
            break;
        default:
            break;
    }
    
    [self addSubview:hud];
    hud.tag = hudViewTag;
    return hud;
}


/**获取HUD对象*/
- (MBProgressHUD *)getHUDIndicatorViewAtCenter {
    UIView *view = [self viewWithTagNotDeepCounting:hudViewTag];
    if (view != nil && [view isKindOfClass:[MBProgressHUD class]]){
        return (MBProgressHUD *)view;
    }
    else
    {
        return nil;
    }
}

- (UIView *)viewWithTagNotDeepCounting:(NSInteger)tag {
    for (UIView *view in self.subviews)
    {
        if (view.tag == tag) {
            return view;
            break;
        }
    }
    return nil;
}
@end
