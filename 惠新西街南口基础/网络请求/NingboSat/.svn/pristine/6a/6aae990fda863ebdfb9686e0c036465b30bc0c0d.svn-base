//
//  BookSpecFrame.m
//  NingboSat
//
//  Created by 王会洲 on 16/11/21.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "BookSpecFrame.h"
#import "Config.h"
#import "NSString+Size.h"

@implementation BookSpecFrame

-(void)setSpecModel:(BookSpecMdoel *)specModel {
    _specModel = specModel;
    
    CGFloat padding = 15;
    
    CGFloat titleX = padding;
    CGFloat titleY = padding;
    CGFloat titleW = SCREEN_WIDTH - padding * 3;
    CGFloat titleH = [specModel.mc heightWithFont:FONT_BOLD_BY_SCREEN(15) width:titleW].height;
    _titleF = CGRectMake(titleX, titleY, titleW, titleH);
    
    
    CGFloat subTitleX = padding;
    CGFloat subTtitleY = CGRectGetMaxY(_titleF) + 4;
    CGFloat subTitleW = titleW;
    CGFloat subTitleH = 15;
    _subTitleF = CGRectMake(subTitleX, subTtitleY, subTitleW, subTitleH);
    
    
    self.cellHeight = CGRectGetMaxY(_subTitleF) + padding;

}


@end
