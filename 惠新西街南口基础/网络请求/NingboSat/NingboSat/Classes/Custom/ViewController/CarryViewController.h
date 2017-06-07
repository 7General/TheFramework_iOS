//
//  CarryViewController.h
//  NingboSat
//
//  Created by 王会洲 on 16/9/6.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CarryViewController : UIViewController

///设置标题
@property (strong ,nonatomic) UILabel *titleLabel;
///返回按钮
@property (strong ,nonatomic) UIButton *backButton;
///导航ImageView
@property (strong,nonatomic)UIImageView *navigationImageView;


///pop
-(void)back;



@end
 