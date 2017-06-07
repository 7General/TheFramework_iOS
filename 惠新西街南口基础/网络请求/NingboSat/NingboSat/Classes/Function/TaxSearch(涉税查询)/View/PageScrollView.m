//
//  PageScrollView.m
//  NingboSat
//
//  Created by ysyc_liu on 16/9/20.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "PageScrollView.h"
#import "Masonry.h"
#import "Config.h"
#import "ViewPageControl.h"

@interface PageScrollView()<UIScrollViewDelegate>

@property (nonatomic, strong)UIScrollView *bgScrollView;
@property (nonatomic, strong)ViewPageControl *pageControl;
@property (nonatomic, weak)UIView *previousPageView;

@end

@implementation PageScrollView

@synthesize sectionViewItems = _sectionViewItems;

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
        [self initData];
        
        self.backgroundColor = YSColor(0xf5, 0xf5, 0xf5);
    }
    
    return self;
}

- (void)initData {
    
}

- (void)initView {
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    [self addSubview:scrollView];
    scrollView.backgroundColor = YSColor(0xf5, 0xf5, 0xf5);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    self.bgScrollView = scrollView;
    
    ViewPageControl *pageControl = [[ViewPageControl alloc] init];
    [self addSubview:pageControl];
    pageControl.numberOfPages = 0;
    pageControl.currentPage = 0;
    pageControl.pageIndicatorTintColor = YSColor(255, 255, 255);
    pageControl.currentPageIndicatorTintColor = YSColor(0x4b, 0xc4, 0xfb);
    [pageControl addTarget:self action:@selector(pageTurn:) forControlEvents:UIControlEventValueChanged];
    [pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.centerX.equalTo(self);
    }];
    pageControl.hidden = self.hideControl;
    self.pageControl = pageControl;
}

- (void)addView:(UIView *)view {
    [self.bgScrollView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgScrollView);
        make.height.equalTo(self.bgScrollView);
        make.width.equalTo(self.bgScrollView);
        if (self.previousPageView == nil) {
            make.left.equalTo(self.bgScrollView);
        }
        else {
            make.left.mas_equalTo(self.previousPageView.mas_right);
        }
    }];
    self.pageControl.numberOfPages += 1;
    [self.pageControl updateCurrentPageDisplay];
    self.previousPageView = view;
    
    [self.sectionViewItems addObject:view];
}

- (void)pageTurn:(ViewPageControl *)sender {
    [self turnToPage:sender.currentPage];
    
    if ([self.pageDelegate respondsToSelector:@selector(pageTurnTo:)]) {
        [self.pageDelegate pageTurnTo:sender.currentPage];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.pageControl.superview bringSubviewToFront:self.pageControl];
    CGSize contentSize = CGSizeMake(CGRectGetWidth(self.bgScrollView.bounds) * (self.bgScrollView.subviews.count - 1), CGRectGetHeight(self.bgScrollView.bounds));
    self.bgScrollView.contentSize = contentSize;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat width = CGRectGetWidth(scrollView.bounds);
    CGFloat offset = scrollView.contentOffset.x;
    NSInteger pageNum = (offset + width / 2) / width;
    if (pageNum < 0) {
        pageNum = 0;
    }
    if (pageNum >= self.pageControl.numberOfPages) {
        pageNum = self.pageControl.numberOfPages - 1;
    }
    
    [self setCurrentPage:pageNum];
}

#pragma mark - set and get
- (NSInteger)currentPage {
    return self.pageControl.currentPage;
}

- (void)setCurrentPage:(NSInteger)currentPage {
    self.pageControl.currentPage = currentPage;
    [self turnToPage:currentPage];
    if ([self.pageDelegate respondsToSelector:@selector(pageTurnTo:)]) {
        [self.pageDelegate pageTurnTo:currentPage];
    }
}

- (void)setHideControl:(BOOL)hideControl {
    _hideControl = hideControl;
    if (self.pageControl) {
        self.pageControl.hidden = hideControl;
    }
}

- (NSMutableArray *)sectionViewItems {
    if (!_sectionViewItems) {
        _sectionViewItems = [NSMutableArray array];
    }
    return _sectionViewItems;
}

#pragma mark - 

- (void)turnToPage:(NSInteger)page {
    CGPoint offset = CGPointMake(CGRectGetWidth(self.bgScrollView.bounds) * page, 0);
    [self.bgScrollView setContentOffset:offset animated:YES];
}

- (void)previousPage {
    if (self.pageControl.currentPage > 0) {
        [self setCurrentPage:self.pageControl.currentPage - 1];
    }
}
- (void)nextPage {
    if (self.pageControl.currentPage < self.pageControl.numberOfPages - 1) {
        [self setCurrentPage:self.pageControl.currentPage + 1];
    }
}

- (void)setPage:(NSInteger)pageNumber {
    if (pageNumber < self.pageControl.numberOfPages - 1 && pageNumber >= 0) {
        [self setCurrentPage:pageNumber];
    }
    else {
        [self setCurrentPage:0];
    }
}
@end
