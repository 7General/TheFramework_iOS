//
//  YSActionSheetView.m
//  NingboSat
//
//  Created by ysyc_liu on 16/9/18.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "YSActionSheetView.h"
#import "Masonry.h"

/// 屏幕Bounds.
#ifndef SCREEN_BOUNDS
#define SCREEN_BOUNDS [UIScreen mainScreen].bounds
#endif
/// 屏幕宽度.
#ifndef SCREEN_WIDTH
#define SCREEN_WIDTH  CGRectGetWidth([UIScreen mainScreen].bounds)
#endif
/// 屏幕高度.
#ifndef SCREEN_HEIGHT
#define SCREEN_HEIGHT CGRectGetHeight([UIScreen mainScreen].bounds)
#endif

// 屏幕高度系数
#ifndef kSCALEHEIGHT
#define kSCALEHEIGHT (SCREEN_HEIGHT / 667)
#endif
// 屏幕宽度系数
#ifndef kSCALEWIDTH
#define kSCALEWIDTH (SCREEN_WIDTH / 375)
#endif
// 设置颜色
#ifndef YSColor
#define YSColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#endif
// 设置字体
#ifndef SCREENSTAE
#define SCREENSTAE 2
#endif
#ifndef FONTWITHSIZE_LIGHT_ADAPTER
#define FONTWITHSIZE_LIGHT_ADAPTER(obj) [UIFont fontWithName:@"STHeitiSC-Light" size:((kSCALEWIDTH > 1) ? (obj + SCREENSTAE) : (obj))]
#endif

@interface YSActionSheetManager : NSObject

+ (instancetype)defaultManager;

- (void)addActionSheetView:(YSActionSheetView *)view;
- (void)removeActionSheetView:(YSActionSheetView *)view;

@property (nonatomic, strong) NSMutableArray<YSActionSheetView *> * stackArray;
@property (nonatomic, strong) YSActionSheetView *currentView;

@end

@implementation YSActionSheetManager

+ (instancetype)defaultManager {
    static YSActionSheetManager *manager = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
    
}

- (void)addActionSheetView:(YSActionSheetView *)view {
    if (!view) {
        return;
    }
    if (self.currentView) {
        [self.stackArray addObject:self.currentView];
        [self.currentView dismiss];
    }
    self.currentView = view;
}

- (void)removeActionSheetView:(YSActionSheetView *)view {
    if (!view) {
        return;
    }
    self.currentView = nil;
    if (self.stackArray.count && ![self.stackArray containsObject:view]) {
        [self.stackArray.lastObject show];
        [self.stackArray removeObject:self.currentView];
    }
}

- (NSMutableArray<YSActionSheetView *> *)stackArray {
    if (!_stackArray) {
        _stackArray = [NSMutableArray array];
    }
    return _stackArray;
}

@end

@interface YSActionSheetView()<UIGestureRecognizerDelegate>

// 顶部取消/确认.
@property (nonatomic, strong)UIView *confirmView;

@end

@implementation YSActionSheetView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT + 44, CGRectGetWidth(frame), CGRectGetHeight(frame))];
            [self addSubview:view];
            view.backgroundColor = [UIColor whiteColor];
            self.contentView = view;
        }
        [self initView];
        
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        self.windowLevel = UIWindowLevelStatusBar + 0.1;
        self.alpha = 0;
        
        UITapGestureRecognizer * tapGes = [[UITapGestureRecognizer alloc] init];
        tapGes.delegate = self;
        [self addGestureRecognizer:tapGes];
    }
    
    return self;
}


- (void)initView {
    {
        UIView *view = [[UIView alloc] init];
        [self addSubview:view];
        view.backgroundColor = [UIColor whiteColor];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(44);
            make.bottom.mas_equalTo(self.contentView.mas_top);
            make.left.and.right.equalTo(self);
        }];
        self.confirmView = view;
        
        UIButton *cancel = [UIButton buttonWithType:UIButtonTypeCustom];
        [view addSubview:cancel];
        [cancel setTitle:@"取消" forState:UIControlStateNormal];
        [cancel setTitleColor:YSColor(0x50, 0x50, 0x50) forState:UIControlStateNormal];
        [cancel addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
        CGSize size = [cancel sizeThatFits:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        [cancel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view).offset(0);
            make.centerY.equalTo(view);
            make.width.mas_equalTo(size.width + 18 * 2);
            make.height.equalTo(view);
        }];
        
        UIButton *confirm = [UIButton buttonWithType:UIButtonTypeCustom];
        [view addSubview:confirm];
        [confirm setTitle:@"确认" forState:UIControlStateNormal];
        [confirm setTitleColor:YSColor(0x4b, 0xc4, 0xfb) forState:UIControlStateNormal];
        [confirm addTarget:self action:@selector(confirmBtnClick) forControlEvents:UIControlEventTouchUpInside];
        size = [confirm sizeThatFits:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        [confirm mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(view).offset(0);
            make.centerY.equalTo(view);
            make.width.mas_equalTo(size.width + 18 * 2);
            make.height.equalTo(view);
        }];
        
        self.confirmView.hidden = !self.showConfirmBar;
    }
}

- (void)show {
    self.hidden = NO;
    CGRect frame = self.contentView.bounds;
    frame.origin.y = SCREEN_HEIGHT - CGRectGetHeight(self.contentView.frame);
    
    [self layoutIfNeeded];
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 1;
        self.contentView.frame = frame;
        [self layoutIfNeeded];
    }];
    
    [[YSActionSheetManager defaultManager] addActionSheetView:self];
}
- (void)dismiss {
    CGRect frame = self.contentView.bounds;
    frame.origin.y = SCREEN_HEIGHT + 44;
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 0;
        self.contentView.frame = frame;
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        self.hidden = YES;
        [self resignKeyWindow];
    }];
    
    [[YSActionSheetManager defaultManager] removeActionSheetView:self];
}

#pragma mark - set and get
- (void)setShowConfirmBar:(BOOL)showConfirmBar {
    _showConfirmBar = showConfirmBar;
    if (self.confirmView) {
        self.confirmView.hidden = !showConfirmBar;
    }
}

#pragma mark - button click action
- (void)cancelBtnClick {
    [self dismiss];
}

- (void)confirmBtnClick {
    [self dismiss];
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([touch.view isKindOfClass:[UIWindow class]]) {
        [self dismiss];
    }
    return YES;
}

@end
