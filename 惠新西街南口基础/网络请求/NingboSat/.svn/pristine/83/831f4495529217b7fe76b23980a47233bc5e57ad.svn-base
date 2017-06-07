//
//  MapShowCell.h
//  NingboSat
//
//  Created by 王会洲 on 16/10/6.
//  Copyright © 2016年 王会洲. All rights reserved.
//

/**税局信息cell*/
#import <UIKit/UIKit.h>
#import "reveModel.h"
#import <BaiduMapAPI_Location/BMKLocationComponent.h>

@protocol MapShowCellDelegate <NSObject>

-(void)CellPusviewControllerwithData:(reveModel *)reve;
/**跳转预约页面*/
-(void)CellClickWithIndexRow:(reveModel * )reve;

@end

@interface MapShowCell : UITableViewCell

@property (nonatomic, weak) id<MapShowCellDelegate>  delegate;

+(instancetype)cellWith:(UITableView *)tableview;
-(void)setCellModelInfo:(reveModel *)model complated:(void(^)(reveModel * model))complated;


@property (nonatomic, weak) UIImageView * titleImgeView;
@property (nonatomic, weak) UILabel * names;
@property (nonatomic, weak) UILabel * addressTitle;
@property (nonatomic, weak) UILabel * address;
@property (nonatomic, weak) UILabel * windowN;
@property (nonatomic, weak) UILabel * distaces;
@property (nonatomic, weak) UILabel * vge;
@property (nonatomic, weak) UIView * hotRate; // 热度.
@property (nonatomic, weak) UILabel * updateTime;
/**预约人数*/
@property (nonatomic, weak) UILabel * yyrs;
/**待办人数*/
@property (nonatomic, weak) UILabel * dbrs;

@property (nonatomic, weak) UILabel * phone;
@property (nonatomic, weak) UILabel * times;

/**当前讯中Model*/
@property (nonatomic, strong)reveModel * selectModel;
@end
