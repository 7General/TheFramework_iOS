//
//  UIButton+countdown.m
//  NingboSat
//
//  Created by 田广 on 16/9/22.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "UIButton+countdown.h"

@implementation UIButton (countdown)

-(void)countdownWithNumber:(NSNumber *)num{
        [self setTitle:[NSString stringWithFormat:@"%@s",num] forState:UIControlStateSelected];
        if ([num intValue] <= 0) {
            self.selected = NO;
            self.userInteractionEnabled = YES;
            [self setTitle:@"重新获取" forState:UIControlStateSelected];
            return;
        }
        else {
            self.selected = YES;
            self.userInteractionEnabled = NO;
            NSNumber *countDownNum = [NSNumber numberWithInt:[num intValue]-1];
            [self performSelector:@selector(countdownWithNumber:) withObject:countDownNum afterDelay:1];
            
        }

}

@end
