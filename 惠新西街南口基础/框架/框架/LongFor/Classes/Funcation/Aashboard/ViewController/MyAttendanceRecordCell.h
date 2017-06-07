//
//  MyAttendanceRecordCell.h
//  LongFor
//
//  Created by ruantong on 17/6/2.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyAttendanceRecordCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLab;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;


-(void)showData:(NSDictionary*)dic;
@end
