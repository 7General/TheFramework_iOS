//
//  UIButton+helper.h
//  InvoicePlus
//
//  Created by 王会洲 on 16/8/30.
//  Copyright © 2016年 ysyc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (helper)
+(instancetype)button:(CGRect)fram TitleColor:(UIColor *)color TitleFont:(UIFont *)font imge:(UIImage *)image forTitle:(NSString *)titles;


/**
 返回只带image的button

 @param image image
 @return 返回只带image的button
 */
+(instancetype)buttonWithImge:(UIImage *)image;


@property (nonatomic, assign) BOOL  isVerticalShow;

@property (nonatomic, strong) NSString *  OrderTags;
/*! 只添加一个bool 属性 */
@property (nonatomic, assign) BOOL    onlyAddition;

@end
