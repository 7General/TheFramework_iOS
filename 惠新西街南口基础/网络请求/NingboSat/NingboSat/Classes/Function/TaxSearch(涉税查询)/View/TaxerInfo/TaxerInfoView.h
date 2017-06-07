//
//  TaxerInfoView.h
//  NingboSat
//
//  Created by ysyc_liu on 16/9/21.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "TaxSearchContentView.h"
#import "TaxerInfoModel.h"

typedef NS_ENUM(NSInteger, TaxerInfoShowType) {
    TaxerInfoShowBase = 0,      // 基本信息
    TaxerInfoShowContact,       // 联系方式
    TaxerInfoShowTax,           // 税务信息
    TaxerInfoShowTaxCheck,      // 税种核定
    TaxerInfoShowInvoiceCheck,  // 发票核定
};

/// 基本信息查询.
@interface TaxerInfoView : TaxSearchContentView

+ (instancetype)TaxerInfoViewWithType:(TaxerInfoShowType)type;


@property (nonatomic, strong)TaxerInfoModel *dataModel;

- (void)loadData:(TaxerInfoModel *)viewData;

- (NSString *)cellTextForIndexPath:(NSIndexPath *)indexPath;
- (NSString *)cellDetailForIndexPath:(NSIndexPath *)indexPath;


@end
