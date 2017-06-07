//
//  LookViewController.h
//  NingboSat
//
//  Created by 王会洲 on 16/9/27.
//  Copyright © 2016年 王会洲. All rights reserved.
//

/**办税地图*/
#import <UIKit/UIKit.h>
#import "reveModel.h"

#import <BaiduMapAPI_Search/BMKSearchComponent.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>


@interface LookViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
//    CLLocationCoordinate2D customUserLocation;
}

//@property (nonatomic, strong)BMKUserLocation * bdUserLocation;
@property (nonatomic, assign) CLLocationCoordinate2D  customUserLocation;

@property (nonatomic, strong)BMKPointAnnotation * destination;
/**具体数据*/
@property (nonatomic, strong) reveModel * lookRevModel;


@end
