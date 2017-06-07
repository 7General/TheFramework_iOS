//
//  YSAFNetWorkManager.h
//  FirstInvoice
//
//  Created by ysyc_liu on 16/3/24.
//  Copyright © 2016年 ysyc_wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import "YSAFURLRequestSerialization.h"
#import "YSAFURLResponseSerialization.h"

#pragma mark - FOUNDATION_EXPORT.
// 请求中涉及的参数(代理类中添加).如果出现代理和`YSAFNetWorkManager`对象的属性同时设置, 则以代理设置为准.
FOUNDATION_EXPORT NSString *const YSHTTPMethod;
FOUNDATION_EXPORT NSString *const YSRequestUrl;
FOUNDATION_EXPORT NSString *const YSRequestHeaderField;
FOUNDATION_EXPORT NSString *const YSRequestTimeoutInterval;

#pragma mark - ENUM & typedef.
/// 请求接口枚举类型声明.(注意:具体类型需要在子类定义!).
typedef NS_ENUM(NSInteger, APIType);

/**
 *  请求方式类型.
 */
typedef NS_ENUM(NSInteger, YSHTTPMethodType) {
    /// POST方式.
    YSHTTPMethodTypePOST = 0,
    /// GET方式.
    YSHTTPMethodTypeGET  = 1
};

/**
 *  请求响应类型.
 */
typedef NS_ENUM(NSInteger, YSRequestResponseType) {
    /// 对应`AFHTTPRequestSerializer` 与 `AFHTTPResponseSerializer`.
    YSRequestResponseTypeHttp = 0,
    /// 对应`AFJSONRequestSerializer` 与 `AFJSONResponseSerializer`.
    YSRequestResponseTypeJson,
    /// 对应`YSAFJSONRequestSerializer` 与 `YSAFJSONResponseSerializer`.
    YSRequestResponseTypeYSJson,
    
    YSRequestResponseTypeProperty,
};

/// 请求响应状态.
typedef NS_ENUM(NSInteger, YSResponseStatus) {
    /// 请求成功,返回"正确".
    YSResponseStatusSuccess = 0,
    /// 请求成功,返回"错误".
    YSResponseStatusFailure,
    /// 请求失败.
    YSResponseStatusError,
    /// 网络连接不可用.
    YSResponseStatusUnReach,
};

typedef void (^NetBlock)(YSResponseStatus status, id object);

/*------------------------------------------------------------------------------------------------
 ------------------------------------------------------------------------------------------------*/

#pragma mark - protocol.
/**
 *  YSAFNetWorkManager代理协议.
 */
@protocol YSAFNetWorkManagerDelegate <NSObject>

/// 等待动画所在的视图.
@property (nonatomic, weak)UIView * animatedView;

@required

/**
 *  参数预加密处理.
 *
 *  @param param 参数.
 *
 *  @return 处理后的参数.
 */
- (id)PreEncodeForParam:(id)param Feature:(APIType)feature;

/**
 *  判断成功请求返回的值是否正确.
 *
 *  @param responseObject 返回值.
 *
 *  @return YES / NO.
 */
- (BOOL)isResponseSuccessful:(id)responseObject;

/**
 *  根据接口类型生成请求相关Url及请求头表.
 *
 *  @param feature 请求接口类型.
 *  @param others  请求接口所需额外参数.
 *
 *  @return 字典对象,其内容格式须为:
 *  `{YSRequestUrl:Url, YSRequestHeaderField:请求头表(字典对象), YSRequestTimeoutInterval:@10}`.
 */
- (NSDictionary *)requestDictWithFeature:(APIType)feature other:(id)others;

@optional

/**
 *  设置证书验证.
 */
- (void)setSSLPinningModeCertificate:(NSString *)urlStr;

#pragma mark - Animation
/*************************
 *  下边是一些动画处理函数.  *
 *************************/

/**
 *  开始等待动画.
 *
 *  @return 动画对象.
 */
- (id)BeginWaitingAnimation;

/**
 *  结束等待动画.
 *
 *  @param object 动画对象.
 */
- (void)EndWaitingAnimation:(id)object;

/**
 *  请求成功且返回值正确时的动画.
 *
 *  @param responseObject 请求返回值.
 */
- (void)SuccessAnimation:(id)responseObject;

/**
 *  请求成功且返回值失败时的动画.
 *
 *  @param responseObject 请求返回值.
 */
- (void)FailureAnimation:(id)responseObject;

/**
 *  请求失败时的动画.
 *
 *  @param error 错误信息.
 */
- (void)RequestErrorAnimation:(NSError *)error;

/**
 *  网络不可连接时的动画或处理.
 */
- (void)UnReachableAnimation;

@end

/*------------------------------------------------------------------------------------------------
  ------------------------------------------------------------------------------------------------*/
#pragma mark - 附件类.

FOUNDATION_EXPORT NSString *const AttachmentsKey;

typedef NS_ENUM(NSInteger, YSFileType) {
    YSFileTypePNG = 1,
    YSFileTypeJPEG,
    YSFileTypeAudio,
    YSFileTypeAAC,
};
/**
 *  附件文件.放在数组里, 之后放到参数里实现上传附件.
 *  !!备注:需要添加附件,必须在参数中以@{...,AttachmentsKey:@[AppendFormFileData,...],...} 格式.
 */
@interface AppendFormFileData : NSObject
/// 文件数据.
@property (nonatomic, copy)NSData * data;
/// 文件参数key.
@property (nonatomic, copy)NSString * key;
/// 文件枚举类型.
@property (nonatomic)YSFileType mineType;
/// 文件名.
@property (nonatomic, readonly)NSString * name;
/// 文件类型.
@property (nonatomic, readonly)NSString * mineTypeStr;

@end

/*------------------------------------------------------------------------------------------------
 ------------------------------------------------------------------------------------------------*/

#pragma mark - interface.
/**
 *  网络请求管理类.
 */
@interface YSAFNetWorkManager : NSObject

/// 请求超时时间(s), defult is 20.0 s.
@property (nonatomic)NSTimeInterval timeoutInterval;

/// 请求内容类型.
@property (nonatomic)YSRequestResponseType requestType;

/// 响应内容类型.
@property (nonatomic)YSRequestResponseType responseType;

/// 请求方式.默认为POST.
@property (nonatomic)YSHTTPMethodType HTTPMethodType;

/// 代理.
@property (nonatomic, weak)id<YSAFNetWorkManagerDelegate> delegate;

/// 请求加密代理.
@property (nonatomic, weak)id<YSSerializerEncryption> Serializedelegate;

/// 请求管理.
@property (nonatomic, strong)AFHTTPSessionManager * AFSManager;

/**
 *  创建`YSAFNetWorkManager`管理对象.
 *
 *  @return 管理对象.
 */
+ (instancetype)Manager;

/**
 *  网络请求.
 *
 *  @param urlFeature   url相关参数.
 *  @param param        请求参数.
 *  @param complete     回调.
 */
- (void)RequestUrlFeature:(APIType)urlFeature Param:(NSDictionary *)param Complete:(NetBlock)complete;

/**
 *  网络请求.(上传文件)
 *
 *  @param urlFeature   url相关参数.
 *  @param param        请求参数.
 *  @param complete     回调.
 */
- (void)uploadUrlFeature:(APIType)urlFeature Param:(NSDictionary *)param Complete:(NetBlock)complete;

/**
 *  网络请求.
 *
 *  @param url          url.
 *  @param param        请求参数.
 *  @param complete     回调.
 */
- (void)RequestUrl:(NSString *)url Param:(NSDictionary *)param Complete:(NetBlock)complete;

@end

/*------------------------------------------------------------------------------------------------
 ------------------------------------------------------------------------------------------------*/

/**
 *  监听网络状态.
 */
@interface YSNetReachabilityManager : NSObject

/// 网络状态.
@property (nonatomic)AFNetworkReachabilityStatus StateType;

/// 对象创建时间.
@property (nonatomic, strong)NSDate * createDate;

/// 网络是否可用.
- (BOOL)isReachable;

/// 单例对象.
+ (instancetype)defaultManager;

@end
