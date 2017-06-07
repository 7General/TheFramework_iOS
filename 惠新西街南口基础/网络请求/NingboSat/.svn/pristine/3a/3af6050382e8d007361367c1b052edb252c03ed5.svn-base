//
//  MailNormalCell.m
//  NingboSat
//
//  Created by ysyc_liu on 2016/11/4.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "MailNormalCell.h"
#import "Masonry.h"
#import "Config.h"

@interface MailNormalCell()

@property (nonatomic, strong)UIImageView *leftImageView;

@end

@implementation MailNormalCell

- (void)initView {
    [super initView];
    
    {
        UILabel *label = [[UILabel alloc] init];
        [self.contentView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(15);
            make.centerY.equalTo(self.contentView);
        }];
//        label.numberOfLines = 0;
        self.leftLabel = label;
        
    }
    
    {
        UILabel *label = [[UILabel alloc] init];
        [self.contentView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.leftLabel.mas_right).offset(5);
            make.right.equalTo(self.contentView).offset(-10);
            make.centerY.equalTo(self.contentView);
            make.width.mas_greaterThanOrEqualTo(40);
            make.width.mas_lessThanOrEqualTo(self.contentView).multipliedBy(0.6);
        }];
        label.textAlignment = NSTextAlignmentRight;
        label.numberOfLines = 0;
        self.rightLabel = label;
    }
    
    self.leftLabel.font = FONT_BY_SCREEN(15);
    self.leftLabel.textColor = YSColor(0x50, 0x50, 0x50);
    self.rightLabel.font = FONT_BY_SCREEN(15);
    self.rightLabel.textColor = YSColor(0x50, 0x50, 0x50);
    self.rightLabel.highlightedTextColor = YSColor(0xb4, 0xb4, 0xb4);
}

- (UIImageView *)leftImageView {
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_leftImageView];
        _leftImageView.hidden = YES;
    }
    
    return _leftImageView;
}

- (void)setLeftImage:(UIImage *)image {
    if (image) {
        self.leftImageView.hidden = NO;
        self.leftImageView.image = image;
        [self.leftImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.contentView).offset(15);
            make.size.mas_equalTo(image.size);
        }];
        [self.leftLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.leftImageView.mas_right).offset(5);
            make.centerY.equalTo(self.contentView);
        }];
    }
    else {
        self.leftImageView.hidden = YES;
        [self.leftLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(15);
            make.centerY.equalTo(self.contentView);
        }];
    }
}

- (void)setCellByModel:(MailNormalCellModel *)model {
    self.leftLabel.text = model.leftText;
    self.rightLabel.text = model.rightText;
    [self setLeftImage:model.image];
    if (model.rightArrow) {
        self.accessoryView = [[self class] rightArrowView];
    }
    else {
        self.accessoryView = nil;
    }
    
}

+ (UIView *)rightArrowView {
    UIImage *image = [UIImage imageNamed:@"rightArrow"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    return imageView;
}

+ (CGFloat)heightNeededByModel:(MailNormalCellModel *)model andWidth:(CGFloat)width {
//    NSString *leftText = model.leftText;
    NSString *rightText = model.rightText;
//    UIImage *leftImage = model.image;
    BOOL hasRightArrow = model.rightArrow;
    
    NSDictionary *attrDict = @{NSFontAttributeName:FONT_BY_SCREEN(15)};
    // 左文本最高
//    CGFloat maxWidth = SCREEN_WIDTH - 15 - 10 - 40 - 5; // 40 为右文本最小宽度值, 5为左右文本间隙
//    if (leftImage) { //扣除图片宽度及间隙
//        maxWidth -= (leftImage.size.width + 5);
//    }
//    if (hasRightArrow) {
//        maxWidth -= 12;
//    }
//    CGFloat leftHeight = [leftText boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrDict context:nil].size.height;
    CGFloat leftHeight = FONT_BY_SCREEN(15).lineHeight;
    // 右文本最高
    CGFloat maxWidth = SCREEN_WIDTH;
    if (hasRightArrow) {
        maxWidth -= 22;
    }
    maxWidth *= 0.6;
    CGFloat rightHeight = [rightText boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrDict context:nil].size.height;
    
    if (leftHeight < rightHeight) {
        leftHeight = rightHeight;
    }
    leftHeight += 24;
    if (leftHeight < 50) {
        leftHeight = 50;
    }
    
    return leftHeight;
}

@end
