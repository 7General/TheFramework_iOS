//
//  MineViewController.m
//  LongFor
//
//  Created by admin on 17/5/9.
//  Copyright © 2017年 admin. All rights reserved.
//
#define ICON_TITLE @"title"
#define ICON @"img"

#import "MineViewController.h"
#import "UIView+Additions.h"
#import "UIColor+Helper.h"
#import "FilterMannger.h"
#import "AppDelegate.h"

#import "HAlertView.h"


@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,retain)UIImageView* headImgView;

@property (nonatomic, strong) NSMutableDictionary *mineData;
@property (nonatomic, strong) NSArray *sectionArry;
@end

@implementation MineViewController

#pragma mark - lazye


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的";
    
}

@end
