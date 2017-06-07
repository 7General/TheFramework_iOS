//
//  YSTableViewCell.h
//  NingboSat
//
//  Created by ysyc_liu on 16/9/14.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YSTableViewCell : UITableViewCell

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

- (void)initView;

- (void)setCellByModel:(id)model;

+ (CGFloat)heightNeededByModel:(id)model andWidth:(CGFloat)width;

@end
