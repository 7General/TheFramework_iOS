//
//  HomeSegment.h
//  NingboSat
//
//  Created by ysyc_liu on 16/9/9.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HomeSegment;
@protocol HomeSegmentDelegate <NSObject>

- (void)segment:(HomeSegment *)segment selected:(NSInteger)index;

@end

@interface HomeSegment : UIView

+ (instancetype)segmentWithItems:(NSArray<NSString *> *)items;

@property (nonatomic, weak)id<HomeSegmentDelegate>delegate;

@property (nonatomic, weak)UIScrollView * contentView;

- (void)setSelectIndex:(NSInteger)selectIndex;

@end
