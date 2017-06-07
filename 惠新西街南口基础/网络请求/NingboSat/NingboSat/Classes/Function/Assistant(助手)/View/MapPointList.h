//
//  MapPointList.h
//  NingboSat
//
//  Created by 王会洲 on 16/10/6.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapShowCell.h"
#import "reveModel.h"

@protocol MapPointListDelegate <NSObject>

-(void)locationPointswithModel:(reveModel *)model;
/**我要预约*/
-(void)pushBookVCWithModel:(reveModel *)model;


@end

@interface MapPointList : UIView<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray * mapPointArry;

@property (nonatomic, weak) id<MapPointListDelegate> delegate;

/**是否点击列表*/
@property (nonatomic, assign) BOOL  isClickListBtn;
@end
