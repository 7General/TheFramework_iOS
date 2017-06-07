//
//  PickerViewModel.m
//  NingboSat
//
//  Created by ysyc_liu on 16/9/19.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "PickerViewModel.h"
#import "Config.h"

@interface PickerViewModel()

@property (nonatomic, readonly)NSInteger component;

@property (nonatomic, strong)NSMutableArray *selectedArray;

@end

@implementation PickerViewModel

#pragma mark - UIPickerViewDataSource, UIPickerViewDelegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return self.component;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (0 == self.type) {
        return [self.dataArray[component] count];
    }
    else {
        return 0;
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return CGRectGetWidth(pickerView.bounds) / self.component;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return CGRectGetHeight(pickerView.bounds) / 5;
}

//- (nullable NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component {
//    UIFont *font = FONT_BY_SCREEN(10);
//    UIColor *color = YSColor(0x50, 0x50, 0x50);
//    NSString *title = [self titleForRow:row forComponent:component];
//    NSAttributedString * attributedTitle = [[NSAttributedString alloc] initWithString:title attributes:@{NSFontAttributeName:font, NSForegroundColorAttributeName:color}];
//    return attributedTitle;
//}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view {
    UILabel *label = [[UILabel alloc] init];
    label.textAlignment = NSTextAlignmentCenter;
    UIFont *font = FONT_BY_SCREEN(17);
    UIColor *color = YSColor(0x50, 0x50, 0x50);
    NSString *title = [self titleForRow:row forComponent:component];
    NSAttributedString * attributedTitle = [[NSAttributedString alloc] initWithString:title attributes:@{NSFontAttributeName:font, NSForegroundColorAttributeName:color}];
    label.attributedText = attributedTitle;
    return label;
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    [self.selectedArray replaceObjectAtIndex:component withObject:[NSNumber numberWithInteger:row]];
}

#pragma mark - PickerActionSheetDelegate

- (void)confirmPickerView:(UIPickerView *)pickerView {
    if (self.confirmBlock) {
        NSArray *array = [self.selectedArray copy];
        self.confirmBlock(array);
    }
}


#pragma mark - set and get
- (NSInteger)component {
    NSInteger retValue = 0;
    if (0 == self.type) {
        retValue = self.dataArray.count;
    }
    else {
        retValue = 1;
    }
    
    if (retValue == 0) {
        retValue = 1;
    }
    
    return retValue;
}

- (NSMutableArray *)selectedArray {
    if (!_selectedArray) {
        _selectedArray = [NSMutableArray array];
        for (NSInteger i = 0, count = self.component; i < count; i++) {
            [_selectedArray addObject:[NSNumber numberWithInteger:0]];
        }
    }
    return _selectedArray;
}

#pragma mark - other

- (NSString *)titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (0 == self.type) {
        return self.dataArray[component][row];
    }
    else {
        return @"";
    }
}

@end
