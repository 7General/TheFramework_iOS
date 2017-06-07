//
//  UIColor+Helper.h
//  LongFor
//
//  Created by ZZG on 17/5/18.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Helper)

+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;

+ (UIImage*) createImageWithColor:(UIColor*) color;
@end
