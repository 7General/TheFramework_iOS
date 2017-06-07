//
//  bookTimeCell.m
//  NingboSat
//
//  Created by 王会洲 on 16/11/17.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "bookTimeCell.h"
#import "Config.h"

@interface bookTimeCell()



@end


@implementation bookTimeCell
+(instancetype)cellWith:(UITableView *)tableview {
    static NSString * ID = @"bookTimeCell";
    bookTimeCell * cell = [tableview dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[bookTimeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return  cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initCellView];
    }
    return self;
}

-(void)initCellView {
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    CGFloat padding = 15;
    
    CGFloat itemX = padding;
    CGFloat itemY = 18;
    CGFloat itemW = 150;
    CGFloat itemH = 15;
    
    UILabel * itemName = [[UILabel alloc] initWithFrame:CGRectMake(itemX, itemY, itemW, itemH)];
    itemName.text = @"预约时间";
    itemName.textColor = YSColor(136, 136, 136);
    itemName.font = FONTLIGHT(15);
    [self.contentView addSubview:itemName];
    self.itemName = itemName;
    
    CGFloat dateW = 140;
    CGFloat dateH = 15;
    CGFloat dateX = SCREEN_WIDTH - 37 - dateW;
    CGFloat dateY = 10;
    
    UILabel * dateShortStr = [[UILabel alloc] initWithFrame:CGRectMake(dateX, dateY, dateW, dateH)];
    //dateShortStr.text = @"2016-11-17  星期四";
    dateShortStr.textAlignment = NSTextAlignmentRight;
    dateShortStr.textColor = YSColor(80, 80, 80);
    dateShortStr.font = FONTLIGHT(15);
    [self.contentView addSubview:dateShortStr];
    self.dateShortStr = dateShortStr;
    
    CGFloat timeW = 140;
    CGFloat timeH = 15;
    CGFloat timeX = SCREEN_WIDTH - 37 - dateW;
    CGFloat timeY = CGRectGetMaxY(dateShortStr.frame) + 2;
    
    UILabel * timeShortStr = [[UILabel alloc] initWithFrame:CGRectMake(timeX, timeY, timeW, timeH)];
    //timeShortStr.text = @"10:50-11:10";
    timeShortStr.textAlignment = NSTextAlignmentRight;
    timeShortStr.textColor = YSColor(180, 180, 180);
    timeShortStr.font = FONTLIGHT(13);
    [self.contentView addSubview:timeShortStr];
    self.timeShortStr = timeShortStr;
    
}

@end
