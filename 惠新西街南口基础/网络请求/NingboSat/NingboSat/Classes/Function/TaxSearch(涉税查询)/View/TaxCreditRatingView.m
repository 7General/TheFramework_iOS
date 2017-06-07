//
//  TaxCreditRatingView.m
//  NingboSat
//
//  Created by ysyc_liu on 16/9/21.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "TaxCreditRatingView.h"
#import "PickerActionSheet.h"

@interface TaxCreditRatingView()<PickerActionSheetDelegate,UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic, copy)NSString *searchYear;
@property (nonatomic, copy)TaxCreditRatingModel *dataModel;

@property (nonatomic, strong)NSMutableArray *searchYearArray;

@end

@implementation TaxCreditRatingView

- (void)initView {
    self.titleLabel.text = @"纳税人信用等级查询";
    
    [self initData];
}

- (void)initData {
    
    [self reShowView];
}

- (void)loadData:(TaxCreditRatingModel *)viewData {
    self.dataModel = viewData;
    [super loadData:viewData];
}

#pragma mark - set and get
- (NSMutableArray *)searchYearArray {
    if (!_searchYearArray) {
        _searchYearArray = [NSMutableArray array];
        for (int i = 1970; i < 2100; i++) {
            [_searchYearArray addObject:[NSString stringWithFormat:@"%d", i]];
        }
    }
    
    return _searchYearArray;
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    
    NSArray *textArray = @[@"查询年度", @"纳税人识别号", @"纳税人名称", [NSString stringWithFormat:@"您%@年的信用等级为", self.searchYear]];
    cell.textLabel.text = textArray[indexPath.row];
    cell.textLabel.highlighted = !(0 == indexPath.row);
    
    cell.accessoryView = nil;
    cell.detailTextLabel.text = nil;
    
    switch (indexPath.row) {
        case 0: {
            UITextField *textField = [[self class] textFieldWithPlaceholder:@""];
            textField.delegate = self;
            textField.bounds = CGRectMake(0, 0, 100, 50);
            if (self.searchYear) {
                textField.text = [NSString stringWithFormat:@"%@年", self.searchYear];
            }
            else {
                textField.text = nil;
            }
            cell.accessoryView = textField;
            break;
        }
        case 1:
            cell.detailTextLabel.text = self.dataModel.taxpayerCode;
            break;
        case 2:
            cell.detailTextLabel.text = self.dataModel.taxpayerName;
            break;
        case 3:
            cell.detailTextLabel.text = self.dataModel.creditRating;
            break;
            
        default:
            break;
    }
    
    return cell;
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    PickerActionSheet *actionSheet = [[PickerActionSheet alloc] initWithViewModel:self];
    NSString *startYear = self.searchYear;
    if (startYear.length < 1) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy"];
        startYear = [dateFormatter stringFromDate:[NSDate date]];
    }
    NSInteger row = [self.searchYearArray indexOfObject:startYear];
    [actionSheet selectRow:row forComponent:0];
    [actionSheet show];
    return NO;
}

#pragma mark - PickerActionSheetDelegate
- (void)confirmPickerView:(UIPickerView *)pickerView {
    NSInteger index = [pickerView selectedRowInComponent:0];
    self.searchYear = self.searchYearArray[index];
    [self.tableView reloadData];
}

#pragma mark - UIPickerViewDataSource,UIPickerViewDelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.searchYearArray.count;
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.searchYearArray[row];
}
@end
