//
//  ConfigUI.h
//  LongFor
//
//  Created by admin on 17/5/10.
//  Copyright © 2017年 admin. All rights reserved.
//
#import "UIColor+Helper.h"
#import "FilterMannger.h"

#ifndef ConfigUI_h
#define ConfigUI_h


// ************** 请求数据相关 
//#define NINGBO_TEST // 是否为测试环境

//#ifdef NINGBO_TEST

//#define LONGFOR_OUTSIDE_SERVER   @"http://customer.demo.longhu.net:8080"
//#define LONGFOR_OUTSIDE_SERVER   @"http://172.18.64.36:8080"
//#else
//#define LONGFOR_OUTSIDE_SERVER   @"https://ydbs.nb-n-tax.gov.cn:7001/itaxer-nb-outside"

//#endif

//#define LONGFOR_OUTSIDE_SUBSERVER(subStr)    (LONGFOR_OUTSIDE_SERVER subStr)

// 正式
#define LONGFOR_FORMAL_SERVER   @"http://customer.demo.longhu.net:8080"
// 测试
#define LONGFOR_TEST_SERVER         @"http://customer.demo.longhu.net:8080"
// 灰度
#define LONGFOR_GREY_SERVER        @"http://customer.grey.longfor.com"



//################## 友盟统计key
#define UMOBCLICK @"59141b5604e2052078001610"


#ifdef DEBUG
//#define NSLog(...) NSLog(__VA_ARGS__)
#define NSLog(format,...) printf("%s",[[NSString stringWithFormat:(format), ##__VA_ARGS__] UTF8String])
#define debugMethod() NHLog(@"%s",__func__)
#else
#define NSLog(...)
#define debugMethod()
#endif



/// 屏幕Bounds.
#define SCREEN_BOUNDS [UIScreen mainScreen].bounds
/// 屏幕宽度.
#define SCREEN_WIDTH  CGRectGetWidth([UIScreen mainScreen].bounds)
/// 屏幕高度.
#define SCREEN_HEIGHT CGRectGetHeight([UIScreen mainScreen].bounds)
/// 状态栏高度.
#define FIT_HEIGHT 20.0
/// 导航栏高度.
#define NAVIV_HEIGHT 44.0
/// tabbar高度.
#define TABBAR_HEIGHT 49.0

// 屏幕宽度系数
#define kSCALEWIDTH (SCREEN_WIDTH / 375)
// 屏幕高度系数
#define kSCALEHEIGHT (SCREEN_HEIGHT / 667)

// 设置颜色
#define SColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define HexColor(_c) [UIColor colorWithHexString:[NSString stringWithFormat:@"%@",_c]];
// 设置字体
#define FONTWITHSIZE_LIGHT(obj) [UIFont fontWithName:@"STHeitiSC-Light" size:obj]


// ##########用户信息

// 公司id
#define ORGID [FilterMannger valueUserInfo][@"orgId"]
// 用户id
#define EMPLOYEEID [FilterMannger valueUserInfo][@"employeeId"]
//员工类型
#define EMPLOYEETYPE [FilterMannger valueUserInfo][@"employeeType"]
//员工app权限
#define APPMENUFLAG = [FilterMannger valueUserInfo][@"menuFlag"]
// 登录名
#define LOGINNAME [FilterMannger valueUserInfo][@"loginName"]
// 中文名
#define PERNAME [FilterMannger valueUserInfo][@"perName"]

// ########## 员工app权限  APPMENUFLAG
//app_ybpydyxmb	仪表盘月度营销目标
//app_ybpkczdgj	仪表盘客储诊断工具
//app_ybprzdt	仪表盘人资地图
//app_ybp4217	仪表盘4217
//app_ybpscj	仪表盘收藏夹
//app_lxdkhlb	龙信端客户列表
//app_lxdkhlb_xzkh	龙信端客户列表新增客户
//app_bjkh	编辑客户
//app_lxdkhxq	龙信端客户详情
//app_khlbsys	客户列表扫一扫
//app_khgj	客户跟进
//app_kqdk	考勤打卡
//app_lxfz	龙信分组
//app_zd	置顶
//app_kqcx	考勤查询


// ##########选中城市-项目信息
// 城市id
#define CITYID [FilterMannger getSelectCity_ProjectDic][CITY_ID]
// 项目id
#define PRJID [FilterMannger valueProjectID]
// ################

// 字符串是否为空
#define IsStrEmpty(_ref)    (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) ||([(_ref)isEqualToString:@""]))
// 数组是否为空
#define IsArrEmpty(_ref)    (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) ||([(_ref) count] == 0))
// 字典是否为空
#define IsDicEmpty(_ref)    (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) ||([[_ref allKeys] count] == 0))
// 对象是否为空
#define IsEmpty(_ref)    (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]))

// 转换ld
#define L(_ref) [NSString stringWithFormat:@"%ld",_ref]






//释放定时器
#undef TT_INVALIDATE_TIMER
#define TT_INVALIDATE_TIMER(__TIMER) \
{\
[__TIMER invalidate];\
__TIMER = nil;\
}

#endif /* ConfigUI_h */
