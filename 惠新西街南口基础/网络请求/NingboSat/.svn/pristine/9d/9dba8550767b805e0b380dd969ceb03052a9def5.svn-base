//
//  BookInfoViewController.h
//  NingboSat
//
//  Created by 王会洲 on 16/11/28.
//  Copyright © 2016年 王会洲. All rights reserved.
//

/**预约详细信息*/
#import <UIKit/UIKit.h>
#import "BookModel.h"
/**取消预约*/
typedef void(^changeState)(NSInteger ids);

@interface BookInfoViewController : UIViewController

@property (nonatomic, strong) BookModel * cellModel;

@property (nonatomic, copy) changeState  changeBlock;


-(void)setChangeBlock:(changeState)changeBlock;

@end
