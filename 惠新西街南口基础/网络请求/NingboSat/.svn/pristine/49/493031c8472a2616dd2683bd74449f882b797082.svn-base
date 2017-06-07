//
//  MailLocateCell.m
//  NingboSat
//
//  Created by ysyc_liu on 16/9/14.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "MailLocateCell.h"
#import "Config.h"
#import "Masonry.h"

@interface MailLocateCell()

@property (nonatomic, strong)UILabel *nameLabel;

@property (nonatomic, strong)UILabel *phoneLabel;

@property (nonatomic, strong)UILabel *locateLabel;

@property (nonatomic, strong)UIImageView *locateImageIcon;

@property (nonatomic, weak)id dataModel;

@end

@implementation MailLocateCell

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    return [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
}

- (void)initView {
    
    {
        UILabel *label = [[UILabel alloc] init];
        [self.contentView addSubview:label];
        label.font = FONT_BOLD_BY_SCREEN(15);
        label.textColor = YSColor(0x50, 0x50, 0x50);
        NSAttributedString *attr = [[NSAttributedString alloc] initWithString:@"收票人：名字名字" attributes:@{NSFontAttributeName:FONT_BOLD_BY_SCREEN(15)}];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(36);
            make.top.equalTo(self.contentView).offset(18);
            make.width.mas_lessThanOrEqualTo(attr.size.width);
        }];
        self.nameLabel = label;
    }
    
    {
        UILabel *label = [[UILabel alloc] init];
        [self.contentView addSubview:label];
        label.font = self.textLabel.font;
        label.textColor = self.textLabel.textColor;
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.nameLabel);
            make.right.equalTo(self.contentView).offset(-10);
            make.width.equalTo(self.contentView).dividedBy(2.5);
        }];
        
        self.phoneLabel = label;
    }
    
    {
        UILabel *label = [[UILabel alloc] init];
        [self.contentView addSubview:label];
        label.font = FONT_BY_SCREEN(15);
        label.textColor = YSColor(0x50, 0x50, 0x50);
        label.numberOfLines = 0;
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(4);
            make.left.mas_equalTo(self.nameLabel);
            make.right.mas_equalTo(self.contentView).offset(-15);
        }];
        self.locateLabel = label;
    }
    
    {
        UIImageView *imageView = [[UIImageView alloc] init];
        [self.contentView addSubview:imageView];
        imageView.image = [UIImage imageNamed:@"locationIcon"];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(16, 16));
            make.right.mas_equalTo(self.nameLabel.mas_left).offset(-5);
            make.centerY.mas_equalTo(self.locateLabel.mas_top).offset(FONT_BY_SCREEN(15).lineHeight / 2);
        }];
        self.locateImageIcon = imageView;
    }
}

- (void)setCellByModel:(id)model isEdit:(BOOL)isEdit {
    if (![model isKindOfClass:[MailAddressModel class]]) {
        return;
    }
    self.dataModel = model;
    MailAddressModel * addressModel = model;
    self.nameLabel.text = [NSString stringWithFormat:@"收票人：%@", addressModel.name];
    self.phoneLabel.text = addressModel.phone;
    self.locateLabel.text = [NSString stringWithFormat:@"收货地址：%@", [addressModel shippingAddress]];
    
    UIView *rightView = [self viewWithTag:1000];
    if (rightView) {
        [rightView removeFromSuperview];
    }
    if (isEdit) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 1000;
        UIImage *image = [UIImage imageNamed:@"mailAddressEdit"];
        [button setImage:image forState:UIControlStateNormal];
//        CGSize size = [button sizeThatFits:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        button.bounds = CGRectMake(0, 0, 44, 80);
        [self addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.equalTo(self);
            make.width.mas_equalTo(44);
        }];
        {
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0.5, 37)];
            [button addSubview:line];
            [line mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(button);
                make.width.mas_equalTo(0.5);
                make.top.equalTo(button).offset(24);
                make.bottom.equalTo(button).offset(-24);
            }];
            line.backgroundColor = YSColor(0xe6, 0xe6, 0xe6);
        }
        
//        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [button addTarget:self action:@selector(editBtnClick) forControlEvents:UIControlEventTouchUpInside];
//        self.accessoryView = button;
        // 为了扩大按键的可点击范围, 把button移出accessoryView.
        UIView *placeholderView  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 29, 0.1)];
        self.accessoryView = placeholderView;
    }
    else {
        self.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rightArrow"]];
    }
    
}

+ (CGFloat)heightNeededByModel:(id)model andWidth:(CGFloat)width isEdit:(BOOL)isEdit {
    if (![model isKindOfClass:[MailAddressModel class]]) {
        return 0;
    }
    MailAddressModel * addressModel = model;
    CGFloat result = 18 * 2;
    result += FONT_BOLD_BY_SCREEN(15).lineHeight;
    result += 4;
    {
        NSAttributedString * attr = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"收货地址：%@", [addressModel shippingAddress]] attributes:@{NSFontAttributeName:FONT_BY_SCREEN(15)}];
        CGFloat maxWidth = width - 36 - 15; // 36:左边距 15:文字离右图标距离
        if (isEdit) {
            maxWidth -= 44; // 有图标占据宽度
        }
        else {
            static UIImage *arrowImage = nil;
            if (!arrowImage) {
                arrowImage = [UIImage imageNamed:@"rightArrow"];
            }
            maxWidth -= 15 + arrowImage.size.width;
        }
        CGRect rect = [attr boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil];
        result += CGRectGetHeight(rect);
    }
    if (result < 50) {
        result = 50;
    }
    
    return result;
}

- (void)editBtnClick {
    if ([self.delegate respondsToSelector:@selector(editButtonClick:)]) {
        [self.delegate editButtonClick:self.dataModel];
    }
}

@end
