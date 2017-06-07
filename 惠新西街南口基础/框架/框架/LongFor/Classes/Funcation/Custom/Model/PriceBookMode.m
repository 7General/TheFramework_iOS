//
//  PriceBookMode.m
//  LongFor
//
//  Created by ZZG on 17/5/31.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "PriceBookMode.h"

@implementation PriceBookMode

-(instancetype)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        self.djys = dict[@"unitPric"];
        self.dfcs = dict[@"visitTime"];
        self.dbjzlp = dict[@"contrasteState"];
        self.zykx = dict[@"mainHoldout"];
    }
    return self;
}

+(instancetype)priceBookMode:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}
@end
