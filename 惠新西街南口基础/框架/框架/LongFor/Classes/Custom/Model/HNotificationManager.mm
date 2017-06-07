//
//  HNotificationManager.m
//  LongFor
//
//  Created by ZZG on 17/5/19.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "HNotificationManager.h"

NSString *const YSConsultUrl                        = @"YSConsultUrl";

#pragma mark - Pravate NotificationName
NSString *const NOTIFICATION_USER_LOGIN             = @"NOTIFICATION_USER_LOGIN";
NSString *const NOTIFICATION_USER_LOGOUT            = @"NOTIFICATION_USER_LOGOUT";

@implementation HNotificationManager

static void post(NSString *name, NSDictionary * userInfo = nil, id object = nil) {
    [[NSNotificationCenter defaultCenter] postNotificationName:name object:object userInfo:userInfo];
}

static void addObserver(id observer, SEL selector, NSString *name, id object = nil) {
    [[NSNotificationCenter defaultCenter] addObserver:observer selector:selector name:name object:object];
}



// ########################################


// 用户登录
+ (void)postUserLogin {
    post(NOTIFICATION_USER_LOGIN);
}
+ (void)addUserLoginObserver:(id)observer selector:(SEL)aSelector {
    addObserver(observer, aSelector, NOTIFICATION_USER_LOGIN);
}





@end
