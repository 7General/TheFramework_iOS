//
//  MoreView.h
//  ReadAddress
//
//  Created by admin on 17/5/9.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MoreData.h"


@protocol MoreViewDelegae <NSObject>

@optional
-(void)sureButtonClick:(NSMutableArray *)arry;

@end

@interface MoreView : UIView
@property (nonatomic, weak) id<MoreViewDelegae> delegate;


@end
