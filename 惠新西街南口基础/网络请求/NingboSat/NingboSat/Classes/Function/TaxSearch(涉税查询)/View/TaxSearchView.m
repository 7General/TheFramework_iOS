//
//  TaxSearchView.m
//  NingboSat
//
//  Created by ysyc_liu on 16/9/20.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "TaxSearchView.h"
#import "TaxerInfoView.h"
#import "TaxDeclarePayInView.h"
#import "TaxApplicationView.h"
#import "TaxCreditRatingView.h"
#import "YSAlertView.h"

#import "RequestBase.h"

NSInteger baseTag = 1000;

@interface TaxSearchView() <PageScrollViewDelegate>

@end

@implementation TaxSearchView

- (void)initView {
    [super initView];
    
//    NSArray<Class> * classArray = @[[TaxerInfoView class], [TaxDeclarePayInView class], [TaxApplicationView class], [TaxCreditRatingView class],];
    NSArray<Class> * classArray = @[[TaxerInfoView class], [TaxDeclarePayInView class],];
    for (NSInteger i = 0; i < classArray.count; i++) {
        TaxSearchContentView * view = [[classArray[i] alloc] init];
        [self addView:view];
        view.tag = baseTag + i;
        [view.unReachableBtn addTarget:self.delegate action:@selector(unReachable) forControlEvents:UIControlEventTouchUpInside];
    }
    
    {
        TaxDeclarePayInView *view = self.sectionViewItems[1];
        [view.commitBtn addTarget:self action:@selector(commitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    self.pageDelegate = self;
}

- (void)commitBtnClick {
    TaxDeclarePayInView *declarePayInView = self.sectionViewItems[1];
    if (declarePayInView.taxType.length < 1) {
        [[YSAlertView alertWithTitle:nil message:@"请选择税种" buttonTitles:@"确定", nil] show];
        return;
    }
    if (declarePayInView.beginTime.length < 1) {
        [[YSAlertView alertWithTitle:nil message:@"请选择起始日期" buttonTitles:@"确定", nil] show];
        return;
    }
    if (declarePayInView.endTime.length < 1) {
        [[YSAlertView alertWithTitle:nil message:@"请选择终止日期" buttonTitles:@"确定", nil] show];
        return;
    }
    NSDictionary *dict = @{@"taxpayer_code":TAXPAYER_CODE, @"tax_type" : declarePayInView.taxType, @"belong_begin" : declarePayInView.beginTime, @"belong_end" : declarePayInView.endTime};
    [RequestBase requestWith:APITypeDeclarePay Param:@{@"jsonParam" : [dict JSONParamString]} Complete:^(YSResponseStatus status, id object) {
        if (status == 0) {
            if ([self.delegate respondsToSelector:@selector(TaxDeclarePayInSearch:)]) {
                [self.delegate TaxDeclarePayInSearch:object[@"content"]];
            }
        }
    } ShowOnView:self.sectionViewItems[1]];
    
}

- (void)initData {
    __weak typeof(self) weakSelf = self;
    if ([NSObject isLogin]) {
        NSDictionary *dict = @{@"taxpayer_code":TAXPAYER_CODE};
        [RequestBase requestWith:APITypeTaxInfo Param:@{@"jsonParam" : [dict JSONParamString]} Complete:^(YSResponseStatus status, id object) {
            if (status == 0) {
                @try {
                    TaxerInfoModel * model = [MTLJSONAdapter modelOfClass:[TaxerInfoModel class] fromJSONDictionary:object[@"content"] error:nil];
                    [weakSelf.sectionViewItems[0] loadData:model];
                } @catch (NSException *exception) {
                    
                }
                
            }
        } ShowOnView:self.sectionViewItems[0]];
    }
}

- (void)resetView {
    for (NSInteger i = 0; i < self.sectionViewItems.count; i++) {
        TaxSearchContentView *view = self.sectionViewItems[i];
        view.viewData = nil;
        [view reShowView];
    }
    [self initData];
    [self setPage:0];
}

#pragma mark - PageScrollViewDelegate

- (void)pageTurnTo:(NSInteger)pageNumber {
    TaxSearchContentView *view = self.sectionViewItems[pageNumber];
    [view reShowView];
}

@end
