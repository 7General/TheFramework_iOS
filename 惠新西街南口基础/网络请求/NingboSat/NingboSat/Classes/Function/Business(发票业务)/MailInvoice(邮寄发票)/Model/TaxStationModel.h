//
//  TaxStationModel.h
//  NingboSat
//
//  Created by ysyc_liu on 16/9/19.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import <Mantle/Mantle.h>

/**
 *  办税服务厅信息模型.
 */
@interface TaxStationModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy)NSString *time;
@property (nonatomic, copy)NSString *address;
@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *district;
@property (nonatomic, copy)NSString *code;

@end
