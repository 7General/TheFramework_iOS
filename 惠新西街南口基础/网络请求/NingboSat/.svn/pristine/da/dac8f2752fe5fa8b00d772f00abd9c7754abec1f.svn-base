//
//  BMKShapeHelper.h
//  NingboSat
//
//  Created by 王会洲 on 16/9/26.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>

@interface BMKShapeHelper : NSObject<BMKAnnotation>

/// 要显示的标题
@property (copy) NSString *Htitle;
/// 要显示的副标题
@property (copy) NSString *Hsubtitle;

@property (nonatomic, readonly) CLLocationCoordinate2D Hcoordinate;

/**网络请求*/
@property (nonatomic, strong) id  customDict;

+(instancetype)BMKShapeHelper:(NSString *)title sub:(NSString *)subTitle coordinate:(CLLocationCoordinate2D)coordinate busData:(id)busyState;

@end
