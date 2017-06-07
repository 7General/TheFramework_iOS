//
//  CustomAddModel.h
//  LongFor
//
//  Created by ruantong on 17/5/27.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>



#define CUSTOMER_GENDER	 @"CUSTOMER_GENDER"//性别
#define INTENTMAIN_HOUSEBIT	@"INTENTMAIN_HOUSEBIT" //意向户位
#define CUSTOMER_FAMILYREALTION	@"CUSTOMER_FAMILYREALTION" //家庭结构
#define CUSTOMER_ISABNORMALPER	@"CUSTOMER_ISABNORMALPER" //是否异客
#define ASSETS_TYPE	@"ASSETS_TYPE" //座驾价格区间
#define INTENTMAIN_INTENTLEVEL	@"INTENTMAIN_INTENTLEVEL" //意向等级
#define CUSTOMER_CHILDSITUATION	@"CUSTOMER_CHILDSITUATION" //小孩情况
#define CUSTOMER_NOWISSCHOOL @"CUSTOMER_NOWISSCHOOL" //现居是否有学区
#define CUSTOMER_AGE	@"CUSTOMER_AGE" //年龄段/年龄
#define CUSTOMER_ISNEVERCONTACTS	@"CUSTOMER_ISNEVERCONTACTS" //是否永不接触
#define INTENTMAIN_KNOWWAY	@"INTENTMAIN_KNOWWAY" //媒介途径
#define CUSTOMER_MARRIAGE	@"CUSTOMER_MARRIAGE" //婚姻状况
#define CUSTOMER_ESTATENUM	@"CUSTOMER_ESTATENUM" //名下房产套数
#define INTENTMAIN_INTENTIONAREAD	@"INTENTMAIN_INTENTIONAREAD" //意向面积段
#define INTENTMAIN_ROOMNUM	@"INTENTMAIN_ROOMNUM" //意向居室数量
#define RELATEDUSER_RELATION	@"RELATEDUSER_RELATION" //关联客户关系
#define INTENTMAIN_REDECORATED	@"INTENTMAIN_REDECORATED" //意向是否装修
#define INTENTMAIN_FACE	@"INTENTMAIN_FACE" //意向朝向
#define CUSTOMER_NOWAREA	@"CUSTOMER_NOWAREA" //现居面积段
#define INTENTMAIN_PURPOSE	@"INTENTMAIN_PURPOSE" //置业目的
#define CUSTOMER_NOWBATHROOMNUM	@"CUSTOMER_NOWBATHROOMNUM" //现居卫生间数量
#define CUSTOMER_CARDTYPE	@"CUSTOMER_CARDTYPE" //证件类型
#define INTENTMAIN_INTENTIONBIZ	@"INTENTMAIN_INTENTIONBIZ" //意向业态
#define SOCIALLY_TYPE	@"SOCIALLY_TYPE" //经常使用的房地产APP
#define INTENTMAIN_WAYDIVIDE	@"INTENTMAIN_WAYDIVIDE" //途径细分
#define CUSTOMER_NOWBUILDAGE	@"CUSTOMER_NOWBUILDAGE" //现居楼龄
#define SOCIALLY_TYPE	@"SOCIALLY_TYPE" //关注的房地产网站
#define CUSTOMER_NOWROOMNUM	@"CUSTOMER_NOWROOMNUM" //现居居室数量
#define INTENTMAIN_CUSTLEVEL	@"INTENTMAIN_CUSTLEVEL" //客储级别
#define CUSTOMER_NOWBIZ	@"CUSTOMER_NOWBIZ" //现居业态
#define CUSTOMER_ISLONGFOR	@"CUSTOMER_ISLONGFOR" //是否龙湖业主
#define INTENTMAIN_SCHOOLREQUEST	@"INTENTMAIN_SCHOOLREQUEST" //学区需求
#define INTENTMAIN_VISITTIME	@"INTENTMAIN_VISITTIME" //到访次数


@interface CustomAddModel : NSObject

+(NSArray*)getInfoWithViewKey:(NSString*)viewKey;

+(NSMutableDictionary*)makeCustomInfoDic;

@end
