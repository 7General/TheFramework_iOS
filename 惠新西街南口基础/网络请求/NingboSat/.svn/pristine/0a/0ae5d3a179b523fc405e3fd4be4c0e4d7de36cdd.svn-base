//
//  TaxerInfoModel.m
//  NingboSat
//
//  Created by ysyc_liu on 16/9/21.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "TaxerInfoModel.h"
@implementation TaxerItemZgrd

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"qualificationAffirm" : @"qualificationAffirm",
             };
}

@end

@implementation TaxerItemSzhd

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"declareTime" : @"declareTime",
             @"taxVouchAmount" : @"taxVouchAmount",
             @"taxLevyType" : @"taxLevyType",
             @"taxType" : @"taxType",
             @"taxItem" : @"taxItem",
             @"zsl" : @"zsl",
             };
}

@end

@implementation TaxerItemJbxx

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"nsrzglxmc" : @"nsrzglxmc",
             @"category" : @"category",
             @"registAddress" : @"registAddress",
             @"taxpayer_code" : @"taxpayer_code",
             @"financeOfficer" : @"financeOfficer",
             @"financeOfficerPhone" : @"financeOfficerPhone",
             @"legalPersonPhone" : @"legalPersonPhone",
             @"registration_type" : @"registration_type",
             @"taxStation" : @"taxStationCode",
             @"nsrztmc" : @"nsrztmc",
             @"legalPerson" : @"legalPerson",
             @"businessAddress" : @"businessAddress",
             };
}

@end

@implementation TaxerItemFphd

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"invoiceVouch" : @"invoiceVouch",
             @"fpzl_dm" : @"fpzl_dm",
             @"fpjc" : @"fpjc",
             };
}

@end

@implementation TaxerInfoModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"itemKphjxx" : @"itemKphjxx",
             @"itemDexx" : @"itemDexx",
             @"itemSzhd" : @"itemSzhd",
             @"itemJbxx" : @"Jbxx",
             @"itemFphd" : @"itemFphd",
             };
}

+ (NSValueTransformer *)itemSzhdJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        return [MTLJSONAdapter modelsOfClass:[TaxerItemSzhd class] fromJSONArray:value error:nil];
    }];
}
+ (NSValueTransformer *)itemJbxxJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        return [MTLJSONAdapter modelsOfClass:[TaxerItemJbxx class] fromJSONArray:value error:nil];
    }];
}
+ (NSValueTransformer *)itemFphdJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        return [MTLJSONAdapter modelsOfClass:[TaxerItemFphd class] fromJSONArray:value error:nil];
    }];
}

@end
