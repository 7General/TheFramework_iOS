//
//  NSString+Helper.m
//  NingboSat
//
//  Created by 王会洲 on 16/9/8.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "NSString+Helper.h"

@implementation NSString (Helper)

- (NSString *)URLEvalutionEncoding {
    NSString * result = (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault,
                                                                                              (CFStringRef)self,
                                                                                              NULL,
                                                                                              (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                              kCFStringEncodingUTF8 );
    return result;
    
}


- (NSString *)URLDecoding {
    return [self stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}
@end
