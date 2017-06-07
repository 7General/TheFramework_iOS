//
//  HAlertView.h
//  AlertView
//
//  Created by 王会洲 on 16/9/19.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import <UIKit/UIKit.h>

#if NS_BLOCKS_AVAILABLE
typedef void(^HZBasicActionBlock)();
#endif


@protocol HAlertViewDelegate;

@interface HAlertView : UIView

@property (nonatomic, strong) UIView * contentView;
// 取消按钮
@property (nonatomic, strong) UIButton * cancelButton;
// 其他按钮
@property (nonatomic, strong) UIButton * otherButton;



/*!
 在点击确认后,是否需要dismiss, 默认YES
 */
@property (nonatomic, assign) BOOL shouldDismissAfterConfirm;


#if NS_BLOCKS_AVAILABLE
@property (nonatomic, copy) HZBasicActionBlock  cancelBlock;
@property (nonatomic, copy) HZBasicActionBlock  confirmBlock;
#endif

/*!
 @abstract      点击取消按钮的回调
 @discussion    如果你不想用代理的方式来进行回调，可使用该方法
 @param         block  点击取消后执行的程序块
 */
- (void)setCancelBlock:(HZBasicActionBlock)block;

/*!
 @abstract      点击确定按钮的回调
 @discussion    如果你不想用代理的方式来进行回调，可使用该方法
 @param         block  点击确定后执行的程序块
 */
- (void)setConfirmBlock:(HZBasicActionBlock)block;



/**代理相关**/
@property (nonatomic, assign) id<HAlertViewDelegate>  delegate;


/******************************************************************************
 函数名称 : 模仿系统AlertView界面-message信息为富文本信息-信息格式使用宏定义内容
 函数描述 : 系统alertView
 输入参数 : (NSString *)title                                       标题
 输入参数 : (NSString *)message                             文本信息
 输入参数 : (id<HZAlertViewDelegate>)delegate    代理
 输入参数 : (NSString *)cancelButtonTitle                取消文本
 输入参数 : (NSString *)otherButtonTitle                  其他文本
 输出参数 : N/A
 返回参数 :
 备注信息 :
 ******************************************************************************/
-(id)initWithBasicTitle:(NSString *)title
                message:(NSString *)message
                iconStr:(NSString *)iconName
               delegate:(id<HAlertViewDelegate>)delegate
      cancelButtonTitle:(NSString *)cancelButtonTitle
      otherButtonTitles:(NSString *)otherButtonTitle;



-(id)initWithTitle:(NSString *)title
           message:(NSString *)message
          delegate:(id<HAlertViewDelegate>)delegate
 cancelButtonTitle:(NSString *)cancelButtonTitle
 otherButtonTitles:(NSString *)otherButtonTitle;

/**
 *  弹出alert
 */
- (void)show;

@end


@protocol HAlertViewDelegate <NSObject>

@optional
- (void)alertView:(HAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex; // before animation and hiding view
- (void)alertView:(HAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex;

- (void)didRotationToInterfaceOrientation:(BOOL)Landscape view:(UIView*)view alertView:(HAlertView *)aletView;


@end
