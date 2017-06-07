//
//  CompanyModel.h
//  NingboSat
//
//  Created by 王会洲 on 16/11/22.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CompanyModel : NSObject

+(instancetype)CompanyModelWithDict:(NSDictionary *)dict;

/**税局ID*/
@property (nonatomic, assign) NSInteger  bswd_id;
/**税局名称*/
@property (nonatomic, strong) NSString * bswd_mc;

@end
