//
//  NSString+Size.h
//  NingboSat
//
//  Created by 王会洲 on 16/9/27.
//  Copyright © 2016年 王会洲. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface NSString (Size)
- (CGSize)heightWithFont:(UIFont *)Font width:(CGFloat)width;
- (CGSize)widthWithFont:(UIFont *)Font height:(CGFloat)height;
@end
