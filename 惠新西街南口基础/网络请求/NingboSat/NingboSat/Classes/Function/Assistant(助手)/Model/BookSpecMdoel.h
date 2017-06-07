//
//  BookSpecMdoel.h
//  NingboSat
//
//  Created by 王会洲 on 16/11/21.
//  Copyright © 2016年 王会洲. All rights reserved.
//

/**可预约具体事项Model*/
#import <Foundation/Foundation.h>

@interface BookSpecMdoel : NSObject

+(instancetype)bookSpecModelWithDict:(NSDictionary *)dict;

/**事项ID*/
@property (nonatomic, assign) NSInteger  ids;
/**所需材料ID*/
@property (nonatomic, assign) NSInteger  docid;
/**事项名称*/
@property (nonatomic, strong) NSString * mc;
/**获取事项所需材料凭证id*/
@property (nonatomic, assign) NSInteger  cnnid;
/**全市通办标识 1：只显示纳税人所属税务局的下属办税厅 2：全部办税厅*/
@property (nonatomic, assign) NSInteger  qstb;
@end
