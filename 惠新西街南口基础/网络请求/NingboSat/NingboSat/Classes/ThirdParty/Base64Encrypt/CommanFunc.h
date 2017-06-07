//
//  CommanFunc.h
//  eTax
//
//  Created by 王会洲 on 16/5/9.
//  Copyright © 2016年 ysyc. All rights reserved.
//

#define __BASE64( text )        [CommanFunc base64StringFromText:text]
#define __TEXT( base64 )        [CommanFunc textFromBase64String:base64]

#import <Foundation/Foundation.h>

@interface CommanFunc : NSObject

/******************************************************************************
 函数名称 : + (NSString *)base64StringFromText:(NSString *)text
 函数描述 : 将文本转换为base64格式字符串
 输入参数 : (NSString *)text    文本
 输出参数 : N/A
 返回参数 : (NSString *)    base64格式字符串
 备注信息 :
 ******************************************************************************/
+ (NSString *)base64StringFromText:(NSString *)text;

/******************************************************************************
 函数名称 : + (NSString *)textFromBase64String:(NSString *)base64
 函数描述 : 将base64格式字符串转换为文本
 输入参数 : (NSString *)base64  base64格式字符串
 输出参数 : N/A
 返回参数 : (NSString *)    文本
 备注信息 :
 ******************************************************************************/
+ (NSString *)textFromBase64String:(NSString *)base64;

/******************************************************************************
 函数名称 :+ (NSData*) base64Decode:(NSString *)string;
 函数描述 : 将base64格式字符串转换为NSData
 输入参数 :
 输出参数 : N/A
 返回参数 : (NSData *)    对象
 备注信息 :
 ******************************************************************************/
+ (NSData*) base64Decode:(NSString *)string;

/******************************************************************************
 函数名称 :+ (NSString*) base64Encode:(NSData *)data;
 函数描述 : 将NSData格式转换为base64格式字符串
 输入参数 :
 输出参数 : N/A
 返回参数 : (NSData *)    对象
 备注信息 :
 ******************************************************************************/
+ (NSString*) base64Encode:(NSData *)data;



@end
