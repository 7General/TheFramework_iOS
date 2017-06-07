//
//  ProjectSelectView.h
//  LongFor
//
//  Created by ruantong on 17/5/19.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 设置协议，当选中切换城市时会调用
 */
@protocol ChangeCityProject <NSObject>

- (void)changeCityProjectStatus:(NSDictionary*)dic;

@end


/**
 城市项目列表控件
 */
@interface ProjectSelectView : UIView<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,weak)NSObject<ChangeCityProject>* delegate;

//数据源
@property(nonatomic,retain)NSArray* yuanDataArr;
//用来标记组是否展开
@property(nonatomic,retain)NSMutableArray* showBiaoArr;

/**
 列表控件
 */
@property(nonatomic,retain)UITableView* myTableView;

//选中的城市-项目信息
@property(nonatomic,retain)NSDictionary *selectProjectDic;

//1为无需长久保存，只需要回调
@property(nonatomic)int dianType;

/**
 创建ui
 */
-(void)makeUI;


@end
