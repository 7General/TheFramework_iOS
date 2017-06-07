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
//+ (void)requestWith:(APIType)urlFeature Param:(NSDictionary *)param Complete:(NetBlock)complete ShowOnView:(UIView *)view AnimationOption:(YSRequestAnimationState)animationOption;

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
    APITypeLogin, //用户登录
    APITypeCustomList, //获取客户列表
    APITypeCustomInfoList, // 获取客户详细信息列表
    APITypeGetNewEmployeeList, //查询公司/项目导航列表
    APITypeGetAddEnable,//查询项目下员工有无录入客户权限
    APITypeAddCustomerAllByTel,//录入客户手机号
    APITypeQueryCsLabelMoreInfo,//查询项目所有选择标签(客户录入)
    APITypeUpdateCustomerAll, //客户录入方法
    APITypeAddFollow, //增加跟进信息
    APITypeValueSingIn, //获取考勤点信息
    APITypeSingInAction, //上班签到
    APITypeSelectWorkRecord, //我的签到记录
    APITypeSelectWorkRecordListCount,//查询考勤记录条数
    APITypeUploadFile, //上传照片
    APITypeSingOutAction, //下班签退
    APITypeSelectWorkRecordByLeader //领导查询考勤记录
};
