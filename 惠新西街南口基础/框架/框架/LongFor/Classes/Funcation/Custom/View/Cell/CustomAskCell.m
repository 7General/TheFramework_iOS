//
//  CustomAskCell.m
//  LongFor
//
//  Created by ZZG on 17/5/31.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "CustomAskCell.h"
#import "ConfigUI.h"

@implementation CustomAskCell

+(instancetype)askCellWithTableView:(UITableView *)tableView {
    static NSString * ID = @"ASKCELL";
    CustomAskCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[CustomAskCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        [self initView];
    }
    return self;
}

-(void)setCellWithArray:(NSArray *)array {
    CGFloat padding = 15;
    CGFloat ftX = padding;
    CGFloat ftY = padding;
    CGFloat ftW = 70;
    CGFloat ftH = 16;
    
    for (NSInteger index = 0; index < array.count; index++) {
        UILabel * title = [[UILabel alloc] initWithFrame:CGRectMake(ftX, ftY, ftW, ftH)];
        title.textColor = SColor(0, 0, 0);
        title.text = [NSString stringWithFormat:@"客户需求%ld",index];
        title.font = FONTWITHSIZE_LIGHT(14);
        [self.contentView addSubview:title];
        NSArray * askItem = array[index];
        CGFloat maxY = CGRectGetMaxY(title.frame) + 15;
        CGFloat lasY = [self rankWithTotalColumns:6 forPoinY:maxY andSize:CGSizeMake(50, 15) forArray:askItem];
        ftY += lasY + 10;
    }

}

-(void)initView {
    CGFloat padding = 15;
    
    NSDictionary * dict = @{
                            @"客户需求一":@[@"高层",@"90-120㎡",@"三居",@"中户",@"东向",@"毛坯",@"东向",@"东向",@"东向",@"东向",@"东向",@"东向"],
                            @"客户需求二":@[@"高层",@"90-120㎡",@"三居",@"中户",@"东向",@"毛坯",@"毛坯",@"毛坯",@"毛坯"]
                            }.mutableCopy;
    
    
    CGFloat ftX = padding;
    CGFloat ftY = padding;
    CGFloat ftW = 70;
    CGFloat ftH = 16;
    
    for (NSString * key in dict) {
        UILabel * title = [[UILabel alloc] initWithFrame:CGRectMake(ftX, ftY, ftW, ftH)];
        title.textColor = SColor(0, 0, 0);
        title.text = key;
        title.font = FONTWITHSIZE_LIGHT(14);
        [self.contentView addSubview:title];
        NSArray * askItem = dict[key];
        CGFloat maxY = CGRectGetMaxY(title.frame) + 15;
        CGFloat lasY = [self rankWithTotalColumns:6 forPoinY:maxY andSize:CGSizeMake(50, 15) forArray:askItem];
        ftY += lasY + 10;
        
    }
    
    
    
    
    
    
    
    
    
}


- (CGFloat)rankWithTotalColumns:(int)totalColumns
                       forPoinY:(CGFloat)startY
                        andSize:(CGSize)itemSize
                       forArray:(NSArray *)array
{
    //总列数
    int _totalColumns = totalColumns;
    //view尺寸
    CGFloat appW = itemSize.width;
    CGFloat appH = itemSize.height;
    
    //横向间隙 (控制器view的宽度 － 列数＊应用宽度)/(列数 ＋ 1)
    CGFloat margin = (SCREEN_WIDTH - (_totalColumns * appW)) / (_totalColumns + 1);
    CGFloat lastY = 0.0f;
    
    for (int index = 0; index < array.count; index++) {
        //创建一个小框框//
        UILabel *appView = [[UILabel alloc] init];
        appView.textAlignment = NSTextAlignmentCenter;
        appView.font = FONTWITHSIZE_LIGHT(14);
        appView.textColor = SColor(130, 130, 130);
        appView.adjustsFontSizeToFitWidth = YES;
        appView.text = array[index];
        //        appView.backgroundColor = [UIColor redColor];
        
        //计算框框的位置...行号列号从0开始
        //行号
        int row = index / totalColumns; //行号为框框的序号对列数取商
        //列号
        int col = index % totalColumns; //列号为框框的序号对列数取余
        // 每个框框靠左边的宽度为 (平均间隔＋框框自己的宽度）
        CGFloat appX = margin + col * (appW + margin);
        // 每个框框靠上面的高度为 平均间隔＋框框自己的高度
        CGFloat appY = startY + row * (appH + margin);
        
        appView.frame = CGRectMake(appX, appY, appW, appH);
        [self.contentView addSubview:appView];
        lastY = CGRectGetMaxY(appView.frame);
    }
    
    return lastY;
}
@end
