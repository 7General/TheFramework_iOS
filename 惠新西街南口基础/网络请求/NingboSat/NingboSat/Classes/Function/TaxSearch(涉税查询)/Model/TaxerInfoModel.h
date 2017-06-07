//
//  TaxerInfoModel.h
//  NingboSat
//
//  Created by ysyc_liu on 16/9/21.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface TaxerItemZgrd : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy)NSString *qualificationAffirm;

@end

@interface TaxerItemSzhd : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy)NSString *declareTime;
@property (nonatomic, copy)NSString *taxVouchAmount;
@property (nonatomic, copy)NSString *taxLevyType;
@property (nonatomic, copy)NSString *taxType;
@property (nonatomic, copy)NSString *taxItem;
@property (nonatomic, copy)NSString *zsl;

@end

@interface TaxerItemJbxx : MTLModel <MTLJSONSerializing>

// 主管税务机关.
@property (nonatomic, copy)NSString *taxStation;
// 法人.
@property (nonatomic, copy)NSString *legalPerson;
@property (nonatomic, copy)NSString *legalPersonPhone;
// 财务负责人.
@property (nonatomic, copy)NSString *financeOfficer;
@property (nonatomic, copy)NSString *financeOfficerPhone;
// 注册地址.
@property (nonatomic, copy)NSString *registAddress;
// 生产经营地址.
@property (nonatomic, copy)NSString *businessAddress;
// 纳税人资格类型名称.
@property (nonatomic, copy)NSString *nsrzglxmc;
// 列别.
@property (nonatomic, copy)NSString *category;
// 纳税人识别号.
@property (nonatomic, copy)NSString *taxpayer_code;
// 登记类型.
@property (nonatomic, copy)NSString *registration_type;
// 纳税人状态.
@property (nonatomic, copy)NSString *nsrztmc;

@end

@interface TaxerItemFphd : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy)NSString *invoiceVouch;
@property (nonatomic, copy)NSString *fpzl_dm;
@property (nonatomic, copy)NSString *fpjc;

@end

@interface TaxerInfoModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy)NSString *itemKphjxx;    // 双定户开票合计金额信息
@property (nonatomic, copy)NSString *itemDexx;      //定额信息
@property (nonatomic, copy)NSArray<TaxerItemSzhd *> *itemSzhd;
@property (nonatomic, copy)NSArray<TaxerItemJbxx *> *itemJbxx;
@property (nonatomic, copy)NSArray<TaxerItemFphd *> *itemFphd;

@end




