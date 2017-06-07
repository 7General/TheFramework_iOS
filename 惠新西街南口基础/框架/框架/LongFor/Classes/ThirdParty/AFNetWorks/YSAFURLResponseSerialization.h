//
//  YSAFURLResponseSerialization.h
//  FirstInvoice
//
//  Created by ysyc_liu on 16/3/25.
//  Copyright © 2016年 ysyc_wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YSAFURLRequestSerialization.h"

/**
 *  可解密的序列化, 响应格式.适用于服务端返回Json加密过的密文数据
 */
@interface YSAFJSONResponseSerializer : AFJSONResponseSerializer

/// 解密代理.
@property (nonatomic, weak, nullable)id<YSSerializerEncryption> decryptionDelegate;

@end
