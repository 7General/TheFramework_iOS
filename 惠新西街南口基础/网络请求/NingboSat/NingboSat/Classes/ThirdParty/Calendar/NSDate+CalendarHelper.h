//
//  NSDate+CalendarHelper.h
//  MSSCalendar
//
//  Created by 王会洲 on 16/11/30.
//  Copyright © 2016年 于威. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (CalendarHelper)
/**下一个月*/
- (NSDate *)dayInTheFollowingMonth;

/**当前日期之后的几个月*/
- (NSDate *)dayInTheFollowingMonth:(int)month;
@end
