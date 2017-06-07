//
//  UIImage+Helper.h
//  LongFor
//
//  Created by ZZG on 17/6/3.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Helper)

/**
 压缩图片指定大小
 
 @param targetSize 图片大小
 @return 压缩后的图片
 */
- (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize;

@end
