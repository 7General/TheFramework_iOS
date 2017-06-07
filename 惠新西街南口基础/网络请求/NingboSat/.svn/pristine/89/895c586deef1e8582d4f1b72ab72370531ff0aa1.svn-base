
//
//  SelectBookTimeModel.m
//  NingboSat
//
//  Created by 王会洲 on 16/11/24.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "SelectBookTimeModel.h"

@implementation SelectBookTimeModel

-(instancetype)initWithSelectBookTimeModel:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.ids = [value integerValue];
    }
}

+(instancetype)selectBookTimeWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithSelectBookTimeModel:dict];
}





@end
