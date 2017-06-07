//
//  TaxerTaxInfoView.m
//  NingboSat
//
//  Created by ysyc_liu on 2016/11/24.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "TaxerTaxInfoView.h"

@implementation TaxerTaxInfoView

- (void)initView {
    self.titleLabel.text = @"税务信息";
    [self reShowView];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

#pragma mark - other mothod
- (NSString *)cellTextForIndexPath:(NSIndexPath *)indexPath {
    @try {
        NSArray *array = @[@"资格信息", @"定额信息", @"开票合集信息"];
        return array[indexPath.row];
    } @catch (NSException *exception) {
        return @"";
    }
}

- (NSString *)cellDetailForIndexPath:(NSIndexPath *)indexPath {
    @try {
        if (0 == indexPath.row) {
            return self.dataModel.itemJbxx.firstObject.nsrzglxmc;
        }
        if (1 == indexPath.row) {
            return self.dataModel.itemDexx;
        }
        if (2 == indexPath.row) {
            return self.dataModel.itemKphjxx;
        }
        return @"";
    } @catch (NSException *exception) {
        return @"";
    }
}

@end
