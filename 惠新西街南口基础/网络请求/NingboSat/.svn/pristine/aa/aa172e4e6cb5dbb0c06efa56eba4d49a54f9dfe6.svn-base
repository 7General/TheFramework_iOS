//
//  BMKShapeHelper.m
//  NingboSat
//
//  Created by 王会洲 on 16/9/26.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "BMKShapeHelper.h"

@implementation BMKShapeHelper

+(instancetype)BMKShapeHelper:(NSString *)title sub:(NSString *)subTitle coordinate:(CLLocationCoordinate2D)coordinate busData:(id )busyState {
    return  [[self alloc] initBMKShape:title sub:subTitle coordinate:coordinate busData:busyState];
}

-(instancetype)initBMKShape:(NSString *)title sub:(NSString *)subTitle coordinate:(CLLocationCoordinate2D)coordinate busData:(id)busyState {
    if (self = [super init]) {
        self.Htitle = title;
        self.Hsubtitle = subTitle;
        _Hcoordinate = coordinate;
        self.customDict = busyState;
    }
    return self;
}

-(NSString *)title {
    return self.Htitle;
    
}
-(NSString *)subtitle {
    return self.Hsubtitle;
}
-(CLLocationCoordinate2D)coordinate {
    return self.Hcoordinate;
}


@end
