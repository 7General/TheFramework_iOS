//
//  URLSwitchManager.m
//  PlanC
//
//  Created by ysyc_liu on 16/8/29.
//  Copyright © 2016年 ysyc_wang. All rights reserved.
//

#import "URLSwitchManager.h"
#import "ConfigUI.h"
#import "FilterMannger.h"

NSString *const PortFeature = @"feature";
NSString *const PortName    = @"name";
NSString *const PortType    = @"type";

/// 对应服务器地址.
typedef NS_ENUM(NSInteger, URLType) {
    URLTypeNone = 0,
    URLTypeTest,
    URLTypeAPI,
    URLTypeSecure,
    URLTypeUserCenter,
    URLTypeAppCenter,
};

@implementation URLSwitchManager


+ (NSString *)getUrlByFeature:(APIType)feature {
    // 获取选择服务器配置 // 默认为【正式服务器】
    NSString * server = [FilterMannger serverAddres];
    NSString * LOGNFOR_SERVER = LONGFOR_FORMAL_SERVER;
    // 正式服务器
    if ([server isEqualToString:@"Z"] || IsStrEmpty(server)) {
        LOGNFOR_SERVER = LONGFOR_FORMAL_SERVER;
    } else if([server isEqualToString:@"C"]) {
        // 测试服务器
        LOGNFOR_SERVER = LONGFOR_TEST_SERVER;
    }else if([server isEqualToString:@"H"]){
        // 灰度服务器
        LOGNFOR_SERVER = LONGFOR_GREY_SERVER;
    }
    
    NSArray     * portUrlArray  = [self portUrlArray];
    NSPredicate * predicate     = [NSPredicate predicateWithFormat:@"%K = %@", PortFeature, @(feature)];
    NSArray     * resultArray   = [portUrlArray filteredArrayUsingPredicate:predicate];
    NSDictionary * resultDict   = [resultArray firstObject];
    URLType     urlType         = [resultDict[PortType] integerValue];
    NSString    * portName      = resultDict[PortName];
    NSString    * serverUrl     = nil;
    
    switch (urlType) {
        case URLTypeAPI: {
            //serverUrl = LONGFOR_OUTSIDE_SUBSERVER(@"/LHService");
            serverUrl = [NSString stringWithFormat:@"%@%@",LOGNFOR_SERVER,@"/LHService"];
            break;
        }
        case URLTypeSecure: {
            //serverUrl = NINGBO_OUTSIDE_SUBSERVER(@"/v1/appi");
            break;
        }
        case URLTypeUserCenter: {
            serverUrl = @"";
            break;
        }
        case URLTypeAppCenter: {
            serverUrl= @"";
            break;
        }
        case URLTypeTest: {
            serverUrl = @"";
            break;
        }
        default:
            serverUrl = @"error no break";
            break;
    }
    
    NSString * ret = [NSString stringWithFormat:@"%@%@",serverUrl,portName];
    return ret;
}

+ (NSArray *)portUrlArray {
    static NSMutableArray * portUrlArray = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        portUrlArray = [NSMutableArray array];
        
        [portUrlArray addObject:@{PortFeature:@(APITypeTest),
                                  PortName:@"test",
                                  PortType:@(URLTypeTest)}];
        // 登录接口
        [portUrlArray addObject:@{PortFeature:@(APITypeLogin),
                                  PortName:@"/caseField/login",
                                  PortType:@(URLTypeAPI)}];
        // 获取客户列表
        [portUrlArray addObject:@{PortFeature:@(APITypeCustomList),
                                  PortName:@"/csCustomer/getInterCustomer",
                                  PortType:@(URLTypeAPI)}];
        // 获取客户详细信息
        [portUrlArray addObject:@{PortFeature:@(APITypeCustomInfoList),
                                  PortName:@"/csCustomer/getCustomerById",
                                  PortType:@(URLTypeAPI)}];
        // 查询公司-项目列表接口
        [portUrlArray addObject:@{PortFeature:@(APITypeGetNewEmployeeList),
                                  PortName:@"/caseField/getNewEmployeeList",
                                  PortType:@(URLTypeAPI)}];
        // 查询项目下员工有无录入客户权限接口
        [portUrlArray addObject:@{PortFeature:@(APITypeGetAddEnable),
                                  PortName:@"/csCustomer/getAddEnable",
                                  PortType:@(URLTypeAPI)}];
        // 5.	录入客户手机号接口
        [portUrlArray addObject:@{PortFeature:@(APITypeAddCustomerAllByTel),
                                  PortName:@"/csCustomer/addCustomerAllByTel",
                                  PortType:@(URLTypeAPI)}];
        // 6.	查询项目所有选择标签(客户录入)接口
        [portUrlArray addObject:@{PortFeature:@(APITypeQueryCsLabelMoreInfo),
                                  PortName:@"/csCustomer/queryCsLabelMoreInfo",
                                  PortType:@(URLTypeAPI)}];
        // 7.	客户录入方法
        [portUrlArray addObject:@{PortFeature:@(APITypeUpdateCustomerAll),
                                  PortName:@"/csCustomer/updateCustomerAll",
                                  PortType:@(URLTypeAPI)}];
        //  增加跟进信息
        [portUrlArray addObject:@{PortFeature:@(APITypeAddFollow),
                                  PortName:@"/csCustomer/addFollow",
                                  PortType:@(URLTypeAPI)}];
        // 获取考勤点信息
        [portUrlArray addObject:@{PortFeature:@(APITypeValueSingIn),
                                  PortName:@"/signin/selectAttendanceName",
                                  PortType:@(URLTypeAPI)}];
        // 上班签到 
        [portUrlArray addObject:@{PortFeature:@(APITypeSingInAction),
                                  PortName:@"/signin/goToWork",
                                  PortType:@(URLTypeAPI)}];
        // 员工签到记录
        [portUrlArray addObject:@{PortFeature:@(APITypeSelectWorkRecord),
                                  PortName:@"/signin/selectWorkRecord",
                                  PortType:@(URLTypeAPI)}];
        // 18.	查询考勤记录条数
        [portUrlArray addObject:@{PortFeature:@(APITypeSelectWorkRecordListCount),
                                  PortName:@"/signin/queryWorkRecordListCount",
                                  PortType:@(URLTypeAPI)}];
        
        // 领导查询考勤记录
        [portUrlArray addObject:@{PortFeature:@(APITypeSelectWorkRecordByLeader),
                                  PortName:@"/signin/selectWorkRecordByLeader",
                                  PortType:@(URLTypeAPI)}];
        
        
    });
    
    return portUrlArray;
}

@end
