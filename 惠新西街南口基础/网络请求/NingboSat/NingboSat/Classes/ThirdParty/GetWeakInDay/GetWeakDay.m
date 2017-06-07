//
//  GetWeakDay.m
//  NingboSat
//
//  Created by 王会洲 on 16/11/22.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "GetWeakDay.h"


@implementation GetWeakDay

-(void)WeakInDay:(NSInteger)inDay compated:(void(^)(DateModel * model))complated {
    NSTimeInterval secondsPerDay = 24 * 60 * 60;
    NSDate * today = [NSDate date];
    NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
    [myDateFormatter setDateFormat:@"yyyy-MM-dd"];
    for (int days = 0; days < inDay; days ++) {
        // 日期字符串
        NSString *dateString = [myDateFormatter stringFromDate:[today dateByAddingTimeInterval:days * secondsPerDay]];
        // 星期字符串
        NSString * xq = [self calculateWeek:dateString];
        DateModel * model = [DateModel DateModelWith:dateString withWeak:xq];
        if (complated) {
            complated(model);
        }
    }
}


- (NSString *)calculateWeek:(NSString *)dateStr{
    NSString* string = dateStr;
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate* inputDate = [inputFormatter dateFromString:string];
    //计算week数
    NSCalendar * myCalendar = [NSCalendar currentCalendar];
    myCalendar.timeZone = [NSTimeZone systemTimeZone];
    NSInteger week = [[myCalendar components:NSCalendarUnitWeekday fromDate:inputDate] weekday];
    switch (week) {
        case 1:
        {
            return @"星期日";
        }
        case 2:
        {
            return @"星期一";
        }
        case 3:
        {
            return @"星期二";
        }
        case 4:
        {
            return @"星期三";
        }
        case 5:
        {
            return @"星期四";
        }
        case 6:
        {
            return @"星期五";
        }
        case 7:
        {
            return @"星期六";
        }
    }
    
    return @"";
}

@end
