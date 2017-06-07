//
//  AppDelegate.m
//  NingboSat
//
//  Created by 王会洲 on 16/9/6.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "AppDelegate.h"
#import "YSNavigationViewController.h"
#import "YSTabBarViewController.h"
#import "YSWebController.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import "RequestBase.h"
#import "YSAlertView.h"
#import "YSNotificationManager.h"
#import "Config.h"
#import "IQKeyboardManager.h"
#import "MobClick.h"
#import "XGPush.h"


@interface AppDelegate ()<BMKGeneralDelegate>
@property (nonatomic, strong) BMKMapManager * mapManager;
@property (nonatomic,assign)NSUInteger bgTask;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //设置后台更新数据时间
    [application setMinimumBackgroundFetchInterval:60.0f];

    
    
    YSTabBarViewController *main = [[YSTabBarViewController alloc]init];
    YSNavigationViewController *rootNav = [[YSNavigationViewController alloc] initWithRootViewController:main];
    self.window.rootViewController = rootNav;
    [self.window makeKeyAndVisible];
    
    [self configBMKMap];
    
    [self umengTrack];
    
    [self remindUpdate];
    
    [self initObserver];
    
    [self IQKeyboardInit];
    
    [self registerNotification];
    
    sleep(4);
    
    [self dealWithLaunchOptions:launchOptions];
    
    return YES;
}

/**
 *  友盟统计
 */
- (void)umengTrack {
    [MobClick startWithAppkey:@"5507946efd98c5686d00013d"];
}

/**要使用百度地图，请先启动BaiduMapManager*/
-(void)configBMKMap{
    self.mapManager = [[BMKMapManager alloc]init];
    BOOL ret = [self.mapManager start:@"o2eUDkEVemIqBec0juSuEQAr194X4fsx"  generalDelegate:self];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
}

#pragma mark - 更新检查
-(void)remindUpdate{
    //获取app 版本号
    NSDictionary * dict = @{@"type":@"4"};
    NSDictionary * param = @{@"jsonParam":[dict JSONParamString]};

    [RequestBase requestWith:APITypeCheckUpdate Param:param Complete:^(YSResponseStatus status, id object) {
        if (status == YSResponseStatusSuccess) {
            NSDictionary * dict = [object objectForKey:@"content"];
            
            NSString *version = [dict objectForKey:@"versionId"];
            ///判断是可更新
            if ([APP_VERSION compare:version options:NSNumericSearch] == NSOrderedAscending) {
                NSString *updateUrl = [dict valueForKey:@"update_url"];
                NSString * flag = [dict valueForKey:@"forceUpdateFlag"];
                if (flag.boolValue) {
                    YSAlertView *alert = [YSAlertView alertWithTitle:@"更新提醒" message:[dict objectForKey:@"versionDescription"] buttonTitles:@"确定", nil];
                    [alert show];
                    [alert alertButtonClick:^(NSInteger buttonIndex) {
                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"itms-apps:%@", updateUrl]]];
                    }];
                }
                else {
                    YSAlertView *alert = [YSAlertView alertWithTitle:@"更新提醒" message:[dict objectForKey:@"versionDescription"] buttonTitles:@"取消", @"确定", nil];
                    [alert show];
                    [alert alertButtonClick:^(NSInteger buttonIndex) {
                        if (buttonIndex == 1) {
                            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"itms-apps:%@", updateUrl]]];
                        }
                    }];
                }
            }
            

        }
    } ShowOnView:nil AnimationOption:YSRequestAnimationStateNone];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.

}

- (void)applicationDidEnterBackground:(UIApplication *)application{
    _bgTask = [application beginBackgroundTaskWithExpirationHandler:^{
        // 3分钟后执行这里，应该进行一些清理工作，如断开和服务器的连接 //
        [application endBackgroundTask:_bgTask];
        _bgTask = UIBackgroundTaskInvalid;

        [self userLogout];
        NSLog(@" end background task!");
        exit(0);
    }];
    if (_bgTask == UIBackgroundTaskInvalid) {
        NSLog(@"failed to start background task!");
    }

}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // 如果没到3分钟又打开了app,结束后台任务
    if (_bgTask != UIBackgroundTaskInvalid) {
        [application endBackgroundTask:_bgTask];
        _bgTask = UIBackgroundTaskInvalid;
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:LAST_ACTIVE_TIME];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];

    NSDate *oldDate = [[NSUserDefaults standardUserDefaults] objectForKey:LAST_ACTIVE_TIME];
    if (oldDate) {
        NSDate *date = [NSDate date];
        NSTimeInterval disTime = [date timeIntervalSinceDate:oldDate];
        if (disTime > 60 * 5) {
            [self performSelector:@selector(userLogout) withObject:nil afterDelay:1.0];
        }
    }
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:LAST_ACTIVE_TIME];
}


- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [self setSGPushAccountAndRegisterDeviceToken:deviceToken];
}

//如果deviceToken获取不到会进入此事件
- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)err {
    
    NSString *str = [NSString stringWithFormat: @"Error: %@",err];
    
    NSLog(@"[XGPush Demo]%@",str);
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [self dealRemoteNotification:userInfo];
}

#pragma mark - 初始化观察服务.
- (void)initObserver {
    [YSNotificationManager addUserLoginObserver:self selector:@selector(userLogin)];
}

#pragma mark - 登录登出.
- (void)userLogin {
    [self setSGPushAccountAndRegisterDeviceToken:nil];
}

- (void)userLogout {
    [NSObject removeUserInfo];
}

#pragma mark - 键盘高度适配处理初始化.
- (void)IQKeyboardInit {
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    
    manager.enable =YES;
    
    manager.shouldResignOnTouchOutside =YES;
    
    manager.shouldToolbarUsesTextFieldTintColor =YES;
    manager.shouldPlayInputClicks = YES;
    
    //控制键盘上面的Done是否显示
    manager.enableAutoToolbar =NO;
}

#pragma mark - 信鸽推送初始化.
- (void)XGPushInit {
    [XGPush startApp:2200244347 appKey:@"I5X353JGGL1N"];
    
    //Types
    UIUserNotificationType types = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
    
    //Actions
    UIMutableUserNotificationAction *acceptAction = [[UIMutableUserNotificationAction alloc] init];
    
    acceptAction.identifier = @"ACCEPT_IDENTIFIER";
    acceptAction.title = @"Accept";
    
    acceptAction.activationMode = UIUserNotificationActivationModeForeground;
    acceptAction.destructive = NO;
    acceptAction.authenticationRequired = NO;
    
    //Categories
    UIMutableUserNotificationCategory *inviteCategory = [[UIMutableUserNotificationCategory alloc] init];
    
    inviteCategory.identifier = @"INVITE_CATEGORY";
    
    [inviteCategory setActions:@[acceptAction] forContext:UIUserNotificationActionContextDefault];
    
    [inviteCategory setActions:@[acceptAction] forContext:UIUserNotificationActionContextMinimal];
    
    NSSet *categories = [NSSet setWithObjects:inviteCategory, nil];
    
    UIUserNotificationSettings *mySettings = [UIUserNotificationSettings settingsForTypes:types categories:categories];
    
    [[UIApplication sharedApplication] registerUserNotificationSettings:mySettings];
    
    [[UIApplication sharedApplication] registerForRemoteNotifications];
}

/**
 设置信鸽推送账号.
 
 @param deviceToken 设备号.如果为nil, 则会取上一次调用所传参的值.
 */
- (void)setSGPushAccountAndRegisterDeviceToken:(NSData *)deviceToken {
    //NSString * deviceTokenStr = [XGPush registerDevice:deviceToken];
    static NSData *sDeviceToken = nil;
    if (deviceToken && ![deviceToken isEqualToData:sDeviceToken]) {
        sDeviceToken = deviceToken;
    }
    void (^successBlock)(void) = ^(void){
        //成功之后的处理
        NSLog(@"[XGPush Demo]register successBlock");
    };
    
    void (^errorBlock)(void) = ^(void){
        //失败之后的处理
        NSLog(@"[XGPush Demo]register errorBlock");
    };
    
    // 设置账号
    if ([[NSObject getTaxNumber] length] > 0) {
        [XGPush setAccount:[NSObject getTaxNumber]];
    }
    else {
        [XGPush setAccount:@"*"];
    }
    
    
    //注册设备
    NSString * deviceTokenStr = [XGPush registerDevice:sDeviceToken successCallback:successBlock errorCallback:errorBlock];
    //如果不需要回调
    //[XGPush registerDevice:deviceToken];
    //打印获取的deviceToken的字符串
    NSLog(@"[XGPush Demo] deviceTokenStr is %@",deviceTokenStr);
}

#pragma mark - 注册通知.
-(void)registerNotification {
    [self XGPushInit];
}



#pragma mark - launchOptions 处理
- (void)dealWithLaunchOptions:(NSDictionary *)launchOptions {
    @try {
        if (launchOptions) {
            [self dealRemoteNotification:launchOptions[UIApplicationLaunchOptionsRemoteNotificationKey]];
        }
    } @catch (NSException *exception) {
        
    }
}

#pragma mark - 推送消息处理
- (void)dealRemoteNotification:(NSDictionary *)userInfo {
    @try {
        if ([userInfo[@"type"] integerValue] == 1) {
            dispatch_async(dispatch_get_main_queue(), ^{
                // 我的消息-详情.
                YSNavigationViewController * rootNav = (YSNavigationViewController *)self.window.rootViewController;
                YSWebController *webVc = [[YSWebController alloc] init];
                webVc.urlStr = [NSString stringWithFormat:@"%@/%@/%@", MINE_MESSAGE_DETAIL_URL, userInfo[@"xxid"], userInfo[@"lxid"]];
                [rootNav pushViewController:webVc animated:YES];
            });
        }
    } @catch (NSException *exception) {
        NSLog(@"[EXCEPTION] %@ : %@", [self class], exception);
    }
    
    if ([[UIApplication sharedApplication] applicationIconBadgeNumber] > 0) {
        [UIApplication sharedApplication].applicationIconBadgeNumber -= 1;
    }
}


//后台唤醒代理
//- (void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
//{
//    [self userLogout];
//}
@end
