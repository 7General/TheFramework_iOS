//
//  MailLocateCell.h
//  NingboSat
//
//  Created by ysyc_liu on 16/9/14.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "YSTableViewCell.h"
#import "MailAddressModel.h"

@protocol MailLocateCellDelegate <NSObject>

- (void)editButtonClick:(id)model;

@end

@interface MailLocateCell : YSTableViewCell

@property (nonatomic, weak) id<MailLocateCellDelegate> delegate;

- (void)setCellByModel:(id)model isEdit:(BOOL)isEdit;
+ (CGFloat)heightNeededByModel:(id)model andWidth:(CGFloat)width isEdit:(BOOL)isEdit;

@end
