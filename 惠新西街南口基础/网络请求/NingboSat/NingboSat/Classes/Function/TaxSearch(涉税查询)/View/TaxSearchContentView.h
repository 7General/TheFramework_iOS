//
//  TaxSearchContentView.h
//  NingboSat
//
//  Created by ysyc_liu on 16/9/21.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Config.h"
#import "Masonry.h"

@interface TaxSearchContentView : UIView<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)UIView *unReachableView;
@property (nonatomic, strong)UIButton *unReachableBtn;

@property (nonatomic, strong)id viewData;

- (void)initView;
- (void)loadData:(id)viewData;
// 数据不变, 重新加载视图.
- (void)reShowView;

+ (UITextField *)textFieldWithPlaceholder:(NSString *)placeholder;

@end
