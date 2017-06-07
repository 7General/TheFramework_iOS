//
//  MoreData.h
//  LongFor
//
//  Created by ZZG on 17/5/25.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MoreData : NSObject
+(instancetype)moreData:(NSString *)text
                forData:(NSString *)data
               forSatae:(NSString *)states;


/*! 项目名称 */
@property (nonatomic, strong) NSString *itemText;
/*! 项目存库名称 */
@property (nonatomic, strong) NSString *itemData;
/*! 项目编号 */
@property (nonatomic, strong) NSString *itemState;
@end
