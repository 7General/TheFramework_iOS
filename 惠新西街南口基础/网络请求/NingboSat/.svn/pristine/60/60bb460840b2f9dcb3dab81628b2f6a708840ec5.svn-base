//
//  MapPointList.m
//  NingboSat
//
//  Created by 王会洲 on 16/10/6.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "MapPointList.h"
#import "Masonry.h"
#import "Config.h"

#import "BMKShapeHelper.h"
#import "reveModel.h"



@interface MapPointList()<MapShowCellDelegate>
@property (nonatomic, weak) UITableView * MapPointTable;
@end

@implementation MapPointList


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.isClickListBtn = NO;
        self.backgroundColor = YSColor(255, 255, 255);
        [self initView];
        self.mapPointArry = [[NSMutableArray alloc] init];
        self.layer.masksToBounds = YES;
    }
    return self;
}


-(void)initView {
    UIImageView * arrowView = [[UIImageView alloc] init];
    [self addSubview:arrowView];
    arrowView.image = [UIImage imageNamed:@"map_route_arrow"];
    [arrowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(4);
        make.size.mas_equalTo(arrowView.image.size);
    }];
    
    UIView * arrowBgView = [[UIView alloc] init];
    [self addSubview:arrowBgView];
    arrowBgView.layer.cornerRadius = 6;
    arrowBgView.layer.borderColor = YSColor(0xe6, 0xe6, 0xe6).CGColor;
    arrowBgView.layer.borderWidth = 0.5;
    [arrowBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(-5);
        make.centerX.equalTo(arrowView);
        make.width.mas_equalTo(arrowView.mas_width).offset(40);
        make.height.mas_equalTo(30);
    }];
    /**添加单击事件回收面板*/
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissArrowBgView)];
    tapGesture.cancelsTouchesInView = NO;
    [arrowBgView addGestureRecognizer:tapGesture];
    

    CGRect rect = CGRectMake(0, 30, self.frame.size.width, self.frame.size.height);
    UITableView * MapPointTable = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    MapPointTable.delegate = self;
    MapPointTable.dataSource =self;
    [self addSubview:MapPointTable];
    self.MapPointTable = MapPointTable;
}

#pragma mark -TABLEVIEW DELEGATE
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.mapPointArry.count;
}

-(UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MapShowCell * cell = [MapShowCell cellWith:tableView];
    cell.delegate = self;
    BMKShapeHelper * item =  self.mapPointArry[indexPath.row];
    reveModel * SingItems = item.customDict;
    [cell setCellModelInfo:SingItems complated:nil];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //cell.indexRow = indexPath.row;
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 225;
}

// 设置距离左右各10的距离
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.MapPointTable setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

-(void)layoutSubviews {
    [super layoutSubviews];
    if ([self.MapPointTable respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.MapPointTable setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    if ([self.MapPointTable respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.MapPointTable setLayoutMargins:UIEdgeInsetsZero];
    }
}


-(void)setMapPointArry:(NSMutableArray *)mapPointArry {
    _mapPointArry = mapPointArry;
    [self.MapPointTable reloadData];
}

/**cell的代理函数在执行代理函数传递*/
-(void)CellPusviewControllerwithData:(reveModel *)reve {
    if (self.delegate && [self.delegate respondsToSelector:@selector(locationPointswithModel:)]) {
        [self.delegate locationPointswithModel:reve];
    }
}
/**我要预约*/
-(void)CellClickWithIndexRow:(reveModel *)reve {
    
//    if (![NSObject isLogin]) {
//        [self unReachable];
//        return;
//    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(pushBookVCWithModel:)]) {
        [self.delegate pushBookVCWithModel:reve];
    }
}

//- (void)unReachable {
//    YSAlertView *alertView = [YSAlertView alertWithTitle:nil message:@"该模块需要登录才能使用，是否立即登录？" buttonTitles:@"稍后", @"立即登录", nil];
//    [alertView show];
//    [alertView alertButtonClick:^(NSInteger buttonIndex) {
//        if (buttonIndex == 1) {
//            [self presentViewController:[LoginViewController new] animated:YES completion:^{
//            }];
//        }
//    }];
//}

/**回收面板*/
-(void)dismissArrowBgView {
    [UIView animateWithDuration:0.25 animations:^{
        CGRect rect = self.frame;
        rect.origin.y = SCREEN_HEIGHT;
        self.frame = rect;
        self.isClickListBtn = NO;
    }];
}




@end
