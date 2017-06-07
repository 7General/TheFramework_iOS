//
//  CustomlistCell.h
//  LongFor
//
//  Created by ZZG on 17/5/19.
//  Copyright © 2017年 admin. All rights reserved.
//

/*! 客户列表cell */
#import <UIKit/UIKit.h>
#import "CustomModeFrame.h"

@protocol AnimateCellDelegate <NSObject>

@optional
/**
 按钮点击事件

 @param path <#path description#>
 */
-(void)animateCellHeightCustom:(NSIndexPath *)path;

/**
 电话，发短信事件

 @param selecIndex 按钮索引
 @param path 当前indexpath
 */
-(void)consoleDidSelectIndex:(NSInteger)selecIndex didselectIndexPath:(NSIndexPath *)path;

@end


@interface CustomlistCell : UITableViewCell


// 加载cell
+ (instancetype)cellWtihTableView:(UITableView *)tableView;

@property (nonatomic, strong) CustomModeFrame *cmFrame;
@property (nonatomic, strong) NSIndexPath * pathIndex;
/*! 设置 隐藏 */
-(void)setHiddenConsoleView;
/*! 设置显示 */
-(void)setShowConsoleView;

@property (nonatomic, weak) id<AnimateCellDelegate> delegate;


@end

@interface UILabel (helper)
+(UILabel *)createLabel:(UIColor *)textColor forFont:(CGFloat)font;
@end


