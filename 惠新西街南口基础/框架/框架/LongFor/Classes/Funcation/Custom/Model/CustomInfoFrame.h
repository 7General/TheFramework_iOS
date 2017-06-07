//
//  CustomInfoFrame.h
//  LongFor
//
//  Created by ZZG on 17/5/31.
//  Copyright © 2017年 admin. All rights reserved.
//

/*! 客户跟进信息Model */
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "CustomInfo.h"

@interface CustomInfoFrame : NSObject


/*! nameFrame */
@property(nonatomic,assign,readonly)CGRect  nameF;
/*! 活动到访Frame */
@property(nonatomic,assign,readonly)CGRect  hddfF;
/*! 到访日期Frame */
@property(nonatomic,assign,readonly)CGRect  dftimeF;
/*! 项目地区Frame */
@property(nonatomic,assign,readonly)CGRect  proF;
/*! 项目名称Frame */
@property(nonatomic,assign,readonly)CGRect  proNameF;
/*! 跟进信息Frame */
@property(nonatomic,assign,readonly)CGRect  contentF;

/*! 行高 */
@property(nonatomic,assign,readonly)CGFloat  cellHeight;


/*! 跟进信息Model */
@property (nonatomic, strong) CustomInfo *CIModel;

@end
