//
//  UIImage+SolidColor.h
//  eTax
//
//  Created by ysyc_liu on 16/5/20.
//  Copyright © 2016年 ysyc. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  纯色图片.
 */
@interface UIImage (SolidColor)

+ (instancetype)imageWithColor:(UIColor *)color size:(CGSize)size;

@end
