//
//  UILabel+helper.m
//  InvoicePlus
//
//  Created by 王会洲 on 16/8/30.
//  Copyright © 2016年 ysyc. All rights reserved.
//

#import "UILabel+helper.h"


@implementation UILabel (helper)
+(instancetype)Label:(NSString *)text Color:(UIColor *)color Font:(UIFont *)font {
    UILabel * label = [[UILabel alloc] init];
    label.text = text;
    label.textColor = color;
    label.font = font;
    
    return label;
}
@end

