//
//  UIButton+ImageAndTitle.h
//  TicketCloud
//
//  Created by ysyc_liu on 16/2/25.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  image and title alignment type.
 */
typedef NS_ENUM(NSInteger, ButtonContentAlignment) {
    /**
     *  image then title.
     */
    ButtonContentAlignmentHorizontal = 0,
    /**
     *  title then image.
     */
    ButtonContentAlignmentHorizontalR,
    /**
     *  image then title.
     */
    ButtonContentAlignmentVertical,
    /**
     *  title then image.
     */
    ButtonContentAlignmentVerticalR,
};

@interface UIButton (ImageAndTitle)

/**
 *  设置图片和标题居中显示, 之间间隔gap.
 *
 *  @param alignment 图片和标题格式.
 *  @param gap       间隔.
 */
- (void)setContentAlignment:(ButtonContentAlignment)alignment withGap:(CGFloat)gap;

/**
 *  根据离按键四条边的距离设置图片和标题的位置.当横向时,仅左右边距有效,当纵向时,仅上下边距有效.
 *
 *  @param alignment  图片和标题格式.
 *  @param edgeInsets 边距.
 */
- (void)setNearEdgesAlignment:(ButtonContentAlignment)alignment withEdgeInsets:(UIEdgeInsets)edgeInsets;

/**
 *  线性布局.(从上往下/从左往右)
 *
 *  @param alignment 布局格式.
 *  @param firstGap  与边缘的间距.
 *  @param secondGap 图片和标题间距.
 */
- (void)setLineAlignment:(ButtonContentAlignment)alignment withFirstGap:(CGFloat)firstGap secondGap:(CGFloat)secondGap;

@end
