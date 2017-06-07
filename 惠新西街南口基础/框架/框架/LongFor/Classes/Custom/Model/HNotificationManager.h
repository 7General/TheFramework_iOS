//
//  HNotificationManager.h
//  LongFor
//
//  Created by ZZG on 17/5/19.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

FOUNDATION_EXPORT NSString *const YSConsultUrl;

@interface HNotificationManager : NSObject

// 用户登录
+ (void)postUserLogin;
+ (void)addUserLoginObserver:(id)observer selector:(SEL)aSelector;

@end
