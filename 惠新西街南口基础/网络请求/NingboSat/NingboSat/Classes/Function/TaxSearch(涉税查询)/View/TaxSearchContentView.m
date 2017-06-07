//
//  TaxSearchContentView.m
//  NingboSat
//
//  Created by ysyc_liu on 16/9/21.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "TaxSearchContentView.h"
#import "YSTableViewCell.h"
#import "TextFieldCustom.h"


@interface TaxSearchContentView()

@end

@implementation TaxSearchContentView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    
    return self;
}

- (void)initView {
    
}

- (void)loadData:(id)viewData {
    self.viewData = viewData;
    [self.tableView reloadData];
    if (IS_LOGIN) {
        self.unReachableView.hidden = YES;
    }
    else {
        self.unReachableView.hidden = NO;
    }
}

- (void)reShowView {
    [self loadData:self.viewData];
}

#pragma mark - set and get

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *titleLabel = [[UILabel alloc] init];
        [self addSubview:titleLabel];
        titleLabel.font = FONT_BOLD_BY_SCREEN(15);
        titleLabel.textColor = YSColor(0x50, 0x50, 0x50);
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.left.equalTo(self).offset(15+5+3);
            make.right.equalTo(self);
            make.height.mas_equalTo(50);
        }];
        
        UIView *leftLine = [[UIView alloc] init];
        [self addSubview:leftLine];
        leftLine.backgroundColor = YSColor(0x4b, 0xc4, 0xfb);
        [leftLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(titleLabel.mas_centerY);
            make.right.mas_equalTo(titleLabel.mas_left).offset(-5);
            make.width.mas_equalTo(3);
            make.height.mas_equalTo(13);
        }];
        
        UIView *line = [[UIView alloc] init];
        [self addSubview:line];
        line.backgroundColor = YSColor(0xe6, 0xe6, 0xe6);
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.equalTo(self);
            make.height.mas_equalTo(0.5);
            make.top.mas_equalTo(titleLabel.mas_bottom).offset(-0.5);
        }];

        _titleLabel = titleLabel;
    }
    
    return _titleLabel;
}

- (UITableView *)tableView {
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [self addSubview:tableView];
        tableView.backgroundColor = YSColor(0xf5, 0xf5, 0xf5);
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.tableFooterView = [[UIView alloc] init];
        tableView.separatorColor = YSColor(0xe6, 0xe6, 0xe6);
        if (SYSTEM_VERSION >= 8.0) {
            tableView.layoutMargins = UIEdgeInsetsZero;
        }
        tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 0);
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.titleLabel.mas_bottom);
            make.left.and.bottom.and.right.equalTo(self);
        }];
        _tableView = tableView;
    }
    return _tableView;
}

- (UIView *)unReachableView {
    if (!_unReachableView) {
        UIView *view = [[UIView alloc] init];
        [self addSubview:view];
        view.backgroundColor = [UIColor whiteColor];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.titleLabel.mas_bottom);
            make.left.and.bottom.and.right.equalTo(self);
        }];
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"unReachable"]];
        [view addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(view).offset(29);
            make.centerX.equalTo(view);
        }];
        
        UILabel *label = [[UILabel alloc] init];
        [view addSubview:label];
        label.numberOfLines = 0;
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(imageView.mas_bottom);
            make.centerX.equalTo(view);
        }];
        NSMutableAttributedString *labelText = [[NSMutableAttributedString alloc] init];
        {
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.alignment = NSTextAlignmentCenter;
            NSAttributedString *titleStr = [[NSAttributedString alloc] initWithString:@"抱歉\n" attributes:@{NSFontAttributeName:FONT_BY_SCREEN(15), NSForegroundColorAttributeName:YSColor(0x50, 0x50, 0x50), NSParagraphStyleAttributeName:paragraphStyle}];
            [labelText appendAttributedString:titleStr];
        }
        {
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.alignment = NSTextAlignmentCenter;
            NSAttributedString *contentStr = [[NSAttributedString alloc] initWithString:@"您需要登录才能使用此功能" attributes:@{NSFontAttributeName:FONT_BY_SCREEN(13), NSForegroundColorAttributeName:YSColor(0x50, 0x50, 0x50), NSParagraphStyleAttributeName:paragraphStyle}];
            [labelText appendAttributedString:contentStr];
        }
        label.attributedText = labelText;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [view addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(view);
        }];
        self.unReachableBtn = button;
        
        _unReachableView = view;
    }
    
    return _unReachableView;
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    YSTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[YSTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        cell.textLabel.font = FONT_BY_SCREEN(15);
        cell.textLabel.textColor = YSColor(0x50, 0x50, 0x50);
        cell.textLabel.highlightedTextColor = YSColor(0x88, 0x88, 0x88);
        cell.detailTextLabel.font = FONT_BY_SCREEN(15);
        cell.detailTextLabel.textColor = YSColor(0x50, 0x50, 0x50);
        cell.detailTextLabel.highlightedTextColor = YSColor(0x88, 0x88, 0x88);
        cell.detailTextLabel.numberOfLines = 0;
        
        UIView *line = [[UIView alloc] init];
        [cell addSubview:line];
        line.backgroundColor = YSColor(0xe6, 0xe6, 0xe6);
        line.tag = 1111;
    }
    
    if (indexPath.row != [self tableView:tableView numberOfRowsInSection:indexPath.section] - 1) {
        UIView *line = [cell viewWithTag:1111];
        [line mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0.5);
            make.left.equalTo(cell).offset(15);
            make.right.equalTo(cell);
            make.bottom.equalTo(cell);
        }];
    }
    else {
        UIView *line = [cell viewWithTag:1111];
        [line mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0.5);
            make.left.equalTo(cell).offset(0);
            make.right.equalTo(cell);
            make.bottom.equalTo(cell);
        }];
    }
    
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

#pragma mark -
+ (UITextField *)textFieldWithPlaceholder:(NSString *)placeholder {
    TextFieldCustom * textField = [[TextFieldCustom alloc] init];
    textField.textColor = YSColor(0x50, 0x50, 0x50);
    textField.font = FONT_BY_SCREEN(15);
    textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholder attributes:@{NSFontAttributeName:FONT_BY_SCREEN(15), NSForegroundColorAttributeName:YSColor(0xb4, 0xb4, 0xb4)}];
    textField.textAlignment = NSTextAlignmentRight;
    textField.tintColor = YSColor(0x50, 0x50, 0x50);
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rightArrow"]];
    imageView.bounds = CGRectMake(0, 0, imageView.image.size.width + 5, imageView.image.size.height);
    imageView.contentMode = UIViewContentModeRight;
    textField.rightView = imageView;
    textField.rightViewMode = UITextFieldViewModeAlways;
    
    return textField;
}

@end
