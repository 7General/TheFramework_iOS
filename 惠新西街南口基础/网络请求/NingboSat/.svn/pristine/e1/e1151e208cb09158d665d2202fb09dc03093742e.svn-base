//
//  PickerViewModel.h
//  NingboSat
//
//  Created by ysyc_liu on 16/9/19.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PickerActionSheet.h"

typedef NS_ENUM(NSInteger, PickerDataType) {
    PickerDataTypeCoordinative = 0, // 并列型数据, 默认值. 格式为@[@[], @[], ...]其中, 每个子数组都单独为一列, 互相之间没有联系.
};

typedef void (^PickerViewModelBlock)(NSArray *selectedArray);

@interface PickerViewModel : NSObject<UIPickerViewDataSource, UIPickerViewDelegate, PickerActionSheetDelegate>

@property (nonatomic, strong)NSArray *dataArray;

@property (nonatomic, assign)PickerDataType type;

@property (nonatomic, copy)PickerViewModelBlock confirmBlock;

@end
