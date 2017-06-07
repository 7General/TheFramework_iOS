//
//  NewInvoiceModel.m
//  NingboSat
//
//  Created by ysyc_liu on 16/9/19.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "NewInvoiceModel.h"

@implementation NewInvoiceModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"type" : @"fpzldm",
             @"name" : @"fpzlmc",
             @"maxNumber" : @"lgsl",
             @"number" : @"klgfs",
             };
}

+ (NSValueTransformer *)numberJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        if ([value isKindOfClass:[NSString class]]) {
            return value;
        }
        return nil;
    }];
}


- (id)mutableCopyWithZone:(nullable NSZone *)zone {
    NewInvoiceModel *model = [[NewInvoiceModel alloc] init];
    model.type = self.type;
    model.name = self.name;
    model.maxNumber = self.maxNumber;
    model.number = self.number;
    return model;
}

- (void)addNumberWithModel:(NewInvoiceModel *)model {
    NSInteger number1 = self.number.integerValue;
    NSInteger number2 = model.number.integerValue;
    NSInteger maxNum = self.maxNumber.integerValue;
    NSInteger sum = number1 + number2;
    if (sum > maxNum) {
        sum = maxNum;
    }
    self.number = [NSString stringWithFormat:@"%ld", (long)sum];
}

@end
