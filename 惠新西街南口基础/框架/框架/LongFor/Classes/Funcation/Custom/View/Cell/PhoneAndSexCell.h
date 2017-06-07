//
//  PhoneAndSexCell.h
//  LongFor
//
//  Created by ZZG on 17/5/31.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhoneAndSexCell : UITableViewCell

+(instancetype)phoneCellWithTableView:(UITableView *)tableView;

-(void)setcellGender:(NSString *)gend forTel:(NSString *)tel;

@end
