//
//  CarryViewController.h
//  NingboSat
//
//  Created by 王会洲 on 16/9/6.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "CarryViewController.h"
#import "CustomConfig.h"


@interface CarryViewController (){
    }

@end

@implementation CarryViewController


- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationController.navigationBar.hidden = YES;

    self.view.backgroundColor =[UIColor whiteColor];
    
    //导航条
    _navigationImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,0, [UIScreen mainScreen].bounds.size.width,44+20)];
   
    _navigationImageView.backgroundColor = YColor(226, 38, 40);
    
    _navigationImageView.userInteractionEnabled = YES;
    [self.view addSubview:_navigationImageView];
    
    

    
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,20,[UIScreen mainScreen].bounds.size.width, 44)];
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.font = [UIFont fontWithName:@"Helvetica" size:18];
    [_navigationImageView addSubview:_titleLabel];
    
    _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _backButton.frame = CGRectMake(0,19,50,40);
    [_backButton setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    [_backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [_navigationImageView addSubview:_backButton];

}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
