//
//  TaxerInfoView.m
//  NingboSat
//
//  Created by ysyc_liu on 16/9/21.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "TaxerInfoView.h"

#import "TaxerBaseInfoView.h"
#import "TaxerContactInfoView.h"
#import "TaxerTaxInfoView.h"
#import "TaxerTaxCheckView.h"
#import "TaxerInvoiceCheckView.h"

@interface TaxerInfoView()

@end

@implementation TaxerInfoView

+ (instancetype)TaxerInfoViewWithType:(TaxerInfoShowType)type {
    CGRect initFrame = [UIScreen mainScreen].bounds;
    switch (type) {
        case TaxerInfoShowBase: {
            return [[TaxerBaseInfoView alloc] initWithFrame:initFrame];
        }
        case TaxerInfoShowContact: {
            return [[TaxerContactInfoView alloc] initWithFrame:initFrame];
        }

        case TaxerInfoShowTax: {
            return [[TaxerTaxInfoView alloc] initWithFrame:initFrame];
        }

        case TaxerInfoShowTaxCheck: {
            return [[TaxerTaxCheckView alloc] initWithFrame:initFrame];
        }
        case TaxerInfoShowInvoiceCheck: {
            return [[TaxerInvoiceCheckView alloc] initWithFrame:initFrame];
        }
        default:
            break;
    }
    
    return nil;
}

- (void)loadData:(TaxerInfoModel *)viewData {
    self.dataModel = viewData;
    [super loadData:viewData];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    cell.textLabel.text = [self cellTextForIndexPath:indexPath];
    cell.textLabel.highlighted = YES;
    if (!self.dataModel) {
        return cell;
    }
    cell.detailTextLabel.text = [self cellDetailForIndexPath:indexPath];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *leftStr = [self cellTextForIndexPath:indexPath];
    NSString *rightStr = [self cellDetailForIndexPath:indexPath];
    CGRect leftRect = [leftStr boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:FONT_BY_SCREEN(15)} context:nil];
    CGRect rightRect = [rightStr boundingRectWithSize:CGSizeMake(CGRectGetWidth(tableView.bounds) - 15 * 2 - 6 - CGRectGetWidth(leftRect), MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:FONT_BY_SCREEN(15)} context:nil];
    CGFloat height = CGRectGetHeight(rightRect) + 17 * 2;
    if (height <= 60) {
        height = 50;
    }
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section > 0) {
        return 10;
    }
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section + 1 == [tableView.dataSource numberOfSectionsInTableView:tableView]) {
        return 40;
    }
    return 0.01;
}

#pragma mark - other mothod

- (NSString *)cellTextForIndexPath:(NSIndexPath *)indexPath {
    return @"";
}

- (NSString *)cellDetailForIndexPath:(NSIndexPath *)indexPath {
    return @"";
}

@end
