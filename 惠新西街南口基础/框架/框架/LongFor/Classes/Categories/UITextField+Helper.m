//
//  UITextField+Helper.m
//  InvoicePlus
//
//  Created by 王会洲 on 16/8/30.
//  Copyright © 2016年 ysyc. All rights reserved.
//

#import "UITextField+Helper.h"
#import "ConfigUI.h"

@implementation UITextField (Helper)
+(instancetype)TextField:(NSString *)placeText Color:(UIColor *)color Font:(CGFloat )fontSize{
    UITextField * textField = [[UITextField alloc] init];
    textField.placeholder = placeText;
    textField.font = FONTWITHSIZE_LIGHT(fontSize);
    textField.textColor = color;
    textField.borderStyle = UITextBorderStyleRoundedRect;
    [textField setValue:FONTWITHSIZE_LIGHT(fontSize) forKeyPath:@"_placeholderLabel.font"];
    [textField setValue:SColor(203, 203, 203) forKeyPath:@"_placeholderLabel.textColor"];
    return textField;
}


+(instancetype)TextAndPleaceField:(NSString *)placeText Color:(UIColor *)color Font:(CGFloat )fontSize {
    UITextField * textField = [[UITextField alloc] init];
    textField.placeholder = placeText;
    textField.font = FONTWITHSIZE_LIGHT(fontSize);
    textField.textColor = color;
    textField.borderStyle = UITextBorderStyleRoundedRect;
    [textField setValue:FONTWITHSIZE_LIGHT(fontSize) forKeyPath:@"_placeholderLabel.font"];
    [textField setValue:SColor(203, 203, 203) forKeyPath:@"_placeholderLabel.textColor"];
    return textField;

}

@end
