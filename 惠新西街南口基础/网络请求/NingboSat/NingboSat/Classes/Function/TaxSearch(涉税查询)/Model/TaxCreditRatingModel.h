//
//  TaxCreditRatingModel.h
//  NingboSat
//
//  Created by ysyc_liu on 16/9/21.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface TaxCreditRatingModel : MTLModel

@property (nonatomic, copy)NSString *taxpayerCode;
@property (nonatomic, copy)NSString *taxpayerName;
@property (nonatomic, copy)NSString *creditRating;

@end
