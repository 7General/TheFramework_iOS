//
//  CustomAskCell.h
//  LongFor
//
//  Created by ZZG on 17/5/31.
//  Copyright © 2017年 admin. All rights reserved.
//
/*! 客户要求 */
#import <UIKit/UIKit.h>

@interface CustomAskCell : UITableViewCell

+(instancetype)askCellWithTableView:(UITableView *)tableView;

-(void)setCellWithArray:(NSArray *)array;

@end
