//
//  CustomInfoCell.h
//  LongFor
//
//  Created by ZZG on 17/5/27.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomInfoFrame.h"

@interface CustomInfoCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView;
/*! 跟进信息frame */
@property (nonatomic, strong) CustomInfoFrame *CIFrame;

@end

@interface UILabel (create)
+(UILabel *)label:(UIColor *)textColor forFont:(CGFloat)font;
@end




