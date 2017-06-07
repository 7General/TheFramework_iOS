//
//  YSNotificationManager.m
//  NingboSat
//
//  Created by 田广 on 16/9/27.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "YSNotificationManager.h"

NSString *const YSConsultUrl                        = @"YSConsultUrl";

#pragma mark - Pravate NotificationName
NSString *const NOTIFICATION_USER_LOGIN             = @"NOTIFICATION_USER_LOGIN";
NSString *const NOTIFICATION_USER_LOGOUT            = @"NOTIFICATION_USER_LOGOUT";
NSString *const NOTIFICATION_CONSULT_JS             = @"NOTIFICATION_CONSULT_JS";

@implementation YSNotificationManager

static void post(NSString *name, NSDictionary * userInfo = nil, id object = nil) {
    [[NSNotificationCenter defaultCenter] postNotificationName:name object:object userInfo:userInfo];
}

static void addObserver(id observer, SEL selector, NSString *name, id object = nil) {
    [[NSNotificationCenter defaultCenter] addObserver:observer selector:selector name:name object:object];
}

// 用户登录
+ (void)postUserLogin {
    post(NOTIFICATION_USER_LOGIN);
}
+ (void)addUserLoginObserver:(id)observer selector:(SEL)aSelector {
    addObserver(observer, aSelector, NOTIFICATION_USER_LOGIN);
}

+ (void)postUserLogout {
    post(NOTIFICATION_USER_LOGOUT);
}
+ (void)addUserLogoutObserver:(id)observer selector:(SEL)aSelector {
    addObserver(observer, aSelector, NOTIFICATION_USER_LOGOUT);
}

+ (void)postConsult:(NSDictionary *)dict {
    post(NOTIFICATION_CONSULT_JS, dict);
}

+ (void)addConsultObserver:(id)observer selector:(SEL)aSelector {
    addObserver(observer, aSelector, NOTIFICATION_CONSULT_JS);
}


@end
