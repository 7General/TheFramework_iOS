//
//  ChooseTaxStationController.m
//  NingboSat
//
//  Created by ysyc_liu on 16/9/19.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "ChooseTaxStationController.h"
#import "Masonry.h"
#import "Config.h"
#import "TextFieldCustom+MailAddress.h"
#import "TypeActionSheet.h"
#import "YSAlertView.h"
#import "RequestBase.h"
#import "PickerViewModel.h"

@interface ChooseTaxStationController()<UITextFieldDelegate>

@property (nonatomic, strong)UITextField *areaTextField;
@property (nonatomic, strong)UITextField *stationTextField;
@property (nonatomic, strong)UIView *desView;

@property (nonatomic, strong)TaxStationModel *selectTaxStation;

@property (nonatomic, copy)NSArray *selectAreas;
@property (nonatomic, copy)NSArray *selectStations;

@end

@implementation ChooseTaxStationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"选择办税服务厅";
    self.view.backgroundColor = YSColor(0xf5, 0xf5, 0xf5);
    
    UIBarButtonItem * barButton = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(commitBtnClick)];
    self.navigationItem.rightBarButtonItem = barButton;
    [self.navigationItem.rightBarButtonItem setTintColor:YSColor(0x4b, 0xc4, 0xfb)];
    
    [self initView];
    [self loadViewData];
}

- (void)initView {
    UIView *mainBgView = self.view;
    
    UIView *previousView = nil;
    {
        UILabel *title = [[UILabel alloc] init];
        [mainBgView addSubview:title];
        title.font = FONT_BY_SCREEN(13);
        title.textColor = YSColor(0xb4, 0xb4, 0xb4);
        title.text = @"选择税务机关";
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(mainBgView);
            make.left.equalTo(mainBgView).offset(15);
            make.height.mas_equalTo(38);
        }];
    }
    
    {
        NSArray *titles = @[@"税务机关", @"办税服务厅"];
        NSArray *placeholders = @[@"请选择", @"请选择"];
        NSArray *isSelects = @[@(1), @(1)];
        NSArray *keyPathArray = @[@"_areaTextField", @"_stationTextField"];
        
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(-0.5, 38, SCREEN_WIDTH + 1, 50 * titles.count)];
        [mainBgView addSubview:bgView];
        bgView.backgroundColor = [UIColor whiteColor];
        previousView = bgView;
        
        for (NSInteger i = 0; i < titles.count; i++) {
            UITextField *textField = [TextFieldCustom textFieldWithTitle:titles[i] placeholder:placeholders[i] isSelect:[isSelects[i] boolValue]];
            [bgView addSubview:textField];
            [textField mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(bgView).offset(50 * i);
                make.left.equalTo(bgView).offset(15);
                make.right.equalTo(bgView).offset(-10);
                make.height.mas_equalTo(50);
            }];
            
            textField.delegate = self;
            textField.tag = i;
            [self setValue:textField forKey:keyPathArray[i]];
        }
        
        // 分割线.
        for (NSInteger i = 0; i < titles.count + 1; i++) {
            UIView *line = [[UIView alloc] init];
            [bgView addSubview:line];
            line.backgroundColor = YSColor(0xe6, 0xe6, 0xe6);
            CGFloat headIntent = (i == 0) ? 0 : 15;
            [line mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(bgView).offset(50 * i - 0.25);
                make.left.equalTo(bgView).offset(headIntent);
                make.right.equalTo(bgView);
                make.height.mas_equalTo(0.5);
            }];
        }
    }
    
    {
        UIView *desView = [[UIView alloc] init];
        [mainBgView addSubview:desView];
        desView.backgroundColor = [UIColor whiteColor];
        [desView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(previousView.mas_bottom).offset(0);
            make.left.equalTo(mainBgView).offset(-0.5);
            make.right.equalTo(mainBgView).offset(0.5);
        }];
        [mainBgView bringSubviewToFront:previousView];
        desView.hidden = YES;
        self.desView = desView;
        UIView *tagView = nil;
        { // 详细地址
            UILabel *titleLabel = [[UILabel alloc] init];
            [desView addSubview:titleLabel];
            titleLabel.textColor = YSColor(80, 80, 80);
            titleLabel.font = FONT_BOLD_BY_SCREEN(13);
            titleLabel.text = @"详细地址:";
            [titleLabel sizeToFit];
            [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(desView).offset(36);
                make.top.equalTo(desView).offset(10);
                make.size.mas_equalTo(titleLabel.bounds.size);
            }];
            UIImageView *icon = [[UIImageView alloc] init];
            [desView addSubview:icon];
            icon.image = [UIImage imageNamed:@"locationGrayIcon"];
            icon.contentMode = UIViewContentModeScaleAspectFit;
            [icon mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(titleLabel);
                make.left.equalTo(desView).offset(15);
                make.size.mas_equalTo(CGSizeMake(16, 16));
            }];
            UILabel *contentLabel = [[UILabel alloc] init];
            [desView addSubview:contentLabel];
            contentLabel.textColor = YSColor(80, 80, 80);
            contentLabel.font = FONT_BY_SCREEN(13);
            contentLabel.tag = 100;
            contentLabel.numberOfLines = 0;
            [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(titleLabel.mas_right).offset(5);
                make.top.equalTo(titleLabel);
                make.right.equalTo(desView).offset(-10);
            }];
            tagView = contentLabel;
        }
        
        { // 工作时间
            UILabel *titleLabel = [[UILabel alloc] init];
            [desView addSubview:titleLabel];
            titleLabel.textColor = YSColor(80, 80, 80);
            titleLabel.font = FONT_BOLD_BY_SCREEN(13);
            titleLabel.text = @"工作时间:";
            [titleLabel sizeToFit];
            [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(tagView.mas_bottom).offset(4);
                make.left.equalTo(desView).offset(36);
                make.size.mas_equalTo(titleLabel.bounds.size);
            }];
            UIImageView *icon = [[UIImageView alloc] init];
            [desView addSubview:icon];
            icon.image = [UIImage imageNamed:@"timeIcon"];
            icon.contentMode = UIViewContentModeScaleAspectFit;
            [icon mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(titleLabel);
                make.left.equalTo(desView).offset(15);
                make.size.mas_equalTo(CGSizeMake(16, 16));
            }];
            UILabel *contentLabel = [[UILabel alloc] init];
            [desView addSubview:contentLabel];
            contentLabel.textColor = YSColor(80, 80, 80);
            contentLabel.font = FONT_BY_SCREEN(13);
            contentLabel.tag = 101;
            contentLabel.numberOfLines = 0;
            [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(titleLabel.mas_right).offset(5);
                make.top.equalTo(titleLabel);
                make.right.equalTo(desView).offset(-10);
            }];
        }
        
        UIView *line = [[UIView alloc] init];
        [desView addSubview:line];
        line.backgroundColor = YSColor(0xe6, 0xe6, 0xe6);
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(desView).offset(0);
            make.left.equalTo(desView);
            make.right.equalTo(desView);
            make.height.mas_equalTo(0.5);
        }];
    }
}

- (void)loadViewData {
    if (self.selectTaxStation) {
        self.areaTextField.text = self.selectTaxStation.district;
        self.stationTextField.text = self.selectTaxStation.name;
        NSMutableString *timeStr = [self.selectTaxStation.time mutableCopy];
        [timeStr replaceCharactersInRange:[timeStr rangeOfString:@"_"] withString:@" "];
//        self.desView.attributedText = [self descriptionWithAddress:self.selectTaxStation.address andTime:timeStr];
        UILabel *addressLabel = [self.desView viewWithTag:100];
        UILabel *timeLabel = [self.desView viewWithTag:101];
        if (addressLabel) {
            addressLabel.text = self.selectTaxStation.address;
        }
        if (timeLabel) {
            timeLabel.text = timeStr;
        }
        [self.desView layoutIfNeeded];
        [self.desView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(CGRectGetMaxY(timeLabel.frame) + 10);
        }];
        self.desView.hidden = NO;
    }
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField.tag == 0) {
        [self selectArea];
        return NO;
    }
    else if (textField.tag == 1) {
        [self selectStation];
        return NO;
    }
    else {
        return YES;
    }
}

#pragma mark - 
- (void)selectArea {
    if (!self.selectAreas) {
        [RequestBase requestWith:APITypeNingboDistricts Param:@{} Complete:^(YSResponseStatus status, id object) {
            if (status == YSResponseStatusSuccess) {
                if (!object[@"content"] || ![object[@"content"] isKindOfClass:[NSDictionary class]]
                    || !object[@"content"][@"districts"] || ![object[@"content"][@"districts"] isKindOfClass:[NSArray class]]) {
                    return;
                }
                self.selectAreas = object[@"content"][@"districts"];
                [self selectAreaShow];
            }
        } ShowOnView:self.view];
    }
    else {
        [self selectAreaShow];
    }
}

- (void)selectAreaShow {
    PickerViewModel *viewModel = [[PickerViewModel alloc] init];
    viewModel.dataArray = @[self.selectAreas];
    PickerActionSheet *actionSheet = [[PickerActionSheet alloc] initWithViewModel:viewModel];
    viewModel.confirmBlock = ^(NSArray *selectedArray) {
        @try {
            NSInteger index = [selectedArray.firstObject integerValue];
            self.areaTextField.text = self.selectAreas[index];
            self.selectStations = nil;
            self.stationTextField.text = nil;
            self.desView.hidden = YES;
        } @catch (NSException *exception) {
            NSLog(@"%@ : %@", [self class], exception);
        }
    };
    [actionSheet show];
}

- (void)selectStation {
    if (self.areaTextField.text.length < 1) {
        [[YSAlertView alertWithTitle:@"请选择地区" message:nil buttonTitles:@"确定", nil] show];
        return;
    }
    if (!self.selectStations) {
        NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:self.areaTextField.text, @"districtName", nil];
        [RequestBase requestWith:APITypeTaxStationByDistricts Param:@{@"jsonParam" : [param JSONParamString]} Complete:^(YSResponseStatus status, id object) {
            if (status == YSResponseStatusSuccess) {
                if (!object[@"content"] || ![object[@"content"] isKindOfClass:[NSDictionary class]] || !object[@"content"][@"taxStations"] || ![object[@"content"][@"taxStations"] isKindOfClass:[NSArray class]]) {
                    return;
                }
                self.selectStations = [MTLJSONAdapter modelsOfClass:[TaxStationModel class] fromJSONArray:object[@"content"][@"taxStations"] error:nil];
                [self selectTaxStationShow];
                
            }
        } ShowOnView:self.view];
    }
    else {
        [self selectTaxStationShow];
    }
}

- (void)selectTaxStationShow {
    NSArray *items = [self.selectStations valueForKeyPath:@"@unionOfObjects.name"];
    PickerViewModel *viewModel = [[PickerViewModel alloc] init];
    viewModel.dataArray = @[items];
    PickerActionSheet *actionSheet = [[PickerActionSheet alloc] initWithViewModel:viewModel];
    viewModel.confirmBlock = ^(NSArray *selectedArray) {
        @try {
            NSInteger index = [selectedArray.firstObject integerValue];
            self.selectTaxStation = self.selectStations[index];
            [self loadViewData];
        } @catch (NSException *exception) {
            NSLog(@"%@ : %@", [self class], exception);
        }
    };
    [actionSheet show];
}

#pragma mark - button click action
- (void)commitBtnClick {
    if (self.areaTextField.text.length < 1) {
//        [[YSAlertView alertWithTitle:@"请选择地区" message:nil buttonTitles:@"确定", nil] show];
        return;
    }
    if (self.stationTextField.text.length < 1) {
//        [[YSAlertView alertWithTitle:@"请选择税局" message:nil buttonTitles:@"确定", nil] show];
        return;
    }
    
    if (self.selectBlock) {
        self.selectBlock(self.selectTaxStation);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - other method

- (NSAttributedString *)descriptionWithAddress:(NSString *)address andTime:(NSString *)time {
    UIFont *font = FONT_BY_SCREEN(15);
    UIColor *color = YSColor(0x50, 0x50, 0x50);
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.firstLineHeadIndent = 15;
    paragraphStyle.headIndent = 15;
    paragraphStyle.tailIndent = -15;
    NSAttributedString *addressSub = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"税局地址: %@\n", address] attributes:@{NSFontAttributeName:font, NSForegroundColorAttributeName:color,NSParagraphStyleAttributeName:paragraphStyle}];
    
    NSArray *timeArray = [time componentsSeparatedByString:@"\n"];
    NSAttributedString *timeSub = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"工作时间: %@", timeArray.firstObject] attributes:@{NSFontAttributeName:font, NSForegroundColorAttributeName:color,NSParagraphStyleAttributeName:paragraphStyle}];
    NSMutableAttributedString * result = [[NSMutableAttributedString alloc] init];
    [result appendAttributedString:addressSub];
    [result appendAttributedString:timeSub];
    
    {
        NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:@"工作时间: " attributes:@{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle}];
        paragraphStyle.headIndent = attrStr.size.width + 15;
        paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.headIndent = attrStr.size.width + 15;
        paragraphStyle.firstLineHeadIndent = paragraphStyle.headIndent;
        paragraphStyle.tailIndent = -15;
    }
    for (NSInteger i = 1; i < timeArray.count; i++) {
        NSString *timeStr = timeArray[i];
        timeSub = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"\n%@", timeStr] attributes:@{NSFontAttributeName:font, NSForegroundColorAttributeName:color,NSParagraphStyleAttributeName:paragraphStyle}];
        [result appendAttributedString:timeSub];
    }
    
    
    return result;
}

@end
