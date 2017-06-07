//
//  CustomEmployeeListModel.h
//  LongFor
//
//  Created by ruantong on 17/5/22.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 获取城市-项目列表model
 */
@interface CustomEmployeeListModel : NSObject

/**
 城市名称
 */
@property(nonatomic,copy)NSString* name;

/**
 编号
 */
@property(nonatomic,copy)NSString* sid;


/**
 城市下的项目（数组）
 */
@property(nonatomic,retain)NSArray* projectList;

@end
