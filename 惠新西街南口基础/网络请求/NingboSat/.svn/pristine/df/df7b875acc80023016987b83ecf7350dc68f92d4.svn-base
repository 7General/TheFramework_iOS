//
//  YSTabBar.h
//  NingboSat
//
//  Created by 王会洲 on 16/9/6.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YSTabBar;
@protocol YSTabBarDelegate <NSObject>

@optional
- (void)tabBar:(YSTabBar *)tabBar didSelectButtonItem:(int)from to:(int)to;

@end


@interface YSTabBar : UIView

- (void)addTabBarButtonWithItem:(UITabBarItem *)tabBarItem;

@property (nonatomic, weak) id<YSTabBarDelegate>  delegate;

@property (nonatomic,weak) UIButton * selectButton;
@end
