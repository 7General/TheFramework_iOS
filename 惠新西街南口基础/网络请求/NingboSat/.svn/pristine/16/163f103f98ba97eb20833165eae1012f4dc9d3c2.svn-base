//
//  TaxerInvoiceCheckView.m
//  NingboSat
//
//  Created by ysyc_liu on 2016/11/24.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "TaxerInvoiceCheckView.h"

@implementation TaxerInvoiceCheckView

- (void)initView {
    self.titleLabel.text = @"发票核定";
    [self reShowView];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    @try {
        if (self.dataModel.itemFphd.count == 0) {
            return 1;
        }
        return self.dataModel.itemFphd.count;
    } @catch (NSException *exception) {
        return 1;
    }
}

#pragma mark - other mothod
- (NSString *)cellTextForIndexPath:(NSIndexPath *)indexPath {
    @try {
        NSArray *array = @[@"票种信息", @"结存信息"];
        return array[indexPath.row];
    } @catch (NSException *exception) {
        return @"";
    }
}

- (NSString *)cellDetailForIndexPath:(NSIndexPath *)indexPath {
    @try {
        if (0 == indexPath.row) {
            return self.dataModel.itemFphd[indexPath.section].invoiceVouch;
        }
        if (1 == indexPath.row) {
            return self.dataModel.itemFphd[indexPath.section].fpjc;
        }
        return @"";
    } @catch (NSException *exception) {
        return @"";
    }
}

@end
