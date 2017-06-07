//
//  PageScrollView.h
//  NingboSat
//
//  Created by ysyc_liu on 16/9/20.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PageScrollViewDelegate <NSObject>

- (void)pageTurnTo:(NSInteger)pageNumber;

@end

@interface PageScrollView : UIView

- (void)initView;
- (void)addView:(UIView *)view;
- (void)previousPage;
- (void)nextPage;
- (void)setPage:(NSInteger)pageNumber;

@property (nonatomic, assign)BOOL hideControl;
@property (nonatomic, readonly)NSInteger currentPage;
@property (nonatomic, weak)id<PageScrollViewDelegate> pageDelegate;
@property (nonatomic, readonly)NSMutableArray *sectionViewItems;

@end
