//
//  bookTimeCell.h
//  NingboSat
//
//  Created by 王会洲 on 16/11/17.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface bookTimeCell : UITableViewCell

+(instancetype)cellWith:(UITableView *)tableview;


/**标题*/
@property (nonatomic, weak) UILabel * itemName;

/**日期*/
@property (nonatomic, weak) UILabel * dateShortStr;
/**时间*/
@property (nonatomic, weak) UILabel * timeShortStr;
@end
