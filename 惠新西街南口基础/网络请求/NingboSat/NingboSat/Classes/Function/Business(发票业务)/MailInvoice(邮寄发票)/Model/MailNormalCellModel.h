//
//  MailNormalCellModel.h
//  NingboSat
//
//  Created by ysyc_liu on 2016/11/4.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MailNormalCellModel : NSObject

@property (nonatomic, copy)NSString *leftText;
@property (nonatomic, copy)NSString *rightText;
@property (nonatomic, strong)UIImage *image;
@property (nonatomic, assign)BOOL rightArrow;

@end
