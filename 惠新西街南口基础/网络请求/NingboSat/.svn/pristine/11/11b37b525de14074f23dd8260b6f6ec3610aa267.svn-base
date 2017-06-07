//
//  LookViewController.m
//  NingboSat
//
//  Created by 王会洲 on 16/9/27.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "LookViewController.h"
#import "Config.h"

#import "Masonry.h"
#import "MapRouteShowViewController.h"
#import "UIView+UIViewUtils.h"

@interface LookViewController ()<BMKRouteSearchDelegate>
@property (nonatomic, strong)UIView * consoleView;
@property (nonatomic, strong)UITableView * tableView;




@property (nonatomic, strong)BMKRouteSearch * routesearch;

@property (nonatomic, strong)NSString * startCity;
@property (nonatomic, strong)NSString * endCity;

/// 路线规划选择: 0公交 1驾车 2步行
@property (nonatomic)NSInteger selectWayIndex;

@property (nonatomic, strong)BMKTransitRouteResult * busRoutes;
@property (nonatomic, strong)BMKDrivingRouteResult * driveRoute;
@property (nonatomic, strong)BMKWalkingRouteResult * walkRoute;
@end

@implementation LookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = YSColor(245, 245, 245);
    self.title = @"查看路线";
    
    [self initView];
    
}
- (void)initView {
    UIView * consoleView = [[UIView alloc] initWithFrame:CGRectMake(0, 8, SCREEN_WIDTH, 169)];
    [self.view addSubview:consoleView];
    consoleView.backgroundColor = [UIColor whiteColor];
    self.consoleView = consoleView;
    [self addConsoleSubView];
    
    UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(consoleView.frame), SCREEN_WIDTH, SCREEN_HEIGHT - CGRectGetMaxY(consoleView.frame))];
    [self.view addSubview:tableView];
    tableView.backgroundColor = self.view.backgroundColor;
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.tableFooterView = [[UIView alloc] init];
    tableView.separatorColor = YSColor(0xe6, 0xe6, 0xe6);
    tableView.separatorInset = UIEdgeInsetsZero;
    if (SYSTEM_VERSION >= 8.0) {
        tableView.layoutMargins = UIEdgeInsetsZero;
    }
    self.tableView = tableView;
}
- (void)addConsoleSubView {
    NSArray * array = @[@{@"name":@"我的位置", @"icon":@"map_mineLocation"}, @{@"name":self.lookRevModel.swjgmc, @"icon":@"map_destination"}];
    for (NSInteger i = 0; i < array.count; i++) {
        NSDictionary * dict = array[i];
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(40, 1 + i * 56, CGRectGetWidth(self.consoleView.bounds) - 40, 55)];
        [self.consoleView addSubview:label];
        label.textColor = (i == 0) ? YSColor(0x4b, 0xc4, 0xfb) : YSColor(50, 50, 50);
        label.font = FONT_BY_SCREEN(17);
        label.text = dict[@"name"];
        
        UIImageView * iconView = [[UIImageView alloc] init];
        [self.consoleView addSubview:iconView];
        iconView.image = [UIImage imageNamed:dict[@"icon"]];
        [iconView sizeToFit];
        iconView.center = CGPointMake(16 + iconView.image.size.width / 2, label.center.y);
    }

    {
        UIImageView * linkView = [[UIImageView alloc] init];
        [self.consoleView addSubview:linkView];
        linkView.image = [UIImage imageNamed:@"map_routeLink"];
        [linkView sizeToFit];
        linkView.center = CGPointMake(23, (CGRectGetHeight(self.consoleView.bounds) - 1) / 3 + 0.5);
    }
//
    NSArray * btnsName = @[@"map_bus", @"map_car", @"map_man"];
    for (NSInteger i = 0; i < btnsName.count; i++) {
        NSString * feature = btnsName[i];
        UIImage * imageNormal = [UIImage imageNamed:[NSString stringWithFormat:@"%@Normal", feature]];
        UIImage * imageHL = [UIImage imageNamed:[NSString stringWithFormat:@"%@HL", feature]];
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.consoleView addSubview:button];
        button.frame = CGRectMake(i * CGRectGetWidth(self.consoleView.bounds) / 3, 1 + 2 * 56, CGRectGetWidth(self.consoleView.bounds) / 3, 55);
        button.tag = i;
        [button setImage:imageNormal forState:UIControlStateNormal];
        [button setImage:imageHL forState:UIControlStateSelected];
        button.adjustsImageWhenHighlighted = NO;
        [button addTarget:self action:@selector(chooseWayByBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    // 分割线.水平4条.
    for (NSInteger i = 0; i < 4; i++) {
        CGFloat x = (i != 1) ? 0 : 40;
        CGFloat y = i * 56;
        UIView * line = [[UIView alloc] initWithFrame:CGRectMake(x, y, CGRectGetWidth(self.consoleView.bounds) - x, 1)];
        [self.consoleView addSubview:line];
        line.backgroundColor = YSColor(0xe6, 0xe6, 0xe6);
    }
    // 分割线.垂直2条.
    for (NSInteger i = 0; i < 2; i++) {
        UIView * line = [[UIView alloc] init];
        [self.consoleView addSubview:line];
        line.bounds = CGRectMake(0, 0, 1, 26);
        line.center = CGPointMake((1 + i) * CGRectGetWidth(self.consoleView.bounds) / 3, (2.5 / 3) * CGRectGetHeight(self.consoleView.bounds));
        line.backgroundColor = YSColor(0xe6, 0xe6, 0xe6);
    }
}

- (BMKRouteSearch *)routesearch {
    if (!_routesearch) {
        _routesearch = [[BMKRouteSearch alloc] init];
        _routesearch.delegate = self;
    }
    return _routesearch;
}


#pragma mark - button click action
- (void)chooseWayByBtn:(UIButton *)btn {
    static UIButton * selectBtn = nil;
    if (selectBtn == btn) {
        return;
    }
    [selectBtn setSelected:NO];
    btn.selected = YES;
    selectBtn = btn;
    self.selectWayIndex = btn.tag;
    
    BMKPlanNode* start = [[BMKPlanNode alloc]init];
    start.pt = self.customUserLocation;//self.bdUserLocation.location.coordinate;
    start.cityName = self.startCity;
    
    BMKPlanNode* end = [[BMKPlanNode alloc]init];
    CLLocationCoordinate2D endLocation;
    endLocation.latitude = [self.lookRevModel.y doubleValue];
    endLocation.longitude = [self.lookRevModel.x doubleValue];
    
    end.pt = endLocation;//self.destination.coordinate;
    end.cityName = self.endCity;
    if (btn.tag == 0) {
        if (self.busRoutes) {
            [self.tableView reloadData];
        }
        else {
            BMKTransitRoutePlanOption *transitRouteSearchOption = [[BMKTransitRoutePlanOption alloc]init];
            transitRouteSearchOption.city = self.startCity;
            transitRouteSearchOption.from = start;
            transitRouteSearchOption.to = end;
            [self.routesearch transitSearch:transitRouteSearchOption];
            [self.view showHUDIndicatorViewETaxAtCenter];
        }
    }
    else if (btn.tag == 1) {
        if (self.driveRoute) {
            [self.tableView reloadData];
        }
        else {
            BMKDrivingRoutePlanOption *drivingRouteSearchOption = [[BMKDrivingRoutePlanOption alloc]init];
            drivingRouteSearchOption.from = start;
            drivingRouteSearchOption.to = end;
            [self.routesearch drivingSearch:drivingRouteSearchOption];
            [self.view showHUDIndicatorViewETaxAtCenter];
        }
    }
    else if (btn.tag == 2) {
        if (self.walkRoute) {
            [self.tableView reloadData];
        }
        else {
            BMKWalkingRoutePlanOption *walkingRouteSearchOption = [[BMKWalkingRoutePlanOption alloc]init];
            walkingRouteSearchOption.from = start;
            walkingRouteSearchOption.to = end;
            [self.routesearch walkingSearch:walkingRouteSearchOption];
            [self.view showHUDIndicatorViewETaxAtCenter];
        }
    }
}


- (void)onGetTransitRouteResult:(BMKRouteSearch*)searcher result:(BMKTransitRouteResult*)result errorCode:(BMKSearchErrorCode)error {
    [self.view hideHUDIndicatorViewAtCenter];
    if (error == BMK_SEARCH_NO_ERROR) {
        self.busRoutes = result;
    }
    [self.tableView reloadData];
}

- (void)onGetDrivingRouteResult:(BMKRouteSearch*)searcher result:(BMKDrivingRouteResult*)result errorCode:(BMKSearchErrorCode)error {
    [self.view hideHUDIndicatorViewAtCenter];
    if (error == BMK_SEARCH_NO_ERROR) {
        self.driveRoute = result;
    }
    [self.tableView reloadData];
}

- (void)onGetWalkingRouteResult:(BMKRouteSearch*)searcher result:(BMKWalkingRouteResult*)result errorCode:(BMKSearchErrorCode)error {

    [self.view hideHUDIndicatorViewAtCenter];
    if (error == BMK_SEARCH_NO_ERROR) {
        self.walkRoute = result;
    }
    [self.tableView reloadData];
}




#pragma mark - UITableViewDataSource, UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.selectWayIndex == 0) {
        return self.busRoutes.routes.count;
    }
    else if (self.selectWayIndex == 1) {
        return self.driveRoute.routes.count;
    }
    else if (self.selectWayIndex == 2) {
        return self.walkRoute.routes.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString * identifier = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.backgroundColor = tableView.backgroundColor;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (SYSTEM_VERSION >= 8.0) {
            cell.layoutMargins = UIEdgeInsetsZero;
        }
        // 右箭头.
        UIImageView * arrowView = [[UIImageView alloc] init];
        arrowView.image = [UIImage imageNamed:@"rightArrow"];
        [arrowView sizeToFit];
        cell.accessoryView = arrowView;
        // 序号.
        UILabel * orderLabel = [[UILabel alloc] init];
        [cell.contentView addSubview:orderLabel];
        orderLabel.tag = 10;
        orderLabel.textColor = YSColor(0x4b, 0xc4, 0xfb);
        orderLabel.font = FONT_BY_SCREEN(17);
        orderLabel.textAlignment = NSTextAlignmentCenter;
        [orderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.and.left.and.bottom.equalTo(cell.contentView);
            make.width.mas_equalTo(50);
        }];
        // 路线.
        UILabel * routeLabel = [[UILabel alloc] init];
        [cell.contentView addSubview:routeLabel];
        routeLabel.tag = 11;
        routeLabel.textColor = YSColor(50, 50, 50);
        routeLabel.font = FONT_BY_SCREEN(15);
        [routeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(cell.contentView).offset(10);
            make.left.mas_equalTo(orderLabel.mas_right);
            make.bottom.mas_equalTo(cell.contentView.mas_centerY);
            make.right.equalTo(cell.contentView);
        }];
        // 路线详情.时间|距离|步行距离
        UILabel * routeDesLabel = [[UILabel alloc] init];
        [cell.contentView addSubview:routeDesLabel];
        routeDesLabel.tag = 12;
        routeDesLabel.textColor = YSColor(0xb4, 0xb4, 0xb4);
        routeDesLabel.font = FONT_BY_SCREEN(13);
        [routeDesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(routeLabel.mas_bottom).offset(8);
            make.left.and.right.equalTo(routeLabel);
            make.bottom.equalTo(cell.contentView).offset(-10);
        }];
    }
    
    UILabel * orderLabel = [cell.contentView viewWithTag:10];
    UILabel * routeLabel = [cell.contentView viewWithTag:11];
    UILabel * routeDesLabel = [cell.contentView viewWithTag:12];
    
    orderLabel.text = [NSString stringWithFormat:@"%ld", (long)indexPath.row];
    if (self.selectWayIndex == 0) {
        BMKTransitRouteLine * routeLine = self.busRoutes.routes[indexPath.row];
        NSString * routeStr = @"";
        int walkLong = 0;
        int minutes = routeLine.duration.dates * 24 * 60 + routeLine.duration.hours * 60 + routeLine.duration.minutes;
        for (NSInteger i = 0; i < routeLine.steps.count; i++) {
            BMKTransitStep * step = routeLine.steps[i];
            if (step.stepType == BMK_WAKLING) {
                walkLong += step.distance;
            }
            else {
                if (routeStr.length > 0) {
                    routeStr = [routeStr stringByAppendingString:@"-"];
                }
                BMKVehicleInfo * vehicleInfo = step.vehicleInfo;
                routeStr = [routeStr stringByAppendingString:vehicleInfo.title];
            }
        }
        routeLabel.text = routeStr;
        routeDesLabel.text = [NSString stringWithFormat:@"%d分钟 | %.1f公里 | 步行%d米", minutes, routeLine.distance / 1000.0, walkLong];
    }
    else if (self.selectWayIndex == 1) {
        BMKDrivingRouteLine * routeLine = self.driveRoute.routes[indexPath.row];
        int minutes = routeLine.duration.dates * 24 * 60 + routeLine.duration.hours * 60 + routeLine.duration.minutes;
        routeLabel.text = [NSString stringWithFormat:@"%@ - %@", @"我的位置", self.lookRevModel.swjgmc];
        routeDesLabel.text = [NSString stringWithFormat:@"%d分钟 | %.1f公里", minutes, routeLine.distance / 1000.0];
    }
    else if (self.selectWayIndex == 2) {
        BMKWalkingRouteLine * routeLine = self.walkRoute.routes[indexPath.row];
        int minutes = routeLine.duration.dates * 24 * 60 + routeLine.duration.hours * 60 + routeLine.duration.minutes;
        routeLabel.text = [NSString stringWithFormat:@"%@ - %@", @"我的位置", self.lookRevModel.swjgmc];
        routeDesLabel.text = [NSString stringWithFormat:@"%d分钟 | %d米", minutes, routeLine.distance];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    UILabel * routeLabel = [cell.contentView viewWithTag:11];
    UILabel * routeDesLabel = [cell.contentView viewWithTag:12];
    
    BMKRouteLine * routeLine = nil;
    
    if (self.selectWayIndex == 0) {
        routeLine = self.busRoutes.routes[indexPath.row];
    }
    else if (self.selectWayIndex == 1) {
        routeLine = self.driveRoute.routes[indexPath.row];
    }
    else if (self.selectWayIndex == 2) {
        routeLine = self.walkRoute.routes[indexPath.row];
    }
    MapRouteShowViewController * vc = [[MapRouteShowViewController alloc] initWithBMKRouteLine:routeLine andTitle:routeLabel.text subTitle:routeDesLabel.text];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
