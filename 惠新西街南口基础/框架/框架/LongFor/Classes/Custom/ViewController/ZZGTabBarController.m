//
//  ZZGTabBarController.m
//  AllBasic
//
//  Created by admin on 17/5/4.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "ConfigUI.h"
#import "ZZGTabBarController.h"

#import "ZZGTabBar.h"
#import "HAlertView.h"

/* import VC */
#import "CustomController.h"
#import "ApplicationController.h"
#import "AashboardController.h"
#import "MineViewController.h"

#import "LoginController.h"
#import "HNotificationManager.h"



@interface ZZGTabBarController ()<UITabBarControllerDelegate>

@end

@implementation ZZGTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self SetupView];
    self.delegate = self;
}


-(void)SetupView {
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:11];
    attrs[NSForegroundColorAttributeName] = SColor(73, 73, 73);
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
    selectedAttrs[NSForegroundColorAttributeName] = SColor(73, 73, 73);
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
    
    // 添加子控制器
    [self setupChildVc:[[CustomController alloc] init] title:@"客户" image:@"tabBar_custom_icon" selectedImage:@"tabBar_custom_click_icon"];
    
    [self setupChildVc:[[ApplicationController alloc] init] title:@"数+" image:@"tabBar_data_icon" selectedImage:@"tabBar_data_click_icon"];
    
    [self setupChildVc:[[AashboardController alloc] init] title:@"应用" image:@"tabBar_application_icon" selectedImage:@"tabBar_application_click_icon"];
    
    [self setupChildVc:[[MineViewController alloc] init] title:@"我的" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];
    
    [self setValue:[ZZGTabBar new] forKey:@"tabBar"];
    
    
    NSString * rolerType = [[NSUserDefaults standardUserDefaults] objectForKey:@"isHaveGroupRole"];
    if ([rolerType isEqualToString:@"1"]) {
        self.selectedIndex = 1;
    }
    
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    ZZGNavigationController * nav = (ZZGNavigationController *)viewController;
    UIViewController * VC = [nav.childViewControllers lastObject];
    if ([VC isKindOfClass:[AashboardController class]] || [VC isKindOfClass:[ApplicationController class]]) {
        if (IsStrEmpty(PRJID)) {
            HAlertView * alert = [[HAlertView alloc] initWithBasicTitle:@"提示" message:@"请选择项目" iconStr:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定"];
            [alert show];
            return NO;
        }else {
            return YES;
        }
    }else {
        return  YES;
    }
}


- (void)setupChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage {
    // 设置文字和图片
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    
    ZZGNavigationController *nav = [[ZZGNavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
}


@end
