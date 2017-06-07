//
//  NSString+Sigment.m
//  NingboSat
//
//  Created by 王会洲 on 16/9/26.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "NSString+Sigment.h"

@implementation NSString (Sigment)

- (CGSize)heightWithFont:(UIFont *)Font width:(CGFloat)width {
    return [self heightWithFont:Font width:width linebreak:NSStringDrawingUsesLineFragmentOrigin];
}
- (CGSize)heightWithFont:(UIFont *)withFont width:(CGFloat)width linebreak:(NSStringDrawingOptions)Options{
    NSDictionary * attrs = @{NSFontAttributeName : withFont};
    CGSize maxSize = CGSizeMake(width, MAXFLOAT);
    return [self boundingRectWithSize:maxSize options:Options attributes:attrs context:nil].size;
}

@end
