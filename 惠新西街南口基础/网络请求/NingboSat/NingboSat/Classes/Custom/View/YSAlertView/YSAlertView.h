//
//  YSAlertView.h
//  eTax
//
//  Created by ysyc_liu on 16/8/11.
//  Copyright © 2016年 ysyc. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, YSAlertViewStyle) {
    YSAlertViewStyleDefault = 0,
    
};

typedef void (^YSAlertClickButtonBlock)(NSInteger buttonIndex);

@interface YSAlertView : UIWindow

+ (instancetype)alertWithTitle:(nullable NSString *)title message:(nullable NSString *)message buttonTitles:(nullable NSString *)buttonTitles, ... NS_REQUIRES_NIL_TERMINATION;
+ (instancetype) alertWithMessage:(NSString*)message sureButtonTitle:(nullable NSString *)buttonTitle;
+ (instancetype)alertWithImage:(UIImage *)image message:(nullable NSString *)message buttonTitles:(nullable NSString *)buttonTitles, ... NS_REQUIRES_NIL_TERMINATION;


+ (instancetype)alertWithAttrTitle:(nullable NSAttributedString *)title attrMessage:(nullable NSAttributedString *)message buttonTitles:(nullable NSString *)buttonTitles, ... NS_REQUIRES_NIL_TERMINATION;

@property(nonatomic,copy) NSString *title;
@property(nonatomic,copy) UIImage *image;

@property(nonatomic,copy) NSAttributedString *attrTitle;

@property(nullable,nonatomic,copy) NSString *message;

@property(nullable,nonatomic,copy) NSAttributedString *attrMessage;

@property (nonatomic, strong) NSArray * buttonTitles;

@property(nonatomic,assign) YSAlertViewStyle alertViewStyle;
// 按键是否为垂直排列.默认为否.
@property(nonatomic,assign) BOOL vertical;

- (void)show;

- (void)dismiss;

- (void)alertButtonClick:(YSAlertClickButtonBlock)clickBlock;

@end

NS_ASSUME_NONNULL_END
