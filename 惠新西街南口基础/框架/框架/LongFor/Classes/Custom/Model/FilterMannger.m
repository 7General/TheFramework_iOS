//
//  FilterMannger.m
//  LongFor
//
//  Created by ZZG on 17/5/18.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "FilterMannger.h"
#import "HNotificationManager.h"
#import "ConfigUI.h"


static NSString * INPUTFROM = @"inputfrom";
static NSString * INPUTTO = @"inputto";
static NSString * SERVERADDRESS = @"SERVERADD";

@implementation FilterMannger

/**
 添加用户缓存信息
 
 @param userInfoDict 用户网络请求字典信息
 @return YES
 */
+(BOOL)addUserInfo:(NSDictionary *)userInfoDict {
    NSArray * employArry = userInfoDict[@"employeeList"];
    NSDictionary * fistUserInfo = [employArry firstObject];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    // 公司ID
    [dict setObject:fistUserInfo[@"orgId"] forKey:@"orgId"];
    // 公司名
    [dict setObject:fistUserInfo[@"orgName"] forKey:@"orgName"];
    //项目id
    [dict setObject:fistUserInfo[@"prjId"] forKey:@"prjId"];
    // 项目名
    [dict setObject:fistUserInfo[@"prjName"] forKey:@"prjName"];
    // 登录名
    [dict setObject:fistUserInfo[@"loginName"] forKey:@"loginName"];
    // 电话
    [dict setObject:fistUserInfo[@"mobilePhone"] forKey:@"mobilePhone"];
    // 中文名
    [dict setObject:fistUserInfo[@"perName"] forKey:@"perName"];
    // 用户头像
    [dict setObject:fistUserInfo[@"photoUrl"] forKey:@"photoUrl"];
    // 员工ID
    [dict setObject:fistUserInfo[@"employeeId"] forKey:@"employeeId"];
    // 员工类型
    [dict setObject:fistUserInfo[@"employeeType"] forKey:@"employeeType"];
    // app权限，
    [dict setObject:fistUserInfo[@"menuFlag"] forKey:@"menuFlag"];
    // 代表数据权限大小
    [dict setObject:fistUserInfo[@"orderNums"] forKey:@"orderNums"];
    // 汇报关系对应
    [dict setObject:fistUserInfo[@"hbgxName"] forKey:@"hbgxName"];
    
    [[NSUserDefaults standardUserDefaults] setObject:dict forKey:USERINFO];
    
    // 用户角色
    [[NSUserDefaults standardUserDefaults] setObject:userInfoDict[@"isHaveGroupRole"] forKey:HAVE_GROUP_ROLE];
    
    // 集团权限 默认选中 tabbar 第二栏
    if (1 == [userInfoDict[@"isHaveGroupRole"] integerValue]) {
        
    }
    [HNotificationManager postUserLogin];
    return YES;
}

/**
 删除用户缓存信息
 
 @return YES
 */
+(BOOL)deleteUseInfo {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:USERINFO];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:HAVE_GROUP_ROLE];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:CITYPROJECTDIC];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:INPUTFROM];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:INPUTTO];
    return YES;
}


/**
 获取用户信息
 
 @return 用户信息字典
 */
+(NSDictionary *)valueUserInfo {
    NSDictionary * userInfoDic = [[NSUserDefaults standardUserDefaults] objectForKey:USERINFO];
    return userInfoDic;
}

/**
 添加自定义输入跟进时间
 
 @param from 起始时间
 @param to 结束时间
 @return bool
 */
+(BOOL)setInputValue:(NSString *)from forTo:(NSString *)to {
    [[NSUserDefaults standardUserDefaults] setObject:from forKey:INPUTFROM];
    [[NSUserDefaults standardUserDefaults] setObject:to forKey:INPUTTO];
    return  YES;
}


/**
 获取去InputFrom
 
 @return <#return value description#>
 */
+(NSString *)valueInputFrom {
    return [[NSUserDefaults standardUserDefaults] objectForKey:INPUTFROM];
}

/**
 获取去InputFrom
 
 @return <#return value description#>
 */
+ (NSString *)valueInputTo {
    return [[NSUserDefaults standardUserDefaults] objectForKey:INPUTTO];
}


/**
 保存选中服务器地址
 
 @param server “C”测试服务区  “Z” 正式服务器
 */
+(BOOL)setServerAddres:(NSString *)server {
    [[NSUserDefaults standardUserDefaults] setObject:server forKey:SERVERADDRESS];
    return YES;
}
/**
 获取选中服务器地址
 
 @return “C”测试服务区  “Z” 正式服务器
 */
+(NSString *)serverAddres {
    return [[NSUserDefaults standardUserDefaults] objectForKey:SERVERADDRESS];
}


/**
 保存选中城市-项目信息
 @param city_ProjectDic 城市-项目信息
 */
+(void)setSelectCity_ProjectDic:(NSDictionary *)city_ProjectDic {
    NSUserDefaults *nf = [NSUserDefaults standardUserDefaults];
    [nf setObject:city_ProjectDic forKey:CITYPROJECTDIC];
    [nf synchronize];
    return ;
}
/**
 获取选中城市-项目信息
 @return 选中城市-项目信息
 */
+(NSDictionary *)getSelectCity_ProjectDic {
    return [[NSUserDefaults standardUserDefaults] objectForKey:CITYPROJECTDIC];
}

/**
 获取项目ID
 @return 项目ID
 */
+(NSString *)valueProjectID {
    NSString* str = [[self getSelectCity_ProjectDic] objectForKey:PROJECT_ID];
    if (IsStrEmpty(str)) {
        NSLog(@"警告-项目id为空");
        return @"";
    }
    return str;
}

//废弃
///**
// 存入项目ID
// @param projectID 项目ID
// */
//+(void)writeProjrctID:(NSString *)projectID {
//    [[NSUserDefaults standardUserDefaults] setObject:projectID forKey:PROJECT_ID];
//}



@end
