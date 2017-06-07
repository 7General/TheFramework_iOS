//
//  httpUrlEncrypt.h
//  eTax
//
//  Created by TianGuang on 14-3-25.
//  Copyright (c) 2014年 YSYC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface httpUrlEncrypt : NSObject

+(NSArray *)compareSortArray:(NSArray *)array;

+(NSDictionary *)UrlEncrypt:(NSDictionary *)dic;

//云平台乱码问题解决-----------
+(NSDictionary *)UrlEncryptForCloud:(NSDictionary *)dic;

@end
