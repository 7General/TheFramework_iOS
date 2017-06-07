//
//  AashboardController.m
//  LongFor
//
//  Created by admin on 17/5/9.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "AashboardController.h"

#import "ConfigUI.h"
#import "ControlCreate.h"

#import "HAlertView.h"


@interface AashboardController ()

@end

@implementation AashboardController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

-(void)initView {

    self.navigationItem.title = @"应用";
    self.view.backgroundColor = SColor(248, 248, 248);
    
}


@end
