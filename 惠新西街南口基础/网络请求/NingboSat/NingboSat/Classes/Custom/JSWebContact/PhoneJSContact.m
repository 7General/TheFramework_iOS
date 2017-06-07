//
//  PhoneJSContact.m
//  PlanC
//
//  Created by ysyc_liu on 16/7/18.
//  Copyright © 2016年 ysyc_wang. All rights reserved.
//

#import "PhoneJSContact.h"
#import "Config.h"
#import "YSNotificationManager.h"

#import "WebImageDetailView.h"
#import "YSWebController.h"
#import "LoginViewController.h"
#import "MSSCalendarViewController.h"
#import "YSProgressHUD.h"


@interface PhoneJSContact()<MSSCalendarViewControllerDelegate>

@end

@implementation PhoneJSContact

- (void)back {
    [self popViewController];
}

- (void)share:(NSString *)shareContent {
    
}

- (NSString *)eventFromJS:(NSString *)jsonStr {
    NSError * error;
    NSMutableString * newJsonStr = [jsonStr mutableCopy];
    NSDictionary * eventDict = [NSJSONSerialization JSONObjectWithData:[newJsonStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];
    JSEventType type = [eventDict[@"type"] integerValue];
    NSDictionary * dict = eventDict[@"data"];
    
    NSString * result = @"{}";
    
    switch (type) {
        case JSEventGetLatestConsultation: {
            result = [self getLatestConsultation];
            break;
        }
        case JSEventGetHottestConsultation: {
            result = [self getHottestConsultation];
            break;
        }
        case JSEventGetUserInfo: {
            result = [self getUserInfo];
            break;
        }
        case JSEventReadDetail: {
            result = [self readDetail:dict];
            break;
        }
        case JSEventGotoLogin: {
            result = [self gotoLogin];
            break;
        }
        case JSEventCalendarSelect: {
            result = [self calendarSelect];
            break;
        }
        case JSEventReadDetailPDF: {
            result = [self readDetailPDF:dict];
            break;
        }
        case JSEventGetAppVersion: {
            result = [self GetAppVersion];
            break;
        }
        case JSEventDataSaveState:{
            result = [self dataSave:dict];
            break;
        }
        case JSEventQrcodeSaveState:{
            result = [self qrCodeSave:dict];
            
        }
        default:
            break;
    }
    NSLog(@"type:%d, result:%@", (int)type, result);
    return result;
}

- (void)openImage:(NSString *)urlStr {
    NSLog(@"openImage:%@", urlStr);
    dispatch_sync(dispatch_get_main_queue(), ^{
        [WebImageDetailView loadImageByURLStr:urlStr];
    });
}

#pragma mark - event method
- (NSString *)getLatestConsultation {
    [YSNotificationManager postConsult:@{YSConsultUrl:INTERACTION_ZXZX_URL}];
    return @"{}";
}

- (NSString *)getHottestConsultation {
    [YSNotificationManager postConsult:@{YSConsultUrl:INTERACTION_ZRZX_URL}];
    return @"{}";
}

- (NSString *)getUserInfo {
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:TAXPAYER_CODE, @"taxerNO", [NSObject getAccessToken], @"accessToken", [NSObject userId], @"userId", [NSObject getTaxName], @"userName", nil];
    return [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:dict options:0 error:nil] encoding:4];
}

- (NSString *)readDetail:(NSDictionary *)dict {
    YSWebController *webVc = [[YSWebController alloc] init];
    webVc.urlStr = dict[@"url"];
    [self pushViewController:webVc];
    return @"{}";
}
- (NSString *)readDetailPDF:(NSDictionary *)dict {
    YSWebController *webVc = [[YSWebController alloc] init];
    webVc.urlStr = dict[@"url"];
    [webVc setEnableScale];
    webVc.showNavigation = YES;
    [self pushViewController:webVc];
    return @"{}";
}

- (NSString *)gotoLogin {
    LoginViewController *loginVc = [[LoginViewController alloc] init];
    [self presentViewController:loginVc];
    return @"{}";
}

- (NSString *)calendarSelect {
    MSSCalendarViewController *cvc = [[MSSCalendarViewController alloc]init];
    cvc.limitMonth = 12 * 1;// 显示几个月的日历
    cvc.type = MSSCalendarViewControllerLastType;
    cvc.beforeTodayCanTouch = YES;// 今天之后的日期是否可以点击
    cvc.afterTodayCanTouch = NO;// 今天之前的日期是否可以点击
    cvc.showChineseHoliday = NO;// 是否展示农历节日
    cvc.showChineseCalendar = NO;// 是否展示农历
    cvc.showHolidayDifferentColor = NO;// 节假日是否显示不同的颜色
    cvc.showAlertView = YES;// 是否显示提示弹窗
    cvc.delegate = self;
    [self pushViewController:cvc];
    return @"{}";
}

- (NSString *)GetAppVersion {
    NSDictionary *dict = @{@"appVersion" : APP_VERSION, @"appCode" : BUNDLE_VERSION};
    @try {
        return [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
    } @catch (NSException *exception) {
        return @"{}";
    }
}


-(NSString *)dataSave:(NSDictionary *)dic{
    //flag 1:存数据  2：取数据
    if ([[dic objectForKey:@"flag"] isEqualToString:@"1"]) {
        [[NSUserDefaults standardUserDefaults]setObject:dic[@"value"] forKey:dic[@"key"]];
        
        return @"{}";
    }else if([[dic objectForKey:@"flag"] isEqualToString:@"2"]){
       NSString *dataString = [[NSUserDefaults standardUserDefaults]objectForKey:dic[@"key"]];
       
        return dataString;

    }else{
        return @"{}";
    }
}

//二维码图片保存
-(NSString *)qrCodeSave:(NSDictionary *)dic{
    NSLog(@"%@",dic);
    
    UIImage *qrImage = [self dataURLImage:dic[@"imgdata"]];
    
    UIImageWriteToSavedPhotosAlbum(qrImage, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);

//    CIImage * imageTmp = [[CreateQRCode sharedInstance] createQRForString:@""];
//
//    UIImage * image = [[CreateQRCode sharedInstance] createNonInterpolatedUIImageFormCIImage:imageTmp withSize:500.0f];
 
    return @"{}";
}
//base64 转图片
- (UIImage *) dataURLImage: (NSString *) imgSrc
{
    NSURL *url = [NSURL URLWithString: imgSrc];
    NSData *data = [NSData dataWithContentsOfURL: url];
    UIImage *image = [UIImage imageWithData: data];
    
    
    return image;
}
#pragma mark - 页面跳转.
- (void)popViewController {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.viewController.navigationController popViewControllerAnimated:YES];
    });
}

- (void)pushViewController:(UIViewController *)vc {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.viewController.navigationController pushViewController:vc animated:YES];
    });
}

- (void)popToRootViewController {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.viewController.navigationController popToRootViewControllerAnimated:YES];
    });
}

- (void)presentViewController:(UIViewController *)vc {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.viewController presentViewController:vc animated:YES completion:^{
            
        }];
    });

}

#pragma mark - MSSCalendarViewControllerDelegate
- (void)calendarViewConfirmClickWithStartDate:(NSInteger)startDate endDate:(NSInteger)endDate {
    @try {
        NSDate * date = [NSDate dateWithTimeIntervalSince1970:startDate];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *dateStr = [dateFormatter stringFromDate:date];
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"1",@"type",@{@"date":dateStr},@"data", nil];
        NSData *responseData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
        NSString *responseStr = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
        [self.callDelegate eventFromJSResponse:responseStr type:JSEventCalendarSelect];
    } @catch (NSException *exception) {
        NSLog(@"[EXCEPTION] %@ : %@", [self class], exception);
    }
}

// 指定回调方法
- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo
{
    if(error != NULL) {
        [YSProgressHUD showErrorHUDOnView:self.viewController.view Message:@"保存失败"];
    }
    else {
        [YSProgressHUD showSuccessWithIconOnView:self.viewController.view Message:@"已保存相册"];
        [self performSelector:@selector(popoverController) withObject:nil afterDelay:1];
    }

}
@end
