//
//  RouteAnnotation.h
//  eTax
//
//  Created by ysyc_liu on 16/5/30.
//  Copyright © 2016年 ysyc. All rights reserved.
//

#import <BaiduMapAPI_Map/BMKMapComponent.h>

@interface RouteAnnotation : BMKPointAnnotation

///<0:起点 1:终点 2:公交 3:地铁 4:驾乘 5:途经点>
@property (nonatomic) NSInteger type;
@property (nonatomic) NSInteger degree;

@end
