//
//  RequestBase.m
//  PlanC
//
//  Created by ysyc_liu on 16/8/29.
//  Copyright © 2016年 ysyc_wang. All rights reserved.
//

#import "RequestBase.h"
#import "URLSwitchManager.h"
#import "httpUrlEncrypt.h"
#import "YSProgressHUD.h"

@implementation RequestBase

@synthesize animatedView;

+ (instancetype)Manager {
    RequestBase * manager = [[RequestBase alloc] init];
    manager.delegate = manager;
    // 请求加密
    manager.Serializedelegate = manager;
    manager.requestType = YSRequestResponseTypeHttp;
    manager.responseType = YSRequestResponseTypeYSJson;
    return manager;
}

+ (void)requestWith:(APIType)urlFeature Param:(NSDictionary *)param Complete:(NetBlock)complete ShowOnView:(UIView *)view AnimationOption:(YSRequestAnimationState)animationOption {
    // 此处不能用RequestBase的单例对象, 因为 NetWorkManager 会将代理设置成该对象, 当有多个 NetWorkManager 请求时候, 需要有多个不同的代理对象.
    RequestBase * requestManager = [RequestBase Manager];
    requestManager.animatedView = view;
    requestManager.animationOption = animationOption;
    [requestManager RequestUrlFeature:urlFeature Param:param Complete:^(YSResponseStatus status, id object) {
        if (complete) {
            @try {
                complete(status, object);
            } @catch (NSException *exception) {
                NSLog(@"[EXCEPTION]%@ APIType %@ : %@", [self class], @(urlFeature), exception);
            }
        }
    }];
}

+ (void)requestWith:(APIType)urlFeature Param:(NSDictionary *)param Complete:(NetBlock)complete ShowOnView:(UIView *)view {
    YSRequestAnimationState animationOption = YSRequestAnimationStateWait | YSRequestAnimationStateFailure | YSRequestAnimationStateError | YSRequestAnimationStateUnReach;
    [self requestWith:urlFeature Param:param Complete:complete ShowOnView:view AnimationOption:animationOption];
}

+ (void)uploadUrlFeature:(APIType)urlFeature Param:(NSDictionary *)param Complete:(NetBlock)complete ShowOnView:(UIView *)view AnimationOption:(YSRequestAnimationState)animationOption {
    RequestBase * requestManager = [RequestBase Manager];
    requestManager.animatedView = view;
    requestManager.animationOption = animationOption;
    [requestManager uploadUrlFeature:urlFeature Param:param Complete:complete];
}

+ (void)uploadUrlFeature:(APIType)urlFeature Param:(NSDictionary *)param Complete:(NetBlock)complete ShowOnView:(UIView *)view {
    RequestBase * requestManager = [RequestBase Manager];
    requestManager.animatedView = view;
    requestManager.animationOption = YSRequestAnimationStateWait | YSRequestAnimationStateFailure | YSRequestAnimationStateError | YSRequestAnimationStateUnReach;
    [requestManager uploadUrlFeature:urlFeature Param:param Complete:complete];
}

/**
 *  请求(仅供测试).
 *
 *  @param url        请求地址.
 *  @param param      参数.
 *  @param complete   完成回调.
 */
+ (void)requestWith:(NSString *)url Param:(NSDictionary *)param Complete:(NetBlock)complete {
    RequestBase * requestManager = [RequestBase Manager];
    requestManager.animationOption = YSRequestAnimationStateNone;
    [requestManager RequestUrl:url Param:param Complete:complete];
}

#pragma mark - YSSerializerEncryption
/**
 *  加密方法实现, 仅在请求类型为`YSRequestResponseTypeYSJson`时有效.
 *
 *  @param data 待加密数据.
 *
 *  @return 加密后数据.
 */
- (nonnull NSData *)Encryption:(nullable NSData *)data {
    
    return data;
}

/**
 *  解密方法实现, 仅在响应类型为`YSAFJSONResponseSerializer`时有效.
 *
 *  @param data 待解密数据.
 *
 *  @return 解密后数据.
 */
- (nonnull NSData *)Decryption:(nullable NSData *)data {
    
    return data;
}

#pragma mark - YSAFNetWorkManagerDelegate

/**
 *  参数预加密处理.
 *
 *  参数有不同加密格式, 复写该函数来实现.
 *  1. 含有key "act" 的参数.
 *
 *  @param param 参数.
 *
 *  @return 处理后的参数.
 */
- (id)PreEncodeForParam:(id)param Feature:(APIType)feature {
    if (feature == APITypeUserLogin ) {
        NSMutableDictionary * newParam = [NSMutableDictionary dictionaryWithDictionary:param];
        newParam = [NSMutableDictionary dictionaryWithDictionary:[httpUrlEncrypt UrlEncrypt:newParam]];
        return newParam;
    }
    return param;
}

- (BOOL)isResponseSuccessful:(id)responseObject {
    return ([[responseObject valueForKey:@"code"] intValue] == 0);
}

- (NSDictionary *)requestDictWithFeature:(APIType)feature other:(id)others {
    // 获取请求Url.
    NSString * urlString = [self urlStringByFeature:feature other:others];
    // 默认请求方式为Post.
    NSNumber * httpMethod = [NSNumber numberWithInteger:YSHTTPMethodTypePOST];
    
    // 当接口有特定的请求方式或者请求头, 在switch语句中添加.
    NSMutableDictionary * headerField = nil;
    NSNumber *  timeoutInterval = nil;
    switch (feature) {
        case APITypeNone: {
            
            break;
        }
        case APITypeApplyForEmailInvoice: {
            timeoutInterval = @(60.0);
        }
        default:
            break;
    }
    
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    if (httpMethod) {
        [dict setObject:httpMethod forKey:YSHTTPMethod];
    }
    if (urlString) {
        [dict setObject:urlString forKey:YSRequestUrl];
    }
    if (headerField) {
        [dict setObject:headerField forKey:YSRequestHeaderField];
    }
    if (timeoutInterval) {
        [dict setObject:timeoutInterval forKey:YSRequestTimeoutInterval];
    }
    
    return dict;
}

/**
 *
 *
 *  @param feature 根据接口类型生成请求相关Url.
 *
 *  @return 请求接口的Url.
 */
- (NSString *)urlStringByFeature:(APIType)feature other:(id)others{
    return [URLSwitchManager getUrlByFeature:feature];
}

#pragma mark - animation
- (id)BeginWaitingAnimation {
    if ((self.animationOption & (0x1 << 0))) {
        NSLog(@"BeginWaitingAnimation");
        return [YSProgressHUD showHUDOnView:self.animatedView];
    }
    return nil;
}

- (void)EndWaitingAnimation:(id)object {
    if ((self.animationOption & (0x1 << 0))) {
        NSLog(@"EndWaitingAnimation");
        [(YSProgressHUD *)object hide:YES];
    }
}

- (void)SuccessAnimation:(id)responseObject {
    if ((self.animationOption & (0x1 << 1))) {
        NSLog(@"SuccessAnimation");
        NSString * message = [responseObject valueForKey:@"message"];
        if (message.length > 0) {
            [YSProgressHUD showSuccessHUDOnView:self.animatedView Message:message];
        }
    }
}

- (void)FailureAnimation:(id)responseObject {
    if ((self.animationOption & (0x1 << 2))) {
        NSLog(@"FailureAnimation");
        NSString * message = [responseObject valueForKey:@"message"];
        if (message.length > 0) {
            [YSProgressHUD showErrorHUDOnView:self.animatedView Message:message];
        }
    }
}

- (void)RequestErrorAnimation:(NSError *)error {
    if ((self.animationOption & (0x1 << 3))) {
        NSLog(@"RequestErrorAnimation");
        NSString * errorMsg = nil;
        if (error.code == -1001) { // 请求超时.
            errorMsg = @"网络请求超时, 请重试.";
        }
        else {
            errorMsg = @"网络请求出错了.";
        }
        if (errorMsg.length > 0) {
            [YSProgressHUD showErrorHUDOnView:self.animatedView Message:errorMsg];
        }
    }
}

- (void)UnReachableAnimation {
    if ((self.animationOption & (0x1 << 4))) {
        NSLog(@"UnReachableAnimation");
        [YSProgressHUD showErrorHUDOnView:self.animatedView Message:@"网络连接暂时不可用."];
    }
}



/**
 *  设置证书验证.
 */
- (void)setSSLPinningModeCertificate:(NSString *)urlStr {
    if ([urlStr hasPrefix:@"https://ydbs.nb-n-tax.gov.cn:7001/"]) {
//        NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"gsAppMobile" ofType:@"cer"];//证书的路径
//        NSData *certData = [NSData dataWithContentsOfFile:cerPath];
//        AFSecurityPolicy * securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
//        securityPolicy.pinnedCertificates = nil;//[NSSet setWithObject:certData];
//        self.AFSManager.securityPolicy = securityPolicy;
        self.AFSManager.securityPolicy.allowInvalidCertificates = YES;
        self.AFSManager.securityPolicy.validatesDomainName = NO;
        
        self.AFSManager.requestSerializer.cachePolicy=NSURLRequestReloadIgnoringLocalCacheData;
    }
}

@end
