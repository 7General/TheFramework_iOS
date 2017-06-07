//
//  CustomAddModel.m
//  LongFor
//
//  Created by ruantong on 17/5/27.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "CustomAddModel.h"

@implementation CustomAddModel




#define SOCIALLY_TYPE	@"SOCIALLY_TYPE" //经常使用的房地产APP


+(NSMutableDictionary*)makeCustomInfoDic{
    
    NSMutableDictionary* csCustomerBean = [NSMutableDictionary dictionary];
    NSMutableDictionary* csAssetsBean = [NSMutableDictionary dictionary];
    NSMutableDictionary* csOtherBean = [NSMutableDictionary dictionary];
    NSMutableDictionary* csIntentMainBean = [NSMutableDictionary dictionary];
    NSMutableArray* csInteniFZBean = [NSMutableArray array];
    NSMutableArray* csFollowBean = [NSMutableArray array];
    
    NSMutableDictionary * allInfoDic = [NSMutableDictionary dictionaryWithDictionary:@{@"employeeType":@"",
                                @"customerId":@"",
                                @"csCustomerBean":csCustomerBean,
                                @"csAssetsBean":csAssetsBean,
                                @"csOtherBean":csOtherBean,
                                @"csIntentMainBean":csIntentMainBean,
                                @"csIntentMainBean":csInteniFZBean,
                                @"csIntentMainBean":csFollowBean,}];
    
    return allInfoDic;
}


+(NSArray*)getInfoWithViewKey:(NSString*)viewKey{
    /*
     * csCustomerBean // 客户资产属性表
     * csAssetsBean // 客户资产属性表
     * csOtherBean //客户其他属性表
     * csIntentMainBean // 客户意向主数据
     * csInteniFZBean // 客户意向分支数据
     * csFollowBean // 客户跟进
     */
    
    if([viewKey isEqualToString:INTENTMAIN_INTENTIONBIZ]){
        return nil;
    }else if([viewKey isEqualToString:CUSTOMER_GENDER]){
        return nil;
    }else if([viewKey isEqualToString:INTENTMAIN_INTENTIONAREAD]){
        return nil;
    }else if([viewKey isEqualToString:INTENTMAIN_HOUSEBIT]){
        return nil;
    }else if([viewKey isEqualToString:INTENTMAIN_INTENTLEVEL]){
        return nil;
    }else if([viewKey isEqualToString:CUSTOMER_AGE]){
        return nil;
    }else if([viewKey isEqualToString:INTENTMAIN_ROOMNUM]){
        return nil;
    }else if([viewKey isEqualToString:INTENTMAIN_FACE]){
        return nil;
    }else if([viewKey isEqualToString:INTENTMAIN_REDECORATED]){
        return nil;
    }else if([viewKey isEqualToString:INTENTMAIN_CUSTLEVEL]){
        return nil;
    }else if([viewKey isEqualToString:CUSTOMER_MARRIAGE]){
        return nil;
    }else if([viewKey isEqualToString:CUSTOMER_FAMILYREALTION]){
        return nil;
    }else if([viewKey isEqualToString:CUSTOMER_ISABNORMALPER]){
        return nil;
    }else if([viewKey isEqualToString:ASSETS_TYPE]){
        return nil;
    }else if([viewKey isEqualToString:CUSTOMER_CHILDSITUATION]){
        return nil;
    }else if([viewKey isEqualToString:CUSTOMER_NOWISSCHOOL]){
        return nil;
    }else if([viewKey isEqualToString:CUSTOMER_ESTATENUM]){
        return nil;
    }else if([viewKey isEqualToString:CUSTOMER_CARDTYPE]){
        return nil;
    }else if([viewKey isEqualToString:RELATEDUSER_RELATION]){
        return nil;
    }else if([viewKey isEqualToString:CUSTOMER_NOWAREA]){
        return nil;
    }else if([viewKey isEqualToString:CUSTOMER_NOWBATHROOMNUM]){
        return nil;
    }else if([viewKey isEqualToString:INTENTMAIN_SCHOOLREQUEST]){
        return nil;
    }else if([viewKey isEqualToString:CUSTOMER_ISLONGFOR]){
        return nil;
    }else if([viewKey isEqualToString:CUSTOMER_NOWBIZ]){
        return nil;
    }else if([viewKey isEqualToString:CUSTOMER_NOWROOMNUM]){
        return nil;
    }else if([viewKey isEqualToString:CUSTOMER_NOWAREA]){
        return nil;
    }else if([viewKey isEqualToString:INTENTMAIN_PURPOSE]){
        return nil;
    }else if([viewKey isEqualToString:CUSTOMER_NOWBUILDAGE]){
        return nil;
    }else if([viewKey isEqualToString:CUSTOMER_NOWROOMNUM]){
        return nil;
    }else if([viewKey isEqualToString:INTENTMAIN_WAYDIVIDE]){
        return nil;
    }else if([viewKey isEqualToString:SOCIALLY_TYPE]){
        return nil;
    }else if([viewKey isEqualToString:CUSTOMER_ISNEVERCONTACTS]){
        return nil;
    }else if([viewKey isEqualToString:INTENTMAIN_VISITTIME]){
        return nil;
    }else if([viewKey isEqualToString:INTENTMAIN_KNOWWAY]){
        return nil;
    }else if([viewKey isEqualToString:SOCIALLY_TYPE]){
        return nil;
    }
    
    return nil;
}

@end
