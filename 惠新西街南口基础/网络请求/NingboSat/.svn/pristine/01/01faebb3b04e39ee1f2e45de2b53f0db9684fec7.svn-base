//
//  PhoneJSContact.h
//  PlanC
//
//  Created by ysyc_liu on 16/7/18.
//  Copyright © 2016年 ysyc_wang. All rights reserved.
//

#import <JavaScriptCore/JavaScriptCore.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, JSEventType) {
    JSEventTypeNone = -1,
    JSEventGetLatestConsultation    = 0,
    JSEventGetHottestConsultation,
    JSEventGetUserInfo,
    JSEventReadDetail,
    JSEventGotoLogin,
    JSEventCalendarSelect,
    JSEventReadDetailPDF,
    JSEventDataSaveState,  // 7 数据的保存
    JSEventQrcodeSaveState,// 8 二维码保存本地

    JSEventGetAppVersion = 12,
};

@protocol PhoneJSExport <JSExport>

- (void)back;

- (void)share:(NSString *)shareContent;

- (NSString *)eventFromJS:(NSString *)jsonStr;

- (void)openImage:(NSString *)urlStr;

@end

@protocol PhoneJSCallDelegate <NSObject>

- (void)eventFromJSResponse:(NSString *)jsonStr type:(JSEventType)type;

@end

@interface PhoneJSContact : NSObject <PhoneJSExport>

@property (nonatomic, weak) UIViewController * viewController;

@property (nonatomic, weak) id<PhoneJSCallDelegate>callDelegate;

@end
