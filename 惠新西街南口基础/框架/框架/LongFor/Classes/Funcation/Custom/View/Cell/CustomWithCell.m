
//
//  CustomWithCell.m
//  LongFor
//
//  Created by ZZG on 17/5/31.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "CustomWithCell.h"
#import "ConfigUI.h"

@interface CustomWithCell()

@property (nonatomic, weak) UILabel * djysV;
@property (nonatomic, weak) UILabel * dfcsV;
@property (nonatomic, weak) UILabel * dbV;
@property (nonatomic, weak) UILabel * kxV;

@end

@implementation CustomWithCell
+(instancetype)withAskCellWithTableView:(UITableView *)tableView {
    static NSString * ID = @"withAsk";
    CustomWithCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[CustomWithCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}


-(void)initView {
    CGFloat padding = 15;
    
    CGFloat djX = padding;
    CGFloat djY = padding;
    CGFloat djW = 86;
    CGFloat djH = 14;
    UILabel * djys = [[UILabel alloc] initWithFrame:CGRectMake(djX, djY, djW, djH)];
    djys.textColor = SColor(0, 0, 0);
    djys.text = @"客户姓名";
    djys.font = FONTWITHSIZE_LIGHT(14);
    [self.contentView addSubview:djys];
    
    CGFloat djVX = CGRectGetMaxX(djys.frame) + 38;
    CGFloat djVY = djY;
    CGFloat djVW = 86;
    CGFloat djVH = 14;
    UILabel * djysV = [[UILabel alloc] initWithFrame:CGRectMake(djVX, djVY, djVW, djVH)];
    djysV.textColor = SColor(129, 129, 129);
    djysV.text = @"王会洲";
    djysV.font = FONTWITHSIZE_LIGHT(14);
    [self.contentView addSubview:djysV];
    self.djysV = djysV;
    
    
    
    
    CGFloat dfcsX = djX;
    CGFloat dfcsY = CGRectGetMaxY(djys.frame) + 15;
    CGFloat dfcsW = 86;
    CGFloat dfcsH = 14;
    UILabel * dfcs = [[UILabel alloc] initWithFrame:CGRectMake(dfcsX, dfcsY, dfcsW, dfcsH)];
    dfcs.textColor = SColor(0, 0, 0);
    dfcs.text = @"电话";
    dfcs.font = FONTWITHSIZE_LIGHT(14);
    [self.contentView addSubview:dfcs];
    
    CGFloat dfcsVX = djVX;
    CGFloat dfcsVY = dfcsY;
    CGFloat dfcsVW = 86;
    CGFloat dfcsVH = 14;
    UILabel * dfcsV = [[UILabel alloc] initWithFrame:CGRectMake(dfcsVX, dfcsVY, dfcsVW, dfcsVH)];
    dfcsV.textColor = SColor(129, 129, 129);
    dfcsV.text = @"15010206793";
    dfcsV.font = FONTWITHSIZE_LIGHT(14);
    [self.contentView addSubview:dfcsV];
    self.dfcsV = dfcsV;
    
    
    
    
    CGFloat dbX = dfcsX;
    CGFloat dbY = CGRectGetMaxY(dfcs.frame) + 15;
    CGFloat dbW = 86;
    CGFloat dbH = 14;
    UILabel * db = [[UILabel alloc] initWithFrame:CGRectMake(dbX, dbY, dbW, dbH)];
    db.textColor = SColor(0, 0, 0);
    db.text = @"证件类型";
    db.font = FONTWITHSIZE_LIGHT(14);
    [self.contentView addSubview:db];
    
    CGFloat dbVX = dfcsVX;
    CGFloat dbVY = dbY;
    CGFloat dbVW = 86;
    CGFloat dbVH = 14;
    UILabel * dbV = [[UILabel alloc] initWithFrame:CGRectMake(dbVX, dbVY, dbVW, dbVH)];
    dbV.textColor = SColor(129, 129, 129);
    dbV.text = @"身份证";
    dbV.font = FONTWITHSIZE_LIGHT(14);
    [self.contentView addSubview:dbV];
    self.dbV = dbV;
    
    
    CGFloat kxX = dbX;
    CGFloat kxY = CGRectGetMaxY(db.frame) + 15;
    CGFloat kxW = 86;
    CGFloat kxH = 14;
    UILabel * kx = [[UILabel alloc] initWithFrame:CGRectMake(kxX, kxY, kxW, kxH)];
    kx.textColor = SColor(0, 0, 0);
    kx.text = @"证件号码";
    kx.font = FONTWITHSIZE_LIGHT(14);
    [self.contentView addSubview:kx];
    
    CGFloat kxVX = dbVX;
    CGFloat kxVY = kxY;
    CGFloat kxVW = 200;
    CGFloat kxVH = 14;
    UILabel * kxV = [[UILabel alloc] initWithFrame:CGRectMake(kxVX, kxVY, kxVW, kxVH)];
    kxV.textColor = SColor(129, 129, 129);
    kxV.text = @"122345678990098876";
    kxV.font = FONTWITHSIZE_LIGHT(14);
    [self.contentView addSubview:kxV];
    self.kxV = kxV;
    
}

-(void)setCellRelativeData:(RelativeModel *)rm {
    self.djysV.text = rm.names;
    self.dfcsV.text = rm.tel;
    self.dbV.text = rm.zjlx;
    self.kxV.text = rm.zjhm;
}


@end
