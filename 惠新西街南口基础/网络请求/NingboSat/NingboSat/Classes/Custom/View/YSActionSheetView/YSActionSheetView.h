//
//  YSActionSheetView.h
//  NingboSat
//
//  Created by ysyc_liu on 16/9/18.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YSActionSheetView : UIWindow

@property (nonatomic, strong)UIView *contentView;
@property (nonatomic, assign)BOOL showConfirmBar;

- (void)show;
- (void)dismiss;

- (void)initView;
- (void)cancelBtnClick;
- (void)confirmBtnClick;
@end
