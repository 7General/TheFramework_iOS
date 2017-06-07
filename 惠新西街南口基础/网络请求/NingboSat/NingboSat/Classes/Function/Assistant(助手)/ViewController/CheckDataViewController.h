//
//  CheckDataViewController.h
//  NingboSat
//
//  Created by 王会洲 on 16/11/28.
//  Copyright © 2016年 王会洲. All rights reserved.
//


/**查看办理所需资料*/
#import <UIKit/UIKit.h>

@interface CheckDataViewController : UIViewController

/**具体事项ID*/
@property (nonatomic, strong) NSString * cpnid;
/**具体事项所需材料ID*/
@property (nonatomic, strong) NSString * docid;

/**标题*/
@property (nonatomic, strong) NSString * titles;

@end
