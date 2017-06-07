//
//  NeedModel.h
//  LongFor
//
//  Created by ZZG on 17/5/31.
//  Copyright © 2017年 admin. All rights reserved.
//
/*! 客户需求 */
#import <Foundation/Foundation.h>

@interface NeedModel : NSObject
/*! 意向业态 */
@property (nonatomic, strong) NSString *intentIonBiz;
/*! 面积段 */
@property (nonatomic, strong) NSString *intentIonAread;
/*! 居室数量 */
@property (nonatomic, assign) NSInteger roomNum;
/*! 户位 */
@property (nonatomic, strong) NSString *houseBit;
/*! 朝向 */
@property (nonatomic, strong) NSString *face;
/*! 装修 */
@property (nonatomic, strong) NSString *redecorated;

+(instancetype)needModeDict:(NSDictionary *)dict;

@end
