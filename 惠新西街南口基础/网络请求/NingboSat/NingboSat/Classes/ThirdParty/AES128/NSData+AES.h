//
//  NSData+AES.h
//  NingboSat
//
//  Created by 王会洲 on 16/9/8.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NSString;

@interface NSData (Encryption)

- (NSData *)AES128EncryptWithKey:(NSString *)key gIv:(NSString *)Iv;   //加密
- (NSData *)AES128DecryptWithKey:(NSString *)key gIv:(NSString *)Iv;   //解密

@end
