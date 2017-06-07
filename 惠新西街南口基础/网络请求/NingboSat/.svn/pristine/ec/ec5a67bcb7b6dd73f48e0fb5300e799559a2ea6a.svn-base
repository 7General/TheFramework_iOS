//
//  YSNavigationViewController.m
//  eTax
//
//  Created by 田广 on 16/3/27.
//  Copyright © 2016年 ysyc. All rights reserved.
//

#import "YSNavigationViewController.h"
#import "YSTabBarViewController.h"
#import "HomeViewController.h"
#import "YSWebController.h"
#import "Config.h"
#import "MineViewController.h"
#import "QueryViewController.h"
#import "InteractiveViewController.h"
#import "AssistantViewController.h"

#import "MailInvoiceReadMeController.h"
#import "ReadViewController.h"
#import "MSSCalendarViewController.h"

/**大于6的屏幕 统一文字加 +2*/
#define BLODFONT(obj) [UIFont fontWithName:@"Helvetica-Bold" size:obj]
#define TITLE_FONTE(obj) ({SCREEN_WIDTH >= 414 ? BLODFONT(obj + 2) :  BLODFONT(obj);})


@interface YSNavigationViewController ()<UIGestureRecognizerDelegate,UINavigationControllerDelegate>

@end

@implementation YSNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置手势代理.
    self.interactivePopGestureRecognizer.delegate = self;
    self.delegate = self;
    
    //
    self.navigationBar.translucent = NO;
    
    //设置NavigationBar.
    [self setupNavigationBar];
    
}

///  设置导航栏主题.
- (void)setupNavigationBar
{
    UINavigationBar *appearance = [UINavigationBar appearance];
    //统一设置导航栏颜色，如果单个界面需要设置，可以在viewWillAppear里面设置，在viewWillDisappear设置回统一格式.
    //[appearance setBackgroundImage:[UIImage imageNamed:@"navigationBarBg"] forBarMetrics:UIBarMetricsDefault];
    //导航栏title格式.
    NSMutableDictionary *textAttribute = [NSMutableDictionary dictionary];
    textAttribute[NSForegroundColorAttributeName] = [UIColor colorWithRed:50/255.f green:50/255.f blue:50/255.f alpha:1];
    textAttribute[NSFontAttributeName] = TITLE_FONTE(17);
    [appearance setTitleTextAttributes:textAttribute];

    [appearance setBarTintColor:YSColor(255, 255, 255)];
    
    //UINavigationBar隐藏边线
//    [appearance setShadowImage:[[UIImage alloc]init]];
  
    [self setNavigationBottomLineColor];
}

/**修改导航栏底部横线颜色*/
-(void)setNavigationBottomLineColor {
    UIImageView * imageView = [self findHairlineImageViewUnder:self.navigationBar];
    CGRect bottomLineRect = imageView.frame;
    bottomLineRect.size.height = 1;
    [imageView removeFromSuperview];
    UIImageView * image = [[UIImageView alloc]initWithFrame:bottomLineRect];
    image.backgroundColor = YSColor(230, 230, 230);
    [self.navigationBar insertSubview:image atIndex:0];
}

- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        
        UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 44)];
        UIImage * image = [UIImage imageNamed:@"backBlack"];
        [backButton setImage:image forState:UIControlStateNormal];
        backButton.adjustsImageWhenHighlighted = NO;
        CGFloat diff =  (CGRectGetWidth(backButton.bounds) - image.size.width) / 2 - 10; // 设置图标离左边距10.
        [backButton setImageEdgeInsets:UIEdgeInsetsMake(0,-diff, 0, diff)];
        [backButton addTarget:self action:@selector(popView) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem * barButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
        UIBarButtonItem * spaceItem = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
        spaceItem.width = (KWidthScale > 1) ? -20 : -16; // 设置宽度, 令backButton的x坐标从0开始.
        if ([viewController isKindOfClass:[MSSCalendarViewController class]] ) {
            viewController.navigationItem.leftBarButtonItems = @[];
        }else {
            viewController.navigationItem.leftBarButtonItems = @[spaceItem, barButtonItem];
        }
        
    }
    [super pushViewController:viewController animated:animated];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    NSArray * viewControllers = self.viewControllers;
    if (viewControllers.count > 2 && [viewControllers[viewControllers.count - 2] isKindOfClass:[MailInvoiceReadMeController class]]) {
        return [self popToViewController:viewControllers[viewControllers.count - 3] animated:animated].lastObject;
    }
    else {
        return [super popViewControllerAnimated:animated];
    }
}

- (void)popView
{
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
    static NSArray * excludeArray = nil;
    if (!excludeArray) {
        excludeArray = @[[YSTabBarViewController class],
                         [HomeViewController class],
                         [MineViewController class],
                         [YSWebController class],
                         [QueryViewController class],
                         [InteractiveViewController class],
                         [AssistantViewController class]
                         ];
    }
    if ([excludeArray containsObject:[viewController class]]) {
        [navigationController setNavigationBarHidden:YES animated:animated];
    } else if ( [navigationController isNavigationBarHidden] ) {
        [navigationController setNavigationBarHidden:NO animated:animated];
    }
    

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
