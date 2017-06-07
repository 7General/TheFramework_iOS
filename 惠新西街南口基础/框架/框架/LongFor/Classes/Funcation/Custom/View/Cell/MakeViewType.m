//
//  MakeViewType.m
//  LongFor
//
//  Created by ruantong on 17/5/26.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "MakeViewType.h"
#import "UIColor+Helper.h"
#import "UIView+Additions.h"

@implementation MakeViewType

+(UIButton*)makeButtonType1:(CGRect)frome{
    UIButton* bu = [UIButton buttonWithType:UIButtonTypeCustom];
    bu.frame = frome;
    bu.layer.cornerRadius = bu.height/2;
    bu.layer.masksToBounds=YES;
    bu.layer.borderWidth = 0.8;
    bu.layer.borderColor = [[UIColor colorWithHexString:@"ededed"] CGColor];
    [bu setTitleColor:[UIColor colorWithHexString:@"888888"] forState:UIControlStateNormal];
    
    return bu;
}


@end
