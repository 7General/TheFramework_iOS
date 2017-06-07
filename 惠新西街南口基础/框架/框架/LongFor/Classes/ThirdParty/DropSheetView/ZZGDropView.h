//
//  ZZGDropView.h
//  ReadAddress
//
//  Created by admin on 17/5/3.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZZGDropView;


@protocol ZZGDropViewDelegate <NSObject>

@optional
-(void)dropView:(ZZGDropView *)dropView didSelectString:(NSInteger)row;

@end


@interface ZZGDropView : UIView
/**
 *  内容视图
 */
@property (nonatomic, strong) UIView *contentView;
/**
 *  按钮高度
 */
@property (nonatomic, assign) CGFloat buttonH;
/**
 *  按钮的垂直方向的间隙
 */
@property (nonatomic, assign) CGFloat buttonMargin;
/**
 *  内容视图的位移
 */
@property (nonatomic, assign) CGFloat contentShift;
/**
 *  动画持续时间
 */
@property (nonatomic, assign) CGFloat animationTime;
/**
 * tableView的高度
 */
@property (nonatomic, assign) CGFloat tableViewH;

@property (nonatomic, weak) id <ZZGDropViewDelegate> DropViewDelegate ;
/**
 *  展示popView
 *
 *  @param array button的title数组
 */
- (void)showDropViewWithArray:(NSMutableArray *)array;
/**
 *  移除popView
 */
- (void)dismissThePopView;


@end
