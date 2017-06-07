//
//  SelectBookTimeModel.h
//  NingboSat
//
//  Created by 王会洲 on 16/11/24.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SelectBookTimeModel : NSObject
+(instancetype)selectBookTimeWithDict:(NSDictionary *)dict;

/**办税网点ID*/
@property (nonatomic, strong) NSString * bswd_id;
/**id*/
@property (nonatomic, assign) NSInteger  ids;
/**可预约数量*/
@property (nonatomic, assign) NSInteger  kyysl;
/**预约时间标志*/
@property (nonatomic, assign) NSInteger  yysj_bz;
/**预约时间起*/
@property (nonatomic, strong) NSString *  yysj_q;
/**预约时间终止*/
@property (nonatomic, strong) NSString * yysj_z;
/**预约数量*/
@property (nonatomic, assign) NSInteger  yyysl;

@end
