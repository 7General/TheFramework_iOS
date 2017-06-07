//
//  BookModel.m
//  NingboSat
//
//  Created by 王会洲 on 16/11/29.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "BookModel.h"

@implementation BookModel
-(instancetype)initWithModelDic:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}


+(instancetype)bookModelWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithModelDic:dict];
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.ids = [value integerValue];
    }

}

@end
