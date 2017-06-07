//
//  EditAddressController.h
//  NingboSat
//
//  Created by ysyc_liu on 16/9/18.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MailAddressController.h"
#import "MailAddressModel.h"
#import "MailInvoiceBlock.h"
/**
 *  新增或编辑收票人地址页.
 */
@interface EditAddressController : UIViewController

@property (nonatomic, strong)MailAddressModel *preAddressModel;

@property (nonatomic, copy)CompleteBlock commitBlock;
@property (nonatomic, copy)CompleteBlock deleteBlock;

@end
