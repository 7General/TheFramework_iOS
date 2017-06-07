//
//  UIButton+ImageAndTitle.m
//  TicketCloud
//
//  Created by ysyc_liu on 16/2/25.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "UIButton+ImageAndTitle.h"

@implementation UIButton (ImageAndTitle)

- (void)setContentAlignment:(ButtonContentAlignment)alignment withGap:(CGFloat)gap {
    
    CGFloat horizontalGap = 0;
    CGFloat horizontalCoefficient = 0;
    CGFloat verticalGap = 0;
    CGFloat verticalCoefficient = 0;
    BOOL isVertical = NO;
    
    switch (alignment) {
        case ButtonContentAlignmentHorizontal:
            horizontalGap = gap / 2;
            horizontalCoefficient = -1;
            break;
        case ButtonContentAlignmentHorizontalR:
            horizontalGap = gap / 2;
            horizontalCoefficient = 1;
            break;
        case ButtonContentAlignmentVertical:
            verticalGap = gap / 2;
            verticalCoefficient = 1;
            isVertical = YES;
            break;
        case ButtonContentAlignmentVerticalR:
            verticalGap = gap / 2;
            verticalCoefficient = -1;
            isVertical = YES;
            break;
            
        default:
            return;
    }
    
    UILabel * label = [[UILabel alloc] init];
    label.attributedText = self.titleLabel.attributedText;
    label.numberOfLines = 0;
    CGSize imageSize = self.currentImage.size;
    CGFloat diff = isVertical ? 0 : imageSize.width;
    CGSize titleSize = [label sizeThatFits:CGSizeMake(CGRectGetWidth(self.bounds) - diff, CGRectGetHeight(self.bounds))];
    
    CGFloat widthDiff = (imageSize.width + titleSize.width) / 2;
    self.contentEdgeInsets = UIEdgeInsetsMake(0, -widthDiff, 0, -widthDiff);
    
    CGFloat titleHorizontalMove = imageSize.width / 2 + horizontalCoefficient * (imageSize.width / 2 + horizontalGap);
    CGFloat imageHorizontalMove = titleSize.width / 2 + horizontalCoefficient * (titleSize.width / 2 + horizontalGap);
    CGFloat titleVerticalMove = verticalCoefficient * (imageSize.height / 2 + verticalGap);
    CGFloat imageVerticalMove = verticalCoefficient * (titleSize.height / 2 + verticalGap);
    
    self.titleEdgeInsets = UIEdgeInsetsMake(titleVerticalMove, -titleHorizontalMove, -titleVerticalMove, titleHorizontalMove);
    self.imageEdgeInsets = UIEdgeInsetsMake(-imageVerticalMove, imageHorizontalMove, imageVerticalMove, -imageHorizontalMove);
}

- (void)setNearEdgesAlignment:(ButtonContentAlignment)alignment withEdgeInsets:(UIEdgeInsets)edgeInsets {
    UILabel * label = [[UILabel alloc] init];
    label.attributedText = self.titleLabel.attributedText;
    label.numberOfLines = 0;
    CGSize imageSize = self.currentImage.size;
    CGSize titleSize = [label sizeThatFits:CGSizeMake(CGRectGetWidth(self.bounds) - imageSize.width, CGRectGetHeight(self.bounds))];
    
    CGFloat horizontalCoefficient = 0;
    CGFloat verticalCoefficient = 0;
    CGFloat buttonHeight = CGRectGetHeight(self.bounds);
    CGFloat buttonWidth  = CGRectGetWidth(self.bounds);
    CGFloat titleGap = 0;
    CGFloat imageGap = 0;
    
    switch (alignment) {
        case ButtonContentAlignmentHorizontal:
            imageGap  = edgeInsets.left;
            titleGap  = edgeInsets.right;
            horizontalCoefficient = -1;
            break;
        case ButtonContentAlignmentHorizontalR:
            imageGap  = edgeInsets.right;
            titleGap  = edgeInsets.left;
            horizontalCoefficient = 1;
            break;
        case ButtonContentAlignmentVertical:
            imageGap  = edgeInsets.top;
            titleGap  = edgeInsets.bottom;
            verticalCoefficient = 1;
            break;
        case ButtonContentAlignmentVerticalR:
            imageGap  = edgeInsets.bottom;
            titleGap  = edgeInsets.top;
            verticalCoefficient = -1;
            break;
            
        default:
            return;
    }
    
    CGFloat titleHorizontalMove = imageSize.width / 2 + horizontalCoefficient * (buttonWidth / 2 - titleSize.width / 2 - titleGap);
    CGFloat imageHorizontalMove = titleSize.width / 2 + horizontalCoefficient * (buttonWidth / 2 - imageSize.width / 2 - imageGap);
    CGFloat titleVerticalMove = verticalCoefficient * (buttonHeight / 2 - titleSize.height / 2 - titleGap);
    CGFloat imageVerticalMove = verticalCoefficient * (buttonHeight / 2 - imageSize.height / 2 - imageGap);
    
    
    self.titleEdgeInsets = UIEdgeInsetsMake(titleVerticalMove, -titleHorizontalMove, -titleVerticalMove, titleHorizontalMove);
    self.imageEdgeInsets = UIEdgeInsetsMake(-imageVerticalMove, imageHorizontalMove, imageVerticalMove, -imageHorizontalMove);
}



- (void)setLineAlignment:(ButtonContentAlignment)alignment withFirstGap:(CGFloat)firstGap secondGap:(CGFloat)secondGap {
    UILabel * label = [[UILabel alloc] init];
    label.attributedText = self.titleLabel.attributedText;
    label.numberOfLines = 0;
    CGSize imageSize = self.currentImage.size;
    CGSize titleSize = [label sizeThatFits:CGSizeMake(CGRectGetWidth(self.bounds) - imageSize.width, CGRectGetHeight(self.bounds))];
    
    CGFloat horizontalCoefficient = 0;
    CGFloat verticalCoefficient = 0;
    CGFloat buttonHeight = CGRectGetHeight(self.bounds);
    CGFloat buttonWidth  = CGRectGetWidth(self.bounds);
    CGFloat titleGap = 0;
    CGFloat imageGap = 0;
    
    switch (alignment) {
        case ButtonContentAlignmentHorizontal:
            imageGap  = firstGap;
            titleGap  = firstGap + secondGap + imageSize.width;
            horizontalCoefficient = 1;
            break;
        case ButtonContentAlignmentHorizontalR:
            imageGap  = firstGap + secondGap + titleSize.width;
            titleGap  = firstGap;
            horizontalCoefficient = 1;
            break;
        case ButtonContentAlignmentVertical:
            imageGap  = firstGap;
            titleGap  = firstGap + secondGap + imageSize.height;
            verticalCoefficient = 1;
            break;
        case ButtonContentAlignmentVerticalR:
            imageGap  = firstGap + secondGap + titleSize.height;
            titleGap  = firstGap;
            verticalCoefficient = 1;
            break;
            
        default:
            return;
    }
    
    CGFloat titleHorizontalMove = imageSize.width / 2 + horizontalCoefficient * (buttonWidth / 2 - titleSize.width / 2 - titleGap);
    CGFloat imageHorizontalMove = titleSize.width / 2 - horizontalCoefficient * (buttonWidth / 2 - imageSize.width / 2 - imageGap);
    CGFloat titleVerticalMove = verticalCoefficient * (buttonHeight / 2 - titleSize.height / 2 - titleGap);
    CGFloat imageVerticalMove = verticalCoefficient * (buttonHeight / 2 - imageSize.height / 2 - imageGap);
    
    
    self.titleEdgeInsets = UIEdgeInsetsMake(titleVerticalMove, -titleHorizontalMove, -titleVerticalMove, titleHorizontalMove);
    self.imageEdgeInsets = UIEdgeInsetsMake(-imageVerticalMove, imageHorizontalMove, imageVerticalMove, -imageHorizontalMove);
}

@end
