//
//  TaxDeclarePayInView.h
//  NingboSat
//
//  Created by ysyc_liu on 16/9/21.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "TaxSearchContentView.h"
/// 申报交款查询.
@interface TaxDeclarePayInView : TaxSearchContentView

@property (nonatomic, strong)UIButton *commitBtn;

@property (nonatomic, copy)NSString *taxType;
@property (nonatomic, copy)NSString *beginTime;
@property (nonatomic, copy)NSString *endTime;

@end
