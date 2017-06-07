//
//  TaxDeclarePayInView.m
//  NingboSat
//
//  Created by ysyc_liu on 16/9/21.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "TaxDeclarePayInView.h"
#import "UIButton+YSSolidColorButton.h"
#import "YSDatePickerView.h"
#import "PickerViewModel.h"

#import "TaxSearchResultController.h"

@implementation TaxDeclarePayInView

- (void)initView {
    self.titleLabel.text = @"申报缴款查询";
    
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
    
    [self reShowView];
}


#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    NSArray *textArray = @[@"税种", @"所属期起", @"所属期止"];
    cell.textLabel.text = textArray[indexPath.row];
    {
        UITextField *textField = [[self class] textFieldWithPlaceholder:@""];
        textField.tag = indexPath.row;
        textField.delegate = self;
        textField.bounds = CGRectMake(0, 0, 200, 50);
        cell.accessoryView = textField;
    }
    
    return cell;
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (0 == textField.tag) {
        NSArray *array = @[@"增值税", @"消费税", @"企业所得税", @"企业所得税退税", @"车辆购置税", @"废弃电器电子产品处理基金收入", @"文化事业建设费", @"税务行政事业性收费收入", @"税务部门罚没收入", @"其他收入"];
        NSArray *typeArray = @[@"10101", @"10102", @"10104", @"10106", @"10116", @"30175", @"30217", @"30408", @"30501", @"39900"];
        
        PickerViewModel *viewModel = [[PickerViewModel alloc] init];
        viewModel.dataArray = @[array];
        PickerActionSheet *actionSheet = [[PickerActionSheet alloc] initWithViewModel:viewModel];
        viewModel.confirmBlock = ^(NSArray *selectedArray) {
            @try {
                NSInteger index = [selectedArray.firstObject integerValue];
                self.taxType = typeArray[index];
                textField.text = array[index];
            } @catch (NSException *exception) {
                NSLog(@"%@ : %@", [self class], exception);
            }
        };
        [actionSheet show];
    }
    else if (1 == textField.tag) {
        YSDatePickerView *datePickerView = [[YSDatePickerView alloc] init];
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
