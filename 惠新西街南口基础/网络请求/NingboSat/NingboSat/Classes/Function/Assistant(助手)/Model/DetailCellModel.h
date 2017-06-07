//
//  DetailCellModel.h
//  NingboSat
//
//  Created by 王会洲 on 16/11/21.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetailCellModel : NSObject
+(instancetype)detailCellModelWithDict:(NSDictionary *)dict;


@property (nonatomic, strong) NSString * subTitleName;
@end
