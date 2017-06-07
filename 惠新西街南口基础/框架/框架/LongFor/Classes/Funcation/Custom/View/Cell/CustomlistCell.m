//
//  CustomlistCell.m
//  LongFor
//
//  Created by ZZG on 17/5/19.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "CustomlistCell.h"
#import "CustomModel.h"
#import "ConfigUI.h"
#import "UIButton+helper.h"

@interface CustomlistCell()
/*! logo */
@property (nonatomic, weak) UIImageView *iconImage;
/*! 姓名 */
@property (nonatomic, weak) UILabel *nameLabel;
/*! 活动邀请 */
@property (nonatomic, weak) UIButton  *inviButton;
/*! 置顶 */
@property (nonatomic, weak) UIButton *topButton;
/*! 出发操作动画 */
@property (nonatomic, weak) UIButton *consButton;
/*! 级别 */
@property (nonatomic, weak) UILabel *leavLabel;
/*! 小高层 */
@property (nonatomic, weak) UILabel *xgcLabel;
/*! 面积 */
@property (nonatomic, weak) UILabel *mianjiLabel;
/*! 楼层 */
@property (nonatomic, weak) UILabel *floorLabel;
/*! 中间横线 */
@property (nonatomic, weak) UIView *lineCenter;
/*! 姓名加时间 */
@property (nonatomic, weak) UILabel *nameAndTime;
/*! 置顾再录 */
@property (nonatomic, weak) UILabel *zgzlLabel;
/*! 信息 */
@property (nonatomic, weak) UILabel *contentLabel;

@property (nonatomic, weak) UIView *consoleView;

/*! 背景 */
@property (nonatomic, weak) UIView *backGroudView;
@end

@implementation CustomlistCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return  self;
}

-(void)initView {
    // 背景
    UIView *backGroudView = [[UIView alloc] init];
    backGroudView.layer.cornerRadius = 8;
    backGroudView.layer.masksToBounds = YES;
    backGroudView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:backGroudView];
    self.backGroudView = backGroudView;
    
    //
    UIImageView *iconImage = [[UIImageView alloc] init];
    [self.backGroudView addSubview:iconImage];
    self.iconImage = iconImage;
    
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.font = FONTWITHSIZE_LIGHT(17);
    nameLabel.textColor = HexColor(@"#333333");
    [self.backGroudView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    UIButton  *inviButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.backGroudView addSubview:inviButton];
    self.inviButton = inviButton;
    
    
    UIButton *topButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.backGroudView addSubview:topButton];
    self.topButton = topButton;
    // 电话 发短信 按钮
    UIButton *consButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [consButton setImage:[UIImage imageNamed:@"cell_animate_down"] forState:UIControlStateNormal];
    [consButton addTarget:self action:@selector(consClick) forControlEvents:UIControlEventTouchUpInside];
    [self.backGroudView addSubview:consButton];
    self.consButton = consButton;
    
    UILabel * leavLabel = [UILabel createLabel:SColor(136, 136, 136) forFont:9];
    [self.backGroudView addSubview:leavLabel];
    self.leavLabel = leavLabel;
    
    /*! 小高层 */
    UILabel * xgcLabel = [UILabel createLabel:SColor(247, 114, 42) forFont:9];
    [self.backGroudView addSubview:xgcLabel];
    self.xgcLabel = xgcLabel;
    
   
    UILabel * mianjiLabel = [UILabel createLabel:SColor(66, 185, 108) forFont:9];
    [self.backGroudView addSubview:mianjiLabel];
    self.mianjiLabel = mianjiLabel;
  
    UILabel * floorLabel = [UILabel createLabel:SColor(104, 186, 193) forFont:9];
    [self.backGroudView addSubview:floorLabel];
    self.floorLabel = floorLabel;
    
    UIView *lineCenter = [[UIView alloc] init];
    lineCenter.backgroundColor = [UIColor colorWithHexString:@"#ebebeb"];
    [self.backGroudView addSubview:lineCenter];
    self.lineCenter = lineCenter;
    
    UILabel *nameAndTime = [[UILabel alloc] init];
    nameAndTime.textColor = SColor(182, 182, 182);
    nameAndTime.font = FONTWITHSIZE_LIGHT(12);
    [self.backGroudView addSubview:nameAndTime];
    self.nameAndTime = nameAndTime;
    
    UILabel *zgzlLabel = [[UILabel alloc] init];
    zgzlLabel.textColor = SColor(182, 182, 182);
    zgzlLabel.font = FONTWITHSIZE_LIGHT(12);
    [self.backGroudView addSubview:zgzlLabel];
    self.zgzlLabel = zgzlLabel;
    
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.numberOfLines = 0;
    contentLabel.textColor = SColor(136, 136, 136);
    contentLabel.font = FONTWITHSIZE_LIGHT(14);
    [self.backGroudView addSubview:contentLabel];
    self.contentLabel = contentLabel;
    
    
    UIView *consoleView = [[UIView alloc] initWithFrame:CGRectMake(0, -70, SCREEN_WIDTH - 30, 70)];
    consoleView.backgroundColor = SColor(39, 127, 255);
    consoleView.layer.cornerRadius = 8;
    consoleView.layer.masksToBounds = YES;
    consoleView.hidden = YES;
    [self.backGroudView addSubview:consoleView];
    self.consoleView = consoleView;
    
    // 打电话
    CGRect rect = CGRectMake(0, 0, consoleView.bounds.size.width * 0.5, 70);
    UIButton * callBtn = [UIButton button:rect
                               TitleColor:SColor(252, 253, 255)
                                TitleFont:FONTWITHSIZE_LIGHT(10)
                                     imge:[UIImage imageNamed:@"cell_call_icon"]
                                  forTitle:@"电话"];
    callBtn.tag = 4001;
    [callBtn addTarget:self action:@selector(callClick:) forControlEvents:UIControlEventTouchUpInside];
    [callBtn setIsVerticalShow:YES];
    [self.consoleView addSubview:callBtn];
    
    // 发送短信
    CGRect MsgRect = CGRectMake(consoleView.bounds.size.width * 0.5, 0, consoleView.bounds.size.width * 0.5, 70);
    UIButton * msgBtn = [UIButton button:MsgRect
                               TitleColor:SColor(252, 253, 255)
                                TitleFont:FONTWITHSIZE_LIGHT(10)
                                     imge:[UIImage imageNamed:@"cell_msg_icon"]
                                 forTitle:@"短信"];
    msgBtn.tag = 4002;
    [msgBtn addTarget:self action:@selector(callClick:) forControlEvents:UIControlEventTouchUpInside];
    [msgBtn setIsVerticalShow:YES];
    [self.consoleView addSubview:msgBtn];
}

#pragma mark - 电话，发短信 按钮点击事件
-(void)callClick:(UIButton *)sender {
    [self setHiddenConsoleView];
    if (self.delegate && [self.delegate respondsToSelector:@selector(consoleDidSelectIndex:didselectIndexPath:)]) {
        [self.delegate consoleDidSelectIndex:sender.tag - 4000 didselectIndexPath:self.pathIndex];
    }
}

#pragma mark - 动画相关
-(void)setHiddenConsoleView {
    self.consoleView.hidden = YES;
    [UIView animateWithDuration:0.12 animations:^{
        self.consoleView.transform = CGAffineTransformMakeTranslation(0, -70);
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:0.25 delay:0.7 options:(UIViewAnimationOptionCurveEaseInOut) animations:^{
            self.consoleView.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            
        }];
        
    }];
}

-(void)setShowConsoleView {
    self.consoleView.hidden = NO;
    self.consoleView.transform = CGAffineTransformMakeTranslation(0, 70);
}

#pragma seetter
-(void)setPathIndex:(NSIndexPath *)pathIndex {
    _pathIndex = pathIndex;
}


#pragma mark - 打电话点击事件
-(void)consClick {
    if (self.delegate && [self.delegate respondsToSelector:@selector(animateCellHeightCustom:)]) {
        [self.delegate animateCellHeightCustom:self.pathIndex];
    }
    
}

-(void)setCmFrame:(CustomModeFrame *)cmFrame {
    _cmFrame = cmFrame;
    //  加载控件位置
    [self initFrame];
    //  加载数据
    [self initData];
}

-(void)initFrame {
    self.iconImage.frame = self.cmFrame.logoF;
    self.nameLabel.frame = self.cmFrame.nameF;
    /*! 活动邀请 */
    //self.inviButton.frame = self.cmFrame.invitationF;
    self.consButton.frame = self.cmFrame.buttonF;
    /*! 置顶 */
    //self.topButton.frame = self.cmFrame.topF;
    self.leavLabel.frame = self.cmFrame.leavelF;
    self.xgcLabel.frame = self.cmFrame.floorF;
    self.mianjiLabel.frame = self.cmFrame.mjF;
    self.floorLabel.frame = self.cmFrame.rooCountF;
    
    self.lineCenter.frame = self.cmFrame.centerLineF;
    self.nameAndTime.frame = self.cmFrame.zygwATimeF;
    self.zgzlLabel.frame = self.cmFrame.zgzlF;
    self.contentLabel.frame = self.cmFrame.contentF;
    self.backGroudView.frame = CGRectMake(15, 3, SCREEN_WIDTH - 30, self.cmFrame.cellHeight - 6);
    
}

-(void)initData {
    CustomModel * mode = self.cmFrame.cMode;
    
    self.iconImage.image = [UIImage imageNamed:@"tabBar_application_icon"];
    self.nameLabel.text = mode.customerName;
    /*! 活动邀请 */
    //[self.inviButton setTitle:@"123" forState:UIControlStateNormal];
    //[self.consButton setTitle:@"456" forState:UIControlStateNormal];
    
    /*! 置顶 */
    //[self.topButton setTitle:@"789" forState:UIControlStateNormal];
    self.leavLabel.text = mode.custlevel;
    self.xgcLabel.text = mode.intentionBiz;
    self.mianjiLabel.text = mode.intentionAread;
    self.floorLabel.text = mode.roomNum;
    self.nameAndTime.text = [NSString stringWithFormat:@"%@ %@",mode.gjR,mode.zrycgjsj];
    self.zgzlLabel.text = mode.gjfs;
    self.contentLabel.text = IsStrEmpty(mode.gjnr) ? @"暂无跟进内容" : mode.gjnr ;
    
    
}

+(instancetype)cellWtihTableView:(UITableView *)tableView {
    static NSString *ID = @"cell";
    CustomlistCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[CustomlistCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = SColor(246, 246, 246);
    return  cell;
}

@end






@implementation UILabel (helper)
/**
 创建UILabel
 
 @param textColor 字体颜色
 @param font 字体大小
 @return UILabel
 */
+(UILabel *)createLabel:(UIColor *)textColor forFont:(CGFloat)font {
    UILabel * Label = [[self alloc] init];
    Label.textAlignment =NSTextAlignmentCenter;
    Label.layer.cornerRadius = 6;
    Label.layer.masksToBounds = YES;
    Label.textColor = textColor;
    Label.font = FONTWITHSIZE_LIGHT(font);
    Label.layer.borderWidth = 1;
    Label.layer.borderColor = Label.textColor.CGColor;
    return Label;
}
@end



