//
//  MatrixView.h
//  eTax
//
//  Created by ysyc_liu on 16/4/14.
//  Copyright © 2016年 YSYC. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  一系列视图排列成方阵.
 *
 *  一般来说,整个方阵的宽度确定,而高度可变. 阵的列数确定,而行数可变.
 *  所以考虑用整个方阵的宽度、每一行的高度、阵的列数 这三个参数结合元素总个数来确定整个方阵的大小.
 */
@interface MatrixView : UIScrollView
/// 方阵元素.
@property (nonatomic, strong)NSArray<UIView *> * viewItems;

/// 列数.
@property (nonatomic) NSInteger cols;

/// 行数.
@property (nonatomic)NSInteger rows;

/// 子图大小.
@property (nonatomic)CGSize subSize;

/// 分割线颜色.
@property (nonatomic, strong)UIColor * splitColor;

/**
 *  初始化函数.(默认分割线颜色).
 *
 *  @param frame    注意, frame里的高度值表示方阵每一行的高度,而不是视图的总高度.
 *  @param items    子视图列表.
 *  @param cols     列数.
 *  @param maxSize  视图最大尺寸.
 *
 *  @return 初始化后的对象.
 */
- (instancetype)initWithFrame:(CGRect)frame items:(NSArray *)items cols:(NSInteger)cols maxSize:(CGSize)maxSize;

/**
 *  初始化函数.
 *
 *  @param frame      注意, frame里的高度值表示方阵每一行的高度,而不是视图的总高度.
 *  @param items      子视图列表.
 *  @param cols       列数.
 *  @param splitColor 分割线颜色.为透明时没有添加分割线视图.
 *  @param maxSize    视图最大尺寸.
 *
 *  @return 初始化后的对象.
 */
- (instancetype)initWithFrame:(CGRect)frame items:(NSArray *)items cols:(NSInteger)cols splitColor:(UIColor *)splitColor maxSize:(CGSize)maxSize;

@end
