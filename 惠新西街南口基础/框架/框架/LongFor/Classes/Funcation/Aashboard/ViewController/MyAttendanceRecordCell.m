//
//  MyAttendanceRecordCell.m
//  LongFor
//
//  Created by ruantong on 17/6/2.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "MyAttendanceRecordCell.h"
#import "UIColor+Helper.h"

@implementation MyAttendanceRecordCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)showData:(NSDictionary*)dic{
    if ([dic[@"status"] isEqualToString:@"1"]) {
        self.titleLabel.text = @"上班";
    }else{
        self.titleLabel.text = @"下班";
    }
    
    self.addressLab.text = dic[@"attendanceName"];
    self.timeLabel.text = dic[@"signTime"];
    
    NSString* signStatusStr = dic[@"signStatus"];
    self.stateLabel.text = signStatusStr;
    if ([signStatusStr isEqualToString:@"早退"]) {
        self.stateLabel.textColor = [UIColor colorWithHexString:@"25c7fc"];
    }else if ([signStatusStr isEqualToString:@"迟到"]) {
        self.stateLabel.textColor = [UIColor colorWithHexString:@"f7722a"];
    }else{
        self.stateLabel.textColor = [UIColor colorWithHexString:@"666666"];
    }

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
