//
//  MapRouteStepView.m
//  eTax
//
//  Created by ysyc_liu on 16/5/30.
//  Copyright © 2016年 ysyc. All rights reserved.
//

#import "MapRouteStepView.h"
#import "Masonry.h"
//#import "ConfigUI.h"
#import "Config.h"

CGFloat g_titleHeight = 72;

@interface MapRouteStepView()

@property (nonatomic, strong)UIButton * titleBtn;
@property (nonatomic, strong)UILabel * titleLabel;
@property (nonatomic, strong)UILabel * subTitleLabel;
@property (nonatomic, strong)UIImageView * arrowView;

@property (nonatomic, strong)UITableView * tableView;

@end

@implementation MapRouteStepView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
        self.backgroundColor = [UIColor whiteColor];
        self.layer.masksToBounds = YES;
        self.layer.shadowOffset = CGSizeMake(0, 1);
        self.layer.shadowRadius = 0;
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowOpacity = 0.5;

    }
    return self;
}

- (void)initView {
    UIButton * titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:titleBtn];
    titleBtn.layer.masksToBounds = YES;
    [titleBtn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [titleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.mas_equalTo(g_titleHeight);
    }];
    self.titleBtn = titleBtn;
    
    UILabel * title = [[UILabel alloc] init];
    [titleBtn addSubview:title];
    title.textColor = YSColor(50, 50, 50);
    title.font = FONT_BY_SCREEN(15);
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleBtn).offset(18);
        make.left.equalTo(titleBtn).offset(18);
        make.bottom.mas_equalTo(titleBtn.mas_centerY).offset(-4);
        make.right.equalTo(titleBtn).offset(-18);
    }];
    self.titleLabel = title;

    UILabel * subTitle = [[UILabel alloc] init];
    [titleBtn addSubview:subTitle];
    subTitle.textColor = YSColor(0xb4, 0xb4, 0xb4);
    subTitle.font = FONT_BY_SCREEN(13);
    [subTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleBtn.mas_centerY).offset(4);
        make.left.equalTo(titleBtn).offset(18);
        make.bottom.equalTo(titleBtn).offset(-18);
        make.right.equalTo(titleBtn).offset(-18);
    }];
    self.subTitleLabel = subTitle;
    
    UIImageView * arrowView = [[UIImageView alloc] init];
    [self addSubview:arrowView];
    arrowView.image = [UIImage imageNamed:@"map_route_arrow"];
    [arrowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(4);
        make.size.mas_equalTo(arrowView.image.size);
    }];
    self.arrowView = arrowView;
    
    UIView * arrowBgView = [[UIView alloc] init];
    [self addSubview:arrowBgView];
    arrowBgView.layer.cornerRadius = 6;
    arrowBgView.layer.borderColor = YSColor(0xe6, 0xe6, 0xe6).CGColor;
    arrowBgView.layer.borderWidth = 0.5;
    [arrowBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(-15);
        make.centerX.equalTo(arrowView);
        make.width.mas_equalTo(arrowView.mas_width).offset(40);
        make.height.mas_equalTo(30);
    }];
    
    UIView * line = [[UIView alloc] init];
    [self addSubview:line];
    line.backgroundColor = YSColor(0xe6, 0xe6, 0xe6);
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleBtn.mas_bottom);
        make.left.equalTo(self).offset(10);
        make.height.mas_equalTo(1);
        make.right.equalTo(self).offset(-10);
    }];
    
    UITableView * tableView = [[UITableView alloc] init];
    [self addSubview:tableView];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.tableFooterView = [[UIView alloc] init];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line.mas_bottom);
        make.left.bottom.right.equalTo(self);
    }];
    self.tableView = tableView;
}

#pragma mark - set and get

- (void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
}
- (NSString *)title {
    return self.titleLabel.text;
}

- (void)setSubTitle:(NSString *)subTitle {
    self.subTitleLabel.text = subTitle;
}

- (NSString *)subTitle {
    return self.subTitleLabel.text;
}

- (void)setDataSource:(id<UITableViewDataSource>)dataSource {
    self.tableView.dataSource = dataSource;
}

- (id<UITableViewDataSource>)dataSource {
    return self.tableView.dataSource;
}

- (void)setDelegate:(id<UITableViewDelegate>)delegate {
    self.tableView.delegate = delegate;
}

- (id<UITableViewDelegate>)delegate {
    return self.tableView.delegate;
}

#pragma mark - button click action

- (void)titleBtnClick:(UIButton *)btn {
    btn.userInteractionEnabled = NO;
    btn.selected = !btn.selected;
    CGRect frame;
    CGAffineTransform transform;
    if (btn.selected) {
        frame = CGRectOffset(self.bounds, 0, CGRectGetHeight(self.superview.bounds) - CGRectGetHeight(self.bounds));
        transform = CGAffineTransformMakeRotation(M_PI);
    }
    else {
        frame = CGRectOffset(self.bounds, 0, CGRectGetHeight(self.superview.bounds) - g_titleHeight);
        transform = CGAffineTransformMakeRotation(2 * M_PI);;
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = frame;
        self.arrowView.transform = transform;
    } completion:^(BOOL finished) {
        btn.userInteractionEnabled = YES;
    }];
}

@end
