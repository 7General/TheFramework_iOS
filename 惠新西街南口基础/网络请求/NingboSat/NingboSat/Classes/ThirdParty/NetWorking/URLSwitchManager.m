//
//  URLSwitchManager.m
//  PlanC
//
//  Created by ysyc_liu on 16/8/29.
//  Copyright © 2016年 ysyc_wang. All rights reserved.
//

#import "URLSwitchManager.h"
#import "Config.h"

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
    NSArray     * portUrlArray  = [self portUrlArray];
    NSPredicate * predicate     = [NSPredicate predicateWithFormat:@"%K = %@", PortFeature, @(feature)];
    NSArray     * resultArray   = [portUrlArray filteredArrayUsingPredicate:predicate];
    NSDictionary * resultDict   = [resultArray firstObject];
    URLType     urlType         = [resultDict[PortType] integerValue];
    NSString    * portName      = resultDict[PortName];
    NSString    * serverUrl     = nil;
    
    switch (urlType) {
        case URLTypeAPI: {
            serverUrl = NINGBO_OUTSIDE_SUBSERVER(@"/v3");

            break;
        }
        case URLTypeSecure: {
            serverUrl = NINGBO_OUTSIDE_SUBSERVER(@"/v1/appi");
            break;
        }
        case URLTypeUserCenter: {
            serverUrl = @"http://120.27.41.251:8080/Itaxer";
            break;
        }
        case URLTypeAppCenter: {
            serverUrl= @"http://global.eshuike.com/Itaxer";
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
        // 涉税信息 基本信息查询
        [portUrlArray addObject:@{PortFeature:@(APITypeTaxInfo),
                                  PortName:@"/basicIn/queryBasicInfo",
                                  PortType:@(URLTypeAPI)}];
        // 获取税厅信息
        [portUrlArray addObject:@{PortFeature:@(APITypeTaxHall),
                                  PortName:@"/taxHall/getTaxHallInfo",
                                  PortType:@(URLTypeAPI)}];
        // 办税地图
        [portUrlArray addObject:@{PortFeature:@(APITypeTaxMap),
                                  PortName:@"/taxHall/taxMap",
                                  PortType:@(URLTypeAPI)}];
        // 涉税信息 申报缴款查询
        [portUrlArray addObject:@{PortFeature:@(APITypeDeclarePay),
                                  PortName:@"/declare/queryDeclarePay",
                                  PortType:@(URLTypeAPI)}];
        // 涉税信息 涉税申请查询
        [portUrlArray addObject:@{PortFeature:@(APITypeApplyForTax),
                                  PortName:@"/taxPayer/applyForQueryTax",
                                  PortType:@(URLTypeAPI)}];
        // 涉税信息 撤销涉税申请
        [portUrlArray addObject:@{PortFeature:@(APITypeApplyTaxCancel),
                                  PortName:@"/taxPayer/applyForBackoutTax",
                                  PortType:@(URLTypeAPI)}];
        // 涉税信息 纳税人信用等级查询
        [portUrlArray addObject:@{PortFeature:@(APITypeCreditRating),
                                  PortName:@"/taxPayer/queryCreditLevel",
                                  PortType:@(URLTypeAPI)}];
        
        
        // 发票开具 开票人设置
        [portUrlArray addObject:@{PortFeature:@(APITypeQueryInvoiceOpenKpr),
                                  PortName:@"/drawer/queryDrawer",
                                  PortType:@(URLTypeAPI)}];
        // 发票业务 获取发票查询验证码
        [portUrlArray addObject:@{PortFeature:@(APITypeGetValidateCode),
                                  PortName:@"/invoice/getValidateCode",
                                  PortType:@(URLTypeAPI)}];
        // 发票业务 发票查询
        [portUrlArray addObject:@{PortFeature:@(APITypeQueryInvoice),
                                  PortName:@"/invoice/queryInvoice",
                                  PortType:@(URLTypeAPI)}];
        //邮寄发票 查询可领用发票信息
        [portUrlArray addObject:@{PortFeature:@(APITypeQueryCanReceiveInvoice),
                                  PortName:@"/invoice/queryCanReceiveInvoice",
                                  PortType:@(URLTypeAPI)}];
        //邮寄发票 是否可申请邮寄发票
        [portUrlArray addObject:@{PortFeature:@(APITypeIsApplyForEmailInvoice),
                                  PortName:@"/invoice/isApplyForEmailInvoice",
                                  PortType:@(URLTypeAPI)}];
        // 地址管理
        [portUrlArray addObject:@{PortFeature:@(APITypeTaxPayerDefAddress),
                                  PortName:@"/address/queryDefAddress",
                                  PortType:@(URLTypeAPI)}];
        [portUrlArray addObject:@{PortFeature:@(APITypeTaxPayerAddressQuery),
                                  PortName:@"/address/queryAddress",
                                  PortType:@(URLTypeAPI)}];
        [portUrlArray addObject:@{PortFeature:@(APITypeTaxPayerAddressInsert),
                                  PortName:@"/address/insertAddress",
                                  PortType:@(URLTypeAPI)}];
        [portUrlArray addObject:@{PortFeature:@(APITypeTaxPayerAddressUpdate),
                                  PortName:@"/address/updateAddress",
                                  PortType:@(URLTypeAPI)}];
        [portUrlArray addObject:@{PortFeature:@(APITypeTaxPayerAddressDelete),
                                  PortName:@"/address/deleteAddress",
                                  PortType:@(URLTypeAPI)}];
        // 获取宁波市下属区
        [portUrlArray addObject:@{PortFeature:@(APITypeNingboDistricts),
                                  PortName:@"/address/getTaxStationDistricts",
                                  PortType:@(URLTypeAPI)}];
        // 获取宁波市下属区税局信息
        [portUrlArray addObject:@{PortFeature:@(APITypeTaxStationByDistricts),
                                  PortName:@"/address/getTaxStationByDistrictName",
                                  PortType:@(URLTypeAPI)}];
        
        // 发票业务 邮寄发票申请
        [portUrlArray addObject:@{PortFeature:@(APITypeApplyForEmailInvoice),
                                  PortName:@"/invoice/applyForEmailInvoice",
                                  PortType:@(URLTypeAPI)}];
        // 小规模申报初始化信息
        [portUrlArray addObject:@{PortFeature:@(APITypeInitXgmsb),
                                  PortName:@"/sb/initXgmsb",
                                  PortType:@(URLTypeAPI)}];
        // 小规模申报预览
        [portUrlArray addObject:@{PortFeature:@(APITypeXgmsbPreview),
                                  PortName:@"/sb/xgmsbPreview",
                                  PortType:@(URLTypeAPI)}];
        // 小规模申报
        [portUrlArray addObject:@{PortFeature:@(APITypeXgmsb),
                                  PortName:@"/sb/xgmsb",
                                  PortType:@(URLTypeAPI)}];
        // 用户登录
        [portUrlArray addObject:@{PortFeature:@(APITypeUserLogin),
                                  PortName:@"/userCenter/user_login",
                                  PortType:@(URLTypeUserCenter)}];
        // 用户激活
        [portUrlArray addObject:@{PortFeature:@(APITypeUserActivate),
                                  PortName:@"/taxUser/taxUserActivation",
                                  PortType:@(URLTypeSecure)}];
        
        // 修改密码
        [portUrlArray addObject:@{PortFeature:@(APITypeUserUpdatePassword),
                                  PortName:@"/taxUser/taxUserUpdatePwd",
                                  PortType:@(URLTypeSecure)}];
        
        // 办税地图
        [portUrlArray addObject:@{PortFeature:@(APITypeRunGuideMap),
                                  PortName:@"/taxHall/getTaxHallInfo",
                                  PortType:@(URLTypeAPI)}];
        // 短信验证码
        [portUrlArray addObject:@{PortFeature:@(APITypeSecurityCode),
                                  PortName:@"/taxUser/taxUserValidMessage",
                                  PortType:@(URLTypeSecure)}];
        
        // banner
        [portUrlArray addObject:@{PortFeature:@(APITypeBanner),
                                  PortName:@"/basicIn/getBanner",
                                  PortType:@(URLTypeAPI)}];
        // 检查更新
        [portUrlArray addObject:@{PortFeature:@(APITypeCheckUpdate),
                                  PortName:@"/version/getVersion",
                                  PortType:@(URLTypeAPI)}];
        
       // 获取纳税人是否可以预约
        [portUrlArray addObject:@{PortFeature:@(APITypeCheckTaxerBook),
                                  PortName:@"/taxHall/getTaxPayerIsReservation",
                                  PortType:@(URLTypeAPI)}];
        
        // 获取可预约事项
        [portUrlArray addObject:@{PortFeature:@(APITypeGetBookItemList),
                                  PortName:@"/taxHall/getReservationMatters",
                                  PortType:@(URLTypeAPI)}];
        // 获取可预约具体事项
        [portUrlArray addObject:@{PortFeature:@(APITypeBookItemSepcFile),
                                  PortName:@"/taxHall/getItemDetails",
                                  PortType:@(URLTypeAPI)}];
        // 获取办税网点信息
        [portUrlArray addObject:@{PortFeature:@(APITypeCheckInCompanyItem),
                                  PortName:@"/taxHall/getTaxHal",
                                  PortType:@(URLTypeAPI)}];
        
        // 获取最大限制办税时间列表
        [portUrlArray addObject:@{PortFeature:@(APITypeDateBookItem),
                                  PortName:@"/taxHall/getBiggestDays",
                                  PortType:@(URLTypeAPI)}];

        // 获取预约办税时间列表
        [portUrlArray addObject:@{PortFeature:@(APITypeCheckBookTimeList),
                                  PortName:@"/taxHall/getReservationTime",
                                  PortType:@(URLTypeAPI)}];
        // 预约按钮发送
        [portUrlArray addObject:@{PortFeature:@(APITypeBookFunClick),
                                  PortName:@"/taxHall/reservation",
                                  PortType:@(URLTypeAPI)}];
        // 取消预约
        [portUrlArray addObject:@{PortFeature:@(APITypeBookCancleClick),
                                  PortName:@"/taxHall/cancelReservation",
                                  PortType:@(URLTypeAPI)}];
        
        // 查看办理所需要的资料
        [portUrlArray addObject:@{PortFeature:@(APITypeCheckData),
                                  PortName:@"/taxHall/getBookingMaterial",
                                  PortType:@(URLTypeAPI)}];
        // 预约列表
        [portUrlArray addObject:@{PortFeature:@(APITypeBooklistData),
                                  PortName:@"/taxUser/myReservation",
                                  PortType:@(URLTypeSecure)}];

    });
    
    return portUrlArray;
}

@end
