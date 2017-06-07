//
//  NSString+ruleCheck.h
//  NingboSat
//
//  Created by 田广 on 16/9/22.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ruleCheck)

- (BOOL)ruleCheckNormal;

//手机号格式校验
- (BOOL)ruleCheckMobile;

//邮箱号格式校验
- (BOOL)ruleCheckEmail;

@end
