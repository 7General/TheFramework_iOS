//
//  BookSpecMdoel.m
//  NingboSat
//
//  Created by 王会洲 on 16/11/21.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "BookSpecMdoel.h"

@implementation BookSpecMdoel
-(instancetype)initBookSepc:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+(instancetype)bookSpecModelWithDict:(NSDictionary *)dict {
    return [[self alloc] initBookSepc:dict];
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.ids = [value integerValue];
    }
}

@end
