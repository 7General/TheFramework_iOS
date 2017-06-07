//
//  MailAddressModel.h
//  NingboSat
//
//  Created by ysyc_liu on 16/9/14.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface MailAddressModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy)NSString *aid;
@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *phone;
@property (nonatomic, copy)NSString *idType;
@property (nonatomic, copy)NSString *idNumber;
@property (nonatomic, copy)NSString *address;
@property (nonatomic, copy)NSString *desAddress;

- (NSString *)shippingAddress;
- (void)setValueByModel:(MailAddressModel *)model;

@end
