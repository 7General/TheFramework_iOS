//
//  SelectDateModel.m
//  NingboSat
//
//  Created by 王会洲 on 16/11/24.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "SelectDateModel.h"
#import "GetWeakDay.h"

@implementation SelectDateModel
-(instancetype)initWithDateModel:(NSDictionary *)dict {
    if (self = [self init]) {
        self.yyrq = dict[@"yyrq"];
        GetWeakDay * weakStr =  [[GetWeakDay alloc] init];
        self.weakStr = [weakStr calculateWeek:self.yyrq];
    }
    return self;
}

+(instancetype)dateModelWithDict:(NSDictionary *)dict {
    return  [[self alloc] initWithDateModel:dict];
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key {}


@end
