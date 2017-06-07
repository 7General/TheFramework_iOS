//
//  URLSwitchManager.h
//  PlanC
//
//  Created by ysyc_liu on 16/8/29.
//  Copyright © 2016年 ysyc_wang. All rights reserved.
//

#import "RequestBase.h"

@interface URLSwitchManager : NSObject

/**
 *  根据接口名获取完整请求接口地址.
 *
 *  @param feature  接口枚举值.
 *
 *  @return 成功返回完整接口地址, 失败返回传入的接口名.
 */
+ (NSString *)getUrlByFeature:(APIType)feature;

@end
