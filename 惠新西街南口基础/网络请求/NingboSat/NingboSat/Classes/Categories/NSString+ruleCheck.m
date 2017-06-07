//
//  NSString+ruleCheck.m
//  NingboSat
//
//  Created by 田广 on 16/9/22.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "NSString+ruleCheck.h"
#import <UIKit/UIKit.h>
@implementation NSString (ruleCheck)

- (BOOL)ruleCheckNormal{
    return YES;
}


- (BOOL)ruleCheckMobile{
    NSString *regex =@"(1)\\d{10}";
    NSPredicate *mobileRule = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isRule = [mobileRule evaluateWithObject:self];
    if (isRule == NO) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"手机号码格式不正确" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
//        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"手机号码格式不正确" message:@"" preferredStyle:UIAlertControllerStyleAlert];
//        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            
//        }];
//        [alertController addAction:sureAction];
//        [self presentViewController:alertController animated:YES completion:nil];


    }
    
    return isRule;
}
- (BOOL)ruleCheckEmail{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailRule = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    BOOL isRule = [emailRule evaluateWithObject:self];
    if (isRule == NO) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"邮箱格式不正确" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }
    return isRule;
}


@end
