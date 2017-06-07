//
//  SecurityUtil.h
//  NingboSat
//
//  Created by 王会洲 on 16/9/8.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SecurityUtil : NSObject

#pragma mark - base64
+ (NSString*)encodeBase64String:(NSString *)input;
+ (NSString*)decodeBase64String:(NSString *)input;

+ (NSString*)encodeBase64Data:(NSData *)data;
+ (NSString*)decodeBase64Data:(NSData *)data;

#pragma mark - AES加密
//将string转成带密码的data
+ (NSString*)encryptAESData:(NSString*)string KeyWord:(NSString *) key;
//将带密码的data转成string
+ (NSString*)decryptAESData:(NSString*)string KeyWord:(NSString *) key;



@end
