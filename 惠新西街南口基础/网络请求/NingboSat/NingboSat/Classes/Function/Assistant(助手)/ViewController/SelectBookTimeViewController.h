//
//  SelectBookTimeViewController.h
//  NingboSat
//
//  Created by 王会洲 on 16/11/22.
//  Copyright © 2016年 王会洲. All rights reserved.
//

/**选中预约时间*/
#import <UIKit/UIKit.h>
#import "SelectBookTimeModel.h"

typedef void(^checkItemlangDate)(NSString * dateStr,SelectBookTimeModel * selectTimeModel);

@interface SelectBookTimeViewController : UIViewController

@property (nonatomic, copy) checkItemlangDate  checkBlock;

-(void)setCheckBlock:(checkItemlangDate)checkBlock;

/**办税网点id*/
@property (nonatomic, strong) NSString * bswd_id;

@end
