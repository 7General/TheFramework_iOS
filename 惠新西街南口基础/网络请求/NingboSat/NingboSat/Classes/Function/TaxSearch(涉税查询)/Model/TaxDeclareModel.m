//
//  TaxDeclareModel.m
//  NingboSat
//
//  Created by ysyc_liu on 16/9/30.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "TaxDeclareModel.h"

@implementation TaxDeclareModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"levyProjectName" : @"levyProjectName",
             @"taxBelongTime" : @"taxBelongTime",
             @"taxOughtFillAmount" : @"taxOughtFillAmount",
             @"declareDate" : @"declareDate",
             };
}
@end
