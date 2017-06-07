//
//  NewInvoiceModel.h
//  NingboSat
//
//  Created by ysyc_liu on 16/9/19.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface NewInvoiceModel : MTLModel<MTLJSONSerializing, NSMutableCopying>

@property (nonatomic, copy)NSString *type;
@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *maxNumber;
@property (nonatomic, copy)NSString *number;

- (void)addNumberWithModel:(NewInvoiceModel *)model;

@end
