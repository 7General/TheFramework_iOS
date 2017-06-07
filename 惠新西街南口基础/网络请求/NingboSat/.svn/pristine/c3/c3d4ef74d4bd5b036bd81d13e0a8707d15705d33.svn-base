//
//  BMKClusterManager.h
//  IphoneMapSdkDemo
//
//  Created by wzy on 15/9/15.
//  Copyright © 2015年 Baidu. All rights reserved.
//

#ifndef BMKClusterManager_h
#define BMKClusterManager_h

#import <Foundation/Foundation.h>
#import "BMKClusterAlgorithm.h"

/**
 * 点聚合管理类
 */
@interface BMKClusterManager : NSObject

///添加item
- (void)addClusterItem:(BMKClusterItem*)clusterItem;

///清除items
- (void)clearClusterItems;

/**
 * 获取聚合后的标注
 * @param zoomLevel map的级别
 * @return BMKCluster数组
 */
- (NSArray*)getClusters:(CGFloat) zoomLevel;

/**
 *  聚合点子聚合可见时的最小放大倍数.
 *
 *  @param cluster 聚合点.
 *
 *  @return 倍数.
 */
- (CGFloat)minZoomLevelForItem:(BMKCluster*)cluster curZoom:(CGFloat)curZoom;

@end

#endif /* BMKClusterManager_h */
