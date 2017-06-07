//
//  YSDatePickerView.m
//  NingboSat
//
//  Created by ysyc_liu on 16/9/22.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "YSDatePickerView.h"
#import "Config.h"
#import "Masonry.h"

@interface YSDatePickerView()

@property (nonatomic, strong)UIDatePicker *datePicker;

@end

@implementation YSDatePickerView

- (instancetype)init {
    self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 224)];
    if (self) {
        self.showConfirmBar = YES;
    }
    return self;
}

- (void)initView {
    [super initView];
    
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    [self.contentView addSubview:datePicker];
    datePicker.datePickerMode = UIDatePickerModeDate;
    datePicker.backgroundColor = YSColor(0xf5, 0xf5, 0xf5);
    [datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    self.datePicker = datePicker;
}

- (void)confirmBtnClick {
    [super confirmBtnClick];
    if (self.datePickerBlock) {
        self.datePickerBlock(self.datePicker.date);
    }
}

- (void)setDate:(NSDate *)date {
    if (!date) {
        return;
    }
    [self.datePicker setDate:date];
}

- (void)setDateStr:(NSString *)dateStr withFormat:(NSString *)format {
    @try {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:format];
        NSDate *date = [dateFormatter dateFromString:dateStr];
        [self setDate:date];
    } @catch (NSException *exception) {
        NSLog(@"%@ EXCEPTION: %@", [self class], exception);
    }
}

@end
