//
//  MapRouteShowViewController.h
//  NingboSat
//
//  Created by 王会洲 on 16/9/27.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BMKRouteLine;

@interface MapRouteShowViewController : UIViewController

- (instancetype)initWithBMKRouteLine:(BMKRouteLine *)routeLine andTitle:(NSString *)title subTitle:(NSString *)subTitle;

@end
