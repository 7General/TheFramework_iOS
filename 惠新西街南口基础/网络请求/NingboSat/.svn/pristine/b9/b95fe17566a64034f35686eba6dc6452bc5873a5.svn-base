//
//  BMKClusterAlgorithm.m
//  IphoneMapSdkDemo
//
//  Created by wzy on 15/9/15.
//  Copyright © 2015年 Baidu. All rights reserved.
//

#import "BMKClusterAlgorithm.h"

#define MAX_DISTANCE_IN_DP    200 //300dp

@implementation BMKClusterAlgorithm

@synthesize quadItems = _quadItems;
@synthesize quadtree = _quadtree;

- (id)init {
    self = [super init];
    if (self) {
        _quadtree = [[BMKClusterQuadtree alloc] initWithRect:CGRectMake(0, 0, 1, 1)];
        _quadItems = [[NSMutableArray alloc] init];
    }
    return self;
}

///添加item
- (void)addItem:(BMKClusterItem*)clusterItem {
    BMKQuadItem *quadItem = [[BMKQuadItem alloc] init];
    quadItem.clusterItem = clusterItem;
    @synchronized(_quadtree) {
        [_quadItems addObject:quadItem];
        [_quadtree addItem:quadItem];
//        NSLog(@"%@", _quadtree.quadItems);
    }
}

///清除items
- (void)clearItems {
    @synchronized(_quadtree) {
        [_quadItems removeAllObjects];
        [_quadtree clearItems];
    }
    
}

/**
 *  cluster算法核心
 * @param zoom map的级别
 * @return BMKCluster数组
 */
- (NSArray*)getClusters:(CGFloat) zoomLevel {
    if (zoomLevel < 3 || zoomLevel > 21) {
        return nil;
    }
    NSMutableArray *results = [NSMutableArray array];
    
    NSUInteger zoom = (NSUInteger)zoomLevel;
    CGFloat zoomSpecificSpan = MAX_DISTANCE_IN_DP / pow(2, zoom) / 256;
    NSMutableSet *visitedCandidates = [NSMutableSet set];
    NSMutableDictionary *distanceToCluster = [NSMutableDictionary dictionary];
    NSMutableDictionary *itemToCluster = [NSMutableDictionary dictionary];
    
    @synchronized(_quadtree) {
        for (BMKQuadItem *candidate in _quadItems) {
            //candidate已经添加到另一cluster中
            if ([visitedCandidates containsObject:candidate]) {
                continue;
            }
            BMKCluster *cluster = [[BMKCluster alloc] init];
            cluster.coordinate = candidate.clusterItem.coor;
            
            // 当放大倍数大于19时.全部显示.
            if (zoomLevel >= 19) {
                [cluster.clusterItems addObject:candidate.clusterItem];
                [results addObject:cluster];
                [visitedCandidates addObject:candidate];
                [distanceToCluster setObject:[NSNumber numberWithDouble:0] forKey:[NSNumber numberWithLongLong:candidate.hash]];
                continue;
            }
            
            CGRect searchRect = [self getRectWithPt:candidate.pt Span:zoomSpecificSpan];
            NSMutableArray *items = (NSMutableArray*)[_quadtree searchInRect:searchRect];
            if (items.count == 1) {
                [cluster.clusterItems addObject:candidate.clusterItem];
                [results addObject:cluster];
                [visitedCandidates addObject:candidate];
                [distanceToCluster setObject:[NSNumber numberWithDouble:0] forKey:[NSNumber numberWithLongLong:candidate.hash]];
                continue;
            }
            
            for (BMKQuadItem *quadItem in items) {
                NSNumber *existDistache = [distanceToCluster objectForKey:[NSNumber numberWithLongLong:quadItem.hash]];
                CGFloat distance = [self getDistanceSquared:candidate.pt point:quadItem.pt];
                if (existDistache != nil) {
                    if (existDistache.doubleValue < distance) {
                        continue;
                    }
                    BMKCluster *existCluster = [itemToCluster objectForKey:[NSNumber numberWithLongLong:quadItem.hash]];
                    [existCluster.clusterItems removeObject:quadItem.clusterItem];
                }
                [distanceToCluster setObject:[NSNumber numberWithDouble:distance] forKey:[NSNumber numberWithLongLong:quadItem.hash]];
                [cluster.clusterItems addObject:quadItem.clusterItem];
                [itemToCluster setObject:cluster forKey:[NSNumber numberWithLongLong:quadItem.hash]];
            }
            [visitedCandidates addObjectsFromArray:items];
            [results addObject:cluster];
        }
    }
    return results;
}

- (CGRect)getRectWithPt:(CGPoint) pt  Span:(CGFloat) span {
    CGFloat half = span / 2.f;
    return CGRectMake(pt.x - half, pt.y - half, span, span);
}

- (CGFloat)getDistanceSquared:(CGPoint) pt1 point:(CGPoint) pt2 {
    return (pt1.x - pt2.x) * (pt1.x - pt2.x) + (pt1.y - pt2.y) * (pt1.y - pt2.y);
}

/**
 *  聚合点子聚合可见时的最小放大倍数.
 *
 *  @param cluster 聚合点.
 *
 *  @return 倍数.
 */
- (CGFloat)minZoomLevelForItem:(BMKCluster*)cluster curZoom:(CGFloat)curZoom {
    if (curZoom >= 19) {
        return curZoom;
    }
    BMKQuadItem * quadItem = [[BMKQuadItem alloc] init];
    BMKClusterItem * centerClusterItem = [[BMKClusterItem alloc] init];
    centerClusterItem.coor = cluster.coordinate;
    quadItem.clusterItem = centerClusterItem;
    NSInteger zoom = 0;
    for (zoom = (NSInteger)curZoom + 1; zoom < 19; zoom++) {
        CGFloat zoomSpecificSpan = MAX_DISTANCE_IN_DP / pow(2, zoom) / 256;
        CGRect searchRect = [self getRectWithPt:quadItem.pt Span:zoomSpecificSpan];
        NSMutableArray *items = (NSMutableArray*)[_quadtree searchInRect:searchRect];
        NSArray * array = [items valueForKeyPath:@"@unionOfObjects.clusterItem"];
        BOOL isExpand = NO;
        for (BMKClusterItem * clusterItem in cluster.clusterItems) {
            if (![array containsObject:clusterItem]) {
                isExpand = YES;
                break;
            }
        }
        if (isExpand) {
            break;
        }
    }
    
    return zoom;
}

@end