//
//  NeedModel.m
//  LongFor
//
//  Created by ZZG on 17/5/31.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "NeedModel.h"

@implementation NeedModel

-(instancetype)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        self.intentIonBiz = dict[@"intentIonBiz"];
        self.intentIonAread = dict[@"intentIonAread"];
        self.roomNum = [dict[@"roomNum"] integerValue];
        self.houseBit = dict[@"houseBit"];
        self.face = dict[@"face"];
        self.redecorated = dict[@"redecorated"];
    }
    return self;

}

+(instancetype)needModeDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

@end
