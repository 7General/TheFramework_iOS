//
//  RelativeModel.m
//  LongFor
//
//  Created by ZZG on 17/5/31.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "RelativeModel.h"

@implementation RelativeModel
-(instancetype)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        self.names = dict[@"customerName"];
        self.tel = dict[@"tel"];
        self.zjlx = dict[@"cardtype"];
        self.zjhm = dict[@"cardid"];
        self.xb = dict[@"gender"];
    }
    return self;
}

+(instancetype)relativeModel:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

@end
