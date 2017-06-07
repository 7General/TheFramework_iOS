//
//  CustomInfo.h
//  LongFor
//
//  Created by ZZG on 17/5/31.
//  Copyright © 2017年 admin. All rights reserved.
//

/*! 客户跟进信息Model */
#import <Foundation/Foundation.h>

@interface CustomInfo : NSObject
//  跟进ID (非必须)
@property (nonatomic, strong) NSString *followId;
// 意向ID (非必须)
@property (nonatomic, strong) NSString *intentId;
// 客户ID
@property (nonatomic, strong) NSString *customerId;
// 公司ID (非必须)
@property (nonatomic, strong) NSString *companyId;
// 公司ID (非必须)
@property (nonatomic, strong) NSString *projectId;

//@property (nonatomic, strong) NSString *projectId;
// 最近一次跟进时间
@property (nonatomic, strong) NSString *zrycgjsj;
/*! 跟进方式 */
@property (nonatomic, strong) NSString *gjFs;
/*! 跟进内容 */
@property (nonatomic, strong) NSString *gjNr;
// gjDateStr
@property (nonatomic, strong) NSString *gjDateStr;

/*! 跟进人 */
@property (nonatomic, strong) NSString *gjR;
/*! 跟进人ID */
@property (nonatomic, strong) NSString *gjRGuid;
/*! 跟进时长 */
@property (nonatomic, strong) NSString *gjDuration;
/*! 是否置顶 */
@property (nonatomic, strong) NSString *isTop;
/*! 语音存储 */
@property (nonatomic, strong) NSString *voicePath;


+(instancetype)customInfoWithDict:(NSDictionary *)dict;

@end
