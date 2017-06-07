//
//  BookListViewController.h
//  NingboSat
//
//  Created by 王会洲 on 16/11/17.
//  Copyright © 2016年 王会洲. All rights reserved.
//

/**可预约事项*/
#import <UIKit/UIKit.h>

typedef void(^readSpecific)(NSString * ids,NSString * mc);
typedef enum : NSUInteger {
    NetCheckList, // 查询可预约事项
    ReadLoaclData, // 读取本地数据
} CheckType;

@interface BookListViewController : UIViewController


/**获取点击可预约事项的id以后返回的block*/
@property (nonatomic, copy) readSpecific  readSpecBlock;

-(void)setReadSpecBlock:(readSpecific)readSpecBlock;

/**显示类型*/
@property (nonatomic, assign) CheckType  showType;



@end
