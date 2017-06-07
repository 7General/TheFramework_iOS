//
//  CustomAnnotationAction.m
//  NingboSat
//
//  Created by 王会洲 on 16/9/26.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "CustomAnnotationAction.h"
#import "BMKShapeHelper.h"
#import "reveModel.h"

@implementation CustomAnnotationAction
+(instancetype)AnnotationView:(BMKMapView *)view viewForAnnotation:(id <BMKAnnotation>)annotation withVC:(UIViewController *)viewController {
    static NSString * AnnotationViewID = @"Annotation";
    // 检查是否有重用的缓存
    CustomAnnotationAction * annotationView = [view dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
    
    // 缓存没有命中，自己构造一个，一般首次添加annotation代码会运行到此处
    if (annotationView == nil) {
        annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
        ((BMKPinAnnotationView*)annotationView).pinColor = BMKPinAnnotationColorRed;
        // 设置重天上掉下的效果(annotation)
        ((BMKPinAnnotationView*)annotationView).animatesDrop = YES;
    }
    // 设置位置
    //    annotationView.centerOffset = CGPointMake(0, -(annotationView.frame.size.height * 0.5));
    //    annotationView.annotation = annotation;
    //
    //    ((BMKPinAnnotationView*)annotationView).pinColor = BMKPinAnnotationColorGreen;
    //    ((BMKPinAnnotationView*)annotationView).animatesDrop = YES;// 设置该标注点动画显示
    annotationView.annotation=annotation;
    
    /**强制转换*/
    BMKShapeHelper * BMKShaper = (BMKShapeHelper *)annotation;
    reveModel * rever = BMKShaper.customDict;

    /*
     -1：未知，图标颜色：#DDDDDD；
     0：空闲，图标颜色：#DDFFDD；
     1：较空，图标颜色：#99FF99；
     3：较忙，图标颜色：#FFBB00；
     4：忙碌，图标颜色：FF3333；
     5：很忙，图标颜色：#990066。
     */
    
    //当前忙碌状态:0无效，1红，2黄，3绿
    // 未知
    if (-1 == rever.state)  {
        annotationView.image = [UIImage imageNamed:@"mapShad_6"];
    }
    // 空闲
    if (0 == rever.state)  {
        annotationView.image = [UIImage imageNamed:@"mapShad_0"];
    }
    // 1 一般
    if (1 == rever.state) {
        annotationView.image = [UIImage imageNamed:@"mapShad_1"];
    }
    
    // 2 一般
    if (2 == rever.state) {
        annotationView.image = [UIImage imageNamed:@"mapShad_2"];
    }
    // 3 较忙
    if (3 == rever.state)  {
        annotationView.image = [UIImage imageNamed:@"mapShad_3"];
    }
    // 4 忙碌
    if (4 == rever.state)  {
        annotationView.image = [UIImage imageNamed:@"mapShad_4"];
    }
    // 5 很忙
    if (5 == rever.state)  {
        annotationView.image = [UIImage imageNamed:@"mapShad_5"];
    }
    
    /**取消气泡显示*/
    UIView *popView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    BMKActionPaopaoView *pView = [[BMKActionPaopaoView alloc]initWithCustomView:popView];
    pView.frame = CGRectMake(0, 0, 0, 0);
   ((BMKPinAnnotationView*)annotationView).paopaoView = nil;
    ((BMKPinAnnotationView*)annotationView).paopaoView = pView;

    /**添加单击事件*/
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.tag = rever.ids;
    [btn addTarget:viewController.self action:@selector(rverBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(0, 0,annotationView.image.size.width, annotationView.image.size.height);
    [annotationView addSubview:btn];
    [annotationView bringSubviewToFront:btn];
    
    return annotationView;
}

@end
