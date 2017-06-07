//
//  CustomModel.h
//  LongFor
//
//  Created by ZZG on 17/5/19.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomModel : NSObject
/*! 案邀客户列表标记；Y：显示，N:隐藏 */
@property (nonatomic, strong) NSString *caseCustomerFlag;
/*! 客户是否接收邀约 */
@property (nonatomic, strong) NSString *caseIsUser;
/*! 邀约类型 */
@property (nonatomic, strong) NSString *caseType;
/*! 是否老客户标识 Y-是 N-不是 (页面显示蓝色的录) */
@property (nonatomic, strong) NSString *crmFlag;
/*! 客储级别,多个逗号隔开 */
@property (nonatomic, strong) NSString *custlevel;
/*! 客户ID */
@property (nonatomic, strong) NSString *customerId;
/*! 客户姓名 */
@property (nonatomic, strong) NSString *customerName;
/*! 专属置业顾问 */
@property (nonatomic, strong) NSString *employeeName;
/*! 姓 */
@property (nonatomic, strong) NSString *firstName;
/*! 性别 */
@property (nonatomic, strong) NSString *gender;
/*! 跟进人 */
@property (nonatomic, strong) NSString *gjR;
/*! 跟进方式 */
@property (nonatomic, strong) NSString *gjfs;
/*! 跟进内容 */
@property (nonatomic, strong) NSString *gjnr;
/*! 跟进人guid */
@property (nonatomic, strong) NSString *gjrguid;
/*! 意向id */
@property (nonatomic, strong) NSString *intentId;
/*! 意向面积 */
@property (nonatomic, assign) NSInteger intentionArea;
/*! 面积段(平方米) */
@property (nonatomic, strong) NSString *intentionAread;
/*! 意向业态 */
@property (nonatomic, strong) NSString *intentionBiz;
/*! 意向评级 */
@property (nonatomic, strong) NSString *intentlevel;
/*! 否实习生录的置业顾问未处理客户 Y-是 N/其他-不是  (页面显示蓝色的实) */
@property (nonatomic, strong) NSString *internFlag;
/*! 名 */
@property (nonatomic, strong) NSString *lastName;
/*! 专属置业顾问的电话 */
@property (nonatomic, strong) NSString *mobilePhone;
/*! 二维码号 */
@property (nonatomic, strong) NSString *qrcode;
/*! 居室数量 */
@property (nonatomic, strong) NSString *roomNum;
/*! 电话 */
@property (nonatomic, strong) NSString *tel;
/*! 总价预期 */
@property (nonatomic, strong) NSString *totalExpectation;
/*! <#说明#> */
@property (nonatomic, strong) NSString *updateDate;
/*! <#说明#> */
@property (nonatomic, strong) NSString *updateDateStr;
/*! 上次跟进时间 */
@property (nonatomic, strong) NSString *zrycgjsj;
+(instancetype)customWithDict:(NSDictionary *)dict;

@end
