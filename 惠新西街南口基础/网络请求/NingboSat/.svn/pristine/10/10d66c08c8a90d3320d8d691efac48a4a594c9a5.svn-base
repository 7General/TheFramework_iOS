//
//  TaxerContactInfoView.m
//  NingboSat
//
//  Created by ysyc_liu on 2016/11/24.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "TaxerContactInfoView.h"

@implementation TaxerContactInfoView

- (void)initView {
    self.titleLabel.text = @"联系方式";
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
        NSArray *array = @[@"法人", @"财务负责人", @"办税人电话"];
        return array[indexPath.row];
    } @catch (NSException *exception) {
        return @"";
    }
}

- (NSString *)cellDetailForIndexPath:(NSIndexPath *)indexPath {
    @try {
        if (0 == indexPath.row) {
            return self.dataModel.itemJbxx.firstObject.legalPerson;
        }
        if (1 == indexPath.row) {
            return self.dataModel.itemJbxx.firstObject.financeOfficer;
        }
        if (2 == indexPath.row) {
            return self.dataModel.itemJbxx.firstObject.legalPersonPhone;
        }
        return @"";
    } @catch (NSException *exception) {
        return @"";
    }
}

@end
