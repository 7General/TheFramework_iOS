//
//  YSDatePickerView.h
//  NingboSat
//
//  Created by ysyc_liu on 16/9/22.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "YSActionSheetView.h"

typedef void (^DatePickerViewBlock)(NSDate *date);

@interface YSDatePickerView : YSActionSheetView

@property (nonatomic, copy)DatePickerViewBlock datePickerBlock;

- (void)setDate:(NSDate *)date;
- (void)setDateStr:(NSString *)dateStr withFormat:(NSString *)format;

@end
