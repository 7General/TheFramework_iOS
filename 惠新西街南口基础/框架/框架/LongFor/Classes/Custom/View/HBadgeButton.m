//
//  HBadgeButton.m
//  LongFor
//
//  Created by ZZG on 17/5/18.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "HBadgeButton.h"

@implementation HBadgeButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.hidden = YES;
        self.userInteractionEnabled = NO;
        //[badgeButton setBackgroundImage:[UIImage imageWithName:@"main_badge"] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageNamed:@"main_badge"] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:11];
    }
    return self;
}

- (void)setBadgeValue:(NSString *)badgeValue {
    /////
    _badgeValue = [badgeValue copy];
    
    if (badgeValue) {
        self.hidden = NO;
        [self setTitle:badgeValue forState:UIControlStateNormal];
        
        CGRect frame = self.frame;
        
        CGFloat badgeH = self.currentBackgroundImage.size.height;
        CGFloat badgeW = self.currentBackgroundImage.size.width;
        
        if (badgeValue.length > 1) {
            //文字尺寸
            NSDictionary *attrs = @{NSFontAttributeName : BadgeTextFont};
            CGSize badgeSize = [badgeValue boundingRectWithSize:CGSizeMake(100, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
            badgeW = badgeSize.width + 10;
        }
        
        frame.size.width = badgeW;
        frame.size.height = badgeH;
        self.frame = frame;
    }else{
        self.hidden = YES;
    }
}

@end
