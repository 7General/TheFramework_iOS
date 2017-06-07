//
//  MSSCalendarCollectionViewCell.h
//  MSSCalendar
//
//  Created by 于威 on 16/4/3.
//  Copyright © 2016年 于威. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSSCircleLabel.h"

@interface MSSCalendarCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong)UIImageView *imageView;
@property (nonatomic,strong)MSSCircleLabel *dateLabel;
/**当天日期*/
@property (nonatomic,strong)UILabel *todayLabel;
@property (nonatomic,strong)UILabel *subLabel;
@property (nonatomic,assign)BOOL isSelected;

-(void)setSelectThem:(BOOL)select withStr:(NSString *)str;

@end
