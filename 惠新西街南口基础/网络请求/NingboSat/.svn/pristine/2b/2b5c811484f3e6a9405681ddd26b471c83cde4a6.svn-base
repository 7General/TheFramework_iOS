//
//  PickerActionSheet.h
//  NingboSat
//
//  Created by ysyc_liu on 16/9/18.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "YSActionSheetView.h"

@protocol PickerActionSheetDelegate <NSObject>

- (void)confirmPickerView:(UIPickerView *)pickerView;

@end

@interface PickerActionSheet : YSActionSheetView

// viewModel : 实现pickerView数据及代理方法的类.
- (instancetype)initWithViewModel:(id<PickerActionSheetDelegate, UIPickerViewDataSource, UIPickerViewDelegate>)viewModel;

- (void)selectRow:(NSInteger)row forComponent:(NSInteger)component;

@end
