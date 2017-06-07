//
//  AppDelegate.m
//  LongFor
//
//  Created by admin on 17/5/9.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "AppDelegate.h"
#import "ZZGTabBarController.h"
#import "ConfigUI.h"
#import "LoginController.h"

#import "MoreData.h"






@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self chekLogin];
//    [self umengTrack];
//    [self createTable];
//    [self IQKeyboardInit];
//    [self configBMKMap];
    [self.window makeKeyAndVisible];
    return YES;
}

#pragma mark - 键盘高度适配处理初始化.
//- (void)IQKeyboardInit {
//    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
//    manager.enable =YES;
//    manager.shouldResignOnTouchOutside =YES;
//    manager.shouldToolbarUsesTextFieldTintColor =YES;
//    manager.shouldPlayInputClicks = YES;
//    //控制键盘上面的Done是否显示
//    manager.enableAutoToolbar = YES;
//}


/**要使用百度地图，请先启动BaiduMapManager*/
//-(void)configBMKMap{
//    self.mapManager = [[BMKMapManager alloc]init];
//    BOOL ret = [self.mapManager start:@"wGokGgAnR8xGDQ6Oyc2DLdcH1f1EbTOE"  generalDelegate:self];
//    if (!ret) {
//        NSLog(@"manager start failed!");
//    }
//}


/**
 创建数据库表
 */
-(void)createTable {
   // NSString * sql =  [FMDBExtension CreateSqlcommandOfClass:[MoreData class]];
    //[[DBHelper defaultManager] CreateDataBaseName:sql];
}


/*! 判断登陆状态 */
-(void)chekLogin {
    NSDictionary * dict = [FilterMannger valueUserInfo];
//    if (IsStrEmpty(dict[@"employeeId"])) {
    if (0) {
        ZZGNavigationController * nvc = [[ZZGNavigationController alloc] initWithRootViewController:[LoginController new]];
        [nvc setNavigationBarHidden:YES animated:YES];
        self.window.rootViewController = nvc;
    }
    else {
        self.window.rootViewController = [[ZZGTabBarController alloc] init];
    }
    
}

/**
 切换跟视图
 */
-(void)switchRootViewController {
    self.window.rootViewController = nil;
    typedef void (^Animation)(void);
    Animation animation = ^{
        BOOL oldState = [UIView areAnimationsEnabled];
        [UIView setAnimationsEnabled:NO];
        self.window.rootViewController = [[ZZGTabBarController alloc] init];
        [UIView setAnimationsEnabled:oldState];
    };
    
    [UIView transitionWithView:self.window
                      duration:0.7f
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:animation
                    completion:nil];
}

/**
 切换跟视图到登录页面
 */
-(void)switchRootViewControllerToLoginView {
    self.window.rootViewController = nil;
    typedef void (^Animation)(void);
    Animation animation = ^{
        BOOL oldState = [UIView areAnimationsEnabled];
        [UIView setAnimationsEnabled:NO];
        ZZGNavigationController * nvc = [[ZZGNavigationController alloc] initWithRootViewController:[LoginController new]];
        [nvc setNavigationBarHidden:YES animated:YES];
        self.window.rootViewController = nvc;

        [UIView setAnimationsEnabled:oldState];
    };
    
    [UIView transitionWithView:self.window
                      duration:0.5f
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:animation
                    completion:nil];
}



/**
 *  友盟统计
 */
- (void)umengTrack {
//    UMConfigInstance.appKey = UMOBCLICK;
//    [MobClick startWithConfigure:UMConfigInstance];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window{
    
    return UIInterfaceOrientationMaskAll;
    
}


@end
