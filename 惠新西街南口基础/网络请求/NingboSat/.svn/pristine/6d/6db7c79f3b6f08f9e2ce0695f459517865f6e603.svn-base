//
//  NSDate+CalendarHelper.m
//  MSSCalendar
//
//  Created by 王会洲 on 16/11/30.
//  Copyright © 2016年 于威. All rights reserved.
//

#import "NSDate+CalendarHelper.h"

@implementation NSDate (CalendarHelper)
//下一个月
- (NSDate *)dayInTheFollowingMonth {
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = 1;
    return [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
}


//获取当前日期之后的几个月
- (NSDate *)dayInTheFollowingMonth:(int)month {
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = month;
    return [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
}
@end
