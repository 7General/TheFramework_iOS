//
//  CustomModel.m
//  LongFor
//
//  Created by ZZG on 17/5/19.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "CustomModel.h"

@implementation CustomModel

-(instancetype)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+(instancetype)customWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key {

}
@end

