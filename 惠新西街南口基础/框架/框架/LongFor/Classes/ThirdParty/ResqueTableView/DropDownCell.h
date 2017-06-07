//
//  DropDownCell.h
//  ReadAddress
//
//  Created by admin on 17/5/8.
//  Copyright © 2017年 admin. All rights reserved.
//

#define DDMWIDTH [UIScreen mainScreen].bounds.size.width
#define DDMHEIGHT [UIScreen mainScreen].bounds.size.height

#import <UIKit/UIKit.h>
#import "UIButton+helper.h"

typedef void(^stateSelectClik)(UIButton * statButton);

@interface DropDownCell : UITableViewCell
@property (nonatomic, weak) UIButton *stateButton;

+(instancetype)cellWithTableView:(UITableView *)tableview;
@property (nonatomic, copy) stateSelectClik stateBlock;
-(void)setStateBlock:(stateSelectClik)stateBlock;
-(void)setCellTitles:(NSString *)titles;

-(void)setCellState:(NSString *)states;
@end
