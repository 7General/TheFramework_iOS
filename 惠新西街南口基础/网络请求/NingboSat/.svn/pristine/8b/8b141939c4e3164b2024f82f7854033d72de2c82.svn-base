//
//  Config.h
//  TicketCloud
//
//  Created by 王会洲 on 16/1/18.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#ifndef Config_h
#define Config_h

#import "NSObject+UserInfoState.h"

#ifdef DEBUG
#define NSLog(...) NSLog(__VA_ARGS__)
#define debugMethod() NHLog(@"%s",__func__)
#else
#define NSLog(...)
#define debugMethod()
#endif



#define KWidthScale ([UIScreen mainScreen].bounds.size.width / 375.0)
#define KHeightScale ([UIScreen mainScreen].bounds.size.height / 667.0)

#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
/// 状态栏高度.
#define FIT_HEIGHT 20.0

#define NAVIGATIONBAR_HEIGHT CGRectGetMaxY(self.navigationController.navigationBar.frame)
#define TABBAR_HEIGHT 47.0

#define SYSTEM_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define DEVICE [[UIDevice currentDevice].systemVersion integerValue] < 7.0
#define BUNDLE_VERSION  [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]
#define APP_VERSION     [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
//系统版本判断-----------------
#define VERSION_OVER_IOS7 (([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)?YES:NO)

// 1.判断是否为iOS7
#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)



// 2.获得RGB颜色
#define YSColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

// 3.字体设置
#define FONTLIGHT(obj) [UIFont fontWithName:@"STHeitiSC-Light" size:obj]
#define FONTMedium(obj) [UIFont fontWithName:@"STHeitiSC-Medium" size:obj]

/**字体增加量*/
#define SCREENSTAE 2
#define FONT_BY_SCREEN(obj) ({SCREEN_WIDTH >= 414 ? FONTLIGHT(obj + SCREENSTAE) :  FONTLIGHT(obj);})
#define FONT_BOLD_BY_SCREEN(obj) [UIFont fontWithName:@"STHeitiSC-Medium" size:(SCREEN_WIDTH >= 414 ? (obj + SCREENSTAE) : obj)]

#define YSTabBarButtonRation 0.6

//按钮的默认文字颜色
#define YSTabBarButtonTitleColor (iOS7 ? YSColor(138,138,138) : YSColor(138,0,138))
//
#define YSTabBarButtonTitleSelectedColor (iOS7 ? YSColor(89,162,240) : YSColor(248,139,0))

// 字符串是否为空
#define IsStrEmpty(_ref)    (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) ||([(_ref)isEqualToString:@""]))
// 数组是否为空
#define IsArrEmpty(_ref)    (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) ||([(_ref) count] == 0))
// 转换ld
#define L(_ref) [NSString stringWithFormat:@"%ld",_ref]

// ************** 请求数据相关 10.157  10.106
#define NINGBO_TEST // 是否为测试环境

#ifdef NINGBO_TEST

#define NINGBO_OUTSIDE_SERVER   @"http://139.217.21.95:8085/itaxer-nb-outside"
#define NINGBO_GOV_SERVER       @"http://www.nb-n-tax.gov.cn/wzgl/ystApp"
#define NINGBO_SEARCH_SERVER    @"http://wsbs.nb-n-tax.gov.cn:8099/web-fpxxcx/sjapp"
#else
#define NINGBO_OUTSIDE_SERVER   @"https://ydbs.nb-n-tax.gov.cn:7001/itaxer-nb-outside"
#define NINGBO_GOV_SERVER       @"http://www.nb-n-tax.gov.cn/wzgl/ystApp"
#define NINGBO_SEARCH_SERVER    @"http://wsbs.nb-n-tax.gov.cn:8099/web-fpxxcx/sjapp"
#endif

#define NINGBO_OUTSIDE_SUBSERVER(subStr)    ([NINGBO_OUTSIDE_SERVER stringByAppendingString:subStr])
#define NINGBO_SUBSERVER(subStr)            ([NINGBO_GOV_SERVER stringByAppendingString:subStr])
#define NINGBO_SEARCH_SUBSERVER(subStr)     ([NINGBO_SEARCH_SERVER stringByAppendingString:subStr])

#define HOME_ANNOUNCEMENT_URL           NINGBO_SUBSERVER(@"/tzgg/")//首页-通知公告
#define HOME_INVOICE_SEARCH_URL         INVOICE_SEARCH_URL//首页-发票查询
#define HOME_CONSULT_URL                NINGBO_SEARCH_SUBSERVER(@"/nszx/jsp/ystAPP_indexConsult.jsp")//首页-咨询

// NINGBO_OUTSIDE_SUBSERVER
#define DECLARE_URL                     @"https://ydbs.nb-n-tax.gov.cn:7001/itaxer-nb-outside/assistant/modules/assistant/index.html" //NINGBO_OUTSIDE_SUBSERVER(@"/assistant/modules/assistant/index.html")//申报
#define INVOICE_SEARCH_URL              NINGBO_OUTSIDE_SUBSERVER(@"/fpcx/html/fpcx.html")//普通发票查询

#define INVOICE_MAKEOUT_DELEGATE_URL    NINGBO_OUTSIDE_SUBSERVER(@"/web/app/modules/issue/htm/vatDedicated.html")//发票代开
#define INVOICE_MAKEOUT_SELF_URL        NINGBO_OUTSIDE_SUBSERVER(@"/web/app/modules/invoiceOpen/index.html#/invoiceOpen")//发票开具
#define INVOICE_MAKEOUT_SET_URL         NINGBO_OUTSIDE_SUBSERVER(@"/web/app/modules/invoiceSet/index.html")//开票设置

#define MINE_FEEDBACK_URL               NINGBO_OUTSIDE_SUBSERVER(@"/web/app/modules/mymsg/#/msgFeedback")//我有话说
#define MINE_MESSAGE_URL                NINGBO_OUTSIDE_SUBSERVER(@"/web/app/modules/mymsg/#/msglist")//我的消息
#define MINE_MESSAGE_DETAIL_URL         NINGBO_OUTSIDE_SUBSERVER(@"/web/app/modules/mymsg/#/msgdetail")//我的消息-详情
#define MINE_INVOICE_URL                NINGBO_OUTSIDE_SUBSERVER(@"/web/app/modules/invoices/htm/invoiceQuery.html")//我的发票

#define TAXSEARCH_APPLYFOR_URL          NINGBO_OUTSIDE_SUBSERVER(@"/web/app/modules/applyQuery/index.html#/appliedList")//涉税申请
#define TAX_REGULATION_URL              NINGBO_OUTSIDE_SUBSERVER(@"/web/app/modules/taxlaws/#/lawslist")//税收法规

//开票设置

// NINGBO_SEARCH_SUBSERVER
#define TAXER_SEARCH_URL            NINGBO_SEARCH_SUBSERVER(@"/nsrcx/html/nsrcx.html")//纳税人查询
#define CAR_TAXER_SEARCH_URL        NINGBO_SEARCH_SUBSERVER(@"/car/html/car.html")// 车购税查询
#define INVOICE_TYPE_SEARCH_URL     NINGBO_SEARCH_SUBSERVER(@"/fpys/html/fpys.html")//发票票样
#define TAX_RATE_TYPE_SEARCH_URL    NINGBO_SEARCH_SUBSERVER(@"/szsl/html/szsl.html")//税率税种
#define TAX_REBATES_SEARCH_URL      NINGBO_SEARCH_SUBSERVER(@"/export/html/export.html")//出口退税率
// 互动
#define INTERACTION_SWXW_URL        NINGBO_SUBSERVER(@"/swyw/")
#define INTERACTION_ZRZX_URL        NINGBO_SUBSERVER(@"/zrzx/")
#define INTERACTION_ZXZX_URL        NINGBO_SUBSERVER(@"/zxzx/")
// 办税日历
#define ASSISTANT_CALENDAR          NINGBO_SUBSERVER(@"/calendar/")
// 办税指南
#define ASSISTANT_GUIDE_REGISTER    NINGBO_SUBSERVER(@"/bszn/swdj/")// 税务登记
#define ASSISTANT_GUIDE_IDENTIFIED  NINGBO_SUBSERVER(@"/bszn/swrd/")// 税务认定
#define ASSISTANT_GUIDE_INVOICE     NINGBO_SUBSERVER(@"/bszn/fpbl/")// 发票办理
#define ASSISTANT_GUIDE_DECLARE     NINGBO_SUBSERVER(@"/bszn/sbns/")// 申报纳税
#define ASSISTANT_GUIDE_PREFERENTIAL    NINGBO_SUBSERVER(@"/bszn/yhbl/")// 优惠办理
#define ASSISTANT_GUIDE_PROVE       NINGBO_SUBSERVER(@"/bszn/zmbl/")// 证明办理


#define TAXPAYER_CODE [NSObject getTaxNumber]
#define IS_LOGIN [NSObject isLogin]


#define LOCATIONS @"locations"
#define LOCATION_VALUE [[NSUserDefaults standardUserDefaults] objectForKey:LOCATIONS]

#define LAST_ACTIVE_TIME @"lastActiveTime"

#endif /* Config_h */
