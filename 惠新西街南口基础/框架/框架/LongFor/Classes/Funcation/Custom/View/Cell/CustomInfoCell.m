//
//  CustomInfoCell.m
//  LongFor
//
//  Created by ZZG on 17/5/27.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "CustomInfoCell.h"
#import "ConfigUI.h"
#import "UILabel+helper.h"

@interface CustomInfoCell()
/*! name */
@property (nonatomic, weak) UILabel *nameL;
/*! 活动到访 */
@property (nonatomic, weak) UILabel *hddfL;
/*! 活动到访日期 */
@property (nonatomic, weak) UILabel *dfTimeL;
/*! 项目地区 */
@property (nonatomic, weak) UILabel *proL;
/*! 项目名称 */
@property (nonatomic, weak) UILabel *pronameL;
/*! 跟进信息 */
@property (nonatomic, weak) UILabel *proContentL;

@end

@implementation CustomInfoCell

+(instancetype)cellWithTableView:(UITableView *)tableView {
 static NSString * ID = @"ID";
    CustomInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[CustomInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.layer.borderWidth = 1;
    cell.layer.borderColor = SColor(245, 245, 245).CGColor;
    return cell;
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        /*! 姓名 */
        UILabel *nameL = [UILabel label:SColor(0, 0, 0) forFont:17];
        [self.contentView addSubview:nameL];
        self.nameL = nameL;
        
        /*! 活动到访 */
        UILabel *hddfL = [UILabel label:SColor(178, 178, 178) forFont:12];
        [self.contentView addSubview:hddfL];
        self.hddfL = hddfL;
        
        /*! 活动到访日期 */
        UILabel *dfTimeL = [UILabel label:SColor(178, 178, 178) forFont:12];
        [self.contentView addSubview:dfTimeL];
        self.dfTimeL = dfTimeL;
        
        /*! 项目地区名称 */
        UILabel *proL = [UILabel label:SColor(178, 178, 178) forFont:12];
        [self.contentView addSubview:proL];
        self.proL = proL;
        
        /*! 项目名称 */
        UILabel *pronameL = [UILabel label:SColor(178, 178, 178) forFont:12];
        [self.contentView addSubview:pronameL];
        self.pronameL = pronameL;
        
        /*! 项目跟进内容 */
        UILabel *proContentL = [UILabel label:SColor(178, 178, 178) forFont:12];
        [self.contentView addSubview:proContentL];
        self.proContentL = proContentL;
        
        
    }
    return self;
}

-(void)setCIFrame:(CustomInfoFrame *)CIFrame {
    _CIFrame = CIFrame;
    [self setFrame];
    [self setData];
    
}
-(void)setFrame {
    CustomInfoFrame * CIF = self.CIFrame;
    self.nameL.frame = CIF.nameF;
    self.hddfL.frame = CIF.hddfF;
    self.dfTimeL.frame = CIF.dftimeF;
    self.proL.frame = CIF.proF;
    self.pronameL.frame = CIF.proNameF;
    self.proContentL.frame = CIF.contentF;
    
}
-(void)setData {
    CustomInfo * CIM = self.CIFrame.CIModel;
    self.nameL.text = CIM.gjR;
    self.hddfL.text = CIM.gjFs;
    self.dfTimeL.text = CIM.gjDateStr;
//    self.proL.text = CIM.
//    self.pronameL.text = CIM.
    NSString * gjnr = IsStrEmpty(CIM.gjNr) ? @"暂无跟进信息" :CIM.gjNr;
    self.proContentL.text = gjnr;
}

-(void)setFrame:(CGRect)frame {
    frame.size.width -= 30;
    frame.origin.x += 15;
    
    frame.origin.y += 2;
    frame.size.height -= 4;
    [super setFrame:frame];
}


@end


@implementation UILabel (create)
/**
 创建UILabel
 
 @param textColor 字体颜色
 @param font 字体大小
 @return UILabel
 */
+(UILabel *)label:(UIColor *)textColor forFont:(CGFloat)font {
    UILabel * Label = [[self alloc] init];
    Label.textAlignment =NSTextAlignmentLeft;
    Label.textColor = textColor;
    Label.font = FONTWITHSIZE_LIGHT(font);
    return Label;
}
@end
