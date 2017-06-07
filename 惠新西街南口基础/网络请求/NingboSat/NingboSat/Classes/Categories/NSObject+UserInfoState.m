//
//  NSObject+UserInfoState.m
//  NingboSat
//
//  Created by 田广 on 16/9/27.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "NSObject+UserInfoState.h"
#import "YSNotificationManager.h"

#define ACCESS_TOKE_KEY @"ACCESS_TOKE_KEY"
#define USER_INFO_KEY @"USER_INFO_KEY"


@implementation NSObject (UserInfoState)

/**
 *  是否登录状态.
 */
+ (BOOL)isLogin{
    
    if ([[self getAccessToken] length] > 0) {
        return YES;
    }
    else{
        return NO;
    }
}

/**
 *  获取accessToken.
 */
+ (NSString *)getAccessToken{
    NSString *accessTokenString = [[NSUserDefaults standardUserDefaults]objectForKey:ACCESS_TOKE_KEY];
    
    return accessTokenString;
}
+ (NSString *)userId {
    @try {
        NSString *userId = [[[NSUserDefaults standardUserDefaults]objectForKey:USER_INFO_KEY] valueForKey:@"user_id"];
        if (!userId) {
            userId = @"";
        }
        return userId;
    } @catch (NSException *exception) {
        return @"";
    }
}
/**
 *  获取税号.
 */
+ (NSString *)getTaxNumber{
    @try {
        NSString *taxNumberString = [[[NSUserDefaults standardUserDefaults]objectForKey:USER_INFO_KEY] valueForKey:@"account_number"];
        if (!taxNumberString) {
            taxNumberString = @"";
        }
        return taxNumberString;
    } @catch (NSException *exception) {
        return @"";
    }
}
/**
 *  获取纳税人名称.
 */
+ (NSString *)getTaxName {
    @try {
        NSString *taxNameString = [[[NSUserDefaults standardUserDefaults]objectForKey:USER_INFO_KEY] valueForKey:@"user_name"];
        if (!taxNameString) {
            taxNameString = @"";
        }
        return taxNameString;
    } @catch (NSException *exception) {
        return @"";
    }
}
/**
 *  获取手机号.
 */
+ (NSString *)getMobile{
    @try {
        NSString *mobileString = [[[NSUserDefaults standardUserDefaults]objectForKey:USER_INFO_KEY] valueForKey:@"phone_number"];
        if (!mobileString) {
            mobileString = @"";
        }
        return mobileString;
    } @catch (NSException *exception) {
        return @"";
    }
}

/**
 *  添加用户信息.
 */
+ (BOOL)addUserInfo:(NSDictionary *)userInfoDic{
    
    [[NSUserDefaults standardUserDefaults]setObject:userInfoDic[@"access_token"] forKey:ACCESS_TOKE_KEY];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:userInfoDic[@"user_name"] forKey:@"user_name"];
    [dict setObject:userInfoDic[@"phone_number"] forKey:@"phone_number"];
    [dict setObject:userInfoDic[@"account_number"] forKey:@"account_number"];
    [dict setObject:[(NSNumber *)userInfoDic[@"user_id"] stringValue] forKey:@"user_id"];
    [[NSUserDefaults standardUserDefaults]setObject:dict forKey:USER_INFO_KEY];
    
    [YSNotificationManager postUserLogin];
    
    return YES;
}

/**
 *  删除用户信息.
 */
+ (BOOL)removeUserInfo{
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:ACCESS_TOKE_KEY];
    
    [YSNotificationManager postUserLogout];
    
    return YES;
}

@end
