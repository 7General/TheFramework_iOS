//
//  TaxPayInModel.h
//  NingboSat
//
//  Created by ysyc_liu on 16/9/30.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import <Mantle/Mantle.h>
/// 缴款数据
@interface TaxPayInModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy)NSString *levyProjectName;
@property (nonatomic, copy)NSString *taxBelongTime;
@property (nonatomic, copy)NSString *levyTaxItemName;
@property (nonatomic, copy)NSString *taxRate;
@property (nonatomic, copy)NSString *taxOughtAmount;
@property (nonatomic, copy)NSString *taxAdvance;
@property (nonatomic, copy)NSString *putStorageDate;

@end
