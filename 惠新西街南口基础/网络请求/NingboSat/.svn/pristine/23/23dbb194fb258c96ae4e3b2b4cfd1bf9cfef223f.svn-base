//
//  AMViewController.h
//  NingboSat
//
//  Created by 王会洲 on 16/11/24.
//  Copyright © 2016年 王会洲. All rights reserved.
//
/**上午选择器*/
#import <UIKit/UIKit.h>
#import "SelectBookTimeModel.h"

@protocol AMSelectDelegate <NSObject>

-(void)didselectObjModelAM:(SelectBookTimeModel *)AMselectModel;

@end

@interface AMViewController : UIViewController
/**上午数据*/
@property (nonatomic, strong) NSMutableArray * AMDataArry;

@property (nonatomic, weak) id<AMSelectDelegate> delegate;

@end
