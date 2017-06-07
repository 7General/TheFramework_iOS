//
//  TaxerInfoView.m
//  NingboSat
//
//  Created by ysyc_liu on 16/9/21.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "TaxerInfoView.h"

@interface TaxerInfoView()

@property (nonatomic, strong)NSArray *itemsArray;
@property (nonatomic, strong)TaxerInfoModel *dataModel;

@end

@implementation TaxerInfoView

- (void)initView {
    self.titleLabel.text = @"基本信息查询";
    
    [self initData];
}

- (void)initData {
    self.itemsArray = @[@"纳税人识别号", @"纳税人名称", @"主管税务机关", @"登记注册类型", @"行业类型", @"法人及联系方式", @"财务负责人及联系方式", @"生产经营地址"];
    
    [self reShowView];
}

- (void)loadData:(TaxerInfoModel *)viewData {
    self.dataModel = viewData;
    [super loadData:viewData];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    NSArray *textArray = self.itemsArray;
    cell.textLabel.text = textArray[indexPath.row];
    cell.textLabel.highlighted = YES;
    if (!self.dataModel) {
        return cell;
    }
    cell.detailTextLabel.text = [self cellDetailForIndexPath:indexPath];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *leftStr = self.itemsArray[indexPath.row];
    NSString *rightStr = [self cellDetailForIndexPath:indexPath];
    CGRect leftRect = [leftStr boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:FONT_BY_SCREEN(15)} context:nil];
    CGRect rightRect = [rightStr boundingRectWithSize:CGSizeMake(CGRectGetWidth(tableView.bounds) - 15 * 2 - 6 - CGRectGetWidth(leftRect), MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:FONT_BY_SCREEN(15)} context:nil];
    CGFloat height = CGRectGetHeight(rightRect) + 17 * 2;
    if (height <= 60) {
        height = 50;
    }
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 40;
}

#pragma mark - other mothod
- (NSString *)cellDetailForIndexPath:(NSIndexPath *)indexPath {
    if (0 == indexPath.row) {
        return [NSObject getTaxNumber];
    }
    else if (1 == indexPath.row) {
        return [NSObject getTaxName];
    }
    else if (2 == indexPath.row) {
        return self.dataModel.taxStation;
    }
    else if (3 == indexPath.row) {
        return self.dataModel.regist_type;
    }
    else if (4 == indexPath.row) {
        return self.dataModel.industry_type;
    }
    else if (5 == indexPath.row) {
        return [NSString stringWithFormat:@"%@-%@", self.dataModel.legalPerson, self.dataModel.legalPersonPhone];
    }
    else if (6 == indexPath.row) {
        return [NSString stringWithFormat:@"%@-%@", self.dataModel.financeOfficer, self.dataModel.financeOfficerPhone];
    }
    else if (7 == indexPath.row) {
        return self.dataModel.businessAddress;
    }
    
    return @"";
}

@end
