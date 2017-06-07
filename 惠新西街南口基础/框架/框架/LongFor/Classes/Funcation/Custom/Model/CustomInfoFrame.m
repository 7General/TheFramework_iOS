//
//  CustomInfoFrame.m
//  LongFor
//
//  Created by ZZG on 17/5/31.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "CustomInfoFrame.h"
#import "ConfigUI.h"
#import "NSString+Size.h"

@implementation CustomInfoFrame

-(void)setCIModel:(CustomInfo *)CIModel {
    _CIModel = CIModel;
    
    CGFloat padding = 15;
    CGFloat nX = padding;
    CGFloat nY = padding;
    CGFloat nW = 54;
    CGFloat nH = 22;
    _nameF = CGRectMake(nX, nY, nW, nH);
    
    CGFloat hddfX = nX;
    CGFloat hddfY = CGRectGetMaxY(_nameF) + 10;
    CGFloat hddfW = 52;
    CGFloat hddfH = 14;
    _hddfF = CGRectMake(hddfX, hddfY, hddfW, hddfH);
    
    CGFloat dfTX = CGRectGetMaxX(_hddfF) + 5;
    CGFloat dfTY = hddfY;
    CGFloat dfTW = 0;
    CGFloat dfTH = 14;
    if (IsStrEmpty(CIModel.gjDateStr)) {
        dfTW = 0;
    }else {
        dfTW = [CIModel.gjDateStr widthWithFont:FONTWITHSIZE_LIGHT(12) height:dfTH].width;
    }
    
    _dftimeF = CGRectMake(dfTX, dfTY, dfTW, dfTH);
    
    CGFloat proX = CGRectGetMaxY(_dftimeF) + 20;
    CGFloat proY = dfTY;
    CGFloat proW = 50;
    CGFloat proH = 15;
    _proF = CGRectMake(proX, proY, proW, proH);
    
    CGFloat pronX = CGRectGetMaxY(_proF) + 5;
    CGFloat pronY = proY;
    CGFloat pronW = 50;
    CGFloat pronH = 15;
    _proNameF = CGRectMake(pronX, pronY, pronW, pronH);
    
    CGFloat conX = nX;
    CGFloat conY = CGRectGetMaxY(_hddfF) + 15;
    CGFloat conW = SCREEN_WIDTH - 30 - 30;
    NSString * gjnr = IsStrEmpty(CIModel.gjNr) ? @"暂无跟进信息" :CIModel.gjNr;
    CGFloat conH = [gjnr heightWithFont:FONTWITHSIZE_LIGHT(14) width:conW].height;
    _contentF = CGRectMake(conX, conY, conW, conH);
    
    _cellHeight = CGRectGetMaxY(_contentF) + 15;
 
}

@end
