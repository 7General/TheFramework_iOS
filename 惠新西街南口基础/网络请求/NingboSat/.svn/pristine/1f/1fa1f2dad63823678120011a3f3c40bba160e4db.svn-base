//
//  BookItemViewController.h
//  NingboSat
//
//  Created by 王会洲 on 16/11/17.
//  Copyright © 2016年 王会洲. All rights reserved.
//

// 查看可预约事项的具体事项
#import <UIKit/UIKit.h>

typedef void(^readSpecifics)(NSString * qstb,NSString * mc,NSString * jtyysxid,NSString * cnnid,NSString * docid);

@interface BookItemViewController : UIViewController

/**获取点击可预约事项的id以后返回的block*/
@property (nonatomic, copy) readSpecifics  readSpecBlock;

-(void)setReadSpecBlock:(readSpecifics)readSpecBlock;

/**标题*/
@property (nonatomic, strong) NSString * titleName;

/**预约事项*/
@property (nonatomic, strong) NSString * yysx;
/**办税网点ID*/
@property (nonatomic, strong) NSString * bswd_id;
/**纳税人识别号*/
@property (nonatomic, strong) NSString * taxpayer_code;

@end
