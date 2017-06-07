//
//  NSDictionary+JSONParam.m
//  NingboSat
//
//  Created by ysyc_liu on 16/9/26.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "NSDictionary+JSONParam.h"

@implementation NSDictionary (JSONParam)

- (NSString *)JSONParamString {
    NSDictionary *dict = [[self class] Base64Object:self];
    return [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:dict options:0 error:nil] encoding:NSUTF8StringEncoding];
}

+ (NSDictionary *)Base64Dictionary:(NSDictionary *)dict {
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    for (NSString *key in dict.allKeys) {
        NSObject *value = dict[key];
        NSObject *base64Value = [self Base64Object:value];
        if (nil == base64Value) {
            continue;
        }
        [result setValue:base64Value forKey:key];
    }
    return result;
}

+ (NSArray *)Base64Array:(NSArray *)array {
    NSMutableArray *result = [NSMutableArray array];
    for (NSObject *value in array) {
        NSObject *base64Value = [self Base64Object:value];
        if (nil == base64Value) {
            continue;
        }
        [result addObject:base64Value];
    }
    
    return result;
}

+ (id)Base64Object:(NSObject *)object {
    if ([object isKindOfClass:[NSDictionary class]]) {
        return [self Base64Dictionary:(NSDictionary *)object];
    }
    else if ([object isKindOfClass:[NSArray class]]) {
        return [self Base64Array:(NSArray *)object];
    }
    else if ([object isKindOfClass:[NSString class]]) {
        return [[(NSString *)object dataUsingEncoding:NSUTF8StringEncoding] base64EncodedStringWithOptions:0];
    }
    else if ([object isKindOfClass:[NSNumber class]]) {
        return [[[(NSNumber *)object stringValue] dataUsingEncoding:NSUTF8StringEncoding] base64EncodedStringWithOptions:0];
    }
    else {
        return object;
    }
}

@end
