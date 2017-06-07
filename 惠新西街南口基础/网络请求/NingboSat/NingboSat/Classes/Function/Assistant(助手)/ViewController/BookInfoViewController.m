//
//  BookInfoViewController.m
//  NingboSat
//
//  Created by 王会洲 on 16/11/28.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "BookInfoViewController.h"
#import "Config.h"
#import "Masonry.h"
#import "NSString+AttributeOrSize.h"
#import "RequestBase.h"
#import "YSAlertView.h"
#import "CheckDataViewController.h"

@interface BookInfoViewController ()
/**状态*/
@property (nonatomic, weak) UILabel * statType;
/**富文本*/
@property (nonatomic, weak) UILabel * attrInfo;
/**logo*/
@property (nonatomic, weak) UIImageView * imgIcon;

@end

@implementation BookInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    
}

-(void)initView {
    self.title = @"预约详情";
    self.view.backgroundColor = YSColor(245, 245, 245);
    
    UIView * infoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 252)];
    infoView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:infoView];
    
    
    UIView * topView = [[UIView alloc] init];
    [infoView addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(infoView.mas_top).with.offset(15);
        make.size.mas_equalTo(CGSizeMake(102, 40));
    }];
    
    UIImageView * imgIcon = [[UIImageView alloc] init];
    imgIcon.image = [UIImage imageNamed:@"info_look_normal"];
    [topView addSubview:imgIcon];
    [imgIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(topView.mas_centerY);
        make.left.equalTo(topView.mas_left).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    self.imgIcon  = imgIcon;

    UILabel * statType = [[UILabel alloc] init];
    statType.textColor = YSColor(80, 80, 80);
    statType.font = FONTMedium(19);
    [topView addSubview:statType];
    [statType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imgIcon.mas_right).with.offset(3);
        make.centerY.equalTo(topView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(75, 19));
    }];
    self.statType = statType;
    
    /**设置状态*/
    if (1 == self.cellModel.yyzt) {
        self.statType.text = @"未办理";
        self.imgIcon.image = [UIImage imageNamed:@"info_look_normal"];
    }
    if (2 == self.cellModel.yyzt || [@2 isEqualToNumber: [NSNumber numberWithInteger:self.cellModel.yyzt]]) {
        self.statType.text = @"已取消";
        self.imgIcon.image = [UIImage imageNamed:@"run_cancle_l"];
    }
    if (3 == self.cellModel.yyzt) {
        self.statType.text = @"已完成";
        self.imgIcon.image = [UIImage imageNamed:@"run_pass_l"];
    }
    if (4 == self.cellModel.yyzt) {
        self.statType.text = @"已违约";
        self.imgIcon.image = [UIImage imageNamed:@"run_wy_l"];
    }
    
    
    UIView * lineOne = [[UIView alloc] init];
    lineOne.backgroundColor = YSColor(230, 230, 230);
    [infoView addSubview:lineOne];
    [lineOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(infoView.mas_left).with.offset(15);
        make.right.equalTo(infoView.mas_right).with.offset(0);
        make.height.mas_equalTo(0.5);
        make.top.equalTo(topView.mas_bottom).with.offset(14);
    }];
    
    UIView * lineTwo = [[UIView alloc] init];
    lineTwo.backgroundColor = YSColor(230, 230, 230);
    [infoView addSubview:lineTwo];
    [lineTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(infoView.mas_left).with.offset(15);
        make.right.equalTo(infoView.mas_right).with.offset(0);
        make.bottom.equalTo(infoView.mas_bottom).with.offset(-38);
        make.height.mas_equalTo(0.5);
    }];
    
    
    UILabel * attrInfo = [[UILabel alloc] init];
    attrInfo.numberOfLines = 0;
     [infoView addSubview:attrInfo];
    
    [attrInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(infoView.mas_left).with.offset(15);
        make.right.equalTo(infoView.mas_right).with.offset(0);
        make.top.equalTo(lineOne.mas_bottom).with.offset(0);
        make.bottom.equalTo(lineTwo.mas_top).with.offset(0);
    }];
    self.attrInfo = attrInfo;
    
    
    NSString * blsj = [NSString stringWithFormat:@"%@ %@-%@",self.cellModel.yyrq,self.cellModel.yysj_q,self.cellModel.yysj_z];
    NSString * row1 = [NSString stringWithFormat:@"办税服务厅：%@\n预 约 事 项：%@\n办 理 时 间：%@",self.cellModel.bswd_mc,self.cellModel.yysx,blsj];
    NSDictionary * leftTitle = @{NSForegroundColorAttributeName:YSColor(154, 154, 154),NSFontAttributeName:FONTLIGHT(15)};
    NSDictionary * rightContent = @{NSForegroundColorAttributeName:YSColor(99, 99, 99),NSFontAttributeName:FONTLIGHT(15)};
    
    NSMutableAttributedString * Allattribute = [[NSMutableAttributedString alloc] init];
    NSAttributedString * attr1 = [row1 stringWithParagraphlineSpeace:2 NormalAttributeFC:leftTitle withKeyTextColor:@[self.cellModel.bswd_mc,self.cellModel.yysx,blsj] KeyAttributeFC:rightContent];
    [Allattribute appendAttributedString:attr1];
    
    
    NSString * row2 = [NSString stringWithFormat:@"\n预   约   码：%@",L(self.cellModel.yym)];
    NSDictionary * rightHContent = @{NSForegroundColorAttributeName:YSColor(255, 126, 0),NSFontAttributeName:FONTLIGHT(15)};
    NSAttributedString * attr2 = [row2 stringWithParagraphlineSpeace:2 NormalAttributeFC:leftTitle withKeyTextColor:@[L(self.cellModel.yym)] KeyAttributeFC:rightHContent];
    [Allattribute appendAttributedString:attr2];
    
    
    NSString * row3 = [NSString stringWithFormat:@"\n预 约 时 间：%@",self.cellModel.yysqsj];
    NSAttributedString * attr3 = [row3 stringWithParagraphlineSpeace:2 NormalAttributeFC:leftTitle withKeyTextColor:@[self.cellModel.yysqsj] KeyAttributeFC:rightContent];
    [Allattribute appendAttributedString:attr3];
    
    self.attrInfo.attributedText = Allattribute;
    
    UIButton * lookData = [UIButton buttonWithType:UIButtonTypeCustom];
    [lookData setTitleColor:YSColor(80, 80, 80) forState:UIControlStateNormal];
    lookData.titleLabel.font = FONTLIGHT(15);
    [lookData setTitle:@"查看办理所需资料" forState:UIControlStateNormal];
    lookData.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [lookData addTarget:self action:@selector(lookClick) forControlEvents:UIControlEventTouchUpInside];
    [infoView addSubview:lookData];
    [lookData mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(infoView.mas_left).with.offset(15);
        make.top.equalTo(lineTwo.mas_bottom).with.offset(10);
        make.right.equalTo(infoView.mas_right).with.offset(-20);
        make.height.mas_equalTo(18);
    }];
    
    UIImageView * runGo = [[UIImageView alloc] init];
    runGo.image = [UIImage imageNamed:@"cell_go"];
    [infoView addSubview:runGo];
    [runGo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(infoView.mas_right).with.offset(-15);
        make.top.equalTo(lineTwo.mas_bottom).with.offset(12);
        make.size.mas_equalTo(CGSizeMake(7, 12));
    }];
    
    
    UILabel * actionMag = [[UILabel alloc] init];
    actionMag.textColor = YSColor(180, 180, 180);
    actionMag.font = FONTLIGHT(13);
    actionMag.text = @"提示 ：办理时间当日不可取消预约。";
    [self.view addSubview:actionMag];
    [actionMag mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(15);
        make.top.equalTo(infoView.mas_bottom).with.offset(10);
        make.right.equalTo(self.view.mas_right).with.offset(0);
        make.height.mas_equalTo(15);
    }];
    
    UIButton * cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.layer.cornerRadius = 8;
    cancelButton.layer.masksToBounds = YES;
    [cancelButton setTitle:@"取消预约" forState:UIControlStateNormal];
    cancelButton.titleLabel.font = FONTLIGHT(17);
    cancelButton.backgroundColor = YSColor(220, 220, 220);
    [cancelButton setTitleColor:YSColor(255, 255, 255) forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(canclClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelButton];
    [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(70);
        make.right.equalTo(self.view.mas_right).with.offset(-70);
        make.top.equalTo(actionMag.mas_bottom).with.offset(30);
        make.height.mas_equalTo(44);
    }];
    int res = [self compareDate:self.cellModel.yyrq withDate:[self currentString]];
    if (res == -1 ) {
        cancelButton.backgroundColor = YSColor(75, 196, 251);
        cancelButton.userInteractionEnabled = YES;
    }
    if (res != -1 || self.cellModel.yyzt == 2 || self.cellModel.yyzt == 3) {
        cancelButton.backgroundColor = YSColor(220, 220, 220);
        cancelButton.userInteractionEnabled = NO;
    }
    
//    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn.frame = CGRectMake(100, 100, 100, 100);
//    btn.backgroundColor = [UIColor redColor];
//    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn];
}
-(void)btnClick {
//    if (self.changeBlock) {
//        self.changeBlock(123);
//        [self.navigationController popViewControllerAnimated:YES];
//    }
}

/**查看办理所需资料*/
-(void)lookClick {
    CheckDataViewController * checkData = [[CheckDataViewController alloc] init];
    checkData.docid = L(self.cellModel.docid);
    checkData.cpnid = L(self.cellModel.cnnid);
    [self.navigationController pushViewController:checkData animated:YES];
}

/**取消预约*/
-(void)canclClick {
    YSAlertView * alert  = [YSAlertView alertWithTitle:nil message:@"您确认要取消该预约？" buttonTitles:@"取消",@"确定", nil];
    [alert alertButtonClick:^(NSInteger buttonIndex) {
        if (1 == buttonIndex) {
            [self cancleBookFunc];
        }
    }];
    [alert show];
}

/**取消预约网络请求*/
-(void)cancleBookFunc {
    NSDictionary * dict = @{@"taxpayer_code":TAXPAYER_CODE,@"taxpayer_name":@"测试纳税人",@"yyid":L(self.cellModel.ids)};
    NSDictionary * param = @{@"jsonParam":[dict JSONParamString]};
    
    [RequestBase requestWith:APITypeBookCancleClick Param:param Complete:^(YSResponseStatus status, id object) {
        if (status == 0) {
            if (self.changeBlock) {
                self.changeBlock(self.cellModel.ids);
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
    } ShowOnView:self.view];
}


/**比较两个时间大小*/
-(int)compareDate:(NSString*)baseDate withDate:(NSString*)date02{
    int ci;
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd"];
    NSDate *dt1 = [[NSDate alloc] init];
    NSDate *dt2 = [[NSDate alloc] init];
    dt1 = [df dateFromString:baseDate];
    dt2 = [df dateFromString:date02];
    NSComparisonResult result = [dt1 compare:dt2];
    switch (result) {
            //date02比date01大
        case NSOrderedAscending: ci=1; break;
            //date02比date01小
        case NSOrderedDescending: ci=-1; break;
            //date02=date01
        case NSOrderedSame: ci=0; break;
        default: NSLog(@"erorr dates %@, %@", dt2, dt1); break;
    }
    return ci;
}

/**获取当前时间*/
-(NSString *)currentString {
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    return  dateString;
}

-(void)setChangeBlock:(changeState)changeBlock {
    _changeBlock = [changeBlock copy];
}

@end
