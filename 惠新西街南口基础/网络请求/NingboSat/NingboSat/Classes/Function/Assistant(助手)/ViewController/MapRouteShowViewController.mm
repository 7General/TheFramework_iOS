//
//  MapRouteShowViewController.m
//  NingboSat
//
//  Created by 王会洲 on 16/9/27.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "MapRouteShowViewController.h"


#import <BaiduMapAPI_Search/BMKSearchComponent.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>

#import "RouteAnnotation.h"
#import "UIImage+Rotate.h"
#import "MapRouteStepView.h"
#import "Config.h"
#import "UIView+UIViewUtils.h"


#define MYBUNDLE_NAME @ "mapapi.bundle"
#define MYBUNDLE_PATH [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent: MYBUNDLE_NAME]
#define MYBUNDLE [NSBundle bundleWithPath: MYBUNDLE_PATH]

@interface MapRouteShowViewController ()<BMKMapViewDelegate, UITableViewDataSource, UITableViewDelegate,BMKLocationServiceDelegate>



@property (nonatomic, strong)BMKMapView * mapView;
/// 底部视图.显示税局名称,地址及路线按键.
@property (nonatomic, strong)MapRouteStepView * bottomView;

@property (nonatomic, strong)BMKRouteLine * routeLine;
@property (nonatomic, strong)BMKLocationService * locationService;
/// 定位信息.
@property (nonatomic, assign)BMKUserLocation *bdUserLocation;

@property (nonatomic, copy)NSString * routeTitle;
@property (nonatomic, copy)NSString * subTitle;

@end

@implementation MapRouteShowViewController

- (void)dealloc {
    NSLog(@"%@ dealloc", [self class]);
    self.mapView.delegate = nil;
    [_locationService stopUserLocationService];
    _locationService.delegate = nil;
}
- (instancetype)initWithBMKRouteLine:(BMKRouteLine *)routeLine andTitle:(NSString *)title subTitle:(NSString *)subTitle {
    self = [super init];
    if (self) {
        self.routeLine = routeLine;
        self.routeTitle = title;
        self.subTitle = subTitle;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"路线";
    
    [self initView];
}

- (void)initView {
    // 地图.
    CGRect frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64);
    BMKMapView * mapView = [[BMKMapView alloc] initWithFrame:frame];
    [self.view addSubview:mapView];
    mapView.delegate = self;
    mapView.zoomLevel = 15;
    self.mapView = mapView;
    
    MapRouteStepView * bottomView = [[MapRouteStepView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 92, SCREEN_WIDTH, (SCREEN_HEIGHT) / 2)];
    [self.view addSubview:bottomView];
    bottomView.dataSource = self;
    bottomView.delegate = self;
    bottomView.title = self.routeTitle;
    bottomView.subTitle = self.subTitle;
    self.bottomView = bottomView;
    
    // 缩放调整按键.
    UIImageView * zoomImageView = [[UIImageView alloc] init];
    [self.view addSubview:zoomImageView];
    zoomImageView.image = [UIImage imageNamed:@"map_size"];
    [zoomImageView sizeToFit];
    zoomImageView.center = CGPointMake(SCREEN_WIDTH - CGRectGetMidX(zoomImageView.bounds) - 20, CGRectGetMinY(bottomView.frame) - 40 - CGRectGetMidY(zoomImageView.bounds));
    zoomImageView.userInteractionEnabled = YES;
    
    UIButton * zoomInBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [zoomImageView addSubview:zoomInBtn];
    zoomInBtn.frame = UIEdgeInsetsInsetRect(zoomImageView.bounds, UIEdgeInsetsMake(0, 0, CGRectGetMidY(zoomImageView.bounds), 0));
    [zoomInBtn addTarget:self action:@selector(zoonInBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * zoomOutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [zoomImageView addSubview:zoomOutBtn];
    zoomOutBtn.frame = UIEdgeInsetsInsetRect(zoomImageView.bounds, UIEdgeInsetsMake(CGRectGetMidY(zoomImageView.bounds), 0, 0, 0));
    [zoomOutBtn addTarget:self action:@selector(zoonOutBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    // 定位按键.
    UIButton * locatedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:locatedBtn];
    locatedBtn.frame = CGRectMake(10, 10, 40, 40);
    [locatedBtn setImage:[UIImage imageNamed:@"location"] forState:UIControlStateNormal];
    [locatedBtn addTarget:self action:@selector(locatedBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
}




- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.mapView viewWillAppear];
    [self.view showHUDIndicatorViewETaxAtCenter];
    [self.view bringSubviewToFront:self.bottomView];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.mapView viewWillDisappear];
    [self.view hideHUDIndicatorViewAtCenter];
}


#pragma mark - BMKMapViewDelegate

- (void)mapViewDidFinishLoading:(BMKMapView *)mapView {
    [self addRouteAnnotation];
    mapView.compassPosition = CGPointMake(SCREEN_WIDTH - mapView.compassSize.width - 10, 10);
    [self.view hideHUDIndicatorViewAtCenter];
}

- (BMKAnnotationView *)mapView:(BMKMapView *)view viewForAnnotation:(id <BMKAnnotation>)annotation {
    if ([annotation isKindOfClass:[RouteAnnotation class]]) {
        return [self getRouteAnnotationView:view viewForAnnotation:(RouteAnnotation*)annotation];
    }
    return nil;
}

- (BMKOverlayView*)mapView:(BMKMapView *)map viewForOverlay:(id<BMKOverlay>)overlay {
    if ([overlay isKindOfClass:[BMKPolyline class]]) {
        BMKPolylineView* polylineView = [[BMKPolylineView alloc] initWithOverlay:overlay];
        polylineView.fillColor = [[UIColor alloc] initWithRed:0 green:1 blue:1 alpha:1];
        polylineView.strokeColor = [[UIColor alloc] initWithRed:0 green:0 blue:1 alpha:0.7];
        polylineView.lineWidth = 3.0;
        return polylineView;
    }
    return nil;
}

#pragma mark - BMKLocationServiceDelegate

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation {
    [self.mapView updateLocationData:userLocation];
    self.bdUserLocation = userLocation;
}

#pragma mark - UITableViewDataSource, UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.routeLine.steps.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString * identifier = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.textColor = YSColor(50, 50, 50);
        cell.textLabel.font = FONT_BY_SCREEN(15);
        cell.textLabel.numberOfLines = 0;
    }
    
    if ([self.routeLine isKindOfClass:[BMKTransitRouteLine class]]) {
        BMKTransitStep* transitStep = [self.routeLine.steps objectAtIndex:indexPath.row];
        cell.textLabel.text = transitStep.instruction;
        switch (transitStep.stepType) {
            case BMK_BUSLINE:
                cell.imageView.image = [UIImage imageNamed:@"map_icon_route_bus"];
                break;
            case BMK_SUBWAY:
                cell.imageView.image = [UIImage imageNamed:@"map_icon_route_metro"];
                break;
            case BMK_WAKLING:
                cell.imageView.image = [UIImage imageNamed:@"map_icon_route_walk"];
                break;
        }
    }
    else if ([self.routeLine isKindOfClass:[BMKDrivingRouteLine class]]) {
        BMKDrivingStep* transitStep = [self.routeLine.steps objectAtIndex:indexPath.row];
        cell.textLabel.text = transitStep.instruction;
        cell.imageView.image = [UIImage imageNamed:@"map_icon_route_car"];
    }
    else if ([self.routeLine isKindOfClass:[BMKWalkingRouteLine class]]) {
        BMKWalkingStep* transitStep = [self.routeLine.steps objectAtIndex:indexPath.row];
        cell.textLabel.text = transitStep.instruction;
        cell.imageView.image = [UIImage imageNamed:@"map_icon_route_walk"];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

#pragma mark - 私有

- (NSString*)getMyBundlePath1:(NSString *)filename
{
    
    NSBundle * libBundle = MYBUNDLE ;
    if ( libBundle && filename ){
        NSString * s=[[libBundle resourcePath ] stringByAppendingPathComponent : filename];
        return s;
    }
    return nil ;
}

- (void)addRouteAnnotation {
    if ([self.routeLine isKindOfClass:[BMKTransitRouteLine class]]) {
        BMKTransitRouteLine* plan = (BMKTransitRouteLine*)self.routeLine;
        // 计算路线方案中的路段数目
        NSInteger size = [plan.steps count];
        int planPointCounts = 0;
        for (int i = 0; i < size; i++) {
            BMKTransitStep* transitStep = [plan.steps objectAtIndex:i];
            if(i==0){
                RouteAnnotation* item = [[RouteAnnotation alloc]init];
                item.coordinate = plan.starting.location;
                item.title = @"起点";
                item.type = 0;
                [self.mapView addAnnotation:item]; // 添加起点标注
                
            }else if(i==size-1){
                RouteAnnotation* item = [[RouteAnnotation alloc]init];
                item.coordinate = plan.terminal.location;
                item.title = @"终点";
                item.type = 1;
                [self.mapView addAnnotation:item]; // 添加起点标注
            }
            RouteAnnotation* item = [[RouteAnnotation alloc]init];
            item.coordinate = transitStep.entrace.location;
            item.title = transitStep.instruction;
            item.type = 3;
            [self.mapView addAnnotation:item];
            
            //轨迹点总数累计
            planPointCounts += transitStep.pointsCount;
        }
        
        //轨迹点
        BMKMapPoint * temppoints = new BMKMapPoint[planPointCounts];
        int i = 0;
        for (int j = 0; j < size; j++) {
            BMKTransitStep* transitStep = [plan.steps objectAtIndex:j];
            int k=0;
            for(k=0;k<transitStep.pointsCount;k++) {
                temppoints[i].x = transitStep.points[k].x;
                temppoints[i].y = transitStep.points[k].y;
                i++;
            }
            
        }
        // 通过points构建BMKPolyline
        BMKPolyline* polyLine = [BMKPolyline polylineWithPoints:temppoints count:planPointCounts];
        [self.mapView addOverlay:polyLine]; // 添加路线overlay
        delete []temppoints;
        [self mapViewFitPolyLine:polyLine];
    }
    else if ([self.routeLine isKindOfClass:[BMKDrivingRouteLine class]]) {
        BMKDrivingRouteLine* plan = (BMKDrivingRouteLine*)self.routeLine;
        // 计算路线方案中的路段数目
        NSInteger size = [plan.steps count];
        int planPointCounts = 0;
        for (int i = 0; i < size; i++) {
            BMKDrivingStep* transitStep = [plan.steps objectAtIndex:i];
            if(i==0){
                RouteAnnotation* item = [[RouteAnnotation alloc]init];
                item.coordinate = plan.starting.location;
                item.title = @"起点";
                item.type = 0;
                [self.mapView addAnnotation:item]; // 添加起点标注
                
            }else if(i==size-1){
                RouteAnnotation* item = [[RouteAnnotation alloc]init];
                item.coordinate = plan.terminal.location;
                item.title = @"终点";
                item.type = 1;
                [self.mapView addAnnotation:item]; // 添加起点标注
            }
            //添加annotation节点
            RouteAnnotation* item = [[RouteAnnotation alloc]init];
            item.coordinate = transitStep.entrace.location;
            item.title = transitStep.entraceInstruction;
            item.degree = transitStep.direction * 30;
            item.type = 4;
            [self.mapView addAnnotation:item];
            
            //轨迹点总数累计
            planPointCounts += transitStep.pointsCount;
        }
        // 添加途经点
        if (plan.wayPoints) {
            for (BMKPlanNode* tempNode in plan.wayPoints) {
                RouteAnnotation* item = [[RouteAnnotation alloc]init];
                item.coordinate = tempNode.pt;
                item.type = 5;
                item.title = tempNode.name;
                [self.mapView addAnnotation:item];
            }
        }
        //轨迹点
        BMKMapPoint * temppoints = new BMKMapPoint[planPointCounts];
        int i = 0;
        for (int j = 0; j < size; j++) {
            BMKDrivingStep* transitStep = [plan.steps objectAtIndex:j];
            int k=0;
            for(k=0;k<transitStep.pointsCount;k++) {
                temppoints[i].x = transitStep.points[k].x;
                temppoints[i].y = transitStep.points[k].y;
                i++;
            }
            
        }
        // 通过points构建BMKPolyline
        BMKPolyline* polyLine = [BMKPolyline polylineWithPoints:temppoints count:planPointCounts];
        [self.mapView addOverlay:polyLine]; // 添加路线overlay
        delete []temppoints;
        [self mapViewFitPolyLine:polyLine];
    }
    else if ([self.routeLine isKindOfClass:[BMKWalkingRouteLine class]]) {
        BMKWalkingRouteLine* plan = (BMKWalkingRouteLine*)self.routeLine;
        NSInteger size = [plan.steps count];
        int planPointCounts = 0;
        for (int i = 0; i < size; i++) {
            BMKWalkingStep* transitStep = [plan.steps objectAtIndex:i];
            if(i==0){
                RouteAnnotation* item = [[RouteAnnotation alloc]init];
                item.coordinate = plan.starting.location;
                item.title = @"起点";
                item.type = 0;
                [self.mapView addAnnotation:item]; // 添加起点标注
                
            }else if(i==size-1){
                RouteAnnotation* item = [[RouteAnnotation alloc]init];
                item.coordinate = plan.terminal.location;
                item.title = @"终点";
                item.type = 1;
                [self.mapView addAnnotation:item]; // 添加起点标注
            }
            //添加annotation节点
            RouteAnnotation* item = [[RouteAnnotation alloc]init];
            item.coordinate = transitStep.entrace.location;
            item.title = transitStep.entraceInstruction;
            item.degree = transitStep.direction * 30;
            item.type = 4;
            [self.mapView addAnnotation:item];
            
            //轨迹点总数累计
            planPointCounts += transitStep.pointsCount;
        }
        
        //轨迹点
        BMKMapPoint * temppoints = new BMKMapPoint[planPointCounts];
        int i = 0;
        for (int j = 0; j < size; j++) {
            BMKWalkingStep* transitStep = [plan.steps objectAtIndex:j];
            int k=0;
            for(k=0;k<transitStep.pointsCount;k++) {
                temppoints[i].x = transitStep.points[k].x;
                temppoints[i].y = transitStep.points[k].y;
                i++;
            }
            
        }
        // 通过points构建BMKPolyline
        BMKPolyline* polyLine = [BMKPolyline polylineWithPoints:temppoints count:planPointCounts];
        [self.mapView addOverlay:polyLine]; // 添加路线overlay
        delete []temppoints;
        [self mapViewFitPolyLine:polyLine];
    }
    
}

- (BMKAnnotationView*)getRouteAnnotationView:(BMKMapView *)mapview viewForAnnotation:(RouteAnnotation*)routeAnnotation
{
    BMKAnnotationView* view = nil;
    switch (routeAnnotation.type) {
        case 0:
        {
            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"start_node"];
            if (view == nil) {
                view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"start_node"];
                view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_start.png"]];
                view.centerOffset = CGPointMake(0, -(view.frame.size.height * 0.5));
                view.canShowCallout = TRUE;
            }
            view.annotation = routeAnnotation;
        }
            break;
        case 1:
        {
            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"end_node"];
            if (view == nil) {
                view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"end_node"];
                view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_end.png"]];
                view.centerOffset = CGPointMake(0, -(view.frame.size.height * 0.5));
                view.canShowCallout = TRUE;
            }
            view.annotation = routeAnnotation;
        }
            break;
        case 2:
        {
            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"bus_node"];
            if (view == nil) {
                view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"bus_node"];
                view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_bus.png"]];
                view.canShowCallout = TRUE;
            }
            view.annotation = routeAnnotation;
        }
            break;
        case 3:
        {
            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"rail_node"];
            if (view == nil) {
                view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"rail_node"];
                view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_rail.png"]];
                view.canShowCallout = TRUE;
            }
            view.annotation = routeAnnotation;
        }
            break;
        case 4:
        {
            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"route_node"];
            if (view == nil) {
                view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"route_node"];
                view.canShowCallout = TRUE;
            } else {
                [view setNeedsDisplay];
            }
            
            UIImage* image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_direction.png"]];
            view.image = [image imageRotatedByDegrees:routeAnnotation.degree];
            view.annotation = routeAnnotation;
            
        }
            break;
        case 5:
        {
            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"waypoint_node"];
            if (view == nil) {
                view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"waypoint_node"];
                view.canShowCallout = TRUE;
            } else {
                [view setNeedsDisplay];
            }
            
            UIImage* image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_waypoint.png"]];
            view.image = [image imageRotatedByDegrees:routeAnnotation.degree];
            view.annotation = routeAnnotation;
        }
            break;
        default:
            break;
    }
    
    return view;
}

//根据polyline设置地图范围
- (void)mapViewFitPolyLine:(BMKPolyline *) polyLine {
    CGFloat ltX, ltY, rbX, rbY;
    if (polyLine.pointCount < 1) {
        return;
    }
    BMKMapPoint pt = polyLine.points[0];
    ltX = pt.x, ltY = pt.y;
    rbX = pt.x, rbY = pt.y;
    for (int i = 1; i < polyLine.pointCount; i++) {
        BMKMapPoint pt = polyLine.points[i];
        if (pt.x < ltX) {
            ltX = pt.x;
        }
        if (pt.x > rbX) {
            rbX = pt.x;
        }
        if (pt.y > ltY) {
            ltY = pt.y;
        }
        if (pt.y < rbY) {
            rbY = pt.y;
        }
    }
    BMKMapRect rect;
    rect.origin = BMKMapPointMake(ltX , ltY);
    rect.size = BMKMapSizeMake(rbX - ltX, rbY - ltY);
    [self.mapView setVisibleMapRect:rect];
    self.mapView.zoomLevel = self.mapView.zoomLevel - 0.3;
}

- (void)startLocationService {
    if (!_locationService) {
        _locationService = [[BMKLocationService alloc] init];
        _locationService.delegate = self;
        [_locationService startUserLocationService];
        self.mapView.showsUserLocation = NO;//先关闭显示的定位图层
        self.mapView.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态
        self.mapView.showsUserLocation = YES;//显示定位图层
    }
}


#pragma mark - button click action

- (void)zoonInBtnClick {
    [self.mapView zoomIn];
}

- (void)zoonOutBtnClick {
    [self.mapView zoomOut];
}

- (void)locatedBtnClick:(UIButton *)btn {
    [self startLocationService];
    if (self.bdUserLocation) {
        [self.mapView setCenterCoordinate:self.bdUserLocation.location.coordinate animated:YES];
    }
}


@end
