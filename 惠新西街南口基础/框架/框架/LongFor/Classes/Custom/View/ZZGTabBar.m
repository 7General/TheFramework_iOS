//
//  ZZGTabBar.m
//  AllBasic
//
//  Created by admin on 17/5/4.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "ZZGTabBar.h"
#import "ConfigUI.h"
#import "UIView+Additions.h"
#import "UIColor+Helper.h"

@interface ZZGTabBar ()

@property (nonatomic, weak) UIButton *publishButton;

@end

@implementation ZZGTabBar
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIButton *publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"applic_sing_search"] forState:UIControlStateNormal];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"applic_sing_search"] forState:UIControlStateHighlighted];
        
        [publishButton addTarget:self action:@selector(handlePublish) forControlEvents:UIControlEventTouchUpInside];
//         设置发布按钮的尺寸
        publishButton.size = publishButton.currentBackgroundImage.size;
        [self addSubview:publishButton];
        self.publishButton = publishButton;
        self.backgroundImage = [UIColor createImageWithColor:SColor(247, 247, 247)];
        
    }
    return self;
}

- (void) handlePublish {
    NSLog(@"pushlish click");
}


- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if (self.isHidden == NO) {
        //将当前tabbar的触摸点转换坐标系，转换到发布按钮的身上，生成一个新的点
        CGPoint newP = [self convertPoint:point toView:self.publishButton];
        //判断如果这个新的点是在发布按钮身上，那么处理点击事件最合适的view就是发布按钮
        if ( [self.publishButton pointInside:newP withEvent:event]) {
//            CGPoint tempPoint = [self.publishButton convertPoint:newP fromView:self.publishButton];
//            
//            if (CGRectContainsPoint(self.publishButton.bounds, tempPoint)) {
//                return self.publishButton;
//            }
            return self.publishButton;
        }else{//如果点不在发布按钮身上，直接让系统处理就可以了
            return [super hitTest:point withEvent:event];
        }
    }
    else {//tabbar隐藏了，那么说明已经push到其他的页面了，这个时候还是让系统去判断最合适的view处理就好了
        return [super hitTest:point withEvent:event];
    }
}



- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat width = self.width;
    CGFloat height = self.height;
    
    // 设置发布按钮的frame
    self.publishButton.center = CGPointMake(width * 0.5, 0);
    
    // 设置其他UITabBarButton的frame
    CGFloat buttonY = -1;
    CGFloat buttonW = width / 5;
    CGFloat buttonH = height;
    NSInteger index = 0;
    for (UIView *button in self.subviews) {
        if (![button isKindOfClass:[UIControl class]] || button == self.publishButton) continue;
        
        // 计算按钮的x值
        CGFloat buttonX = buttonW * ((index > 1)?(index + 1):index);
//        CGFloat buttonX = buttonW * (index);
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        // 增加索引
        index++;
    }
}


@end
