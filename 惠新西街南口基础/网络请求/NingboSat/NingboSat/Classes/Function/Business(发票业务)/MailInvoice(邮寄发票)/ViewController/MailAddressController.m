//
//  MailAddressController.m
//  NingboSat
//
//  Created by ysyc_liu on 16/9/18.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "MailAddressController.h"
#import "MailLocateCell.h"
#import "Config.h"
#import "UIButton+YSSolidColorButton.h"
#import "Masonry.h"
#import "RequestBase.h"

#import "EditAddressController.h"

@interface MailAddressController()<UITableViewDelegate, UITableViewDataSource, MailLocateCellDelegate>

@property (nonatomic, strong)UITableView *tableView;

@property (nonatomic, strong)NSMutableArray *addressArray;

@end

@implementation MailAddressController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"选择收票人地址";
    self.view.backgroundColor = YSColor(0xf5, 0xf5, 0xf5);
    [self initView];
    [self initData];
}

- (void)initData {
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:[NSObject getTaxNumber], @"taxpayer_code", nil];
    [RequestBase requestWith:APITypeTaxPayerAddressQuery Param:@{@"jsonParam" : [param JSONParamString]} Complete:^(YSResponseStatus status, id object) {
        if (status == YSResponseStatusSuccess) {
            if (object[@"content"] && object[@"content"][@"addresses"]) {
                NSArray * array = [MTLJSONAdapter modelsOfClass:[MailAddressModel class] fromJSONArray:object[@"content"][@"addresses"] error:nil];
                if (array) {
                    [self.addressArray addObjectsFromArray:array];
                    [self.tableView reloadData];
                }
            }
        }
    } ShowOnView:self.view];
}

- (void)initView {
    UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 64) style:UITableViewStyleGrouped];
    [self.view addSubview:tableView];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorColor = YSColor(0xe6, 0xe6, 0xe6);
    tableView.backgroundColor = self.view.backgroundColor;
    if (SYSTEM_VERSION >= 8.0) {
        tableView.layoutMargins = UIEdgeInsetsZero;
    }
    tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 0);
    
    self.tableView = tableView;
    
    {
        UIButton *button = [UIButton buttonWithColor:YSColor(0x4b, 0xc4, 0xfb) title:@"新增收票人地址"];
        [self.view addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.view).offset(-10);
            make.height.mas_equalTo(44);
            make.left.equalTo(self.view).offset(35);
            make.right.equalTo(self.view).offset(-35);
        }];
        [button addTarget:self action:@selector(addAddressBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
}

#pragma mark - set and get
- (NSMutableArray *)addressArray {
    if (!_addressArray) {
        _addressArray = [NSMutableArray array];
    }
    return _addressArray;
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.addressArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString * identifier = @"locateCell";
    MailLocateCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[MailLocateCell alloc] initWithReuseIdentifier:identifier];
        cell.delegate = self;
    }
    MailAddressModel *model = self.addressArray[indexPath.section];
    [cell setCellByModel:model isEdit:YES];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    MailAddressModel *model = self.addressArray[indexPath.section];
    return [MailLocateCell heightNeededByModel:model andWidth:CGRectGetWidth(tableView.bounds) isEdit:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (0 == section) {
        return 0.01;
    }
    return 11;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.selectBlock) {
        self.selectBlock(self.addressArray[indexPath.section]);
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - MailLocateCellDelegate
- (void)editButtonClick:(id)model {
    __weak typeof(self) weakSelf = self;
    EditAddressController *vc = [[EditAddressController alloc] init];
    vc.preAddressModel = model;
    vc.deleteBlock = ^(MailAddressModel *addressModel) {
        [weakSelf.addressArray removeObject:addressModel];
        [weakSelf.tableView reloadData];
    };
    vc.commitBlock = ^(MailAddressModel *addressModel) {
        NSUInteger index = [weakSelf.addressArray indexOfObject:model];
        if (index == NSNotFound) {
            return;
        }
        [model setValueByModel:addressModel];
        [weakSelf.tableView reloadData];
    };
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - button click action
- (void)addAddressBtnClick {
    //TODO: 跳转至新增收票人地址页面.
    __weak typeof(self) weakSelf = self;
    EditAddressController *vc = [[EditAddressController alloc] init];
    vc.commitBlock = ^(MailAddressModel *addressModel) {
        [weakSelf.addressArray addObject:addressModel];
        [weakSelf.tableView reloadData];
    };
    [self.navigationController pushViewController:vc animated:YES];
}


@end
