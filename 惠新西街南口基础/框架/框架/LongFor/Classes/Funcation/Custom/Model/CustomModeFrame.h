//
//  CustomModeFrame.h
//  LongFor
//
//  Created by ZZG on 17/5/19.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "CustomModel.h"

@interface CustomModeFrame : NSObject

/*! logoFrame */
@property(nonatomic,assign,readonly)CGRect  logoF;
/*! 姓名fram */
@property(nonatomic,assign,readonly)CGRect  nameF;
/*! 活动邀请F */
@property(nonatomic,assign,readonly)CGRect  invitationF;
/*! 置顶F */
@property(nonatomic,assign,readonly)CGRect  topF;
/*! 电话，短信 动画按钮 */
@property(nonatomic,assign,readonly)CGRect  buttonF;
/*! 级别F */
@property(nonatomic,assign,readonly)CGRect  leavelF;
/*! 楼层F */
@property(nonatomic,assign,readonly)CGRect  floorF;
/*! 面积F */
@property(nonatomic,assign,readonly)CGRect  mjF;
/*! 居室 */
@property(nonatomic,assign,readonly)CGRect  rooCountF;
/*! 中间横线 */
@property(nonatomic,assign,readonly)CGRect  centerLineF;
/*! 置业顾问F */
@property(nonatomic,assign,readonly)CGRect  zygwATimeF;
/*! 置业顾问时间F */
//@property(nonatomic,assign,readonly)CGRect  zygwTimeF;
/*! 置顾再录F */
@property(nonatomic,assign,readonly)CGRect  zgzlF;
/*! 留言内容F */
@property(nonatomic,assign,readonly)CGRect  contentF;

/*! 行高 */
@property(nonatomic,assign,readonly)CGFloat cellHeight;

/*! cell的mode数据 */
@property(nonatomic,strong)CustomModel *cMode;


@end
