//
//  BookFootView.h
//  NingboSat
//
//  Created by 王会洲 on 16/11/17.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookFootView : UIView

/**查看所需要的资料*/
@property (nonatomic, weak) UIButton * needFile;
/**查看可预约的事项*/
@property (nonatomic, weak) UIButton * bookItem;
/**更新约束*/
-(void)updateButtonMASON;
/**复位约束*/
-(void)resetButtonMASON;

@end
