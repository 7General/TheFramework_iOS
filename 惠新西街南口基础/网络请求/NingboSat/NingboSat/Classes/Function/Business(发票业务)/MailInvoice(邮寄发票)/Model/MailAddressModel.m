//
//  MailAddressModel.m
//  NingboSat
//
//  Created by ysyc_liu on 16/9/14.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "MailAddressModel.h"

@implementation MailAddressModel

- (NSString *)shippingAddress {
    NSString * result = [NSString stringWithFormat:@"%@%@", self.address, self.desAddress ? self.desAddress : @""];
    return result;
}

- (void)setValueByModel:(MailAddressModel *)model {
    self.aid = model.aid;
    self.name = model.name;
    self.phone = model.phone;
    self.idType = model.idType;
    self.idNumber = model.idNumber;
    self.address = model.address;
    self.desAddress = model.desAddress;
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"aid" : @"id",
             @"name" : @"name",
             @"phone" : @"mobile",
             @"idType" : @"type",
             @"idNumber" : @"number",
             @"address" : @"district",
             @"desAddress" : @"address"
             };
}

+ (NSValueTransformer *)idTypeJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        if ([value isKindOfClass:[NSNumber class]]) {
            return [value stringValue];
        }
        else {
            return value;
        }
    }];
}

@end
