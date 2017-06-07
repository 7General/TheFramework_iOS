//
//  MSSCalendarCollectionViewCell.m
//  MSSCalendar
//
//  Created by 于威 on 16/4/3.
//  Copyright © 2016年 于威. All rights reserved.
//

#import "MSSCalendarCollectionViewCell.h"
#import "MSSCalendarDefine.h"

@implementation MSSCalendarCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    {
        [self createCell];
    }
    return self;
}

- (void)createCell {
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height)];
    [self.contentView addSubview:_imageView];
    
    _dateLabel = [[MSSCircleLabel alloc]initWithFrame:CGRectMake(4, MSS_Iphone6Scale(0), 36, 36)];
    _dateLabel.textAlignment = NSTextAlignmentCenter;
    _dateLabel.font = [UIFont systemFontOfSize:18.0f];
    [self.contentView addSubview:_dateLabel];
    
    _todayLabel = [[UILabel alloc]initWithFrame:CGRectMake(4, MSS_Iphone6Scale(0), 36, 36)];
    _todayLabel.textAlignment = NSTextAlignmentCenter;
    _todayLabel.font = [UIFont systemFontOfSize:18.0f];
    _todayLabel.hidden = YES;
    [self.contentView addSubview:_todayLabel];
    
    _subLabel = [[UILabel alloc]initWithFrame:CGRectMake(-6, CGRectGetMaxY(_dateLabel.frame) - 5, self.contentView.frame.size.width, _dateLabel.frame.size.height)];
    _subLabel.textAlignment = NSTextAlignmentCenter;
    _subLabel.font = [UIFont systemFontOfSize:10.0f];
    _subLabel.textColor = MSS_UTILS_COLORRGB(180, 180, 180);
    [self.contentView addSubview:_subLabel];
}

- (void)setIsSelected:(BOOL)isSelected{
    _dateLabel.isSelected = isSelected;
}


-(void)setSelectThem:(BOOL)select withStr:(NSString *)str {
    if (select) {
        // 替代品显示
        _todayLabel.hidden = NO;
        _todayLabel.layer.borderWidth = 1;
        _todayLabel.layer.cornerRadius = 18;
        _todayLabel.layer.masksToBounds = YES;
        _todayLabel.text = str;
        _todayLabel.layer.borderColor = MSS_UTILS_COLORRGB(75, 196, 251).CGColor;
        _todayLabel.textColor = MSS_UTILS_COLORRGB(75, 196, 251);
       
        _subLabel.text = @"今天";
        
        
        _dateLabel.hidden = YES;
    }else {
        // 替代品影藏
        _todayLabel.hidden = YES;
        
        _todayLabel.layer.borderWidth = 0;
        _todayLabel.layer.cornerRadius = 0;
        _todayLabel.layer.masksToBounds = YES;
        _todayLabel.text = @"";
        _todayLabel.layer.borderColor = nil;//MSS_UTILS_COLORRGB(75, 196, 251).CGColor;
        _todayLabel.textColor = nil;//MSS_UTILS_COLORRGB(75, 196, 251);

        
        
        _dateLabel.hidden = NO;
        
        _subLabel.text = @"";
    }
}

@end
