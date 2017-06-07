//
//  TaxStationModel.m
//  NingboSat
//
//  Created by ysyc_liu on 16/9/19.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "TaxStationModel.h"

@implementation TaxStationModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"time" : @"time",
             @"address" : @"address",
             @"name" : @"name",
             @"district" : @"district",
             @"code" : @"code",
             };
}
@end
