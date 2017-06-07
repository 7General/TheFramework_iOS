//
//  YSAFNetWorkManager.m
//  FirstInvoice
//
//  Created by ysyc_liu on 16/3/24.
//  Copyright © 2016年 ysyc_wang. All rights reserved.
//

#import "YSAFNetWorkManager.h"


NSString *const YSHTTPMethod                = @"YSHTTPMethod";
NSString *const YSRequestUrl                = @"YSRequestUrl";
NSString *const YSRequestHeaderField        = @"YSRequestHeaderField";
NSString *const YSRequestTimeoutInterval    = @"YSRequestTimeoutInterval";

NSString *const AttachmentsKey              = @"YSNetAttachmentsKey";

@interface AppendFormFileData()

@property (nonatomic, strong)NSString * fileDate;

@end

@implementation AppendFormFileData

- (instancetype)init {
    self = [super init];
    if (self) {
        NSDate * date = [NSDate date];
        NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        self.fileDate = [formatter stringFromDate:date];
    }
    return self;
}

- (void)setMineType:(YSFileType)mineType {
    _mineType = mineType;
    switch (mineType) {
        case YSFileTypePNG: {
            _mineTypeStr = @"image/png";
            _name = [NSString stringWithFormat:@"%@.png", self.fileDate];
            break;
        }
        case YSFileTypeJPEG: {
            _mineTypeStr = @"image/jpg";
            _name = [NSString stringWithFormat:@"%@.jpg", self.fileDate];
            break;
        }
        case YSFileTypeAudio: {
            _mineTypeStr = @"audio/mp3";
            _name = [NSString stringWithFormat:@"%@.mp3", self.fileDate];
        }
            //YSFileTypeAAC
        case YSFileTypeAAC: {
            _mineTypeStr = @"audio/caf";
            _name = [NSString stringWithFormat:@"%@.mp3", self.fileDate];
        }
        default:
            break;
    }
}

@end



@interface YSAFNetWorkManager()

@end

@implementation YSAFNetWorkManager

- (instancetype)init {
    self = [super init];
    if (self) {
        self.timeoutInterval = 30.0f;
        self.requestType    = YSRequestResponseTypeHttp;
        self.responseType   = YSRequestResponseTypeYSJson;
        self.HTTPMethodType = YSHTTPMethodTypePOST;
        [YSNetReachabilityManager defaultManager];
    }
    return self;
}

+ (instancetype)Manager {
    return [[self alloc] init];
}

- (void)setTimeoutInterval:(NSTimeInterval)timeoutInterval {
    if (timeoutInterval > 0) {
        _timeoutInterval = timeoutInterval;
    }
}

#pragma mark - initialize

/// 初始化`AFSManager`
- (void)initAFSManager {
    AFHTTPSessionManager * sessionManager = [AFHTTPSessionManager manager];
    switch (self.requestType) {
        case YSRequestResponseTypeHttp: {
            sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
            break;
        }
        case YSRequestResponseTypeJson: {
            sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
            break;
        }
        case YSRequestResponseTypeYSJson: {
            YSAFJSONRequestSerializer * requestSerializer = [YSAFJSONRequestSerializer serializer];
            requestSerializer.encryptionDelegate = self.Serializedelegate;
            sessionManager.requestSerializer = requestSerializer;
            
            break;
        }
        case YSRequestResponseTypeProperty: {
            sessionManager.requestSerializer = [AFPropertyListRequestSerializer serializer];
            break;
        }
        default:
            break;
    }
    
    switch (self.responseType) {
        case YSRequestResponseTypeHttp: {
            sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
            break;
        }
        case YSRequestResponseTypeJson: {
            sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
            break;
        }
        case YSRequestResponseTypeYSJson: {
            YSAFJSONResponseSerializer * responseSerializer = [YSAFJSONResponseSerializer serializer];
            responseSerializer.decryptionDelegate = self.Serializedelegate;
            sessionManager.responseSerializer = responseSerializer;
            break;
        }
        case YSRequestResponseTypeProperty: {
            sessionManager.responseSerializer = [AFPropertyListResponseSerializer serializer];
            break;
        }
        default:
            break;
    }
    
    self.AFSManager = sessionManager;
}

- (void)RequestUrlFeature:(APIType)urlFeature Param:(NSDictionary *)param Complete:(NetBlock)complete {
    
    // 计算时间, 当距离启动不超过1s内请求延时(延时是为了判断网络状态的管理类数据更新至设备当前状态).
    YSNetReachabilityManager * reachabilityManager = [YSNetReachabilityManager defaultManager];
     
    NSDate * dateNow = [NSDate date];
    NSDate * date = [NSDate dateWithTimeInterval:1 sinceDate:reachabilityManager.createDate];
    NSTimeInterval delay = [date timeIntervalSinceDate:dateNow];
    delay = delay > 0 ? delay : 0;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (![reachabilityManager isReachable]) {
            /**
             *  !!!网络不可连接
             */
            [self.delegate UnReachableAnimation];
            if (complete) {
                complete(YSResponseStatusUnReach, nil);
            }
            return;
        }
        
        /// 请求设置.
        [self initAFSManager];
        
        NSString * urlString = [self loadRequestSets:urlFeature other:param];
        id newParam = [self.delegate PreEncodeForParam:param Feature:urlFeature];
        [self printRequestUrl:urlString param:newParam];
        
        id animation = [self.delegate BeginWaitingAnimation];
        /// 发起请求.
        NSString * selectorName = [NSString stringWithFormat:@"%@:parameters:progress:success:failure:", (self.HTTPMethodType == YSHTTPMethodTypeGET) ? @"GET" : @"POST"];
        SEL selector = sel_registerName(selectorName.UTF8String);
        if (![self.AFSManager respondsToSelector:selector]) {
            return;
        }
        typedef void (^ProgressBlock)(NSProgress * _Nonnull);
        typedef void (^SuccessBlock)(NSURLSessionDataTask * _Nonnull, id _Nullable);
        typedef void (^FailureBlock)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull);
        
        IMP imp = [self.AFSManager methodForSelector:selector];
        NSURLSessionDataTask * (*function)(id, SEL, NSString *, id, ProgressBlock, SuccessBlock, FailureBlock) = (__typeof__(function))imp;
        
        function(self.AFSManager, selector, urlString, newParam, ^(NSProgress * _Nonnull uploadProgress) {
            
        }, ^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            [self.delegate EndWaitingAnimation:animation];
            YSResponseStatus status;
            if ([self.delegate isResponseSuccessful:responseObject]) {
                [self.delegate SuccessAnimation:responseObject];
                status = YSResponseStatusSuccess;
            }
            else {
                [self.delegate FailureAnimation:responseObject];
                status = YSResponseStatusFailure;
            }
            if (complete) {
                complete(status, responseObject);
            }
        }, ^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"----->%@",error);
            [self.delegate EndWaitingAnimation:animation];
            [self.delegate RequestErrorAnimation:error];
            if (complete) {
                complete(YSResponseStatusError, error);
            }
        });
    });
}

/**
 *  网络请求.(上传文件)
 *
 *  @param urlFeature   url相关参数.
 *  @param param        请求参数.
 *  @param complete     回调.
 */
- (void)uploadUrlFeature:(APIType)urlFeature Param:(NSDictionary *)param Complete:(NetBlock)complete {
    // 计算时间, 当距离启动不超过1s内请求延时(延时是为了判断网络状态的管理类数据更新至设备当前状态).
    YSNetReachabilityManager * reachabilityManager = [YSNetReachabilityManager defaultManager];
    NSDate * dateNow = [NSDate date];
    NSDate * date = [NSDate dateWithTimeInterval:1 sinceDate:reachabilityManager.createDate];
    NSTimeInterval delay = [date timeIntervalSinceDate:dateNow];
    delay = delay > 0 ? delay : 0;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (![reachabilityManager isReachable]) {
            /**
             *  !!!网络不可连接
             */
            [self.delegate UnReachableAnimation];
            if (complete) {
                complete(YSResponseStatusUnReach, nil);
            }
            return;
        }
        // 获取参数中的附件.
        NSArray * attachments = [param objectForKey:AttachmentsKey];
        NSMutableDictionary * paramDict = [NSMutableDictionary dictionaryWithDictionary:param];
        [paramDict removeObjectForKey:AttachmentsKey];
        id newParam = [self.delegate PreEncodeForParam:paramDict Feature:urlFeature];
        /// 请求设置.
        [self initAFSManager];
        NSString * urlString = [self loadRequestSets:urlFeature other:param];
        
        id animation = [self.delegate BeginWaitingAnimation];
        /// 发起请求.
        [self.AFSManager POST:urlString parameters:newParam constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            for (AppendFormFileData * file in attachments) {
                [formData appendPartWithFileData:file.data name:file.key fileName:file.name mimeType:file.mineTypeStr];
            }
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self.delegate EndWaitingAnimation:animation];
            YSResponseStatus status;
            if ([self.delegate isResponseSuccessful:responseObject]) {
                [self.delegate SuccessAnimation:responseObject];
                status = YSResponseStatusSuccess;
            }
            else {
                [self.delegate FailureAnimation:responseObject];
                status = YSResponseStatusFailure;
            }
            if (complete) {
                complete(status, responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self.delegate EndWaitingAnimation:animation];
            [self.delegate RequestErrorAnimation:error];
            if (complete) {
                complete(YSResponseStatusError, error);
            }
        }];
    });
}

- (void)RequestUrl:(NSString *)url Param:(NSDictionary *)param Complete:(NetBlock)complete {
    // 计算时间, 当距离启动不超过1s内请求延时(延时是为了判断网络状态的管理类数据更新至设备当前状态).
    YSNetReachabilityManager * reachabilityManager = [YSNetReachabilityManager defaultManager];
    NSDate * dateNow = [NSDate date];
    NSDate * date = [NSDate dateWithTimeInterval:1 sinceDate:reachabilityManager.createDate];
    NSTimeInterval delay = [date timeIntervalSinceDate:dateNow];
    delay = delay > 0 ? delay : 0;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (![reachabilityManager isReachable]) {
            /**
             *  !!!网络不可连接
             */
            [self.delegate UnReachableAnimation];
            if (complete) {
                complete(YSResponseStatusUnReach, nil);
            }
            return;
        }
        // 获取参数中的附件.
        NSArray * attachments = [param objectForKey:AttachmentsKey];
        NSMutableDictionary * paramDict = [NSMutableDictionary dictionaryWithDictionary:param];
        [paramDict removeObjectForKey:AttachmentsKey];
        id newParam = [self.delegate PreEncodeForParam:paramDict Feature:0];
        /// 请求设置.
        [self initAFSManager];
        
        [self printRequestUrl:url param:newParam];
        
        id animation = [self.delegate BeginWaitingAnimation];
        /// 发起请求.
        switch (self.HTTPMethodType) {
            case YSHTTPMethodTypePOST: {
                [self.AFSManager POST:url parameters:newParam constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                    for (AppendFormFileData * file in attachments) {
                        [formData appendPartWithFileData:file.data name:file.key fileName:file.name mimeType:file.mineTypeStr];
                    }
                } progress:^(NSProgress * _Nonnull uploadProgress) {
                    
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    [self.delegate EndWaitingAnimation:animation];
                    YSResponseStatus status;
                    if ([self.delegate isResponseSuccessful:responseObject]) {
                        [self.delegate SuccessAnimation:responseObject];
                        status = YSResponseStatusSuccess;
                    }
                    else {
                        [self.delegate FailureAnimation:responseObject];
                        status = YSResponseStatusFailure;
                    }
                    if (complete) {
                        complete(status, responseObject);
                    }
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    [self.delegate EndWaitingAnimation:animation];
                    [self.delegate RequestErrorAnimation:error];
                    if (complete) {
                        complete(YSResponseStatusError, error);
                    }
                }];
                break;
            }
                
            case YSHTTPMethodTypeGET: {
                [self.AFSManager GET:url parameters:newParam progress:^(NSProgress * _Nonnull uploadProgress) {
                    
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    [self.delegate EndWaitingAnimation:animation];
                    YSResponseStatus status;
                    if ([self.delegate isResponseSuccessful:responseObject]) {
                        [self.delegate SuccessAnimation:responseObject];
                        status = YSResponseStatusSuccess;
                    }
                    else {
                        [self.delegate FailureAnimation:responseObject];
                        status = YSResponseStatusFailure;
                    }
                    if (complete) {
                        complete(status, responseObject);
                    }
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    [self.delegate EndWaitingAnimation:animation];
                    [self.delegate RequestErrorAnimation:error];
                    if (complete) {
                        complete(YSResponseStatusError, error);
                    }
                }];
                break;
            }
                
            default: {
                [self.delegate EndWaitingAnimation:animation];
                if (complete) {
                    complete(YSResponseStatusError, nil);
                }
                break;
            }
        }
    });
}

#pragma mark -

/**
 *  设置请求头.
 *
 *  @param param 参数.
 */
- (void)setRequestHeadField:(NSDictionary *)param {
    for (id key in param.allKeys) {
        [self.AFSManager.requestSerializer setValue:param[key] forHTTPHeaderField:key];
    }
}

/**
 *  加载请求设置.
 *
 *  加载请求头、请求超时时长、以及证书
 *
 *  @param urlFeature url相关参数.
 *
 *  @return 完整url字符串.
 */
- (NSString *)loadRequestSets:(APIType)urlFeature other:(id)others {
    NSDictionary * requestDict = [self.delegate requestDictWithFeature:urlFeature other:others];
    NSString * urlString = [requestDict objectForKey:YSRequestUrl];
    [self setRequestHeadField:[requestDict objectForKey:YSRequestHeaderField]];
    
    self.timeoutInterval = [[requestDict objectForKey:YSRequestTimeoutInterval] floatValue];
    self.AFSManager.requestSerializer.timeoutInterval = self.timeoutInterval;
    
    NSNumber * httpMethod = [requestDict objectForKey:YSHTTPMethod];
    if (httpMethod) {
        self.HTTPMethodType = [httpMethod integerValue];
    }
    
    /// 添加证书.
    if ([self.delegate respondsToSelector:@selector(setSSLPinningModeCertificate:)]) {
        [self.delegate setSSLPinningModeCertificate:urlString];
    }
    
    return urlString;
}

#pragma mark - print request url

- (void)printRequestUrl:(NSString *)url param:(NSDictionary *)param {
    NSString * logStr = [url stringByAppendingString:@"?"];
    for (NSString * key in param.allKeys) {
        logStr = [logStr stringByAppendingFormat:@"%@=%@", key, param[key]];
        if (key != param.allKeys.lastObject) {
            logStr = [logStr stringByAppendingString:@"&"];
        }
    }
    NSLog(@"%@", logStr);
}

@end

/*------------------------------------------------------------------------------------------------
 ------------------------------------------------------------------------------------------------*/

@interface YSNetReachabilityManager()

@end

@implementation YSNetReachabilityManager

- (void)dealloc {
    [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self checkReachability];
        self.createDate = [NSDate date];
    }
    return self;
}

+ (instancetype)defaultManager {
    static YSNetReachabilityManager * s_defaultManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_defaultManager = [[self alloc] init];
    });
    return s_defaultManager;
}

- (void)checkReachability {
    AFNetworkReachabilityManager * manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        self.StateType = status;
    }];
    [manager startMonitoring];
    
    self.StateType = manager.networkReachabilityStatus;
}

- (BOOL)isReachable {
    return [AFNetworkReachabilityManager sharedManager].isReachable;
}

@end
