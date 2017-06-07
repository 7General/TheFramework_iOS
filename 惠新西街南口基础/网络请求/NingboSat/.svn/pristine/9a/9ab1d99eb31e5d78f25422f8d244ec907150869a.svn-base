//
//  YSAFURLRequestSerialization.m
//  FirstInvoice
//
//  Created by ysyc_liu on 16/3/25.
//  Copyright © 2016年 ysyc_wang. All rights reserved.
//

#import "YSAFURLRequestSerialization.h"

@implementation YSAFJSONRequestSerializer

/**
 *  参数序列化并加进请求里.
 *
 *  参数会转化成Json格式字符串后加密, 如果不能转为Json, 则以原文来加密.
 *
 *  @param request    请求.
 *  @param parameters 参数.
 *  @param error      错误.
 *
 *  @return 加参数后的请求.
 */
- (NSURLRequest *)requestBySerializingRequest:(NSURLRequest *)request
                               withParameters:(id)parameters
                                        error:(NSError *__autoreleasing *)error
{
    NSParameterAssert(request);
    
    if ([self.HTTPMethodsEncodingParametersInURI containsObject:[[request HTTPMethod] uppercaseString]]) {
        return [super requestBySerializingRequest:request withParameters:parameters error:error];
    }
    
    NSMutableURLRequest *mutableRequest = [request mutableCopy];
    
    [self.HTTPRequestHeaders enumerateKeysAndObjectsUsingBlock:^(id field, id value, BOOL * __unused stop) {
        if (![request valueForHTTPHeaderField:field]) {
            [mutableRequest setValue:value forHTTPHeaderField:field];
        }
    }];
    
    if (parameters) {
        NSData * httpBody = nil;
        BOOL isEncrypt = NO;
        @try {
            httpBody = [NSJSONSerialization dataWithJSONObject:parameters options:self.writingOptions error:error];
        } @catch (NSException *exception) {
            httpBody = [[NSString stringWithFormat:@"%@", parameters] dataUsingEncoding:NSUTF8StringEncoding];
        } @finally {
            if ([self.encryptionDelegate respondsToSelector:@selector(Encryption:)]) {
                NSData *  newHttpBody = [self.encryptionDelegate Encryption:httpBody];
                isEncrypt = ![newHttpBody isEqualToData:httpBody];
            }
            [mutableRequest setHTTPBody:httpBody];
            NSString * content_type = isEncrypt ? @"text/plain" : @"application/json";
            if (![mutableRequest valueForHTTPHeaderField:@"Content-Type"]) {
                [mutableRequest setValue:content_type forHTTPHeaderField:@"Content-Type"];
            }
        }
    }
    
    return mutableRequest;
}
@end
