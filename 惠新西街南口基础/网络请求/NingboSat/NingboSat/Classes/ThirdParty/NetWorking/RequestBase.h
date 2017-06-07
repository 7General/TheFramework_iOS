//
//  RequestBase.h
//  PlanC
//
//  Created by ysyc_liu on 16/8/29.
//  Copyright © 2016年 ysyc_wang. All rights reserved.
//

#import "YSAFNetWorkManager.h"
#import "NSDictionary+JSONParam.h"

/// 请求过程动画选择类型.
typedef NS_OPTIONS(NSUInteger, YSRequestAnimationState) {
    YSRequestAnimationStateNone      = 0,       // 无.
    YSRequestAnimationStateWait      = 1 << 0,  // 等待响应.
    YSRequestAnimationStateSuccess   = 1 << 1,  // 成功.
    YSRequestAnimationStateFailure   = 1 << 2,  // 失败.
    YSRequestAnimationStateError     = 1 << 3,  // 请求出错.
    YSRequestAnimationStateUnReach   = 1 << 4,  // 无法连接.
};

/**
 *  请求基类.实现请求的代理方法.
 */
@interface RequestBase : YSAFNetWorkManager <YSAFNetWorkManagerDelegate, YSSerializerEncryption>

/// 动画选择.
@property (nonatomic)YSRequestAnimationState animationOption;

/**
 *  请求(选择动画).
 *
 *  @param urlFeature      url特征值.
 *  @param param           参数.
 *  @param complete        完成回调.
 *  @param view            提示或动画所在视图.(当animationOption不为YSRequestAnimationStateNone时,不能为空).
 *  @param animationOption 提示或动画选择.
 */
+ (void)requestWith:(APIType)urlFeature Param:(NSDictionary *)param Complete:(NetBlock)complete ShowOnView:(UIView *)view AnimationOption:(YSRequestAnimationState)animationOption;

/**
 *  请求(默认动画选取).
 *
 *  @param urlFeature url特征值.
 *  @param param      参数.
 *  @param complete   完成回调.
 *  @param view       提示或动画所在视图.(不能为空).
 */
+ (void)requestWith:(APIType)urlFeature Param:(NSDictionary *)param Complete:(NetBlock)complete ShowOnView:(UIView *)view;

/**
 *  请求上传文件(选择动画).
 *
 *  @param urlFeature      url特征值.
 *  @param param           参数.
 *  @param complete        完成回调.
 *  @param view            提示或动画所在视图.(当animationOption不为YSRequestAnimationStateNone时,不能为空).
 *  @param animationOption 提示或动画选择.
 */
+ (void)uploadUrlFeature:(APIType)urlFeature Param:(NSDictionary *)param Complete:(NetBlock)complete ShowOnView:(UIView *)view AnimationOption:(YSRequestAnimationState)animationOption;

/**
 *  请求上传文件(默认动画选取).
 *
 *  @param urlFeature url特征值.
 *  @param param      参数.
 *  @param complete   完成回调.
 *  @param view       提示或动画所在视图.(不能为空).
 */
+ (void)uploadUrlFeature:(APIType)urlFeature Param:(NSDictionary *)param Complete:(NetBlock)complete ShowOnView:(UIView *)view;


/**
 *  请求(仅供测试).
 *
 *  @param url        请求地址.
 *  @param param      参数.
 *  @param complete   完成回调.
 */
+ (void)requestWith:(NSString *)url Param:(NSDictionary *)param Complete:(NetBlock)complete;

@end

/*------------------------------------------------------------------------------------------------
 ------------------------------------------------------------------------------------------------*/
#pragma mark - Server API type
/// 请求接口枚举类型具体定义.
typedef NS_ENUM(NSInteger, APIType) {
    APITypeNone = 0,
    APITypeTest,
    //TODO: 在这儿定义接口枚举.
    APITypeTaxInfo, // 涉税信息 基本信息查询
    APITypeTaxHall, // 获取税厅信息
    APITypeTaxMap,  // 办税地图
    APITypeDeclarePay,  // 涉税信息 申报缴款查询
    APITypeApplyForTax, // 涉税信息 涉税申请查询
    APITypeApplyTaxCancel,  // 涉税信息 撤销涉税申请
    APITypeCreditRating,    // 涉税信息 纳税人信用等级查询
    
    APITypeQueryInvoiceOpenKpr,       // 获取开票人信息
    APITypeGetValidateCode, // 发票业务 获取发票查询验证码
    APITypeQueryInvoice,    // 发票业务 发票查询
    APITypeQueryCanReceiveInvoice, //邮寄发票 查询可领用发票信息

    APITypeIsApplyForEmailInvoice,  // 是否可申请邮寄发票
    APITypeTaxPayerDefAddress,      // 邮寄发票 默认地址获取
    APITypeTaxPayerAddressQuery,    // 地址管理 获取
    APITypeTaxPayerAddressInsert,   // 地址管理 增加
    APITypeTaxPayerAddressUpdate,   // 地址管理 修改
    APITypeTaxPayerAddressDelete,   // 地址管理 删除
    APITypeApplyForEmailInvoice,    // 邮寄发票 邮寄发票申请
    APITypeNingboDistricts,     // 邮寄发票 获取宁波市下属区
    APITypeTaxStationByDistricts,     // 邮寄发票 获取宁波市下属区税局信息
    
    APITypeInitXgmsb,   // 小规模申报初始化信息
    APITypeXgmsbPreview,// 小规模申报预览
    APITypeXgmsb,   // 小规模申报
    
    APITypeUserLogin,   // 用户登录
    APITypeUserActivate, //用户激活
    APITypeSecurityCode,    // 短信验证码
    APITypeUserUpdatePassword,   // 修改密码
    APITypeRunGuideMap,    // 办税地图
    APITypeBanner,  // banner
    APITypeCheckUpdate, // 检查更新
    
    
    APITypeCheckTaxerBook,       // 获取纳税人是否可以预约
    APITypeGetBookItemList,         // 获取可预约事项
    APITypeBookItemSepcFile,      // 获取可预约具体事项
    APITypeCheckInCompanyItem, // 获取办税网点信息
    
    APITypeDateBookItem, // 获取最大限制办税时间列表
    APITypeCheckBookTimeList, // 获取办税预约时间列表
    APITypeBookFunClick, // 预约按钮
    APITypeBookCancleClick, // 取消预约按钮
    
    APITypeCheckData, // 查看办理所需资料
    APITypeBooklistData, // 预约列表

};
