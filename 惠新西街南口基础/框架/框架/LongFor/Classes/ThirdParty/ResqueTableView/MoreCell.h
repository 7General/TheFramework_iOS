//
//  MoreCell.h
//  LongFor
//
//  Created by ZZG on 17/5/27.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^cellItemSlect)(UIButton * sender);
typedef void(^cellFromTime)(UITextField *field);
typedef void(^cellToTime)(UITextField *field);

typedef void(^cellFromTimeEnd)(UITextField * field);
typedef void(^cellToTimeEnd)(UITextField *field);


typedef void(^cellClearTimeUpdata)(UITextField *field);

@interface MoreCell : UITableViewCell

+(instancetype)cellWithTable:(UITableView *)tableview;

@property (nonatomic, copy) cellItemSlect  cellItemBlock;

@property (nonatomic, copy) cellFromTime cellFromBlock;
@property (nonatomic, copy) cellToTime cellToBlock;

@property (nonatomic, copy) cellFromTimeEnd cellFromEndBlock;
@property (nonatomic, copy) cellToTimeEnd cellToEndBlock;


@property (nonatomic, copy) cellClearTimeUpdata cellClearUpdateBlock;

-(void)setCellItemBlock:(cellItemSlect)cellItemBlock;

-(void)setCellFromBlock:(cellFromTime)cellFromBlock;
-(void)setCellToBlock:(cellToTime)cellToBlock;

-(void)setCellFromEndBlock:(cellFromTimeEnd)cellFromEndBlock;
-(void)setCellToEndBlock:(cellToTimeEnd)cellToEndBlock;



-(void)setCellClearUpdateBlock:(cellClearTimeUpdata)cellClearUpdateBlock;

-(void)setView:(NSArray *)titleData
      forState:(NSArray *)stateAry
      forTitle:(NSString *)title;





@end
