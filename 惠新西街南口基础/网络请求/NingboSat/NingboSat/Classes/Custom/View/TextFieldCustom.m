//
//  TextFieldCustom.m
//  TicketCloud
//
//  Created by ysyc_liu on 16/1/26.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "TextFieldCustom.h"

@implementation TextFieldCustom


- (void)drawPlaceholderInRect:(CGRect)rect {
    CGRect rectNew = rect;
    rectNew.size.height = CGRectGetHeight(self.bounds);
    [super drawPlaceholderInRect:rectNew];
}
@end
