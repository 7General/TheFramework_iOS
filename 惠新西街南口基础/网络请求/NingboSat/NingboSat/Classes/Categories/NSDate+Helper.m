//
//  NSDate+Helper.m
//  NingboSat
//
//  Created by 王会洲 on 16/12/1.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "NSDate+Helper.h"

@implementation NSDate (Helper)

-(NSString *)stringFromDate:(NSString *)format {
    NSDateFormatter *Formatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [Formatter setDateFormat:format];
    return  [Formatter stringFromDate:self];
}

//传入今天的时间，返回明天的时间
- (NSString *)GetTomorrowDay {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:NSCalendarUnitWeekday | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:self];
    [components setDay:([components day]+1)];
    
    NSDate *beginningOfWeek = [gregorian dateFromComponents:components];
    NSDateFormatter *dateday = [[NSDateFormatter alloc] init];
    [dateday setDateFormat:@"yyyy-MM-dd"];
    return [dateday stringFromDate:beginningOfWeek];
}

@end
