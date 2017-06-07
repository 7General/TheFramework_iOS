//
//  PriceBookMode.h
//  LongFor
//
//  Created by ZZG on 17/5/31.
//  Copyright © 2017年 admin. All rights reserved.
//

/*! 单价预算 */
#import <Foundation/Foundation.h>

@interface PriceBookMode : NSObject
/*! 单价预算 */
@property (nonatomic, strong) NSString *djys;
/*! 到访次数 */
@property (nonatomic, strong) NSString *dfcs;
/*! 对比竞争楼盘 */
@property (nonatomic, strong) NSString *dbjzlp;
/*! 主要抗性 */
@property (nonatomic, strong) NSString *zykx;
+(instancetype)priceBookMode:(NSDictionary *)dict;

@end
