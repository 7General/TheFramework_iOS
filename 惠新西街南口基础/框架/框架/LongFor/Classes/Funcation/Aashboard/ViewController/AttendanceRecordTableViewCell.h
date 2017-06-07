//
//  AttendanceRecordTableViewCell.h
//  LongFor
//
//  Created by ruantong on 17/6/3.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AttendanceRecordTableViewCell : UITableViewCell

@property(nonatomic)CGFloat lw;

@property(nonatomic,retain)UILabel* nameLab;
@property(nonatomic,retain)UILabel* addressLab;
@property(nonatomic,retain)UILabel* inWorkLab;
@property(nonatomic,retain)UILabel* upWorkLab;
@property(nonatomic,retain)UIImageView* image1;
@property(nonatomic,retain)UIImageView* image2;

-(void)showUIForData:(NSDictionary*)dic;
@end
