//
//  LeadViewPageControl.m
//  eTax
//
//  Created by ysyc_liu on 16/4/22.
//  Copyright © 2016年 YSYC. All rights reserved.
//

#import "ViewPageControl.h"
#import "Config.h"

@interface ViewPageControl()

 - (void)updateDots;

@end

@implementation ViewPageControl

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event { // 点击事件
    [super endTrackingWithTouch:touch withEvent:event];
    [self updateDots];
}

- (void)setCurrentPage:(NSInteger)currentPage {
    [super setCurrentPage:currentPage];
    [self updateDots];
}

- (void)updateDots { // 更新显示所有的点按钮
    NSArray *subview = self.subviews;  // 获取所有子视图
    for (NSInteger i = 0; i < [subview count]; i++)
    {
        UIView *dot = [subview objectAtIndex:i];
        if (self.currentPage != i) {
            dot.backgroundColor = self.pageIndicatorTintColor;
            dot.layer.borderWidth = 1;
            dot.layer.borderColor = YSColor(0xb4, 0xb4, 0xb4).CGColor;
        }
        else {
            dot.layer.borderWidth = 0;
        }
        
    }
}

@end
