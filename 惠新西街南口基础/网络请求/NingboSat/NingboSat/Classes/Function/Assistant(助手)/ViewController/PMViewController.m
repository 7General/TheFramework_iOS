//
//  PMViewController.m
//  NingboSat
//
//  Created by 王会洲 on 16/11/24.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "PMViewController.h"
#import "Config.h"
#import "UIView+Addtional.h"


@interface PMViewController ()
@property (nonatomic, weak) UIView * centerView;

@property (nonatomic, assign) NSInteger  leftCurrentTag;
@property (nonatomic, assign) NSInteger  rightCurrentTag;
@end

@implementation PMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView * centerView = [[UIView alloc] initWithFrame:CGRectMake(10, 5, SCREEN_WIDTH - 20, SCREEN_HEIGHT)];
    [self.view addSubview:centerView];
    self.centerView = centerView;
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NotifiResetButton) name:@"AMPOST" object:nil];
}

-(void)NotifiResetButton {
    [self resetButtonStateStep];
}
-(void)dealloc {
    NSLog(@"------dealloc");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)setPMDataArry:(NSMutableArray *)PMDataArry {
    _PMDataArry = PMDataArry;
    for (UIView * view in self.centerView.subviews) {
        [view removeFromSuperview];
    }
    
    
    int appW = (SCREEN_WIDTH - 20) / 3;
    [self rankWithTotalColumns:3 andWithAppW:appW andWithAppH:70 andWithPadding:10 targetView:self.centerView rowData:self.PMDataArry];

}



- (void)rankWithTotalColumns:(int)totalColumns
                 andWithAppW:(int)appW
                 andWithAppH:(int)appH
              andWithPadding:(int)padding
                  targetView:(UIView *)view
                     rowData:(NSMutableArray *)arry
{
    //view尺寸
    CGFloat _appW = appW;
    CGFloat _appH = appH;
    
    //横向间隙 (控制器view的宽度 － 列数＊应用宽度)/(列数 ＋ 1)
    CGFloat margin = padding;
    
    for (int index = 0; index < arry.count; index++) {
        //创建一个小框框//
        UIView *appView = [[UIView alloc] init];
        
        
        //计算框框的位置...行号列号从0开始
        //行号
        int row = index / totalColumns; //行号为框框的序号对列数取商
        //列号
        int col = index % totalColumns; //列号为框框的序号对列数取余
        // 每个框框靠左边的宽度为 (平均间隔＋框框自己的宽度）
        CGFloat appX = col * (appW);
        // 每个框框靠上面的高度为 平均间隔＋框框自己的高度
        CGFloat appY = 10 + row * (appH + margin);
        
        appView.frame = CGRectMake(appX, appY, _appW, _appH);
        appView.layer.borderWidth = 0.5;
        appView.layer.borderColor = YSColor(230, 230, 230).CGColor;
        
        
        SelectBookTimeModel * item = arry[index];
        
        /**预约时间*/
        UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _appW, _appH * 0.5)];
        titleLabel.text = [NSString stringWithFormat:@"%@-%@",item.yysj_q,item.yysj_z];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = YSColor(80, 80, 80);
        titleLabel.font = [UIFont systemFontOfSize:18];
        [appView addSubview:titleLabel];
        
        
        CGFloat booX = 5;
        CGFloat booY = CGRectGetMaxY(titleLabel.frame);
        CGFloat booW = _appW - (5 * 2);
        CGFloat booH = _appH * 0.5 - 5;
        
        UIView * bookView = [[UIView alloc] init];
        bookView.frame = CGRectMake(booX,booY,booW,booH);
        bookView.layer.cornerRadius = 2;
        bookView.layer.masksToBounds = YES;
        bookView.layer.borderWidth = 1;
        [appView addSubview:bookView];
        
        
        /**左边按钮*/
        UIButton * btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn1.tag = 1000 + index;
        btn1.frame = CGRectMake(0, 0, booW * 0.5, booH);
        [btn1 addTarget:self action:@selector(leftBookClick:) forControlEvents:UIControlEventTouchUpInside];
        [bookView addSubview:btn1];
        btn1.layer.borderWidth = 1;
        
        
        /**右边按钮*/
        UIButton * btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn2.tag = 3000 + index;
        btn2.frame = CGRectMake(booW * 0.5, 0, booW * 0.5, booH);
        [btn2 addTarget:self action:@selector(rightBookClick:) forControlEvents:UIControlEventTouchUpInside];
        [bookView addSubview:btn2];
        btn2.layer.borderWidth = 1;
        
        
        /**中间竖线*/
        CGFloat lX = bookView.frame.size.width * 0.5;
        CGFloat lY = 0;
        CGFloat lW = 1;
        CGFloat lH = _appH * 0.5 - 5;
        UIView * line = [[UIView alloc] initWithFrame:CGRectMake(lX, lY, lW, lH)];
        [bookView addSubview:line];
        
        
        /**不可预约状态 全部为灰色*/
        if (2 == item.yyysl) {
            bookView.layer.borderColor = YSColor(230, 230, 230).CGColor;
            line.backgroundColor = YSColor(230, 230, 230);
            
            btn1.backgroundColor = YSColor(245, 245, 245);
            [btn1 setImage:[UIImage imageNamed:@"book_unSelect"] forState:UIControlStateNormal];
            
            btn1.layer.borderColor = YSColor(245, 245, 245).CGColor;
            btn1.userInteractionEnabled = NO;
            
            btn2.backgroundColor = YSColor(245, 245, 245);
            [btn2 setImage:[UIImage imageNamed:@"book_unSelect"] forState:UIControlStateNormal];
            btn2.layer.borderWidth = 1;
            btn2.layer.borderColor = YSColor(245, 245, 245).CGColor;
            btn2.userInteractionEnabled = NO;
            
            btn1.hidden = NO;
            btn2.frame = CGRectMake(booW * 0.5, 0, booW * 0.5, booH);
        }
        
        /**预约次数没满*/
        if ( 1 == item.yyysl ) {
            bookView.layer.borderWidth = 0;
            btn1.layer.borderColor = YSColor(230, 230, 230).CGColor;
            [btn1 setRoundedCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft radius:3];
            [btn1 setImage:[UIImage imageNamed:@"book_unSelect"] forState:UIControlStateNormal];
            btn1.backgroundColor = YSColor(245, 245, 245);
            btn1.userInteractionEnabled = NO;
            
            [btn2 setTitle:@"预约" forState:UIControlStateNormal];
            btn2.titleLabel.font = [UIFont systemFontOfSize:15];
            [btn2 setTitleColor:YSColor(29, 204, 118) forState:UIControlStateNormal];
            btn2.layer.borderColor = YSColor(29, 204, 118).CGColor;
            
            // 已预约数量为1，可能是可预约数量为1
            if (1 == item.kyysl) {
                btn1.hidden = YES;
                btn2.frame = CGRectMake((booW - (booW * 0.5))* 0.5, 0, booW * 0.5, booH);
//                btn1.borderWhich = ViewBorderTop | ViewBorderLeft | ViewBorderBottom ;
            }
        }
        
        /**全部为可预约状态 全部为绿色*/
        if ( 0 == item.yyysl) {
            bookView.layer.borderWidth = 0;
            [btn1 setTitle:@"预约" forState:UIControlStateNormal];
            btn1.titleLabel.font = [UIFont systemFontOfSize:15];
            [btn1 setTitleColor:YSColor(29, 204, 118) forState:UIControlStateNormal];
            btn1.layer.borderColor = YSColor(29, 204, 118).CGColor;
            btn1.borderWhich = ViewBorderTop | ViewBorderLeft | ViewBorderBottom;
            [btn1 setRoundedCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft radius:2];
            
            [btn2 setTitle:@"预约" forState:UIControlStateNormal];
            btn2.titleLabel.font = [UIFont systemFontOfSize:15];
            [btn2 setTitleColor:YSColor(29, 204, 118) forState:UIControlStateNormal];
            btn2.layer.borderColor = YSColor(29, 204, 118).CGColor;
            btn2.borderWhich = ViewBorderTop | ViewBorderLeft | ViewBorderBottom | ViewBorderRight;
            [btn2 setRoundedCorners:UIRectCornerTopRight | UIRectCornerBottomRight radius:2];
            
            // 已预约数量为1，可能是可预约数量为1
            if (1 == item.kyysl) {
                btn1.hidden = YES;
                btn2.frame = CGRectMake((booW - (booW * 0.5))* 0.5, 0, booW * 0.5, booH);
//                btn1.borderWhich = ViewBorderTop | ViewBorderLeft | ViewBorderBottom | ViewBorderRight;
            }
        }
       
        [view addSubview:appView];
    }
}

-(void)leftBookClick:(UIButton *)sender {
    if (self.leftCurrentTag != sender.tag ) {
        [self resetButtonStateStep];
    }
    
    sender.selected = !sender.selected;
    [sender setImage:[UIImage imageNamed:@"book_select"] forState:UIControlStateSelected];
    if (sender.selected) {
        sender.backgroundColor = YSColor(254, 179, 50);
        sender.layer.borderColor = YSColor(242, 153, 0).CGColor;
        sender.borderWhich = ViewBorderTop | ViewBorderLeft | ViewBorderBottom;
        [sender setTitle:@"" forState:UIControlStateSelected];
        
    }else {
        sender.backgroundColor = YSColor(255, 255, 255);
        sender.layer.borderColor = YSColor(29, 204, 118).CGColor;
        sender.borderWhich = ViewBorderTop | ViewBorderLeft | ViewBorderBottom;
    }
    self.leftCurrentTag = sender.tag;
    /**清除右边记录*/
    self.rightCurrentTag = -1;
    
    /**代理传出*/
    if (self.delegate && [self.delegate respondsToSelector:@selector(didselectObjModelPM:)]) {
        SelectBookTimeModel * model = self.PMDataArry[sender.tag - 1000];
        [self.delegate didselectObjModelPM:model];
    }
    
    /**左边按钮发送通知清除上一个选中状态*/
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PMPOST" object:nil];
    
    
}
-(void)rightBookClick:(UIButton *)sender {
    if (self.rightCurrentTag != sender.tag) {
        [self resetButtonStateStep];
    }
    
    
    sender.selected = !sender.selected;
    [sender setImage:[UIImage imageNamed:@"book_select"] forState:UIControlStateSelected];
    if (sender.selected) {
        sender.backgroundColor = YSColor(254, 179, 50);
        sender.layer.borderColor = YSColor(242, 153, 0).CGColor;
        [sender setTitle:@"" forState:UIControlStateSelected];
        sender.borderWhich = ViewBorderTop | ViewBorderLeft | ViewBorderBottom | ViewBorderRight;
    }else {
        sender.backgroundColor = YSColor(255, 255, 255);
        sender.layer.borderColor = YSColor(29, 204, 118).CGColor;
        sender.borderWhich = ViewBorderTop | ViewBorderLeft | ViewBorderBottom | ViewBorderRight;
    }
    self.rightCurrentTag = sender.tag;
    self.leftCurrentTag = -1;
    
    /**代理传出*/
    if (self.delegate && [self.delegate respondsToSelector:@selector(didselectObjModelPM:)]) {
        SelectBookTimeModel * model = self.PMDataArry[sender.tag - 3000];
        [self.delegate didselectObjModelPM:model];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PMPOST" object:nil];
}



/**重置按钮状态*/
-(void)resetButtonStateStep {
    for (UIView *subsubview in self.centerView.subviews){
        for (UIView *TargetView in subsubview.subviews) {
            for (UIView *view in TargetView.subviews) {
                if ([view isKindOfClass:[UIButton class]]) {
                    /**找UIButton*/
                    UIButton * selectBtn = (UIButton *)view;
                    if (selectBtn.selected) {
                        selectBtn.selected = !selectBtn.selected;
                        selectBtn.backgroundColor = YSColor(255, 255, 255);
                        selectBtn.layer.borderColor = YSColor(29, 204, 118).CGColor;
                        /**左边之前点击*/
                        if (selectBtn.tag >= 3000) {
                            selectBtn.borderWhich = ViewBorderTop | ViewBorderLeft | ViewBorderBottom | ViewBorderRight;
                        }else {
                            selectBtn.borderWhich = ViewBorderTop | ViewBorderLeft | ViewBorderBottom;
                        }
                    }
                }
            }
        }
    }
}

@end
