//
//  TypeActionSheet.m
//  NingboSat
//
//  Created by ysyc_liu on 16/9/18.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "TypeActionSheet.h"
#import "Config.h"
#import "Masonry.h"

@interface TypeActionSheet()

@property (nonatomic, strong)NSArray *items;
@property (nonatomic, copy)TypeActionSheetBlock actionSheetBlock;

@end

@implementation TypeActionSheet

- (instancetype)initWithItems:(NSArray *)items {
    self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    if (self) {
        self.showConfirmBar = NO;
        self.items = items;
        [self loadItemsView];
    }
    
    return self;
}

- (void)loadItemsView {
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.contentView.bounds];
    [self.contentView addSubview:scrollView];
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.contentView.bounds), 50 * self.items.count)];
    [scrollView addSubview:bgView];
    scrollView.contentSize = bgView.bounds.size;
    
    for (NSInteger i = 0; i < self.items.count; i++) {
        UIButton *button = [self buttonWithTitle:self.items[i]];
        [bgView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(bgView).offset(50 * i);
            make.left.equalTo(bgView).offset(-0.5);
            make.right.equalTo(bgView).offset(0.5);
            make.height.mas_equalTo(50.25);
        }];
        button.layer.borderColor = YSColor(0xe6, 0xe6, 0xe6).CGColor;
        button.layer.borderWidth = 0.5;
        button.tag = i;
        [button addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (UIButton *)buttonWithTitle:(NSString *)title {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:YSColor(0x50, 0x50, 0x50) forState:UIControlStateNormal];
    [button setTitleColor:YSColor(0x4b, 0xc4, 0xfb) forState:UIControlStateSelected];
    button.titleLabel.font = FONT_BY_SCREEN(15);
    return button;
}

- (void)itemClick:(UIButton *)sender {
    if (self.actionSheetBlock) {
        self.actionSheetBlock(sender.tag);
    }
    [self dismiss];
}

#pragma mark - set and get
- (void)setActionSheetClickBlock:(TypeActionSheetBlock)block {
    self.actionSheetBlock = block;
}

@end
