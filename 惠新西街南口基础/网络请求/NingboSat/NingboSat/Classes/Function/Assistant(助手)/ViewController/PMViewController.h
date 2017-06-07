//
//  PMViewController.h
//  NingboSat
//
//  Created by 王会洲 on 16/11/24.
//  Copyright © 2016年 王会洲. All rights reserved.
//

/**选择下午预约时间控制器*/
#import <UIKit/UIKit.h>
#import "SelectBookTimeModel.h"

@protocol PMSelectDelegate <NSObject>

-(void)didselectObjModelPM:(SelectBookTimeModel *)PMselectModel;

@end

@interface PMViewController : UIViewController
/**上午数据*/
@property (nonatomic, strong) NSMutableArray * PMDataArry;


@property (nonatomic, weak) id<PMSelectDelegate>  delegate;

@end
