//
//  otherAskCell.h
//  LongFor
//
//  Created by ZZG on 17/5/31.
//  Copyright © 2017年 admin. All rights reserved.
//

/*! 其他要求 */
#import <UIKit/UIKit.h>
#import "PriceBookMode.h"

@interface otherAskCell : UITableViewCell

+(instancetype)otherAskCellWithTableView:(UITableView *)tableView;
-(void)setCellWithPriceBookM:(PriceBookMode *)pm;
@end
