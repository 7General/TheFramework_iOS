//
//  ItemListModel.h
//  NingboSat
//
//  Created by 王会洲 on 16/11/21.
//  Copyright © 2016年 王会洲. All rights reserved.
//

/**可预约事项列表*/
#import <Foundation/Foundation.h>

@interface ItemListModel : NSObject


+(instancetype)itemlistModelWithDict:(NSDictionary *)dict;

@property (nonatomic, assign) NSInteger  ids;
@property (nonatomic, strong) NSString * mc;


@end
