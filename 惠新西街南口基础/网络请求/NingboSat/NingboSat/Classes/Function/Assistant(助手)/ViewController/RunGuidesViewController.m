//
//  RunGuidesViewController.m
//  NingboSat
//
//  Created by 王会洲 on 16/9/26.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "RunGuidesViewController.h"
#import "RequestBase.h"
#import "Masonry.h"
#import "Config.h"

#import "BMKShapeHelper.h"
#import "CustomAnnotationAction.h"
#import "YSAlertView.h"

#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>//引入计算工具所有的头文件
#import "NSString+Size.h"
#import "MapPointList.h"



/*
 *点聚合Annotation
 */
@interface ClusterAnnotation : BMKPointAnnotation

///所包含annotation个数
@property (nonatomic, assign) NSInteger size;

@end

@implementation ClusterAnnotation

@synthesize size = _size;

@end


/*
 *点聚合AnnotationView
 */
@interface ClusterAnnotationView : BMKPinAnnotationView {
    
}

@property (nonatomic, assign) NSInteger size;
@property (nonatomic, strong) UILabel *label;

@end

@implementation ClusterAnnotationView

@synthesize size = _size;
@synthesize label = _label;

- (id)initWithAnnotation:(id<BMKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setBounds:CGRectMake(0.f, 0.f, 22.f, 22.f)];
        _label = [[UILabel alloc] initWithFrame:CGRectMake(0.f, 0.f, 22.f, 22.f)];
        _label.textColor = [UIColor whiteColor];
        _label.font = [UIFont systemFontOfSize:11];
        _label.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:_label];
        self.alpha = 0.85;
    }
    return self;
}

- (void)setSize:(NSInteger)size {
    _size = size;
    if (_size == 1) {
        self.label.hidden = YES;
        self.pinColor = BMKPinAnnotationColorRed;
        return;
    }
    self.label.hidden = NO;
    if (size > 20) {
        self.label.backgroundColor = [UIColor redColor];
    } else if (size > 10) {
        self.label.backgroundColor = [UIColor purpleColor];
    } else if (size > 5) {
        self.label.backgroundColor = [UIColor blueColor];
    } else {
        self.label.backgroundColor = [UIColor greenColor];
    }
    _label.text = [NSString stringWithFormat:@"%ld", size];
}

@end



@interface RunGuidesViewController ()<UINavigationControllerDelegate,MapPointListDelegate>
{
    BMKClusterManager *_clusterManager;//点聚合管理类
    NSInteger _clusterZoom;//聚合级别
    NSMutableArray *_clusterCaches;//点聚合缓存标注
}


/**记录本机安转导航app*/
@property (nonatomic, strong) NSMutableArray * installAppArry;

/**图例面板*/
@property (nonatomic, strong) UIView * legendView;

/**数据源*/
@property (nonatomic, strong) NSMutableArray * pointsBMKArry;

/**电话*/
@property (nonatomic, strong) NSString * telPhone;
/**定位按钮*/
@property (nonatomic, weak) UIButton * locationBtn;
/**税局列表*/
@property (nonatomic, weak) UIButton * showListBtn;
/**刷新*/
@property (nonatomic, weak) UIButton * refreshListBtn;

/**列表view*/
@property (nonatomic, strong) MapPointList * mapListView;

@property (nonatomic, strong) reveModel * reModel;


@end

@implementation RunGuidesViewController

-(BMKClusterManager *)clusterManager {
    if (_clusterManager == nil) {
      _clusterManager = [[BMKClusterManager alloc] init];
    }
    return _clusterManager;
}

-(NSMutableArray *)pointsBMKArry {
    if (_pointsBMKArry == nil) {
        _pointsBMKArry = [NSMutableArray new];
    }
    return _pointsBMKArry;
}


-(UIView *)legendView {
    if (_legendView == nil) {
        _legendView = [UIView new];
        _legendView.backgroundColor = [UIColor whiteColor];
        _legendView.layer.masksToBounds = YES;
        _legendView.layer.cornerRadius = 8;
    }
    return _legendView;
}

-(NSMutableArray *)installAppArry {
    if (_installAppArry == nil) {
        _installAppArry = [NSMutableArray new];
    }
    return _installAppArry;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self configMapView];
    [self initConsole];
}
/**加载图例*/
-(void)initConsole {
    /**图例*/
    [self.view addSubview:self.legendView];
    [self.legendView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(14 * KWidthScale);
        make.top.mas_equalTo(self.view.mas_top).with.offset(10 * KWidthScale);
        make.size.mas_equalTo(CGSizeMake(165 * KWidthScale, 50 * KHeightScale));
    }];
    
    NSArray * lengDict = @[
                                             @{@"state":@"wz",@"title":@"未知"},
                                             @{@"state":@"kx",@"title":@"空闲"},
                                             @{@"state":@"jk",@"title":@"较空"},
                                             @{@"state":@"yb",@"title":@"一般"},
                                             @{@"state":@"jm",@"title":@"较忙"},
                                             @{@"state":@"ml",@"title":@"忙碌"}
                                             ];
    
    NSInteger lengbtnX = 0;
    NSInteger maxCout = 3;
    for (NSInteger index = 0; index < lengDict.count; index++) {
        UIButton * lengBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        lengBtn.titleLabel.font = FONTLIGHT(13);
        CGFloat lengbtnY = index >= maxCout ? (5+ 17 + 6) * KWidthScale : 5 * KWidthScale;
        if (index % maxCout == 0) {
            lengbtnX = 0;
        }
        lengBtn.frame = CGRectMake(5 * KWidthScale +(lengbtnX * (50 * KWidthScale )), lengbtnY, 50 * KWidthScale, 17 * KHeightScale);
        lengbtnX++;
        [lengBtn setImage:[UIImage imageNamed:lengDict[index][@"state"]] forState:UIControlStateNormal];
        lengBtn.imageView.layer.cornerRadius = 5;
        lengBtn.imageView.layer.masksToBounds = YES;
        [lengBtn setTitle:[NSString stringWithFormat:@" %@",lengDict[index][@"title"]] forState:UIControlStateNormal];
        [lengBtn setTitleColor:YSColor(99, 99, 99) forState:UIControlStateNormal];
        [self.legendView addSubview:lengBtn];
    }
    
    /**添加定位按钮*/
    UIButton * locationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [locationBtn setImage:[UIImage imageNamed:@"location"] forState:UIControlStateNormal];
    [locationBtn addTarget:self action:@selector(locationServer) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:locationBtn];
    [locationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.legendView);
        make.bottom.mas_equalTo(self.mapView.mas_bottom).with.offset(-32);
        make.size.mas_equalTo(CGSizeMake(32 * KWidthScale, 32 * KHeightScale));
    }];
    self.locationBtn = locationBtn;
    
    UIButton * showListBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [showListBtn setImage:[UIImage imageNamed:@"icon_drop_bac"] forState:UIControlStateNormal];
    [showListBtn addTarget:self action:@selector(showBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:showListBtn];
    [showListBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view.mas_right).with.offset(-14);
        make.top.mas_equalTo(self.view.mas_top).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(32,32));
    }];
    self.showListBtn = showListBtn;
    
    UIButton * refreshListBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [refreshListBtn setImage:[UIImage imageNamed:@"refresh_drop"] forState:UIControlStateNormal];
    [refreshListBtn addTarget:self action:@selector(refreshBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:refreshListBtn];
    [refreshListBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view.mas_right).with.offset(-14);
        make.top.mas_equalTo(showListBtn.mas_bottom).with.offset(6);
        make.size.mas_equalTo(CGSizeMake(32,32));
    }];
    self.refreshListBtn = refreshListBtn;
}


/**定位信息 */
-(void)locationServer {
    if (self.userLocation) {
        [self.mapView setCenterCoordinate:self.userLocation.location.coordinate animated:YES];
    }
    UIView * deleView = [self.view viewWithTag:3001];
    [deleView removeFromSuperview];
}


/**设置加载地图*/
-(void)configMapView {
    [self.view addSubview:self.mapView];
    self.locService.delegate = self;
    //启动LocationService
    [self.locService startUserLocationService];
    self.mapView.showsUserLocation = NO;//先关闭显示的定位图层
    self.mapView.userTrackingMode = BMKUserTrackingModeFollow;//设置定位的状态
    self.mapView.showsUserLocation = YES;//显示定位图层
}


//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation {
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    /**保存用户定位信息*/
    self.userLocation = userLocation;
    
    NSUserDefaults * defaultes = [NSUserDefaults standardUserDefaults];
    CLLocation * loca = self.userLocation.location;
    
    NSString * latitude = [NSString stringWithFormat:@"%f",loca.coordinate.latitude];
    NSString * longitude = [NSString stringWithFormat:@"%f",loca.coordinate.longitude];
    
    NSString * points = [NSString stringWithFormat:@"%@,%@",latitude,longitude];
    [defaultes setObject:points forKey:LOCATIONS];
    
    
    [self.mapView updateLocationData:userLocation];
}

/**地图加载完成mapViewDidFinishLoading */
-(void)mapViewDidFinishLoading:(BMKMapView *)mapView {
    NSLog(@"mapView Did Finish Loading Map");
    self.mapView.zoomLevel = 13;
    /**刷新地图坐标点*/
    [self refreshMapView:nil];
    /**聚合*/
//    [self updateClusters];
}

/**刷新地图坐标点*/
-(void)refreshMapView:(void(^)())complated {
    [self initData:^(NSMutableArray *arry) {
        [self.mapView addAnnotations:arry];
        BMKShapeHelper *shapeHelper = arry.firstObject;
        [self.mapView setCenterCoordinate:shapeHelper.coordinate animated:YES];
        if (complated) {
            /**删除旧点*/
            [self.mapView removeAnnotations:arry];
            complated();
        }
    }];
}


/**聚合*/
//- (void)mapView:(BMKMapView *)mapView onDrawMapFrame:(BMKMapStatus *)status {
//    if (_clusterZoom != 0 && _clusterZoom != (NSInteger)mapView.zoomLevel) {
//        [self updateClusters];
//    }
//}

-(BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation {
    CustomAnnotationAction * AnnotationAction = [CustomAnnotationAction AnnotationView:mapView viewForAnnotation:annotation withVC:self];
    return AnnotationAction;

    /**聚合*/
//    NSString *AnnotationViewID = @"ClusterMark";
//    ClusterAnnotation *cluster = (ClusterAnnotation*)annotation;
//    ClusterAnnotationView *annotationView = [[ClusterAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
//    annotationView.size = cluster.size;
//    annotationView.draggable = YES;
//    annotationView.annotation = cluster;
//    return annotationView;
}

/**按钮单击事件*/
-(void)rverBtnClick:(UIButton *)sender {
    reveModel * resItem = [self reachBMKHelper:sender.tag];
    self.reModel = resItem;
    [self showBoardInfo:resItem];
}

/**添加模板*/
-(void)showBoardInfo:(reveModel *)model {
    [self deleAlertWindow:3001];
    [self deleAlertWindow:3002];
    [self sheetView:(reveModel *)model];
    
    /**改变定位按钮位置*/
    [self.locationBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.legendView);
        make.bottom.mas_equalTo(self.mapView.mas_bottom).with.offset(-(32 + 220));
        make.size.mas_equalTo(CGSizeMake(32 * KWidthScale, 32 * KHeightScale));
    }];
    
}


/**获取对象*/
-(reveModel *)reachBMKHelper:(NSInteger)ids {
    reveModel * resModel = [[reveModel alloc] init];
    for (BMKShapeHelper * item in self.pointsBMKArry) {
        reveModel * SingItems = item.customDict;
        if (SingItems.ids == ids) {
            resModel = SingItems;
            break;
        }else {
            continue;
        }
    }
    return resModel;
}

/**加载数据*/
-(void)initData:(void(^)(NSMutableArray * arry))complate {
    [self.pointsBMKArry removeAllObjects];
    NSDictionary * param = @{@"area_code":@"",@"taxpayer_code":@""};
    [RequestBase requestWith:(APITypeRunGuideMap) Param:@{@"jsonParam":[param JSONParamString]} Complete:^(YSResponseStatus status, id object) {
        if (status == YSResponseStatusSuccess) {
            if (![[NSString stringWithFormat:@"%@",object[@"content"]] isEqualToString:@"<null>"]) {
                for (NSDictionary * dict in object[@"content"]) {
                    reveModel * reve = [reveModel reveModelWithDict:dict];
                    
                    CLLocationCoordinate2D coordinate;
                    coordinate.longitude = [reve.x doubleValue];
                    coordinate.latitude = [reve.y doubleValue];
                    
                    BMKShapeHelper * BMKHelper = [BMKShapeHelper BMKShapeHelper:@" " sub:@" " coordinate:(coordinate) busData:reve];
                    [self.pointsBMKArry addObject:BMKHelper];
                }
            }

            if (complate) {
                complate(self.pointsBMKArry);
            }
        }
    } ShowOnView:self.view];
}

-(void)test1 {
    //    CLLocationCoordinate2D coordinate;
    //    coordinate.latitude =  39.915168;
    //    coordinate.longitude = 116.403875;
    //
    //
    //    reveModel * reve = [[reveModel alloc]init];
    //    reve.address = @"余姚市曹占赛区10492号余姚市曹占赛区的的余姚市曹占赛区10492号";
    //    reve.swjgmc = @"杏花岭办税大厅";
    //    reve.dqcks = 12;
    //    reve.taxpayers = 32;
    //    reve.telephone = 15010206793;
    //    reve.worktime = @"08:30~11:30,14:00~17:15";
    //    reve.state = 0;
    //    reve.y = @"39.915168";
    //    reve.x = @"116.403875";
    //
    //    BMKShapeHelper * BMKHelper = [BMKShapeHelper BMKShapeHelper:reve.swjgmc sub:@" " coordinate:(coordinate) busData:reve];
    //
    //    [self.pointsBMKArry addObject:BMKHelper];
    //    
    //    if (complate) {
    //        complate(self.pointsBMKArry);
    //    }
}
-(void)test2 {
    _clusterCaches = [[NSMutableArray alloc] init];
    for (NSInteger i = 3; i < 22; i++) {
        [_clusterCaches addObject:[NSMutableArray array]];
    }
    CLLocationCoordinate2D coor = CLLocationCoordinate2DMake(39.915, 116.404);
    //向点聚合管理类中添加标注
    for (NSInteger i = 0; i < 20; i++) {
        double lat =  (arc4random() % 100) * 0.001f;
        double lon =  (arc4random() % 100) * 0.001f;
        BMKClusterItem *clusterItem = [[BMKClusterItem alloc] init];
        clusterItem.coor = CLLocationCoordinate2DMake(coor.latitude + lat, coor.longitude + lon);
        [self.clusterManager addClusterItem:clusterItem];
    }
}
//更新聚合状态
- (void)updateClusters {
    _clusterZoom = (NSInteger)_mapView.zoomLevel;
    NSMutableArray * clusters = [NSMutableArray new];
    __block NSArray *array = [_clusterManager getClusters:_clusterZoom];
    for (BMKCluster *item in array) {
        ClusterAnnotation *annotation = [[ClusterAnnotation alloc] init];
        annotation.coordinate = item.coordinate;
        annotation.size = item.size;
        annotation.title = [NSString stringWithFormat:@"我是%ld个", item.size];
        [clusters addObject:annotation];
    }
    [_mapView removeAnnotations:_mapView.annotations];
    [_mapView addAnnotations:clusters];
}



/**sheetView*/
-(UIView *)sheetView:(reveModel *)model {
    UIView * sheet = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 240)];
    sheet.tag = 3001;
    sheet.layer.masksToBounds = YES;
    sheet.backgroundColor = [UIColor whiteColor];
    [UIView animateWithDuration:0.25 animations:^{
        CGRect rect = sheet.frame;
        rect.origin.y = SCREEN_HEIGHT - 400;
        sheet.frame = rect;
    }];
    [self.view addSubview:sheet];
    
    UIImageView * arrowView = [[UIImageView alloc] init];
    [sheet addSubview:arrowView];
    arrowView.image = [UIImage imageNamed:@"map_route_arrow"];
    [arrowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(sheet);
        make.top.equalTo(sheet).offset(4);
        make.size.mas_equalTo(arrowView.image.size);
    }];
    
    UIView * arrowBgView = [[UIView alloc] init];
    [sheet addSubview:arrowBgView];
    arrowBgView.layer.cornerRadius = 6;
    arrowBgView.layer.borderColor = YSColor(0xe6, 0xe6, 0xe6).CGColor;
    arrowBgView.layer.borderWidth = 0.5;
    [arrowBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(sheet.mas_top).offset(-10);
        make.centerX.equalTo(arrowView);
        make.width.mas_equalTo(arrowView.mas_width).offset(40);
        make.height.mas_equalTo(30);
    }];
    /**添加单击事件回收面板*/
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissSheetView)];
    tapGesture.cancelsTouchesInView = NO;
    [arrowBgView addGestureRecognizer:tapGesture];

    
    UIImageView * imgeView = [[UIImageView alloc] init];
    //imgeView.image = [UIImage imageNamed:@"pleace_show"];
    [sheet addSubview:imgeView];
    // 未知
    if (-1 == model.state)  {
        imgeView.image = [UIImage imageNamed:@"pleace_show"];
    }
    // 空闲
    if (0 == model.state)  {
        imgeView.image = [UIImage imageNamed:@"map_0"];
    }
    // 1 一般
    if (1 == model.state) {
        imgeView.image = [UIImage imageNamed:@"map_1"];
    }
    // 2 一般
    if (2 == model.state) {
        imgeView.image = [UIImage imageNamed:@"map_2"];
    }
    // 3 较忙
    if (3 == model.state)  {
        imgeView.image = [UIImage imageNamed:@"map_3"];
    }
    // 4 忙碌
    if (4 == model.state)  {
        imgeView.image = [UIImage imageNamed:@"map_4"];
    }
    // 5 很忙
    if (5 == model.state)  {
        imgeView.image = [UIImage imageNamed:@"map_5"];
    }
    [imgeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(sheet.mas_left).with.offset(14);
        make.top.mas_equalTo(sheet.mas_top).with.offset(25);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    CLLocationCoordinate2D endCoor;
    endCoor.latitude = [model.y doubleValue];
    endCoor.longitude = [model.x doubleValue];
    
    CLLocationDistance dist = [self sumDistance:self.userLocation.location.coordinate end:endCoor];
    // 距离
    UILabel * distance = [[UILabel alloc] init];
    distance.textColor = YSColor(80, 80, 80);
    distance.text = [NSString stringWithFormat:@"%0.2fkm",dist/1000];
    distance.font = FONTLIGHT(17);
    CGFloat disWidth = [distance.text widthWithFont:FONTLIGHT(17) height:17].width;
    distance.textAlignment = NSTextAlignmentRight;
    [sheet addSubview:distance];
    [distance mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(sheet.mas_right).with.offset(-10);
        make.top.mas_equalTo(sheet.mas_top).with.offset(25);
        make.size.mas_equalTo(CGSizeMake(disWidth + 10, 17));
    }];
    
    
    // 税务局名称
    UILabel * names = [[UILabel alloc] init];
    names.text = model.swjgmc;
    names.textColor = YSColor(80, 80, 80);
    names.font = FONTLIGHT(17);
    [sheet addSubview:names];
    [names mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imgeView.mas_right).with.offset(4);
        make.right.mas_equalTo(sheet.mas_right).with.offset(-(disWidth + 20));
        make.top.mas_equalTo(sheet.mas_top).with.offset(25);
        make.height.mas_equalTo(17);
    }];
    
    
    UILabel * addressTitle = [[UILabel alloc] init];
    addressTitle.font = FONTLIGHT(15);
    addressTitle.text = @"地址:";
    addressTitle.textColor = YSColor(80, 80, 80);
    [sheet addSubview:addressTitle];
    [addressTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(sheet.mas_left).with.offset(14);
        make.top.mas_equalTo(imgeView.mas_bottom).with.offset(9);
        make.size.mas_equalTo(CGSizeMake(40, 17));
    }];
    
    UILabel * address = [[UILabel alloc] init];
    address.font = FONTLIGHT(15);
    address.textColor = YSColor(80, 80, 80);
    address.numberOfLines = 0;
    address.text = model.address;
    [sheet addSubview:address];
    /**计算文本高度*/
    CGFloat addressHeight = [model.address heightWithFont:FONTLIGHT(15) width:(SCREEN_WIDTH - 14 - 58)].height;
    [address mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(addressTitle.mas_right).with.offset(4);
        make.right.mas_equalTo(sheet.mas_right).with.offset(-14);
        make.top.mas_equalTo(imgeView.mas_bottom).with.offset(9);
        make.height.mas_equalTo(addressHeight);
    }];
    
    
    UILabel * windowTitle = [[UILabel alloc] init];
    windowTitle.text = @"窗口数:";
    windowTitle.textColor = YSColor(80, 80, 80);
    windowTitle.font = FONTLIGHT(15);
    [sheet addSubview:windowTitle];
    [windowTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(sheet.mas_left).with.offset(14);
        make.top.mas_equalTo(address.mas_bottom).with.offset(4);
        make.size.mas_equalTo(CGSizeMake(60 * KWidthScale, 17));
    }];
    
    UILabel * window = [[UILabel alloc] init];
    window.text =L(model.dqcks);
    window.textColor = YSColor(255, 1, 1);
    [sheet addSubview:window];
    [window mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(windowTitle.mas_right).with.offset(4);
        make.top.mas_equalTo(address.mas_bottom).with.offset(4);
        make.height.mas_equalTo(17);
    }];
    //
    UILabel * vgeTitle = [[UILabel alloc] init];
    vgeTitle.text = @"排队人数:";
    vgeTitle.font = FONTLIGHT(15);
    vgeTitle.textColor = YSColor(80, 80, 80);
    [sheet addSubview:vgeTitle];
    [vgeTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(window.mas_right).with.offset(10);
        make.top.mas_equalTo(window.mas_top);
        make.size.mas_equalTo(CGSizeMake(80 * KWidthScale, 17));
    }];
    
    UILabel * vge = [[UILabel alloc] init];
    vge.text = L(model.taxpayers);
    vge.textColor = YSColor(255, 1, 1);
    [sheet addSubview:vge];
    [vge mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(vgeTitle.mas_right).with.offset(4);
        make.top.mas_equalTo(vgeTitle.mas_top);
        make.size.mas_equalTo(CGSizeMake(30 * KWidthScale, 17));
    }];
    
    
    UILabel * hotS = [[UILabel alloc] init];
    hotS.text = @"热度:";
    hotS.font = FONTLIGHT(15);
    hotS.textColor = YSColor(80, 80, 80);
    [sheet addSubview:hotS];
    [hotS mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(vge.mas_right).with.offset(5);
        make.top.mas_equalTo(vge.mas_top);
        make.size.mas_equalTo(CGSizeMake(50 * KWidthScale, 17));
    }];
    
    UIImageView * hotImage = [[UIImageView alloc] init];
    [sheet addSubview:hotImage];
    [hotImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(hotS.mas_right).with.offset(5);
        make.centerY.mas_equalTo(hotS.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(10, 10));
    }];
    hotImage.layer.cornerRadius = 5;
    hotImage.layer.masksToBounds=  YES;
    
    // 未知
    if (-1 == model.state)  {
        hotImage.image = [UIImage imageNamed:@"wz"];
    }
    // 空闲
    if (0 == model.state)  {
        hotImage.image = [UIImage imageNamed:@"kx"];
    }
    // 2 一般
    if (1 == model.state) {
        hotImage.image = [UIImage imageNamed:@"kx"];
    }
    
    // 2 一般
    if (2 == model.state) {
        hotImage.image = [UIImage imageNamed:@"jk"];
    }
    // 3 较忙
    if (3 == model.state)  {
        hotImage.image = [UIImage imageNamed:@"jm"];
    }
    // 4 忙碌
    if (4 == model.state)  {
        hotImage.image = [UIImage imageNamed:@"ml"];
    }
    // 5 很忙
    if (5 == model.state)  {
        hotImage.image = [UIImage imageNamed:@"hm"];
    }
    // 预约人数
    UILabel * yyrsL = [[UILabel alloc] init];
    yyrsL.text = @"预约人数:";
    yyrsL.textColor = YSColor(80, 80, 80);
    yyrsL.font = FONTLIGHT(15);
    [sheet addSubview:yyrsL];
    [yyrsL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(sheet.mas_left).with.offset(15);
        make.top.equalTo(windowTitle.mas_bottom).with.offset(5);
        make.size.mas_equalTo(CGSizeMake(80 * KWidthScale, 17));
    }];
    
    UILabel * yyrsV = [[UILabel alloc] init];
    yyrsV.text = L(model.yyrs);
    yyrsV.textColor = YSColor(80, 80, 80);
    yyrsV.font = FONTLIGHT(15);
    [sheet addSubview:yyrsV];
    [yyrsV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(yyrsL.mas_right).with.offset(4);
        make.top.equalTo(windowTitle.mas_bottom).with.offset(5);
        make.size.mas_equalTo(CGSizeMake(40 * KWidthScale, 17));
    }];
    
    // 预约人数
    UILabel * dbrsL = [[UILabel alloc] init];
    dbrsL.text = @"待办人数:";
    dbrsL.textColor = YSColor(80, 80, 80);
    dbrsL.font = FONTLIGHT(15);
    [sheet addSubview:dbrsL];
    [dbrsL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(yyrsV.mas_right).with.offset(5);
        make.top.equalTo(windowTitle.mas_bottom).with.offset(5);
        make.size.mas_equalTo(CGSizeMake(80 * KWidthScale, 17));
    }];
    
    UILabel * dbrsV = [[UILabel alloc] init];
    dbrsV.text = L(model.dbrs);
    dbrsV.textColor = YSColor(80, 80, 80);
    dbrsV.font = FONTLIGHT(15);
    [sheet addSubview:dbrsV];
    [dbrsV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(dbrsL.mas_right).with.offset(4);
        make.top.equalTo(windowTitle.mas_bottom).with.offset(5);
        make.size.mas_equalTo(CGSizeMake(80 * KWidthScale, 17));
    }];
    
    
    
    UILabel * updateTitle = [[UILabel alloc] init];
    updateTitle.text = @"更新时间:";
    updateTitle.font = FONTLIGHT(15);
    updateTitle.textColor = YSColor(80, 80, 80);
    [sheet addSubview:updateTitle];
    [updateTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(sheet.mas_left).with.offset(14);
        make.top.mas_equalTo(yyrsL.mas_bottom).with.offset(4);
        make.size.mas_equalTo(CGSizeMake(80 * KWidthScale, 17));
    }];

    
    UILabel * updateTime = [[UILabel alloc] init];
    updateTime.text = model.updatetime;
    updateTime.font = FONTLIGHT(15);
    updateTime.textColor = YSColor(80, 80, 80);
    [sheet addSubview:updateTime];
    [updateTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(updateTitle.mas_right).with.offset(4);
        make.top.mas_equalTo(updateTitle.mas_top);
        make.right.mas_equalTo(sheet.mas_right).with.offset(-50);
        make.height.mas_equalTo(17);
    }];

    
    
    /**定位按钮*/
    UIButton * location = [UIButton buttonWithType:UIButtonTypeCustom];
    [location setImage:[UIImage imageNamed:@"location_action"] forState:UIControlStateNormal];
    [location addTarget:self action:@selector(locationClick) forControlEvents:UIControlEventTouchUpInside];
    [sheet addSubview:location];
    [location mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(sheet.mas_right).with.offset(-8);
        make.top.mas_equalTo(distance.mas_bottom).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(24, 24));
    }];
    
    /**我要预约*/
    UIButton * bookButton = [UIButton buttonWithType:UIButtonTypeCustom];
    bookButton.backgroundColor = YSColor(74, 193, 247);
    [bookButton setTitle:@"我要预约" forState:UIControlStateNormal];
    [bookButton setTitleColor:YSColor(255, 255, 255) forState:UIControlStateNormal];
    bookButton.titleLabel.font = FONTLIGHT(13);
    bookButton.layer.masksToBounds = YES;
    bookButton.layer.cornerRadius = 2;
    [bookButton addTarget:self action:@selector(bookButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [sheet addSubview:bookButton];
    [bookButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(sheet.mas_right).with.offset(-10);
        make.top.mas_equalTo(location.mas_bottom).with.offset(20);
        make.size.mas_equalTo(CGSizeMake(64, 22));
    }];
    
    

    /**划线*/
    UIView * line = [[UIView alloc] init];
    line.backgroundColor = YSColor(231, 231, 231);
    [sheet addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(sheet.mas_left).with.offset(18);
        make.right.mas_equalTo(sheet.mas_right).with.offset(0);
        make.top.mas_equalTo(updateTime.mas_bottom).with.offset(10);
        make.height.mas_equalTo(0.5);
    }];

    
    UILabel * phoneTitle = [[UILabel alloc] init];
    phoneTitle.font = FONTLIGHT(15);
    phoneTitle.text = @"电话:";
    phoneTitle.textColor = YSColor(80, 80, 80);
    [sheet addSubview:phoneTitle];
    [phoneTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(sheet.mas_left).with.offset(14);
        make.top.mas_equalTo(line.mas_bottom).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(40, 17));
    }];
    
    
    UILabel * phone = [[UILabel alloc] init];
    phone.text = L(model.telephone);
    phone.font = FONTLIGHT(15);
    phone.textColor = YSColor(80, 80, 80);
    [sheet addSubview:phone];
    [phone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(phoneTitle.mas_right).with.offset(4);
        make.right.mas_equalTo(sheet.mas_right).with.offset(-34);
        make.top.mas_equalTo(line.mas_bottom).with.offset(9);
        make.height.mas_equalTo(17);
    }];
    self.telPhone = phone.text;
    
    
    UILabel * timeTitle = [[UILabel alloc] init];
    timeTitle.text = @"时间:";
    timeTitle.font = FONTLIGHT(15);
    timeTitle.textColor = YSColor(80, 80, 80);
    [sheet addSubview:timeTitle];
    [timeTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(sheet.mas_left).with.offset(14);
        make.top.mas_equalTo(phoneTitle.mas_bottom).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(40, 17));
    }];
    
    UILabel * times = [[UILabel alloc] init];
    times.font = FONTLIGHT(15);
    times.text = model.worktime;//@"8:00-11:00，13：30-16：45";
    times.textColor = YSColor(80, 80, 80);
    [sheet addSubview:times];
    [times mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(timeTitle.mas_right).with.offset(4);
        make.right.mas_equalTo(sheet.mas_right).with.offset(-34);
        make.top.mas_equalTo(phoneTitle.mas_bottom).with.offset(9);
        make.height.mas_equalTo(17);
    }];
    
    /**打电话按钮*/
    UIButton * callBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [callBtn setImage:[UIImage imageNamed:@"call_action"] forState:UIControlStateNormal];
    [callBtn addTarget:self action:@selector(callClick) forControlEvents:UIControlEventTouchUpInside];
    [sheet addSubview:callBtn];
    [callBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(sheet.mas_right).with.offset(-25);
        make.top.mas_equalTo(phoneTitle.mas_top);
        make.size.mas_equalTo(CGSizeMake(24, 24));
    }];
    
    
    UIView * lastView = [[UIView alloc] init];
    lastView.backgroundColor = YSColor(231, 231, 231);
    [sheet addSubview:lastView];
    [lastView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(sheet);
        make.right.mas_equalTo(sheet);
        make.bottom.mas_equalTo(sheet);
        make.height.mas_equalTo(0.5);
    }];
    
    return sheet;
    
}

/**定位按钮*/
-(void)locationClick {
    if (self.delegate && [self.delegate respondsToSelector:@selector(customPusviewController:withData:)]) {
        [self.delegate customPusviewController:self.userLocation withData:self.reModel];
    }
}

#pragma mark - 我要预约
-(void)bookButtonClick {
    if (self.delegate && [self.delegate respondsToSelector:@selector(customPusBookController:withData:)]) {
        [self.delegate customPusBookController:YES withData:self.reModel];
    }
}




/**打电话*/
-(void)callClick {
    NSString * message = [NSString stringWithFormat:@"是否拨打电话\n%@",self.telPhone];
    YSAlertView * alert = [YSAlertView alertWithTitle:nil message:message buttonTitles:@"取消",@"确定", nil];
    [alert alertButtonClick:^(NSInteger buttonIndex) {
        if (buttonIndex == 1) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",self.telPhone]]];
        }
    }];
    [alert show];
}
/**计算距离*/
-(CLLocationDistance)sumDistance:(CLLocationCoordinate2D)start end:(CLLocationCoordinate2D)endLoaction {
    BMKMapPoint point1 = BMKMapPointForCoordinate(start);
    BMKMapPoint point2 = BMKMapPointForCoordinate(endLoaction);
    CLLocationDistance distance = BMKMetersBetweenMapPoints(point1,point2);
    return  distance;
}

/**列表信息*/
-(void)showBtnClick {
    [self deleAlertWindow:3001];
    [self deleAlertWindow:3002];
    [UIView animateWithDuration:0.25 animations:^{
        self.mapListView = [[MapPointList alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, SCREEN_HEIGHT - 100 - 64 - 44 - 47)];
        self.mapListView.delegate = self;
        self.mapListView.tag = 3002;
        self.mapListView.isClickListBtn = YES;
        [self.view addSubview:self.mapListView];
        self.mapListView.mapPointArry = self.pointsBMKArry;
    }];
}

/**刷新按钮*/
-(void)refreshBtnClick {
    [self refreshMapView:^{
        if (self.mapListView.isClickListBtn) {
           [self showBtnClick];
        }
    }];
}


/**执行maplistview的代理函数*/
-(void)locationPointswithModel:(reveModel *)model {
    if (self.delegate && [self.delegate respondsToSelector:@selector(customCellPusviewController:withData:)]) {
        [self.delegate customPusviewController:self.userLocation withData:model];
    }
}
/**我要预约*/
-(void)pushBookVCWithModel:(reveModel *)model {
    if (self.delegate && [self.delegate respondsToSelector:@selector(customPusBookController:withData:)]) {
        [self.delegate customPusBookController:YES withData:model];
    }
}


/**删除点击地图中弹出的对话框*/
-(void)deleAlertWindow:(NSInteger)tag {
    UIView * deleView = [self.view viewWithTag:tag];
    [deleView removeFromSuperview];
}


-(void)dismissSheetView {
   [UIView animateWithDuration:0.25 animations:^{
        UIView * deleView = [self.view viewWithTag:3001];
        CGRect rect = deleView.frame;
       rect.origin.y = SCREEN_HEIGHT;
       deleView.frame = rect;
   }completion:^(BOOL finished) {
       [self deleAlertWindow:3001];
       [self deleAlertWindow:3002];
   }];
    
    [self.locationBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.legendView);
        make.bottom.mas_equalTo(self.mapView.mas_bottom).with.offset(-32);
        make.size.mas_equalTo(CGSizeMake(32 * KWidthScale, 32 * KHeightScale));
    }];
}


@end
