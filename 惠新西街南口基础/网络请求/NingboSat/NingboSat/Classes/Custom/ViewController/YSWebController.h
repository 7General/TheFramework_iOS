//
//  YSWebController.h
//  NingboSat
//
//  Created by ysyc_liu on 16/9/26.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YSWebController : UIViewController
// 是否隐藏添加的状态栏背景遮挡.
@property (nonatomic, assign)BOOL hideStatusCover;
@property (nonatomic, assign)BOOL showNavigation;
@property (nonatomic, copy)NSString *urlStr;



/**
 初始化函数.
 当控制器不是由 UINavigationController 管理的时候, 需要指定一个由UINavigationController 管理的控制器, 用户内部实现相应的页面管理.

 @param viewController 最近的由UINavigationController 管理的控制器
 @return 初始化结果.
 */
- (instancetype)initWithController:(UIViewController *)viewController;


/**
 设置可缩放.
 */
- (void)setEnableScale;

@end
