//
//  MapShowCell.m
//  NingboSat
//
//  Created by 王会洲 on 16/10/6.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "MapShowCell.h"
#import "Masonry.h"
#import "Config.h"
#import "NSString+Size.h"
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>//引入计算工具所有的头文件
#import "YSAlertView.h"

@interface MapShowCell()
/**当前选中的对象*/
@property (nonatomic, strong) reveModel * currentModel;
@end

@implementation MapShowCell

+(instancetype)cellWith:(UITableView *)tableview {
   static NSString * ID = @"mapCell";
    MapShowCell * cell = [tableview dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[MapShowCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return  cell;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initCellView];
    }
    return self;
}

-(void)initCellView {
    
    UIImageView * imgeView = [[UIImageView alloc] init];
    imgeView.image = [UIImage imageNamed:@"pleace_show"];
    [self.contentView addSubview:imgeView];
    [imgeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).with.offset(14);
        make.top.mas_equalTo(self.mas_top).with.offset(18);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    self.titleImgeView = imgeView;
    
    UILabel * names = [[UILabel alloc] init];
    names.text = @"标题";
    names.textColor = YSColor(80, 80, 80);
    names.font = FONTLIGHT(17);
    [self.contentView addSubview:names];
    self.names = names;
    
    // 距离
    UILabel * distance = [[UILabel alloc] init];
    distance.textAlignment = NSTextAlignmentRight;
    distance.textColor = YSColor(80, 80, 80);
    distance.font = FONTLIGHT(15);
    [self.contentView addSubview:distance];
    self.distaces = distance;
    // 地址
    UILabel * addressTitle = [[UILabel alloc] init];
    addressTitle.font = FONTLIGHT(15);
    addressTitle.text = @"地址:";
    addressTitle.textColor = YSColor(80, 80, 80);
    [self.contentView addSubview:addressTitle];
    self.addressTitle = addressTitle;
    // 地址数据
    UILabel * address = [[UILabel alloc] init];
    address.font = FONTLIGHT(15);
    address.textColor = YSColor(80, 80, 80);
    address.numberOfLines = 0;
    [self.contentView addSubview:address];
    self.address = address;
    
    
    CGFloat lineHeight = FONTLIGHT(15).lineHeight;
//
    UILabel * windowTitle = [[UILabel alloc] init];
    windowTitle.text = @"窗口数:";
    windowTitle.textColor = YSColor(80, 80, 80);
    windowTitle.font = FONTLIGHT(15);
    [self.contentView addSubview:windowTitle];
    [windowTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).with.offset(14);
        make.top.mas_equalTo(address.mas_bottom).with.offset(4);
        make.height.mas_equalTo(lineHeight);
    }];
//
    UILabel * windowN = [[UILabel alloc] init];
    windowN.textColor = YSColor(255, 1, 1);
    [self.contentView addSubview:windowN];
    [windowN mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(windowTitle.mas_right).with.offset(4);
        make.top.mas_equalTo(address.mas_bottom).with.offset(4);
        make.height.mas_equalTo(lineHeight);
    }];
    self.windowN = windowN;


    UILabel * vgeTitle = [[UILabel alloc] init];
    vgeTitle.text = @"排队人数:";
    vgeTitle.font = FONTLIGHT(15);
    vgeTitle.textColor = YSColor(80, 80, 80);
    [self.contentView addSubview:vgeTitle];
    [vgeTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(windowN.mas_right).with.offset(10);
        make.top.equalTo(windowN);
        make.height.mas_equalTo(lineHeight);
    }];
    
    UILabel * vge = [[UILabel alloc] init];
    vge.textColor = YSColor(255, 1, 1);
    [self.contentView addSubview:vge];
    [vge mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(vgeTitle.mas_right).with.offset(4);
        make.top.equalTo(vgeTitle);
        make.height.mas_equalTo(lineHeight);
    }];
    self.vge = vge;
    
    //热度
    UILabel * hotTitle = [[UILabel alloc] init];
    hotTitle.text = @"热度:";
    hotTitle.font = FONTLIGHT(15);
    hotTitle.textColor = YSColor(80, 80, 80);
    [self.contentView addSubview:hotTitle];
    [hotTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(vge.mas_right).offset(10);
        make.top.equalTo(vge);
        make.height.mas_equalTo(lineHeight);
    }];
    UIView * hotRate = [[UIView alloc] init];
    hotRate.backgroundColor = YSColor(0xC3, 0xC3, 0xC3);
    hotRate.layer.cornerRadius = 6;
    [self.contentView addSubview:hotRate];
    [hotRate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(hotTitle.mas_right).offset(5);
        make.centerY.equalTo(hotTitle);
        make.size.mas_equalTo(CGSizeMake(12, 12));
    }];
    self.hotRate = hotRate;
    
    
    
    // 预约人数
    UILabel * yyrsTitle = [[UILabel alloc] init];
    yyrsTitle.text = @"预约人数:";
    yyrsTitle.font = FONTLIGHT(15);
    yyrsTitle.textColor = YSColor(80, 80, 80);
    [self.contentView addSubview:yyrsTitle];
    [yyrsTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(windowTitle.mas_left);
        make.top.equalTo(windowTitle.mas_bottom).with.offset(4);
        make.size.mas_equalTo(CGSizeMake(80 * KWidthScale, 20));
    }];
    UILabel * yyrs = [[UILabel alloc] init];
    yyrs.font = FONTLIGHT(15);
    yyrs.textColor = YSColor(80, 80, 80);
    [self.contentView addSubview:yyrs];
    [yyrs mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(yyrsTitle.mas_right).offset(4);
        make.centerY.equalTo(yyrsTitle);
        make.size.mas_equalTo(CGSizeMake(40, 20));
    }];
    self.yyrs = yyrs;
    
    // 预约人数
    UILabel * dbrsTitle = [[UILabel alloc] init];
    dbrsTitle.text = @"待办人数:";
    dbrsTitle.font = FONTLIGHT(15);
    dbrsTitle.textColor = YSColor(80, 80, 80);
    [self.contentView addSubview:dbrsTitle];
    [dbrsTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(yyrs.mas_right).with.offset(4);
        make.top.equalTo(windowTitle.mas_bottom).with.offset(4);
        make.size.mas_equalTo(CGSizeMake(80 * KWidthScale, 20));
    }];
    UILabel * dbrs = [[UILabel alloc] init];
    dbrs.font = FONTLIGHT(15);
    dbrs.textColor = YSColor(80, 80, 80);
    [self.contentView addSubview:dbrs];
    [dbrs mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(dbrsTitle.mas_right).offset(4);
        make.centerY.equalTo(dbrsTitle);
        make.size.mas_equalTo(CGSizeMake(40, 20));
    }];
    self.dbrs = dbrs;

    // 更新时间
    UILabel * updateTimeTitle = [[UILabel alloc] init];
    updateTimeTitle.text = @"更新时间:";
    updateTimeTitle.font = FONTLIGHT(15);
    updateTimeTitle.textColor = YSColor(80, 80, 80);
    [updateTimeTitle sizeToFit];
    [self.contentView addSubview:updateTimeTitle];
    [updateTimeTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).with.offset(14);
        make.top.mas_equalTo(yyrsTitle.mas_bottom).with.offset(4);
        make.height.mas_equalTo(lineHeight);
        make.width.mas_equalTo(CGRectGetWidth(updateTimeTitle.bounds));
    }];
    
    UILabel * updateTime = [[UILabel alloc] init];
    updateTime.textColor = YSColor(255, 1, 1);
    updateTime.font = FONTLIGHT(15);
    [self.contentView addSubview:updateTime];
    [updateTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(updateTimeTitle.mas_right).with.offset(4);
        make.top.mas_equalTo(updateTimeTitle);
        make.height.mas_equalTo(lineHeight);
    }];
    self.updateTime = updateTime;
    
    
    
    /**定位按钮*/
    UIButton * location = [UIButton buttonWithType:UIButtonTypeCustom];
    [location setImage:[UIImage imageNamed:@"location_action"] forState:UIControlStateNormal];
    [location addTarget:self action:@selector(locationClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:location];
    [location mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).with.offset(-8);
        make.top.mas_equalTo(distance.mas_bottom).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(24, 24));
    }];
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"我要预约" forState:UIControlStateNormal];
    btn.layer.cornerRadius = 2;
    btn.titleLabel.font = FONTLIGHT(13);
    btn.layer.masksToBounds = YES;
    [btn setTitleColor:YSColor(255, 255, 255) forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(bookClick) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = YSColor(74, 193, 247);
    [self.contentView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).with.offset(-10);
        make.top.equalTo(location.mas_bottom).with.offset(30);
        make.size.mas_equalTo(CGSizeMake(64 * KWidthScale, 22));
    }];
    
    /**划线*/
    UIView * line = [[UIView alloc] init];
    line.backgroundColor = YSColor(231, 231, 231);
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).with.offset(18);
        make.right.mas_equalTo(self.contentView.mas_right).with.offset(0);
        make.top.mas_equalTo(updateTimeTitle.mas_bottom).with.offset(10);
        make.height.mas_equalTo(0.5);
    }];
    
    
    UILabel * phoneTitle = [[UILabel alloc] init];
    phoneTitle.font = FONTLIGHT(15);
    phoneTitle.text = @"电话:";
    phoneTitle.textColor = YSColor(80, 80, 80);
    [self.contentView addSubview:phoneTitle];
    [phoneTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).with.offset(14);
        make.top.mas_equalTo(line.mas_bottom).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(40, 17));
    }];
    
    
    UILabel * phone = [[UILabel alloc] init];
    phone.font = FONTLIGHT(15);
    phone.textColor = YSColor(80, 80, 80);
    [self.contentView addSubview:phone];
    [phone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(phoneTitle.mas_right).with.offset(4);
        make.right.mas_equalTo(self.contentView.mas_right).with.offset(-34);
        make.top.mas_equalTo(line.mas_bottom).with.offset(9);
        make.height.mas_equalTo(17);
    }];
    self.phone = phone;
    
    
    UILabel * timeTitle = [[UILabel alloc] init];
    timeTitle.text = @"时间:";
    timeTitle.font = FONTLIGHT(15);
    timeTitle.textColor = YSColor(80, 80, 80);
    [self.contentView addSubview:timeTitle];
    [timeTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).with.offset(14);
        make.top.mas_equalTo(phoneTitle.mas_bottom).with.offset(4);
        make.height.mas_equalTo(lineHeight);
    }];
    
    UILabel * times = [[UILabel alloc] init];
    times.font = FONTLIGHT(15);
    times.textColor = YSColor(80, 80, 80);
    times.numberOfLines = 0;
    [self.contentView addSubview:times];
    [times mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(timeTitle.mas_right).with.offset(4);
        make.right.mas_equalTo(self.contentView.mas_right).with.offset(-34);
        make.top.mas_equalTo(phoneTitle.mas_bottom).with.offset(4);
    }];
    self.times = times;
    
    /**打电话按钮*/
    UIButton * callBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [callBtn setImage:[UIImage imageNamed:@"call_action"] forState:UIControlStateNormal];
    [callBtn addTarget:self action:@selector(callClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:callBtn];
    [callBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).with.offset(-25);
        make.top.mas_equalTo(phoneTitle.mas_top);
        make.size.mas_equalTo(CGSizeMake(24, 24));
    }];
    
}

-(void)setCellModelInfo:(reveModel *)model complated:(void(^)(reveModel * model))complated {
    self.currentModel = model;
    
    CLLocationCoordinate2D endCoor;
    endCoor.latitude = [model.y doubleValue];
    endCoor.longitude = [model.x doubleValue];

    NSString * location = LOCATION_VALUE;
    NSArray * arry = [location componentsSeparatedByString:@","];
    
    
    CLLocationCoordinate2D userCoor;
    userCoor.latitude = [arry[0] doubleValue];
    userCoor.longitude = [arry[1] doubleValue];
    
    CLLocationDistance dist = [self sumDistance:userCoor end:endCoor];
    self.distaces.text = [NSString stringWithFormat:@"%0.2fkm",dist / 1000];
    CGFloat distW = [self.distaces.text widthWithFont:FONTLIGHT(15) height:17].width;
    [self.distaces mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).with.offset(-10);
        make.top.mas_equalTo(self.contentView.mas_top).with.offset(20);
        make.size.mas_equalTo(CGSizeMake(distW + 10, 17));
    }];
    
    self.names.text = model.swjgmc;
    [self.names mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleImgeView.mas_right).with.offset(4);
        make.right.mas_equalTo(self.contentView.mas_right).with.offset(-(15 + distW));
        make.top.mas_equalTo(self.contentView.mas_top).with.offset(20);
        make.height.mas_equalTo(17);
    }];
    
    
    self.titleImgeView.image = [self imageWithHotRate:model.state];
    self.address.text = model.address;
    self.windowN.text = L(model.dqcks);
    self.vge.text = L(model.taxpayers);
    self.hotRate.backgroundColor = [self colorWithHotRate:model.state];
    self.updateTime.text = model.updatetime;
    self.phone.text = L(model.telephone);
    self.times.text = model.worktime;
    self.yyrs.text = L(model.yyrs);
    self.dbrs.text = L(model.dbrs);
    
    
    [self.addressTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).with.offset(14);
        make.top.mas_equalTo(self.titleImgeView.mas_bottom).with.offset(9);
        make.size.mas_equalTo(CGSizeMake(40, 17));
    }];

    [self.address mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.addressTitle.mas_right).with.offset(4);
        make.right.mas_equalTo(self.contentView.mas_right).with.offset(-14);
        make.top.mas_equalTo(self.titleImgeView.mas_bottom).with.offset(9);
        make.height.mas_equalTo(17);
    }];
    
    
    
    
    if (complated) {
        complated(model);
    }
}

/**打电话*/
-(void)callClick {
    NSString * message = [NSString stringWithFormat:@"是否拨打电话\n%@",L(self.currentModel.telephone)];
    YSAlertView * alert = [YSAlertView alertWithTitle:nil message:message buttonTitles:@"取消",@"确定", nil];
    [alert alertButtonClick:^(NSInteger buttonIndex) {
        if (buttonIndex == 1) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",L(self.currentModel.telephone)]]];
        }
    }];
    [alert show];
}

/**定位按钮*/
-(void)locationClick {
    if (self.delegate && [self.delegate respondsToSelector:@selector(CellPusviewControllerwithData:)]) {
        [self.delegate CellPusviewControllerwithData:self.currentModel];
    }
}


/**计算距离*/
-(CLLocationDistance)sumDistance:(CLLocationCoordinate2D)start end:(CLLocationCoordinate2D)endLoaction {
    BMKMapPoint point1 = BMKMapPointForCoordinate(start);
    BMKMapPoint point2 = BMKMapPointForCoordinate(endLoaction);
    CLLocationDistance distance = BMKMetersBetweenMapPoints(point1,point2);
    return  distance;
}

- (UIColor *)colorWithHotRate:(NSInteger)rate {
    NSArray * array = @[YSColor(0xC3, 0xC3, 0xC3),
                        YSColor(0xDD, 0xFF, 0xDD),
                        YSColor(0x99, 0xFF, 0x99),
                        YSColor(0x44, 0xAA, 0x44),
                        YSColor(0xFF, 0xBB, 0),
                        YSColor(0xFF, 0x33, 0x33),
                        YSColor(0x99, 0, 0x66),];
    UIColor * retColor = nil;
    @try {
        retColor = array[rate + 1];
    } @catch (NSException *exception) {
        retColor = YSColor(0xC3, 0xC3, 0xC3);
    }
    return retColor;
}

/**预约按钮*/
-(void)bookClick {
//    if (self.delegate && [self.delegate respondsToSelector:@selector(CellPusviewControllerwithData:)]) {
//        [self.delegate CellPusviewControllerwithData:self.currentModel];
//    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(CellClickWithIndexRow:)]) {
        [self.delegate CellClickWithIndexRow:self.currentModel];
    }
}

- (UIImage *)imageWithHotRate:(NSInteger)rate {
    NSInteger finalRate = rate;
    if (rate < -1 || rate > 5) {
        finalRate = -1;
    }
    NSString * imageName = nil;
    if (rate == -1) {
        imageName = @"pleace_show";
    }
    else {
        imageName = [NSString stringWithFormat:@"map_%d", (int)finalRate];
    }
    return [UIImage imageNamed:imageName];
}

@end
