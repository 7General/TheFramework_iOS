//
//  TextFieldCustom+MailAddress.m
//  NingboSat
//
//  Created by ysyc_liu on 16/9/19.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "TextFieldCustom+MailAddress.h"
#import "Config.h"

@implementation TextFieldCustom (MailAddress)

+ (instancetype)textFieldWithTitle:(NSString *)title placeholder:(NSString *)placeholder isSelect:(BOOL)isSelect {
    TextFieldCustom * textField = [[TextFieldCustom alloc] init];
    textField.textColor = YSColor(0x50, 0x50, 0x50);
    textField.font = FONT_BY_SCREEN(15);
    textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholder attributes:@{NSFontAttributeName:FONT_BY_SCREEN(15), NSForegroundColorAttributeName:YSColor(0xb4, 0xb4, 0xb4)}];
    textField.textAlignment = NSTextAlignmentRight;
    textField.tintColor = YSColor(0x50, 0x50, 0x50);
    
    if (title.length > 0) {
        UILabel *label = [[UILabel alloc] init];
        label.font = FONT_BY_SCREEN(15);
        label.textColor = YSColor(0x50, 0x50, 0x50);
        label.text = title;
        [label sizeToFit];
        
        textField.leftView = label;
        textField.leftViewMode = UITextFieldViewModeAlways;
    }
    
    if (isSelect) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rightArrow"]];
        imageView.bounds = CGRectMake(0, 0, imageView.image.size.width + 5, imageView.image.size.height);
        imageView.contentMode = UIViewContentModeRight;
        textField.rightView = imageView;
        textField.rightViewMode = UITextFieldViewModeAlways;
    }
    
    return textField;
}

@end
