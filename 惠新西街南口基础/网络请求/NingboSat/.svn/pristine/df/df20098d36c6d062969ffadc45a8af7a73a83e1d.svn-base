//
//  GuideViewController.h
//  NingboSat
//
//  Created by 王会洲 on 16/9/26.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GuideViewControllerDelegate <NSObject>
/**跳转*/
-(void)customPusviewController:(NSString *)url;

@end

@interface GuideViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, assign) id<GuideViewControllerDelegate>  delegate;

@end
