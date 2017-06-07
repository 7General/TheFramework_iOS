//
//  CustomModeFrame.m
//  LongFor
//
//  Created by ZZG on 17/5/19.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "CustomModeFrame.h"
#import "ConfigUI.h"
#import "NSString+Size.h"


@implementation CustomModeFrame

-(void)setCMode:(CustomModel *)cMode {
    _cMode = cMode;
    
    CGFloat padding = 15;
    
    // icon
    CGFloat iconX = padding;
    CGFloat iconY = padding;
    CGFloat iconW = 45;
    CGFloat iconH = 45;
    _logoF = CGRectMake(iconX, iconY, iconW, iconH);
    
    // 姓名
    CGFloat nameX = CGRectGetMaxX(_logoF) + 10;
    CGFloat nameY = padding + 2;
    CGFloat nameH = 16;
    CGFloat nameW =  [cMode.customerName widthWithFont:FONTWITHSIZE_LIGHT(17) height:nameH].width;
    
    _nameF = CGRectMake(nameX, nameY, nameW, nameH);
    
    // 活动邀约
    CGFloat yyX = CGRectGetMaxX(_nameF) + 10;
    CGFloat yyY = nameY;
    CGFloat yyW = 33;
    CGFloat yyH = 7;
    _invitationF = CGRectMake(yyX, yyY, yyW, yyH);
    
    // 电话 短信 动画按钮
    CGFloat anX = SCREEN_WIDTH - 13 - 20 - 30;
    CGFloat anY = 22 - 10;
    CGFloat anW = 20;
    CGFloat anH = 20;
    _buttonF = CGRectMake(anX, anY, anW, anH);
    
    // 置顶
    CGFloat topX = anX - 15 - 40;
    CGFloat topY = 21;
    CGFloat topW = 40;
    CGFloat topH = 13;
    _topF = CGRectMake(topX, topY, topW, topH);
    
    // 级别
    CGFloat leavX = nameX;
    CGFloat leavY = CGRectGetMaxY(_nameF) + 10;
    CGFloat leavW = IsStrEmpty(cMode.custlevel) ? 0 : 20;
    CGFloat leavH = 13;
    _leavelF = CGRectMake(leavX, leavY, leavW, leavH);
    
    // 楼层
    CGFloat floX = IsStrEmpty(cMode.custlevel) ? leavX : CGRectGetMaxX(_leavelF) + 5;
    CGFloat floY = leavY;
//    CGFloat floW = IsStrEmpty(cMode.intentionBiz) ? 0 : 40;
    CGFloat floH = 13;
    CGFloat floW = 0;
    if (IsStrEmpty(cMode.intentionBiz)) {
        floW = 0;
    }else {
        floW = [cMode.intentionBiz widthWithFont:FONTWITHSIZE_LIGHT(9) height:floH].width + 10;
    }
    
    _floorF = CGRectMake(floX, floY, floW, floH);
    
    // 面积
    CGFloat mjX = IsStrEmpty(cMode.intentionBiz) ? floX : CGRectGetMaxX(_floorF) + 5;
    CGFloat mjY = floY;
    CGFloat mjH = 13;
//    CGFloat mjW = IsStrEmpty(cMode.intentionAread) ? 0 : 35;
    CGFloat mjW = 0;
    if (IsStrEmpty(cMode.intentionAread)) {
        mjW = 0;
    }else {
        mjW = [cMode.intentionAread widthWithFont:FONTWITHSIZE_LIGHT(9) height:mjH].width + 10;
    }

    
    _mjF = CGRectMake(mjX, mjY, mjW, mjH);
    
    // 居室
    CGFloat rcX = IsStrEmpty(cMode.intentionAread) ? mjX : CGRectGetMaxX(_mjF) + 5;
    CGFloat rcY = mjY;
    CGFloat rcW = IsStrEmpty(cMode.roomNum) ? 0 : 30;
    CGFloat rcH = 13;
    _rooCountF = CGRectMake(rcX, rcY, rcW, rcH);
    
    // 横线
    CGFloat linX = 15;
    CGFloat linY = CGRectGetMaxY(_logoF) + 10;
    CGFloat linW = SCREEN_WIDTH - 30 - 15 - 15;
    CGFloat linH = 1;
    _centerLineF = CGRectMake(linX, linY, linW, linH);
    
    // 姓名+时间
    CGFloat ztX = iconX;
    CGFloat ztY = CGRectGetMaxY(_centerLineF) + 15;
    CGFloat ztW = 100;
    CGFloat ztH = 8;
    _zygwATimeF = CGRectMake(ztX, ztY, ztW, ztH);
    
    //置顾再录F
    CGFloat zgX = CGRectGetMaxX(_zygwATimeF);
    CGFloat zgY = ztY;
    CGFloat zgW = 100;
    CGFloat zgH = 8;
    _zgzlF = CGRectMake(zgX, zgY, zgW, zgH);
    
    // 内容
    CGFloat cX = iconX;
    CGFloat cY = CGRectGetMaxY(_zygwATimeF) + 10;
    CGFloat cW = SCREEN_WIDTH - 30 - 30;
    NSString * content = IsStrEmpty(cMode.gjnr) ? @"暂无跟进内容" : cMode.gjnr;
    CGFloat cH = [content heightWithFont:FONTWITHSIZE_LIGHT(14) width:cW].height;
    _contentF = CGRectMake(cX, cY, cW, cH);
    
    
    _cellHeight = CGRectGetMaxY(_contentF) + 15;
}

@end
