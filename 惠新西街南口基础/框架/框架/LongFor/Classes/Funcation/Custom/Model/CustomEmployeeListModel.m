//
//  CustomEmployeeListModel.m
//  LongFor
//
//  Created by ruantong on 17/5/22.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "CustomEmployeeListModel.h"

@implementation CustomEmployeeListModel


- (void)setValue:(id)value forUndefinedKey:(NSString *)key  {
    NSLog(@"%@ Undefined Key: %@", [NSString stringWithUTF8String:object_getClassName(self)],key);
}

@end
