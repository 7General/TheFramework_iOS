//
//  NSObject+InputFormatCheck.m
//  NingboSat
//
//  Created by ysyc_liu on 2016/11/5.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "NSObject+InputFormatCheck.h"

@implementation NSObject (InputFormatCheck)

+ (BOOL)CheckPhone:(NSString *)phoneNum {
    if (!phoneNum) {
        return NO;
    }
    NSString *regex =@"1\\d{10}";
    NSPredicate *mobileTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [mobileTest evaluateWithObject:phoneNum];
}

@end
