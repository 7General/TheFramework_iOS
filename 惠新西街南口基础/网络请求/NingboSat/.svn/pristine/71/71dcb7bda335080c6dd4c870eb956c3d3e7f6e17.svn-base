//
//  NSString+AttributeOrSize.h
//  NingboSat
//
//  Created by 王会洲 on 16/11/24.
//  Copyright © 2016年 王会洲. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface NSString (AttributeOrSize)

/********************************************************************
 *  返回包含关键字的富文本编辑
 *
 *  @param lineSpacing 行高
 *  @param textcolor   字体颜色
 *  @param font        字体
 *  @param KeyColor    关键字字体颜色
 *  @param KeyFont     关键字字体
 *  @param KeyWords    关键字数组
 *
 *  @return
 ********************************************************************/
-(NSAttributedString *)stringWithParagraphlineSpeace:(CGFloat)lineSpacing
                                   NormalAttributeFC:(NSDictionary *)NormalFC
                                    withKeyTextColor:(NSArray *)KeyWords
                                      KeyAttributeFC:(NSDictionary *)keyFC;


/**
 * 把YYYY-MM-dd 装换成YYYYMMdd格式
 *
 *  @return 返回转换后的NSString
 */
- (NSString *)stringTimeWithFormat;


/**
 *  比较两个时间大小
 *
 *  @param leftTime  左边时间
 *  @param rightTime 右边时间
 *
 *  @return 右>左 = 1，左>右 = -1 ， 左=右 = 1
 */
-(int)compareDate:(NSString*)leftTime withDate:(NSString*)rightTime;


/**
 *  返回当月首日
 *  输入格式为yyyy-MM-dd
 *  @return 
 */
- (NSString *)getMonthBeginAndEndWith:(NSString *)formaat;
@end
