//
//  tallyButtonView.m
//  LongFor
//
//  Created by ruantong on 17/5/25.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "TallyButtonView.h"
#import "UIView+Additions.h"
#import "UIColor+Helper.h"

@implementation TallyButtonView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}



-(void)makeViewWith:(CGRect)frame andDataStrArr:(NSArray*)strArr andNum:(int)num andButtonHeight:(CGFloat)buheight andButtonHJianju:(CGFloat)Hjianju  andButtonWithForFrameWith:(CGFloat)buWith andDelegate:(UIViewController<ChangeBiaoQian>*)delegate andViewKey:(NSString*)viewKey andBiao:(NSString*)biao{
    _tallyButtonsArr = strArr;
    self.viewKey = viewKey;
    self.biao = biao;
    self.delegate = delegate;
    self.frame = frame;
    self.backgroundColor = [UIColor whiteColor];
    
    CGFloat ww = frame.size.width;
    CGFloat wjianxi = (ww-buWith*num)/(num+1);
    
    for (int i =0;i<strArr.count;i++) {
        NSString* texts = self.tallyButtonsArr[i];
        int xx = i%num;
        int yy = i/num;
        UIButton* bu = [UIButton buttonWithType:UIButtonTypeCustom];
        bu.frame = CGRectMake(wjianxi+xx*(buWith+wjianxi), (yy*(Hjianju+buheight)), buWith, buheight);
        bu.tag = 8736400+i;
        
        bu.layer.cornerRadius = bu.height/2;
        bu.layer.masksToBounds=YES;
        bu.layer.borderWidth = 1;
        bu.layer.borderColor = [[UIColor colorWithHexString:@"dedede"] CGColor];
        
        [bu addTarget:self action:@selector(tallybut:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:bu];
        
        UILabel* la = [[UILabel alloc] initWithFrame:CGRectMake(bu.height/4.0, 0, bu.width-bu.height/2.0, bu.height)];
        la.tag = 93862;
        la.userInteractionEnabled = NO;
        la.textAlignment = NSTextAlignmentCenter;
        la.text = texts;
        la.font = [UIFont systemFontOfSize:13];
        la.adjustsFontSizeToFitWidth = YES;
        la.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
//        la.backgroundColor = [UIColor yellowColor];
        la.textAlignment = NSTextAlignmentCenter;
        la.textColor = [UIColor colorWithHexString:@"888888"];
        
        [bu addSubview:la];
        
        if (i== self.tallyButtonsArr.count-1) {
            self.height = bu.bottom;
        }
    }
}

-(void)tallybut:(UIButton*) bu{
    NSLog(@"点击了but = %d --- %@",bu.tag-8736400,self.tallyButtonsArr[bu.tag-8736400]);
    
    if (bu.selected) {
        bu.selected = NO;
        bu.layer.borderColor = [[UIColor colorWithHexString:@"dedede"] CGColor];
        bu.backgroundColor = [UIColor whiteColor];
        UILabel* la = (UILabel*)[bu viewWithTag:93862];
        la.textColor = [UIColor colorWithHexString:@"888888"];
        
        if ([self.delegate respondsToSelector:@selector(changeBiaoQianStatus: andViewKey: andBiao:)]) {
            [self.delegate changeBiaoQianStatus:@"" andViewKey:self.viewKey andBiao:self.biao];
        }

    }else{
        for (int i = 0; i<self.tallyButtonsArr.count; i++) {
            UIButton* bus = (UIButton*)[self viewWithTag:8736400+i];
            if (bus.selected) {
                bus.selected = NO;
                bus.layer.borderColor = [[UIColor colorWithHexString:@"dedede"] CGColor];
                bus.backgroundColor = [UIColor whiteColor];
                UILabel* las = (UILabel*)[bus viewWithTag:93862];
                las.textColor = [UIColor colorWithHexString:@"888888"];
            }
        }
        bu.selected = YES;
        bu.layer.borderColor = [[UIColor colorWithHexString:@"25c7fc"] CGColor];
        bu.backgroundColor = [UIColor colorWithHexString:@"25c7fc"];
        UILabel* la = (UILabel*)[bu viewWithTag:93862];
        la.textColor = [UIColor whiteColor];
        
        if ([self.delegate respondsToSelector:@selector(changeBiaoQianStatus: andViewKey: andBiao:)]) {
            [self.delegate changeBiaoQianStatus:self.tallyButtonsArr[bu.tag-8736400] andViewKey:self.viewKey andBiao:self.biao];
        }
    }
}



@end
