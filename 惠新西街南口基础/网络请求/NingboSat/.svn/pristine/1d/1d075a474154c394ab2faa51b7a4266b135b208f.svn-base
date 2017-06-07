//
//  UIButton+Model.m
//  NingboSat
//
//  Created by ysyc_liu on 16/9/9.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "UIButton+Model.h"
#import "UIImage+AlphaSet.h"
#import "config.h"

@implementation UIButton (Model)

+ (instancetype)buttonWithModel:(ButtonModel *)model {
    UIButton * button = [self buttonWithType:UIButtonTypeCustom];
    [button setTitle:model.title forState:UIControlStateNormal];
    [button setTitleColor:YSColor(0x50, 0x50, 0x50) forState:UIControlStateNormal];
    button.titleLabel.font = FONT_BY_SCREEN(17);
    
    if (model.icon) {
        UIImage * image = [UIImage imageNamed:model.icon];
        [button setImage:image forState:UIControlStateNormal];
        if (model.iconHL) {
            [button setImage:[UIImage imageNamed:model.iconHL] forState:UIControlStateHighlighted];
        }
        else {
            [button setImage:[UIImage imageByApplyingAlpha:0.5 image:image] forState:UIControlStateHighlighted];
        }
    }
    
    
    button.tag = model.btnTag;
    return button;
}

@end
