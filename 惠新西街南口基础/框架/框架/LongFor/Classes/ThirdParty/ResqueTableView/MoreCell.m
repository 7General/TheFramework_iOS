//
//  MoreCell.m
//  LongFor
//
//  Created by ZZG on 17/5/27.
//  Copyright © 2017年 admin. All rights reserved.
//


#define INPUTTO [FilterMannger valueInputFrom]
#define INPUTFROM [FilterMannger valueInputTo]

#import "MoreCell.h"
#import "UIButton+FillColor.h"
#import "ConfigUI.h"
#import "MoreData.h"


@interface MoreCell()<UITextFieldDelegate>

@property (nonatomic, strong) NSMutableArray * selectArry;

@property (nonatomic, weak) UIView *customIputView;

//
@property (nonatomic, weak) UITextField *inputFrom;
@property (nonatomic, weak) UITextField *inputTo;


@end

@implementation MoreCell

-(NSMutableArray *)selectArry {
    if (_selectArry == nil) {
        _selectArry = [NSMutableArray array];
    }
    return _selectArry;
}


+(instancetype)cellWithTable:(UITableView *)tableview {
    static NSString * ID = @"ID";
    MoreCell * cell = [tableview dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[MoreCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    } else {
        // 当页面拉动的时候 当cell存在并且最后一个存在 把它进行删除就出来一个独特的cell我们在进行数据配置即可避免
        while ([cell.contentView.subviews lastObject] != nil) {
            [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

-(void)setView:(NSArray *)titleData
      forState:(NSArray *)stateAry
      forTitle:(NSString *)title {
    
    
    NSMutableArray * SelectedArry = [NSMutableArray array];
    for (MoreData * md in stateAry) {
        [SelectedArry addObject:md.itemText];
    }
    
    UIView * lineV = [[UIView alloc] init];
    lineV.frame = CGRectMake(20, 20, 3, 14);
    lineV.backgroundColor = SColor(47, 150, 254);
    [self.contentView addSubview:lineV];
    
    CGFloat tY = 20;
    CGFloat tH = 14;
    
    UILabel * titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(CGRectGetMaxX(lineV.frame) + 10, tY, 150, tH);
    titleLabel.textColor = SColor(0, 0, 0);
    titleLabel.font = [UIFont systemFontOfSize:13];
    titleLabel.text = title;
    [self.contentView addSubview:titleLabel];
    
    
    //总列数
    int totalColumns = 3;
    //view尺寸
    CGFloat appW = 95 * kSCALEWIDTH;
    CGFloat appH = 30;
    
    //横向间隙 (控制器view的宽度 － 列数＊应用宽度)/(列数 ＋ 1)
    CGFloat margin = (SCREEN_WIDTH - 20 - (totalColumns * appW)) / (totalColumns + 1);
    
    CGFloat basicHeight = CGRectGetMaxY(titleLabel.frame) + 15;
    
    
    for (int index = 0; index < titleData.count; index++) {
        //创建一个小框框//
        MoreData * dm = titleData[index];
        NSString * buttonTitle = dm.itemText;
        UIButton * selectButton = [[UIButton alloc] init];
        selectButton.titleLabel.font = [UIFont systemFontOfSize:14];
        selectButton.layer.cornerRadius = 15;
        selectButton.layer.masksToBounds = YES;
        selectButton.layer.borderWidth = 1;
        
        selectButton.layer.borderColor = SColor(237, 237, 237).CGColor;
        [selectButton setTitle:buttonTitle forState:UIControlStateNormal];
        [selectButton setBackgroundColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [selectButton setTitleColor:SColor(125, 125, 125) forState:UIControlStateNormal];
        
        [selectButton setBackgroundColor:SColor(47, 150, 255) forState:UIControlStateSelected];
        [selectButton setTitleColor:SColor(255, 255, 255) forState:UIControlStateSelected];
        
        selectButton.titleLabel.adjustsFontSizeToFitWidth = YES;
        [selectButton addTarget:self action:@selector(itemSelectClick:) forControlEvents:UIControlEventTouchUpInside];
        //行号
        int row = index / totalColumns; //行号为框框的序号对列数取商
        //列号
        int col = index % totalColumns; //列号为框框的序号对列数取余
        // 每个框框靠左边的宽度为 (平均间隔＋框框自己的宽度）
        CGFloat appX = margin + col * (appW + margin);
        // 每个框框靠上面的高度为 平均间隔＋框框自己的高度
        CGFloat appY = basicHeight + row * (appH + 5);
        selectButton.frame = CGRectMake(appX, appY, appW, appH);
        
        [self.contentView addSubview:selectButton];
        
        if ([SelectedArry containsObject:buttonTitle]) {
            selectButton.selected = YES;
        }
    }
    
    
    // 自定义
    if ([title isEqualToString:@"最近一次跟进时间"]) {
        UIView * cusom = [[UIView alloc] init];
        cusom.layer.cornerRadius = 15;
        cusom.layer.masksToBounds = YES;
        cusom.layer.borderWidth = 1;
        cusom.layer.borderColor = SColor(237, 237, 237).CGColor;
        CGFloat cY = basicHeight + 1 * (appH + 5);
        CGFloat appX = margin + 1 * (appW + margin);
        cusom.frame = CGRectMake(appX, cY , appW * 2 + margin, appH);
        [self.contentView addSubview:cusom];
        self.customIputView = cusom;

        // input1
        UITextField * inputFrom = [[UITextField alloc] init];
        inputFrom.delegate = self;
        inputFrom.font = [UIFont systemFontOfSize:14];
        inputFrom.keyboardType = UIKeyboardTypeNumberPad;
        inputFrom.textAlignment = NSTextAlignmentCenter;
        inputFrom.placeholder = @"自定义";
        [inputFrom setValue:SColor(189, 189, 189) forKeyPath:@"_placeholderLabel.textColor"];
        [inputFrom setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
        CGFloat inputW = CGRectGetWidth(cusom.frame);
        inputFrom.frame = CGRectMake(0, 0, inputW * 0.5 - 10, appH);
        [cusom addSubview:inputFrom];
        self.inputFrom = inputFrom;
        
        if (!IsStrEmpty(INPUTFROM)) {
            self.inputFrom.text = INPUTFROM;
        }

        
        UILabel * heri = [[UILabel alloc] init];
        heri.textAlignment = NSTextAlignmentCenter;
        heri.textColor = SColor(120, 120, 120);
        heri.text = @"-";
        heri.frame = CGRectMake(inputW * 0.5 - 10, 0, 20, appH);
        [cusom addSubview:heri];
        // input2
        UITextField * inputTo = [[UITextField alloc] init];
        inputTo.delegate = self;
        inputTo.font = [UIFont systemFontOfSize:14];
        inputTo.keyboardType = UIKeyboardTypeNumberPad;
        inputTo.textAlignment = NSTextAlignmentCenter;
        inputTo.placeholder = @"自定义";
        [inputTo setValue:SColor(189, 189, 189) forKeyPath:@"_placeholderLabel.textColor"];
        [inputTo setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
        inputTo.frame = CGRectMake(inputW * 0.5 + 10, 0, inputW * 0.5 - 10, appH);
        [cusom addSubview:inputTo];
        self.inputTo = inputTo;

        
        if (!IsStrEmpty(INPUTTO)) {
            self.inputTo.text = INPUTTO;
        }
        if (stateAry.count > 0) {
            self.inputTo.text = @"";
            self.inputFrom.text = @"";
        }
        
        
    
        
    }else {
        self.customIputView.hidden = YES;
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField == self.inputTo) {
        if (self.cellToBlock) {
            self.cellToBlock(textField);
        }
    }
    if (textField == self.inputFrom) {
        if (self.cellFromBlock) {
            self.cellFromBlock(textField);
        }
    }
    [self resetCellState];
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField == self.inputTo) {
        if (self.cellToEndBlock) {
            self.cellToEndBlock(textField);
        }
    }
    if (textField == self.inputFrom) {
        if (self.cellFromEndBlock) {
            self.cellFromEndBlock(textField);
        }
    }
}

-(void)setCellFromEndBlock:(cellFromTimeEnd)cellFromEndBlock {
    _cellFromEndBlock = [cellFromEndBlock copy];
}
-(void)setCellToEndBlock:(cellToTimeEnd)cellToEndBlock {
    _cellToEndBlock = [cellToEndBlock copy];
}


-(void)setCellItemBlock:(cellItemSlect)cellItemBlock {
    _cellItemBlock = [cellItemBlock copy];
}
-(void)setCellFromBlock:(cellFromTime)cellFromBlock {
    _cellFromBlock = [cellFromBlock copy];
}
-(void)setCellToBlock:(cellToTime)cellToBlock {
    _cellToBlock = [cellToBlock copy];
}
-(void)setCellClearUpdateBlock:(cellClearTimeUpdata)cellClearUpdateBlock {
_cellClearUpdateBlock = [cellClearUpdateBlock copy];
}


-(void)itemSelectClick:(UIButton *)button {
    button.selected = !button.selected;
    NSString * text = button.titleLabel.text;
    NSLog(@"-----%@",text);
    [[NSUserDefaults standardUserDefaults] setObject:@"e" forKey:@"CL"];
    if (button.selected) {
        [self.selectArry addObject:text];
    }else {
        [self.selectArry removeObject:text];
    }
    
    if (self.cellItemBlock) {
        self.cellItemBlock(button);
    }
}



/**
 重置按钮选中状态
 */
-(void)resetCellState {
    for (UIView * view in self.contentView.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton * btn = (UIButton *)view;
            btn.selected = NO;
        }
    }
}



@end
