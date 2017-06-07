//
//  YSNotificationManager.h
//  NingboSat
//
//  Created by 田广 on 16/9/27.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import <Foundation/Foundation.h>

FOUNDATION_EXPORT NSString *const YSConsultUrl;

/**
 *  Notification 管理.
 */
@interface YSNotificationManager : NSObject

// 用户登录
+ (void)postUserLogin;
+ (void)addUserLoginObserver:(id)observer selector:(SEL)aSelector;

// 用户退出.
+ (void)postUserLogout;
+ (void)addUserLogoutObserver:(id)observer selector:(SEL)aSelector;

// 需要跳转至互动.
+ (void)postConsult:(NSDictionary *)dict;
+ (void)addConsultObserver:(id)observer selector:(SEL)aSelector;

@end
