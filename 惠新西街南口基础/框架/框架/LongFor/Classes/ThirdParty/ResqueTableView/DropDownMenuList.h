//
//  DropDownMenuList.h
//  ReadAddress
//
//  Created by admin on 17/5/8.
//  Copyright © 2017年 admin. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "MoreView.h"
@class DropDownMenuList;

/*! 视图view的高度 */
UIKIT_EXTERN CGFloat const DropMenuContentHeight;
/*! 确定按钮高度 */
UIKIT_EXTERN CGFloat const SureButtonHeight;


@interface HZIndexPath : NSObject
@property (nonatomic, assign) NSInteger  row; // 行
@property (nonatomic, assign) NSInteger  column; //列
// 构造HZIndexPath
+(instancetype)indexPathWithColumn:(NSInteger)column row:(NSInteger)row;

@end

@protocol DropDownMenuListDataSource <NSObject>
@required
// 设置显示列的内容
-(NSMutableArray *)menuNumberOfRowInColumn;
// 设置多少行显示
-(NSInteger)menu:(DropDownMenuList *)menu numberOfRowsInColum:(NSInteger)column;
// 设置显示没行的内容
-(NSString *)menu:(DropDownMenuList *)menu titleForRowAtIndexPath:(HZIndexPath *)indexPath;

@optional
// 每行图片
-(NSString *)menu:(DropDownMenuList *)menu imageNameForRowAtIndexPath:(HZIndexPath *)indexPath;
@end


@protocol DropDownMenuListDelegate <NSObject>
@optional
// 点击每一行的效果
- (void)menu:(DropDownMenuList *)segment didSelectRowAtIndexPath:(HZIndexPath *)indexPath;
// 点击没一列的效果
- (void)menu:(DropDownMenuList *)segment didSelectTitleAtColumn:(NSInteger)column;
// 每个栏目对应的点击事件
- (void)menu:(DropDownMenuList *)segment didSelectArry:(NSMutableArray *)cellSelect forColumn:(NSInteger)column;

@end

@interface DropDownMenuList : UIView

// 显示
+(instancetype)show:(CGPoint)orgin andHeight:(CGFloat)height;


// 代理
@property (nonatomic, weak) id<DropDownMenuListDelegate>  delegate;
@property (nonatomic, weak) id<DropDownMenuListDataSource>  dataSource;

//##################################


// 获取Title
-(NSString *)titleForRowAtIndexPath:(HZIndexPath *)indexPath;

-(instancetype)initWithOrgin:(CGPoint)origin andHeight:(CGFloat)height;

/*！
 *  页面即可消失没有动画
 *  解决在退出界面时，当前window上继续保留原有界面的bug
 * 看官只需要在你调用的VC上得viewWillDisappear里调用该方法
 */
-(void)rightNowDismis;


@end
