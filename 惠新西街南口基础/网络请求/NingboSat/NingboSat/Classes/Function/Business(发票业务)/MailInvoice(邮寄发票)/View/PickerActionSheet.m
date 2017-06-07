//
//  PickerActionSheet.m
//  NingboSat
//
//  Created by ysyc_liu on 16/9/18.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "PickerActionSheet.h"
#import "Config.h"
#import "Masonry.h"

@interface PickerActionSheet()

@property (nonatomic, strong)UIPickerView *pickerView;
@property (nonatomic, strong)id<PickerActionSheetDelegate, UIPickerViewDataSource, UIPickerViewDelegate> pickerViewModel;

@end

@implementation PickerActionSheet

- (instancetype)initWithViewModel:(id)viewModel {
    self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 224)];
    if (self) {
        self.showConfirmBar = YES;
        self.pickerViewModel = viewModel;
        self.pickerView.dataSource = viewModel;
        self.pickerView.delegate = viewModel;
    }
    
    return self;
}

- (void)initView {
    [super initView];
    UIPickerView *pickerView = [[UIPickerView alloc] init];
    [self.contentView addSubview:pickerView];
    pickerView.backgroundColor = YSColor(0xf5, 0xf5, 0xf5);
    [pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    self.pickerView = pickerView;
    
    for (UIView *subView in pickerView.subviews) {
        if (subView.subviews.count > 0) {
            continue;
        }
        subView.hidden = NO;
        subView.backgroundColor = YSColor(0xd2, 0xd2, 0xd2);
    }
}

- (void)selectRow:(NSInteger)row forComponent:(NSInteger)component {
    [self.pickerView selectRow:row inComponent:component animated:NO];
}

- (void)confirmBtnClick {
    [super confirmBtnClick];
    [self.pickerViewModel confirmPickerView:self.pickerView];
}

@end
