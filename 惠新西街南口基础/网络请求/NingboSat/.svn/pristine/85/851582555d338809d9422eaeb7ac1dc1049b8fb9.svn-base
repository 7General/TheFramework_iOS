//
//  BookCell.m
//  NingboSat
//
//  Created by 王会洲 on 16/11/29.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "BookCell.h"
#import "Config.h"
#import "NSString+AttributeOrSize.h"
#import "Masonry.h"
@interface BookCell()

/**内容页*/
@property (nonatomic, weak) UILabel * content;

@property (nonatomic, weak) UIView * lineView;
/**状态图标*/
@property (nonatomic, weak) UIImageView *goIcon;

@property (nonatomic, weak) UIView * CenterView;

@end

@implementation BookCell

+(instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString * ids = @"MyCell";
    BookCell * cell = [tableView dequeueReusableCellWithIdentifier:ids];
    if (cell == nil) {
        cell = [[BookCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ids];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}




-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

-(void)initView {
    CGFloat padding = 15;
    
    CGFloat CvX = padding;
    CGFloat CvY = 9;
    CGFloat CvW = SCREEN_WIDTH - padding * 2;
    CGFloat CvH = 147;
    
    UIView * CenterView = [[UIView alloc] initWithFrame:CGRectMake(CvX, CvY, CvW, CvH)];
    [self.contentView addSubview:CenterView];
    self.CenterView = CenterView;
    
    UILabel * content = [[UILabel alloc] init];
    content.numberOfLines = 0;
    content.textColor = [UIColor redColor];
    [CenterView addSubview:content];
    self.content = content;
    
    UIView * lineView = [[UIView alloc] init];
    lineView.backgroundColor = YSColor(230, 230, 230);
    [self.contentView addSubview:lineView];
    self.lineView = lineView;
   
    UIImageView * imgeIcon = [[UIImageView alloc] init];
    imgeIcon.image = [UIImage imageNamed:@"run_icon"];
    [self.contentView addSubview:imgeIcon];
    self.imgeIcon = imgeIcon;
    
    UILabel * stateRun = [[UILabel alloc] init];
    stateRun.textColor = YSColor(80, 80, 80);
    stateRun.font = FONTLIGHT(15);
    stateRun.text = @"未办理";
    [self.contentView addSubview:stateRun];
    self.stateRun = stateRun;
    
    UIImageView *goIcon = [[UIImageView alloc] init];
    goIcon.image = [UIImage imageNamed:@"cell_go"];
    [self.contentView addSubview:goIcon];
    self.goIcon = goIcon;
    
    
}

-(void)setCellModel:(BookModel *)model{
    /**设置状态*/
    if (1 == model.yyzt) {
        self.stateRun.text = @"未办理";
        self.imgeIcon.image = [UIImage imageNamed:@"run_icon"];
    }
    if (2 == model.yyzt) {
        self.stateRun.text = @"已取消";
        self.imgeIcon.image = [UIImage imageNamed:@"run_cancle"];
    }
    if (3 == model.yyzt) {
        self.stateRun.text = @"已完成";
        self.imgeIcon.image = [UIImage imageNamed:@"run_pass"];
    }
    if (4 == model.yyzt) {
        self.stateRun.text = @"已违约";
        self.imgeIcon.image = [UIImage imageNamed:@"run_wy"];
    }
    
    NSString * blsj = [NSString stringWithFormat:@"%@ %@-%@",model.yyrq,model.yysj_q,model.yysj_z];
    
    NSString * row1 = [NSString stringWithFormat:@"办税服务厅：%@\n预 约 事 项：%@\n办 理 时 间：%@",model.bswd_mc,model.yysx,blsj];
    NSDictionary * leftTitle = @{NSForegroundColorAttributeName:YSColor(154, 154, 154),NSFontAttributeName:FONTLIGHT(15)};
    NSDictionary * rightContent = @{NSForegroundColorAttributeName:YSColor(99, 99, 99),NSFontAttributeName:FONTLIGHT(15)};
    
    NSMutableAttributedString * Allattribute = [[NSMutableAttributedString alloc] init];
    NSAttributedString * attr1 = [row1 stringWithParagraphlineSpeace:2 NormalAttributeFC:leftTitle withKeyTextColor:@[model.bswd_mc,model.yysx,blsj] KeyAttributeFC:rightContent];
    [Allattribute appendAttributedString:attr1];
    
    
    NSString * row2 = [NSString stringWithFormat:@"\n预   约   码：%@",L(model.yym)];
    NSDictionary * rightHContent = @{NSForegroundColorAttributeName:YSColor(255, 126, 0),NSFontAttributeName:FONTLIGHT(15)};
    NSAttributedString * attr2 = [row2 stringWithParagraphlineSpeace:2 NormalAttributeFC:leftTitle withKeyTextColor:@[L(model.yym)] KeyAttributeFC:rightHContent];
    [Allattribute appendAttributedString:attr2];
    
    
    NSString * row3 = [NSString stringWithFormat:@"\n预 约 时 间：%@",model.yysqsj];
    NSAttributedString * attr3 = [row3 stringWithParagraphlineSpeace:2 NormalAttributeFC:leftTitle withKeyTextColor:@[model.yysqsj] KeyAttributeFC:rightContent];
    [Allattribute appendAttributedString:attr3];
    
    self.content.attributedText = Allattribute;
    
    [self.content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.CenterView.mas_left).offset(0);
        make.right.equalTo(self.CenterView.mas_right).offset(0);
        make.top.equalTo(self.CenterView.mas_top).offset(0);
    }];
   
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(0);
        make.right.equalTo(self.contentView.mas_right).offset(0);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-38);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.imgeIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.top.equalTo(self.lineView.mas_bottom).offset(8);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    [self.stateRun mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgeIcon.mas_right).offset(3);
        make.top.equalTo(self.imgeIcon);
        make.size.mas_equalTo(CGSizeMake(100, 20));
    }];
    
    [self.goIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-14);
        make.top.equalTo(self.lineView.mas_bottom).offset(12);
        make.size.mas_equalTo(CGSizeMake(7, 12));
    }];
}



-(void)setFrame:(CGRect)frame {
    frame.size.height -= 10;
    frame.origin.y += 10;
    [super setFrame:frame];
}








@end
