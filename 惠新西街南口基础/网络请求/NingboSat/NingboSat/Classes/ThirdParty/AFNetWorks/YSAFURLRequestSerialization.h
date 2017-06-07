//
//  YSAFURLRequestSerialization.h
//  FirstInvoice
//
//  Created by ysyc_liu on 16/3/25.
//  Copyright © 2016年 ysyc_wang. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

/**
 *  加密协议
 */
@protocol YSSerializerEncryption <NSObject>

@required
/**
 *  数据加密.
 *
 *  @param data 要加密的数据.
 *
 *  @return 加密后的数据.
 */
- (nonnull NSData *)Encryption:(nullable NSData *)data;

/**
 *  数据解密.
 *
 *  @param data 要解密的数据.
 *
 *  @return 解密后的数据.
 */
- (nonnull NSData *)Decryption:(nullable NSData *)data;

@end

/**
 *  可加密的序列化, 请求格式.适用于向服务端发送Json加密过的密文数据
 */
@interface YSAFJSONRequestSerializer : AFJSONRequestSerializer

/// 加密代理.
@property (nonatomic, weak, nullable)id<YSSerializerEncryption> encryptionDelegate;

@end
