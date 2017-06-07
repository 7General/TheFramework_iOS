//
//  ZZGNavigationController.m
//  AllBasic
//
//  Created by admin on 17/5/4.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "ZZGNavigationController.h"
#import "UIView+Additions.h"
#import "ConfigUI.h"
#import "UIColor+Helper.h"


@interface ZZGNavigationController ()<UINavigationControllerDelegate,UIGestureRecognizerDelegate>

@end

@implementation ZZGNavigationController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationBar.barTintColor = [UIColor colorWithHexString:@"#2F96FF"];
    self.navigationBar.translucent = NO;
    [self.navigationBar setTitleTextAttributes:@{
                                                 NSForegroundColorAttributeName:[UIColor whiteColor]//字体颜色
                                                 }];

    
    //设置手势代理.
    self.interactivePopGestureRecognizer.delegate = self;
    self.delegate = self;
}


/**
 * 在这个方法中可以拦截所有push进来的控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // 只有push进来的不是第一个控制器才进行如下操作
    if(self.childViewControllers.count > 0) {
        // 设置导航栏的返回按钮
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//        [button setTitle:@"返回" forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        //[button setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        button.size = CGSizeMake(70, 30);
        
        // 让按钮内部所有内容左对齐
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        // 让按钮的内容往左偏移10
        button.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        // 为按钮添加点击事件
        [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        // 修改导航栏左边的item
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        // 隐藏TabBar
        viewController.hidesBottomBarWhenPushed = YES;
    }
    // 这句super的push要放在后面, 让viewController可以覆盖上面设置的leftBarButtonItem
    [super pushViewController:viewController animated:animated];
}

- (void)back {
    [self popViewControllerAnimated:YES];
}




#pragma mark - UIGestureRecognizerDelegate

///  手势代理.
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return self.childViewControllers.count > 1;
}

#pragma mark - navigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
//    if ( [viewController isKindOfClass:[CustomInfoController class]]) {
//        [navigationController setNavigationBarHidden:YES animated:animated];
//    } else if ( [navigationController isNavigationBarHidden] ) {
//        [navigationController setNavigationBarHidden:NO animated:animated];
//    }
}


@end
