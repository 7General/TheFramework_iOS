//
//  BookDetailViewController.h
//  NingboSat
//
//  Created by 王会洲 on 16/11/17.
//  Copyright © 2016年 王会洲. All rights reserved.
//

/**预约办税*/
#import <UIKit/UIKit.h>
#import "reveModel.h"


@interface BookDetailViewController : UIViewController
/**是否使用选中的模型数据-----默认为不使用*/
@property (nonatomic, assign) BOOL  isUserSelectModel;
/**选中的模型数据*/
@property (nonatomic, strong) reveModel * selectReveModel;
@end
