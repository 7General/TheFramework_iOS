//
//  MineHeadView.h
//  NingboSat
//
//  Created by 田广 on 16/9/20.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MineHeadViewDelegate <NSObject>

-(void)loginButtonClicked:(UIButton *)sender;

@end

@interface MineHeadView : UIView

@property (nonatomic,assign)id<MineHeadViewDelegate>delegate;
@property (nonatomic, weak) UILabel * nameLabel;

- (instancetype)initWithFrame:(CGRect)frame;

@end
