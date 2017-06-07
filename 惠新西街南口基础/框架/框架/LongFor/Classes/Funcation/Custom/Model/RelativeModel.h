//
//  RelativeModel.h
//  LongFor
//
//  Created by ZZG on 17/5/31.
//  Copyright © 2017年 admin. All rights reserved.
//
/*! 关系客户model */
#import <Foundation/Foundation.h>

@interface RelativeModel : NSObject
/*! 客户姓名 */
@property (nonatomic, strong) NSString *names;
/*! 客户电话 */
@property (nonatomic, strong) NSString *tel;
/*! 证件类型 */
@property (nonatomic, strong) NSString *zjlx;
/*! 证件号码 */
@property (nonatomic, strong) NSString *zjhm;
/*! 性别 */
@property (nonatomic, strong) NSString *xb;

+(instancetype)relativeModel:(NSDictionary *)dict;


@end
