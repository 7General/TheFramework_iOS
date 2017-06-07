//
//  TaxerBaseInfoView.m
//  NingboSat
//
//  Created by ysyc_liu on 2016/11/24.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "TaxerBaseInfoView.h"

@implementation TaxerBaseInfoView

- (void)initView {
    self.titleLabel.text = @"基本信息";
    [self reShowView];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

#pragma mark - other mothod
- (NSString *)cellTextForIndexPath:(NSIndexPath *)indexPath {
    @try {
        NSArray *array = @[@"主管税务机关", @"状态"];
        return array[indexPath.row];
    } @catch (NSException *exception) {
        return @"";
    }
}

- (NSString *)cellDetailForIndexPath:(NSIndexPath *)indexPath {
    @try {
        if (0 == indexPath.row) {
            return self.dataModel.itemJbxx.firstObject.taxStation;
        }
        if (1 == indexPath.row) {
            return self.dataModel.itemJbxx.firstObject.nsrztmc;
        }
        
        return @"";
    } @catch (NSException *exception) {
        return @"";
    }
    
}

@end
