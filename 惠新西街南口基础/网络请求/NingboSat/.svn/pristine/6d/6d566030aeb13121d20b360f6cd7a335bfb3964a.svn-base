//
//  UIImage+AlphaSet.m
//  eTax
//
//  Created by ysyc_liu on 16/6/29.
//  Copyright © 2016年 ysyc. All rights reserved.
//

#import "UIImage+AlphaSet.h"

@implementation UIImage (AlphaSet)

+ (UIImage *)imageByApplyingAlpha:(CGFloat)alpha image:(UIImage*)image {
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.0f);
    
    [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height) blendMode:kCGBlendModeNormal alpha:alpha];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
