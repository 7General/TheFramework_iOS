//
//  UIButton+helper.m
//  InvoicePlus
//
//  Created by 王会洲 on 16/8/30.
//  Copyright © 2016年 ysyc. All rights reserved.
//

#import "UIButton+helper.h"
#import "ConfigUI.h"
#import "objc/runtime.h"


static char *isVerticalShowK = "isVerticalShowK";

static char *onlyAdditionK = "onlyAdditionK";

static const void * OrderTagsBy = &OrderTagsBy;

@implementation UIButton (helper)

@dynamic OrderTags;

+(instancetype)button:(CGRect)fram
           TitleColor:(UIColor *)color
            TitleFont:(UIFont *)font
                 imge:(UIImage *)image
             forTitle:(NSString *)titles
{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = fram;
    [btn setTitleColor:color forState:UIControlStateNormal];
    [btn setTitle:titles forState:UIControlStateNormal];
    [btn setImage:image forState:UIControlStateNormal];
    [btn.titleLabel setFont:font];
    btn.adjustsImageWhenHighlighted = NO;
    return btn;
}

/**
 返回只带image的button
 
 @param image image
 @return 返回只带image的button
 */
+(instancetype)buttonWithImge:(UIImage *)image {
    return [UIButton button:CGRectZero TitleColor:nil TitleFont:nil imge:image forTitle:nil];
}


#pragma mark - 设置垂直排列
-(void)setIsVerticalShow:(BOOL)isVerticalShow {
   objc_setAssociatedObject(self, isVerticalShowK, [NSNumber numberWithBool:isVerticalShow], OBJC_ASSOCIATION_ASSIGN);
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    CGFloat totalHeight = (imageSize.height + titleSize.height + 6);
    self.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageSize.height), 0.0, 0.0, - titleSize.width);
    self.titleEdgeInsets = UIEdgeInsetsMake(10.0, - imageSize.width, - (totalHeight - titleSize.height),0.0);
    
}
-(BOOL)isVerticalShow {
    return objc_getAssociatedObject(self, isVerticalShowK);
}

#pragma mark - 设置添加一个nsstring属性
-(void)setOrderTags:(NSString *)OrderTags {
    objc_setAssociatedObject(self, OrderTagsBy, OrderTags, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(NSString *)OrderTags {
    return objc_getAssociatedObject(self, OrderTagsBy);
}

#pragma makr -设置添加一个BOOL属性
-(void)setOnlyAddition:(BOOL)onlyAddition {
    objc_setAssociatedObject(self, onlyAdditionK, [NSNumber numberWithBool:onlyAddition], OBJC_ASSOCIATION_ASSIGN);
}
-(BOOL)onlyAddition {
    return objc_getAssociatedObject(self, onlyAdditionK);
}


@end
