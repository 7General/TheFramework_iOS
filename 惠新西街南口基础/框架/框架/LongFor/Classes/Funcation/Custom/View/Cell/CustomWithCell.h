//
//  CustomWithCell.h
//  LongFor
//
//  Created by ZZG on 17/5/31.
//  Copyright © 2017年 admin. All rights reserved.
//

/*! 关系客户 */
#import <UIKit/UIKit.h>
#import "RelativeModel.h"

@interface CustomWithCell : UITableViewCell
+(instancetype)withAskCellWithTableView:(UITableView *)tableView;

-(void)setCellRelativeData:(RelativeModel *)rm;

@end
