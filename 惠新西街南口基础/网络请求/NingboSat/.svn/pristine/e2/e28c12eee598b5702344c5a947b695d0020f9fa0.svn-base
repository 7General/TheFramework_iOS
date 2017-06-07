//
//  YSTabBarViewController.m
//  NingboSat
//
//  Created by 王会洲 on 16/9/6.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "YSTabBarViewController.h"
#import "YSTabBar.h"
#import "YSNavigationViewController.h"
#import "HomeViewController.h"
#import "QueryViewController.h"
#import "AssistantViewController.h"
#import "InteractiveViewController.h"
#import "MineViewController.h"
#import "YSWebController.h"
#import "YSNotificationManager.h"
#import "Config.h"


@interface YSTabBarViewController ()<YSTabBarDelegate>
@property(nonatomic, weak) YSTabBar * customBar;
@end

@implementation YSTabBarViewController

- (instancetype)init {
    if (self = [super init]) {
        [YSNotificationManager addConsultObserver:self selector:@selector(gotoConsult:)];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化tabbar
    [self setupTabBar];
    
    [self setupAllChildViewControllers];
        
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    for (UIView * child in self.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    for (UIView *subView in self.tabBar.subviews) {
        if ([subView isKindOfClass:[UIControl class]]) {
            [subView removeFromSuperview];
        }
    }
}




///初始化tabbar
- (void)setupTabBar {
    
    YSTabBar * customBar = [[YSTabBar alloc] init];
    //z****************
    customBar.frame = self.tabBar.bounds;
    [self.tabBar addSubview:customBar];
    
    customBar.delegate = self;
    self.customBar = customBar;
    
}

///监听tabbar
- (void)tabBar:(YSTabBar *)tabBar didSelectButtonItem:(int)from to:(int)to {
    self.selectedIndex = to;
}

- (void)setupAllChildViewControllers {
    // 1.首页
    HomeViewController *home = [[HomeViewController alloc] init];
    [self setupChildViewController:home title:@"主页" imageName:@"taxTabBarItem_01" selectedImageName:@"taxTabBarItem_checked_01"];

    // 2.查询
    QueryViewController * query = [[QueryViewController alloc] init];
    [self setupChildViewController:query title:@"查询" imageName:@"taxTabBarItem_02" selectedImageName:@"taxTabBarItem_checked_02"];
    
    // 3.助手
    AssistantViewController * assist = [[AssistantViewController alloc] init];
    [self setupChildViewController:assist title:@"助手" imageName:@"taxTabBarItem_03" selectedImageName:@"taxTabBarItem_checked_03"];
    
    // 4.互动
    InteractiveViewController * interactive = [[InteractiveViewController alloc] init];
    [self setupChildViewController:interactive title:@"互动" imageName:@"taxTabBarItem_04" selectedImageName:@"taxTabBarItem_checked_04"];

    // 5.我的
    MineViewController *message = [[MineViewController alloc] init];
    [self setupChildViewController:message title:@"我的" imageName:@"taxTabBarItem_05" selectedImageName:@"taxTabBarItem_checked_05"];
}

- (void)setupChildViewController:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    /**设置控制器的属性*/
    childVc.tabBarItem.title = title;
    /**设置图标*/
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    /**设置选中的图标*/
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    
    childVc.tabBarItem.selectedImage = selectedImage;
    
    //创建修改字体颜色的字典，同时可以设置字体的内边距；
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor colorWithRed:80/255.f green:80/255.f blue:80/255.f alpha:1];
    NSMutableDictionary *selectedTextAttrs = [NSMutableDictionary dictionary];
    selectedTextAttrs[NSForegroundColorAttributeName] = [UIColor colorWithRed:21/255.f green:85/255.f blue:200/255.f alpha:1];
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [childVc.tabBarItem setTitleTextAttributes:selectedTextAttrs forState:UIControlStateSelected];
    /**包装一个导航控制器*/
    YSNavigationViewController * nav = [[YSNavigationViewController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];
    
    [self.customBar addTabBarButtonWithItem:childVc.tabBarItem];
}


#pragma mark - notification observer action
- (void)gotoConsult:(NSNotification *)sender {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.selectedIndex = 3;
        for (id subView in self.tabBar.subviews) {
            if ([subView isKindOfClass:[YSTabBar class]]) {
                YSTabBar *tabBar = subView;
                tabBar.selectButton.selected = NO;
                UIButton *button = [tabBar viewWithTag:3];
                tabBar.selectButton = button;
                button.selected = YES;
                break;
            }
        }
        InteractiveViewController * interactive = (InteractiveViewController *)[(UINavigationController *)self.selectedViewController topViewController];
        interactive.urlStr = sender.userInfo[YSConsultUrl];
    });
}

@end
