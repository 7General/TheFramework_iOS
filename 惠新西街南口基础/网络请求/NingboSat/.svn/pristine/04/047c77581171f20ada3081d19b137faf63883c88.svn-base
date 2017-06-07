//
//  TaxerTaxCheckView.m
//  NingboSat
//
//  Created by ysyc_liu on 2016/11/24.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "TaxerTaxCheckView.h"

@implementation TaxerTaxCheckView

- (void)initView {
    self.titleLabel.text = @"税种核定信息";
    [self reShowView];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    @try {
        if (self.dataModel.itemSzhd.count == 0) {
            return 1;
        }
        return self.dataModel.itemSzhd.count;
    } @catch (NSException *exception) {
        return 1;
    }
}

#pragma mark - other mothod
- (NSString *)cellTextForIndexPath:(NSIndexPath *)indexPath {
    @try {
        NSArray *array = @[@"税种信息", @"税目信息", @"税率信息"];
        return array[indexPath.row];
    } @catch (NSException *exception) {
        return @"";
    }
}

- (NSString *)cellDetailForIndexPath:(NSIndexPath *)indexPath {
    @try {
        if (0 == indexPath.row) {
            return self.dataModel.itemSzhd[indexPath.section].taxType;
        }
        if (1 == indexPath.row) {
            return self.dataModel.itemSzhd[indexPath.section].taxItem;
        }
        if (2 == indexPath.row) {
            return self.dataModel.itemSzhd[indexPath.section].zsl;
        }
        return @"";
    } @catch (NSException *exception) {
        return @"";
    }
}

@end
