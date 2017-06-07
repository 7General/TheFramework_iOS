//
//  CustomAnnotationAction.h
//  NingboSat
//
//  Created by 王会洲 on 16/9/26.
//  Copyright © 2016年 王会洲. All rights reserved.
//

/**重写自定义点击事件*/
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>

@class CustomAnnotationAction;
@protocol CustomAnnotationActionDelegate <NSObject>

@optional
-(void)btnClick;

@end

@interface CustomAnnotationAction : BMKAnnotationView
/**重用*/
+(instancetype)AnnotationView:(BMKMapView *)view viewForAnnotation:(id <BMKAnnotation>)annotation withVC:(UIViewController *)viewController;

@property (nonatomic, weak) id<CustomAnnotationActionDelegate> delegate;
@end
