//
//  MoreData.m
//  LongFor
//
//  Created by ZZG on 17/5/25.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "MoreData.h"

@interface MoreData()


@end

@implementation MoreData



-(instancetype)initWithText:(NSString *)text forData:(NSString *)data forSatate:(NSString *)state {
    self = [super init];
    if (self) {
        self.itemText = text;
        self.itemState = state;
        self.itemData = data;
    }
    return self;
}

+(instancetype)moreData:(NSString *)text forData:(NSString *)data  forSatae:(NSString *)states {
    return [[self alloc] initWithText:text forData:data forSatate:states];
}

@end
