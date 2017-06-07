//
//  TaxApplicationView.m
//  NingboSat
//
//  Created by ysyc_liu on 16/9/21.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "TaxApplicationView.h"
#import "YSAlertView.h"
#import "UIButton+YSSolidColorButton.h"
#import "YSDatePickerView.h"
#import "PickerViewModel.h"

@interface TaxApplicationView()

@property (nonatomic, copy)NSString *taxTypeStr;

@end

@implementation TaxApplicationView

- (void)initView {
    self.titleLabel.text = @"涉税申请查询";
    
    {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 70, 44 + 30 * 2)];
        UIButton *button = [UIButton buttonWithColor:YSColor(0x4b, 0xc4, 0xfb) title:@"查询"];
        [view addSubview:button];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(SCREEN_WIDTH - 70);
            make.height.mas_equalTo(44);
            make.center.equalTo(view);
        }];
        self.tableView.tableFooterView = view;
        self.commitBtn = button;
    }
    
    [self initData];
}

- (void)initData {
    NSDate *date = [NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setMonth:-1]; // 默认起始时间为当天的前一个月
    NSDate *sDate = [calendar dateByAddingComponents:comps toDate:date options:0];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    
    self.taxTypeStr = @"全部";
    self.taxType = @"";
    self.beginTime = [dateFormatter stringFromDate:sDate];
    self.endTime = [dateFormatter stringFromDate:date];
    [self reShowView];
}

#pragma mark - set and get


#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    NSArray *textArray = @[@"处理状态", @"申请时间起", @"申请时间止"];
    cell.textLabel.text = textArray[indexPath.row];
    {
        UITextField *textField = [[self class] textFieldWithPlaceholder:@""];
        textField.tag = indexPath.row;
        textField.delegate = self;
        textField.bounds = CGRectMake(0, 0, 200, 50);
        cell.accessoryView = textField;
        if (0 == indexPath.row) {
            textField.text = self.taxTypeStr;
        }
        else if (1 == indexPath.row) {
            textField.text = self.beginTime;
        }
        else if (2 == indexPath.row) {
            textField.text = self.endTime;
        }
    }
    
    return cell;
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (0 == textField.tag) {
        NSArray *array = @[@"全部", @"已申请待审核", @"审核中", @"同意受理", @"不予受理", @"已完成"];
        NSArray *typeArray = @[@"", @"0", @"1", @"2", @"3", @"99"];
        
        PickerViewModel *viewModel = [[PickerViewModel alloc] init];
        viewModel.dataArray = @[array];
        PickerActionSheet *actionSheet = [[PickerActionSheet alloc] initWithViewModel:viewModel];
        viewModel.confirmBlock = ^(NSArray *selectedArray) {
            @try {
                NSInteger index = [selectedArray.firstObject integerValue];
                self.taxType = typeArray[index];
                self.taxTypeStr = array[index];
                textField.text = array[index];
            } @catch (NSException *exception) {
                NSLog(@"%@ : %@", [self class], exception);
            }
        };
        [actionSheet show];
    }
    else if (1 == textField.tag) {
        YSDatePickerView *datePickerView = [[YSDatePickerView alloc] init];
        [datePickerView setDateStr:self.beginTime withFormat:@"yyyyMMdd"];
        [datePickerView show];
        [datePickerView setDatePickerBlock:^(NSDate *date){
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyyMMdd"];
            self.beginTime = [dateFormatter stringFromDate:date];
            textField.text = self.beginTime;
        }];
    }
    else if (2 == textField.tag) {
        YSDatePickerView *datePickerView = [[YSDatePickerView alloc] init];
        [datePickerView setDateStr:self.endTime withFormat:@"yyyyMMdd"];
        [datePickerView show];
        [datePickerView setDatePickerBlock:^(NSDate *date){
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyyMMdd"];
            self.endTime = [dateFormatter stringFromDate:date];
            textField.text = self.endTime;
        }];
    }
    return NO;
}

@end
