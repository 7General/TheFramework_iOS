//
//  NSString+Size.m
//  NingboSat
//
//  Created by 王会洲 on 16/9/27.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "NSString+Size.h"

@implementation NSString (Size)
- (CGSize)heightWithFont:(UIFont *)Font width:(CGFloat)width {
    return [self heightWithFont:Font width:CGSizeMake(width, MAXFLOAT) linebreak:NSStringDrawingUsesLineFragmentOrigin];
}
- (CGSize)heightWithFont:(UIFont *)withFont width:(CGSize)sizes linebreak:(NSStringDrawingOptions)Options{
    NSDictionary * attrs = @{NSFontAttributeName : withFont};
    CGSize maxSize = sizes;//CGSizeMake(width, MAXFLOAT);
    return [self boundingRectWithSize:maxSize options:Options attributes:attrs context:nil].size;
}


- (CGSize)widthWithFont:(UIFont *)Font height:(CGFloat)height {
     return [self heightWithFont:Font width:CGSizeMake(MAXFLOAT, height) linebreak:NSStringDrawingUsesLineFragmentOrigin];
}

@end
