//
//  SelectBookTimeViewController.m
//  NingboSat
//
//  Created by 王会洲 on 16/11/22.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "SelectBookTimeViewController.h"
#import "Config.h"
#import "Masonry.h"
#import "CustomDatePicker.h"
#import "GetWeakDay.h"
#import "SigmentScrollView.h"
#import "AMViewController.h"
#import "PMViewController.h"
#import "RequestBase.h"
#import "SelectDateModel.h"
#import "NSString+AttributeOrSize.h"
#import "NSDate+Helper.h"
#import "UIView+UIViewUtils.h"



@interface SelectBookTimeViewController ()<CustomDatePickerDataSource,CustomDatePickerDelegate,AMSelectDelegate,PMSelectDelegate>

@property (nonatomic, weak) UILabel * dateTitle;

/**预约日期-----用于发送数据*/
@property (nonatomic, strong) NSString * yyrq;

/**选择日期数据源*/
@property (nonatomic, strong) NSMutableArray * dateArryData;

@property (nonatomic, strong) SigmentScrollView * SingmentView;

/**上午控制器*/
@property (nonatomic, strong) AMViewController * AMVC;
/**上午预约时间数据*/
@property (nonatomic, strong) NSMutableArray * AMBookTimeDate;
/**下午控制器*/
@property (nonatomic, strong) PMViewController * PMVC;
/**下午预约时间数据*/
@property (nonatomic, strong) NSMutableArray * PMBookTimeDate;


/**选择公司列表*/
@property (nonatomic, strong) CustomDatePicker * pickerView;
/**当前选中的预约时间*/
@property (nonatomic, strong) SelectBookTimeModel * currentSelectTime;
@end

@implementation SelectBookTimeViewController

-(NSMutableArray *)AMBookTimeDate {
    if (_AMBookTimeDate == nil) {
        _AMBookTimeDate = [NSMutableArray new];
    }
    return _AMBookTimeDate;
}
-(NSMutableArray *)PMBookTimeDate {
    if (_PMBookTimeDate == nil) {
        _PMBookTimeDate = [NSMutableArray new];
    }
    return _PMBookTimeDate;
}




-(NSMutableArray *)dateArryData {
    if (_dateArryData == nil) {
        _dateArryData = [NSMutableArray new];
    }
    return _dateArryData;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"预约时间";
    self.view.backgroundColor = YSColor(245, 245, 245);
    [self initView];
    
    [self initDateList:^(NSString *date) {
        self.yyrq = date;
        [self initBookSelectTime:(date)];
    }];
   
}
/**加载时间日期*/
-(void)initDateList:(void(^)(NSString * date))complated {
    [self.dateArryData removeAllObjects];
    NSDictionary * dict = @{@"":@""};
    NSDictionary * param = @{@"jsonParam":[dict JSONParamString]};
    [RequestBase requestWith:APITypeDateBookItem Param:param Complete:^(YSResponseStatus status, id object) {
        if (status == 0) {
            for (NSDictionary * dict in object[@"content"]) {
                SelectDateModel * model = [SelectDateModel dateModelWithDict:dict];
                [self.dateArryData addObject:model];
            }
            
            if (self.dateArryData.count > 0) {
                SelectDateModel * model = [self.dateArryData firstObject];
                // 获取今天时间的明天日期
               NSString * tomorrStr = [[NSDate date] GetTomorrowDay];
                if ([tomorrStr isEqualToString:model.yyrq]) {
                  self.dateTitle.text = [NSString stringWithFormat:@"%@ %@ (明天)",model.yyrq,model.weakStr];
                }else {
                  self.dateTitle.text = [NSString stringWithFormat:@"%@ %@ ",model.yyrq,model.weakStr];
                }
                if (complated) {
                    complated(model.yyrq);
                }
            }
        }
    } ShowOnView:self.view];
}
/**加载预约时间*/
-(void)initBookSelectTime:(NSString * )selectDate {
    [self.AMBookTimeDate removeAllObjects];
    [self.PMBookTimeDate removeAllObjects];
    NSDictionary * dict = @{@"bswd_id":self.bswd_id,@"yyrq":[selectDate stringTimeWithFormat]};
    NSDictionary * param = @{@"jsonParam":[dict JSONParamString]};
    [RequestBase requestWith:APITypeCheckBookTimeList Param:param Complete:^(YSResponseStatus status, id object) {
        if (status == YSResponseStatusSuccess) {
            for (NSDictionary * dict in object[@"content"]) {
                SelectBookTimeModel * model = [SelectBookTimeModel selectBookTimeWithDict:dict];
               /**1：上午 、2：下午*/
                if (model.yysj_bz == 1) {
                    [self.AMBookTimeDate addObject:model];
                }else {
                    [self.PMBookTimeDate addObject:model];
                }
            }
            /**传至开始*/
            self.AMVC.AMDataArry = self.AMBookTimeDate;
            self.PMVC.PMDataArry = self.PMBookTimeDate;
        }
    } ShowOnView:self.view];
}

-(void)setCheckBlock:(checkItemlangDate)checkBlock {
    _checkBlock = checkBlock;
}


-(void)initView {
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.AMVC = [[AMViewController alloc] init];
    self.AMVC.delegate = self;
    self.PMVC = [[PMViewController alloc] init];
    self.PMVC.delegate = self;
    
    /**填写确定*/
    UIButton * sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.frame = CGRectMake(0, 0, 50, 50);
    sureBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -20);
    [sureBtn setTitleColor:YSColor(80, 80, 80) forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(sureClick) forControlEvents:UIControlEventTouchUpInside];
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:sureBtn];
    
    
    UILabel * msgLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 38)];
    msgLabel.text = @"    温馨提示：同一天内最多预约一次。";
    msgLabel.textColor = YSColor(180, 180, 180);
    msgLabel.font = FONT_BY_SCREEN(13);
    [self.view addSubview:msgLabel];
    
    UIButton * selectView = [UIButton buttonWithType:UIButtonTypeCustom];
    selectView.frame = CGRectMake(0, CGRectGetMaxY(msgLabel.frame), SCREEN_WIDTH, 50);
    selectView.layer.borderWidth = 0.5;
    selectView.layer.borderColor = YSColor(230, 230, 230).CGColor;
    selectView.backgroundColor = [UIColor whiteColor];
    [selectView addTarget:self action:@selector(selectDateCliclk) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:selectView];
    
    UIImageView * icon = [[UIImageView alloc] init];
    icon.image = [UIImage imageNamed:@"date_select"];
    [selectView addSubview:icon];
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(selectView.mas_left).with.offset(10);
        make.centerY.equalTo(selectView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(16, 16));
    }];
    
    UILabel * dateTitle = [[UILabel alloc] init];
    dateTitle.textColor = YSColor(80, 80, 80);
    dateTitle.font = FONT_BY_SCREEN(15);
    [selectView addSubview:dateTitle];
    [dateTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(icon.mas_right).with.offset(10);
        make.centerY.equalTo(selectView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(200, 50));
    }];
    self.dateTitle = dateTitle;
    
    
    UIImageView * accessTypes = [[UIImageView alloc] init];
    accessTypes.image = [UIImage imageNamed:@"rightArrow"];
    [selectView addSubview:accessTypes];
    [accessTypes mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(selectView.mas_right).with.offset(-15);
        make.centerY.equalTo(selectView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(7, 12));
    }];
    
    
    self.SingmentView = [[SigmentScrollView alloc] initWithFrame:CGRectMake(0, 99, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.SingmentView.titleScrollArrys = @[@"上午",@"下午"].mutableCopy;
    self.SingmentView.titleControllerArrys = @[self.AMVC,self.PMVC].mutableCopy;
//    self.SingmentView.SelectDefaultIndex = 1;
    [self.view addSubview:self.SingmentView];
}




/**选中日期*/
-(void)selectDateCliclk {
    self.pickerView = [[CustomDatePicker alloc] initWithSureBtnTitle:@"取消" otherButtonTitle:@"确定"];
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    [self.pickerView show];
}


#pragma mark - 地区选择代理
-(NSInteger)CpickerView:(UIPickerView *)pickerView numberOfRowsInPicker:(NSInteger)component {
    return self.dateArryData.count;
}

-(UIView *)CpickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    SelectDateModel * model = self.dateArryData[row];
    UILabel * cellTitle = [[UILabel alloc] init];
    cellTitle.text = [NSString stringWithFormat:@"%@(%@)",model.yyrq,model.weakStr];
    cellTitle.textColor = YSColor(80, 80, 80);
    cellTitle.font = FONTLIGHT(17);
    cellTitle.textAlignment = NSTextAlignmentCenter;
    return cellTitle;
}

/**确定事件*/
-(void)CpickerViewdidSelectRow:(NSInteger)row {
    SelectDateModel * model = self.dateArryData[row];
    self.dateTitle.text = [NSString stringWithFormat:@"%@ (%@)",model.yyrq,model.weakStr];
    self.yyrq = model.yyrq;
    [self initBookSelectTime:(model.yyrq)];
}
///**取消事件*/
//-(void)CpickerViewCancleClick {
//    [self.pickerView dismisView];
//}

-(CGFloat)CpickerView:(UIPickerView *)pickerView rowHeightForPicker:(NSInteger)component {
    return 43;
}


#pragma mark - 代理监听选择预约模块数据
/**上午*/
-(void)didselectObjModelAM:(SelectBookTimeModel *)AMselectModel {
    self.currentSelectTime = AMselectModel;
}

/**下午*/
-(void)didselectObjModelPM:(SelectBookTimeModel *)PMselectModel {
    self.currentSelectTime = PMselectModel;
}



/**确定事件*/
-(void)sureClick {
    if (IsStrEmpty(self.currentSelectTime.bswd_id)) {
        [self.view showHUDIndicatorLabelAtCenter:@"请选择时间"];
        return;
    }
    if (self.checkBlock) {
        self.checkBlock(self.yyrq,self.currentSelectTime);
    }
    [self.navigationController popViewControllerAnimated:YES];
}




@end
