//
//  BookItemCell.m
//  NingboSat
//
//  Created by 王会洲 on 16/11/21.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "BookItemCell.h"
#import "NSString+Size.h"
#import "Config.h"

@interface BookItemCell()

@property (nonatomic, weak) UILabel * titleLabel;

@property (nonatomic, weak) UILabel * subTitleLabel;


@end


@implementation BookItemCell

+(instancetype)cellWithTableView:(UITableView *)tableview {
    static NSString * ID = @"bookItemCell";
    BookItemCell * cell = [tableview dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[BookItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
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
    
    UILabel * titleLabel = [[UILabel alloc] init];
    titleLabel.numberOfLines = 2;
    titleLabel.textColor = YSColor(80, 80, 80);
    titleLabel.font = FONT_BOLD_BY_SCREEN(15);
    [self.contentView addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    
    UILabel * subTitleLabel = [[UILabel alloc] init];//WithFrame:CGRectMake(subTitleX, subTtitleY, subTitleW, subTitleH)];
    subTitleLabel.text = @"全市通办事项";
    subTitleLabel.textColor = YSColor(180, 180, 180);
    subTitleLabel.font = FONT_BOLD_BY_SCREEN(13);
    [self.contentView addSubview:subTitleLabel];
    self.subTitleLabel = subTitleLabel;
    
}

-(void)setSpecFrame:(BookSpecFrame *)SpecFrame {
    _SpecFrame = SpecFrame;
    
    BookSpecMdoel * specModel = _SpecFrame.specModel;
    
    self.titleLabel.text = specModel.mc;
    self.titleLabel.frame = SpecFrame.titleF;
    if (specModel.qstb == 1) {
        self.subTitleLabel.text = @"主管税务机关";
    }
    if (specModel.qstb == 2) {
        self.subTitleLabel.text = @"全市通办事项";
    }
    
    self.subTitleLabel.frame = SpecFrame.subTitleF;

}



@end
