//
//  RunGuidesViewController.h
//  NingboSat
//
//  Created by 王会洲 on 16/9/26.
//  Copyright © 2016年 王会洲. All rights reserved.
//

/**办税指南*/
#import <UIKit/UIKit.h>
#import "reveModel.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import "BMKClusterManager.h"




@protocol RunGuidesViewControllerDelegate <NSObject>
@optional
/**跳转*/
-(void)customPusviewController:(BMKUserLocation *)location withData:(reveModel *)reve;
-(void)customCellPusviewController:(CLLocationCoordinate2D)location withData:(reveModel *)reve;
/**跳转预约办税*/
-(void)customPusBookController:(BOOL)isUsed withData:(reveModel *)reve;
@end


@interface RunGuidesViewController : UIViewController<BMKMapViewDelegate,BMKLocationServiceDelegate>

@property (nonatomic, assign) id<RunGuidesViewControllerDelegate>  delegate;

/**地图*/
@property (nonatomic, strong) BMKMapView * mapView;
/**定位*/
@property (nonatomic, strong) BMKLocationService * locService;
/**用户定位信息*/
@property (nonatomic, strong) BMKUserLocation * userLocation;
/**增加点聚合功能*/
@property (nonatomic, strong) BMKClusterManager * clusterManager;
/**用户目的地信息*/
@property (nonatomic, assign) CLLocationCoordinate2D  userEndLocation;


@end
