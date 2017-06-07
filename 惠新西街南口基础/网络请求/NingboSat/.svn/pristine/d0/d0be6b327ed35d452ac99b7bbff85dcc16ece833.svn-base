//
//  MatrixView.m
//  eTax
//
//  Created by ysyc_liu on 16/4/14.
//  Copyright © 2016年 YSYC. All rights reserved.
//

#import "MatrixView.h"

/// 垂直分割线tag.
NSInteger splitBaseTagV = 10000;
/// 水平分割线tag.
NSInteger splitBaseTagH = 20000;

@interface MatrixView()

@end

@implementation MatrixView

- (instancetype)initWithFrame:(CGRect)frame items:(NSArray *)items cols:(NSInteger)cols maxSize:(CGSize)maxSize {
    return [self initWithFrame:frame items:items cols:cols splitColor:[UIColor colorWithRed:242/255.f green:242/255.f blue:242/255.f alpha:1] maxSize:maxSize];
}

- (instancetype)initWithFrame:(CGRect)frame items:(NSArray *)items cols:(NSInteger)cols splitColor:(UIColor *)splitColor maxSize:(CGSize)maxSize {
    self = [super init];
    if (self) {
        NSInteger itemsCount = items.count;
        NSInteger rows = (itemsCount - 1) / cols + 1;
        CGFloat subWidth = CGRectGetWidth(frame) / cols;
        CGFloat subHeight = CGRectGetHeight(frame);
        for (NSInteger i = 0; i < itemsCount; i++) {
            NSInteger subCol = i % cols;
            NSInteger subRow = i / cols;
            UIView * subView = items[i];
            [self addSubview:subView];
            subView.center = CGPointMake(subCol * subWidth + subWidth * 0.5, subRow * subHeight + subHeight * 0.5);
        }
        // 添加分割线.
        if (!CGColorEqualToColor(splitColor.CGColor, [UIColor clearColor].CGColor)) {
            // 垂直分割线.
            for (NSInteger i = 1; i < cols; i++) {
                UIView * line = [[UIView alloc] init];
                [self addSubview:line];
                line.tag = i + splitBaseTagV;
                line.frame = CGRectMake(i * subWidth - 0.25, 0, 0.5, rows * subHeight);
                line.backgroundColor = splitColor;
            }
            // 水平分割线.
            for (NSInteger i = 1; i < rows + 1; i++) {
                UIView * line = [[UIView alloc] init];
                [self addSubview:line];
                line.tag = i + splitBaseTagH;
                line.frame = CGRectMake(0, i * subHeight - 0.5, CGRectGetWidth(frame), 0.5);
                line.backgroundColor = splitColor;
            }
        }
        
        frame.size.height = rows * subHeight;
        self.contentSize = frame.size;
        if (frame.size.height > maxSize.height || frame.size.width > maxSize.width) {
            frame.size.height = maxSize.height;
            frame.size.width = maxSize.width;
        }
        self.frame = frame;
        
        self.viewItems = items;
        self.cols = cols;
        self.rows = rows;
        self.splitColor = splitColor;
        self.subSize = CGSizeMake(subWidth, subHeight);
        
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.bounces = NO;
    }
    return self;
}

@end
