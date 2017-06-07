//
//  DropDownCell.m
//  ReadAddress
//
//  Created by admin on 17/5/8.
//  Copyright © 2017年 admin. All rights reserved.
//

#define DDMColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#import "DropDownCell.h"




@interface DropDownCell()

@property (nonatomic, weak) UILabel *titleLabel;

@property (nonatomic, weak) UIButton *currentButton;

@end

@implementation DropDownCell
+(instancetype)cellWithTableView:(UITableView *)tableview {
     static NSString * ID = @"ID";
    DropDownCell * cell = [tableview dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[DropDownCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}
-(void)setStateBlock:(stateSelectClik)stateBlock {
    _stateBlock = [stateBlock copy];
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIButton * currentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        currentButton.frame = CGRectMake(0, 0, DDMWIDTH - 40, 45);
        //self.contentView.bounds;
        [currentButton addTarget:self action:@selector(cellClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:currentButton];
        self.currentButton = currentButton;
        
        UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 100, 45)];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.textColor = DDMColor(0, 0, 0);
        titleLabel.font = [UIFont systemFontOfSize:15];
        titleLabel.highlightedTextColor = [UIColor redColor];
        [self.currentButton addSubview:titleLabel];
        self.titleLabel = titleLabel;
        
        CGRect SRect = CGRectMake(DDMWIDTH - 40 - 40 - 20, 0, 40, 45);
        UIImage * SImage = [UIImage imageNamed:@"cell_select_normal"];
        UIButton * stateButton = [UIButton button:SRect TitleColor:nil TitleFont:nil imge:SImage forTitle:nil];
        [stateButton setOrderTags:@"no"];
        [stateButton addTarget:self action:@selector(stateClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.currentButton addSubview:stateButton];
        self.stateButton = stateButton;
    }
    return self;
}

-(void)setCellTitles:(NSString *)titles {
    self.titleLabel.text = titles;
}
-(void)setCellState:(NSString *)states {
    if ([states isEqualToString:@"Q"]) {
        [self.stateButton setImage:[UIImage imageNamed:@"cell_select_normal"] forState:UIControlStateNormal];
        [self.stateButton setOrderTags:@"no"];
    }else {
        [self.stateButton setImage:[UIImage imageNamed:@"cell_select_click_normal"] forState:UIControlStateNormal];
        [self.stateButton setOrderTags:@"yes"];
    }
}

-(void)stateClick:(UIButton *)sender {
    NSLog(@"----");
    if (self.stateBlock) {
        self.stateBlock(sender);
    }
}
-(void)cellClick:(UIButton *)sender {
    for (UIView * view in sender.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            if (self.stateBlock) {
                self.stateBlock((UIButton *)view);
            }
        }
    }
}

@end
