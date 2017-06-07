//
//  NSDate+Helper.h
//  NingboSat
//
//  Created by 王会洲 on 16/12/1.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Helper)
/**date转换为string*/
-(NSString *)stringFromDate:(NSString *)format;

//传入今天的时间，返回明天的时间
- (NSString *)GetTomorrowDay;

@end
