//
//  FilterMannger.h
//  LongFor
//
//  Created by ZZG on 17/5/18.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString * USERINFO = @"userInfo";
static NSString * HAVE_GROUP_ROLE = @"isHaveGroupRole";
static NSString * CITYPROJECTDIC = @"CITYPROJECTDIC";
static NSString * CITY_ID = @"citySid";
static NSString * PROJECT_ID = @"projectSid";


@interface FilterMannger : NSObject

/**
 添加用户缓存信息

 @param userInfoDict 用户网络请求字典信息
 @return YES
 */
+(BOOL)addUserInfo:(NSDictionary *)userInfoDict;

/**
 删除用户缓存信息

 @return YES
 */
+(BOOL)deleteUseInfo;

/**
 获取用户信息

 @return 用户信息字典
 */
+(NSDictionary *)valueUserInfo;


/**
 添加自定义输入跟进时间

 @param from 起始时间
 @param to 结束时间
 @return bool
 */
+(BOOL)setInputValue:(NSString *)from forTo:(NSString *)to;

/**
 获取去InputFrom

 @return string
 */
+(NSString *)valueInputFrom;

/**
 获取去InputFrom
 
 @return string
 */
+(NSString *)valueInputTo;


/**
 保存选中服务器地址

 @param server “C”测试服务区  “Z” 正式服务器
 */
+(BOOL)setServerAddres:(NSString *)server;

/**
 获取选中服务器地址

 @return “C”测试服务区  “Z” 正式服务器
 */
+(NSString *)serverAddres;


/**
 保存选中城市-项目信息
 @param city_ProjectDic 城市-项目信息
 */
+(void)setSelectCity_ProjectDic:(NSDictionary *)city_ProjectDic;

/**
 获取选中城市-项目信息
 @return 选中城市-项目信息
 */
+(NSDictionary *)getSelectCity_ProjectDic;

//废弃
///**
// 存入项目ID
// @param projectID 项目ID
// */
//+(void)writeProjrctID:(NSString *)projectID;

/**
 获取项目ID
 @return 项目ID
 */
+(NSString *)valueProjectID;

@end
