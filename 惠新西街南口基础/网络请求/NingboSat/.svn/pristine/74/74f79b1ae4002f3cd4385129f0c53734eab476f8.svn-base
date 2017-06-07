//
//  HomeSegment.m
//  NingboSat
//
//  Created by ysyc_liu on 16/9/9.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "HomeSegment.h"
#import "Masonry.h"
#import "config.h"

static NSInteger sg_baseBtnTag = 10000;

@interface HomeSegment()<UIScrollViewDelegate>

@property (nonatomic, strong)NSArray<NSString *> *items;
@property (nonatomic, assign)NSInteger selectIndex;

@end

@implementation HomeSegment


- (instancetype)initWithItems:(NSArray<NSString *> *)items {
    self = [super init];
    if (self) {
        self.items = items;
        [self initView];
        self.selectIndex = 0;
    }
    return self;
}

+ (instancetype)segmentWithItems:(NSArray *)items {
    return [[self alloc] initWithItems:items];
}

- (void)initView {
    // 区域按键.
    UIView * leftView = nil;
    for (NSInteger i = 0; i < self.items.count; i++) {
        NSString * title = self.items[i];
        
        UIButton * button = [self buttonWithTitle:title];
        [self addSubview:button];
        button.tag = i + sg_baseBtnTag;
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.and.bottom.equalTo(self);
            if (leftView) {
                make.left.mas_equalTo(leftView.mas_right);
            }
            else {
                make.left.equalTo(self);
            }
            make.width.equalTo(self).dividedBy(self.items.count);
        }];
        
        [button addTarget:self action:@selector(segmentClick:) forControlEvents:UIControlEventTouchUpInside];
        
        leftView = button;
    }
    
    // 区域分割线.
    for (NSInteger i = 1; i < self.items.count; i++) {
        UIView * line = [[UIView alloc] init];
        [self addSubview:line];
        line.backgroundColor = YSColor(0xe6, 0xe6, 0xe6);
        
        UIView * view = [self viewWithTag:(i + sg_baseBtnTag)];
        NSAssert([view isKindOfClass:[UIButton class]], @"HomeSegment split line masonry error.");
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(11);
            make.height.mas_equalTo(19);
            make.width.mas_equalTo(0.5);
            make.left.equalTo(view).offset(-0.5);
        }];
    }
    
    {   // 尾分割线.
        UIView * line = [[UIView alloc] init];
        [self addSubview:line];
        line.backgroundColor = YSColor(0xe6, 0xe6, 0xe6);
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.equalTo(self);
            make.height.mas_equalTo(0.5);
            make.bottom.equalTo(self);
        }];
    }
    
    {   // 选中线.
        UIView * line = [[UIView alloc] init];
        [self addSubview:line];
        line.backgroundColor = YSColor(0x15, 0x89, 0xFF);
        line.tag = 101;
    }
}

- (UIButton *)buttonWithTitle:(NSString *)title {
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    NSDictionary *attrDict = @{NSFontAttributeName:FONT_BY_SCREEN(15), NSForegroundColorAttributeName:YSColor(0x50, 0x50, 0x50)};
    [button setAttributedTitle:[[NSAttributedString alloc] initWithString:title attributes:attrDict] forState:UIControlStateNormal];
    attrDict = @{NSFontAttributeName:FONT_BY_SCREEN(17), NSForegroundColorAttributeName:YSColor(0x15, 0x89, 0xFF)};
    [button setAttributedTitle:[[NSAttributedString alloc] initWithString:title attributes:attrDict] forState:UIControlStateSelected];
    return button;
}

#pragma mark - set and get

- (void)setSelectIndex:(NSInteger)selectIndex {
    UIButton * oldBtn = [self viewWithTag:(_selectIndex + sg_baseBtnTag)];
    [self setButton:oldBtn selected:NO];
    
    UIButton * newBtn = [self viewWithTag:(selectIndex + sg_baseBtnTag)];
    [self setButton:newBtn selected:YES];
    
    _selectIndex = selectIndex;
    
    if ([self.delegate respondsToSelector:@selector(segment:selected:)]) {
        [self.delegate segment:self selected:selectIndex];
    }
}

- (void)setContentView:(UIScrollView *)contentView {
    if (_contentView) {
        _contentView.delegate = nil;
    }
    _contentView = contentView;
    _contentView.delegate = self;
}

- (void)setButton:(UIButton *)btn selected:(BOOL)selected {
    btn.selected = selected;
    if (!selected) {
        return;
    }
    
    UIView * view = [self viewWithTag:101];
    if (view) {
        [self layoutIfNeeded];
        [view mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.equalTo(btn);
            make.height.mas_equalTo(1.5);
            make.bottom.equalTo(self);
        }];
        [UIView animateWithDuration:0.25 animations:^{
            [self layoutIfNeeded];
        }];
    }
}

#pragma mark - button click action
- (void)segmentClick:(UIButton *)sender {
    self.selectIndex = sender.tag - sg_baseBtnTag;
    
    if (self.contentView) {
        [self.contentView setContentOffset:CGPointMake(CGRectGetWidth(self.contentView.bounds) * self.selectIndex, 0) animated:YES];
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat width = CGRectGetWidth(scrollView.bounds);
    CGFloat offset = scrollView.contentOffset.x;
    NSInteger pageNum = (offset + width / 2) / width;
    if (pageNum < 0) {
        pageNum = 0;
    }
    if (pageNum >= self.items.count) {
        pageNum = self.items.count - 1;
    }
    
    self.selectIndex = pageNum;
    [scrollView setContentOffset:CGPointMake(width * pageNum, 0) animated:YES];
}



@end
