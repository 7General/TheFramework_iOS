//
//  MoreView.m
//  ReadAddress
//
//  Created by admin on 17/5/9.
//  Copyright © 2017年 admin. All rights reserved.
//




#import "MoreView.h"
#import "UIButton+FillColor.h"
#import "UIButton+helper.h"
#import "ConfigUI.h"
#import "FilterMannger.h"
#import "MoreCell.h"



@interface MoreView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSDictionary *moreDict;
@property (nonatomic, strong) NSMutableArray *titleData;

@property (nonatomic, strong) NSMutableDictionary *selectData;

@property (nonatomic, strong) NSMutableArray * selectArry;
@property (nonatomic, weak) UITableView *moreTable;

/*! 自定义开始时间 */
@property (nonatomic, strong) NSString *inputFText;
/*! 自定义结束时间 */
@property (nonatomic, strong) NSString *inputTText;
@end

@implementation MoreView

#pragma mark - lazy
-(NSMutableDictionary *)selectData {
    if (_selectData == nil) {
        _selectData = [NSMutableDictionary dictionary];
    }
    return _selectData;
}

-(NSMutableArray *)selectArry {
    if (_selectArry == nil) {
        _selectArry = [NSMutableArray array];
    }
    return _selectArry;
}

-(NSMutableArray *)titleData {
    if (_titleData == nil) {
        _titleData = [NSMutableArray array];
    }
    return _titleData;
}
-(NSDictionary *)moreDict {
    if (_moreDict == nil) {
        _moreDict = [NSDictionary dictionary];
    }
    return _moreDict;
}
-(void)initMoreDataContent {
    
    self.inputFText = @"";
    self.inputTText = @"";
    NSArray * mjd = @[
                      [MoreData moreData:@"95-103㎡" forData:@"" forSatae:@"1"],
                      [MoreData moreData:@"115-117㎡" forData:@"" forSatae:@"1"],
                      [MoreData moreData:@"125-130㎡" forData:@"" forSatae:@"1"],
                      [MoreData moreData:@"167-180㎡" forData:@"" forSatae:@"1"],
                      [MoreData moreData:@"2000以上" forData:@"" forSatae:@"1"]
                      ].mutableCopy;
    NSArray * mj = @[].mutableCopy;
    NSArray * js = @[
                     [MoreData moreData:@"1居" forData:@"" forSatae:@"3"],
                     [MoreData moreData:@"2居" forData:@"" forSatae:@"3"],
                     [MoreData moreData:@"3居" forData:@"" forSatae:@"3"],
                     [MoreData moreData:@"4居" forData:@"" forSatae:@"3"],
                     [MoreData moreData:@"5居" forData:@"" forSatae:@"3"]
                     ].mutableCopy;
    NSArray * cx = @[
                     [MoreData moreData:@"东向" forData:@"" forSatae:@"4"],
                     [MoreData moreData:@"东西" forData:@"" forSatae:@"4"],
                     [MoreData moreData:@"北向" forData:@"" forSatae:@"4"],
                     [MoreData moreData:@"南北" forData:@"" forSatae:@"4"],
                     [MoreData moreData:@"南向" forData:@"" forSatae:@"4"],
                     [MoreData moreData:@"西向" forData:@"" forSatae:@"4"]
                     ].mutableCopy;
    NSArray * zx = @[
                     [MoreData moreData:@"精装" forData:@"" forSatae:@"5"],
                     [MoreData moreData:@"毛坯" forData:@"" forSatae:@"5"]
                     ].mutableCopy;
    NSArray * gjsj = @[
                       [MoreData moreData:@"3天内" forData:@"" forSatae:@"6"],
                       [MoreData moreData:@"4-7天" forData:@"" forSatae:@"6"],
                       [MoreData moreData:@"8-14天" forData:@"" forSatae:@"6"],
                       [MoreData moreData:@"15天以上" forData:@"" forSatae:@"6"]
                       ].mutableCopy;
    NSArray * ewm = @[
                      [MoreData moreData:@"是" forData:@"" forSatae:@"7"],
                      [MoreData moreData:@"否" forData:@"" forSatae:@"7"]
                      ].mutableCopy;
    NSArray * yy = @[
                     [MoreData moreData:@"邀约客户" forData:@"" forSatae:@"8"]
                     ].mutableCopy;
    self.moreDict = @{
                      @"面积段(平方米)":mjd,
                      //@"面积(平方米)":mj,
                      @"最近一次跟进时间":gjsj,
                      @"居室":js
//                      @"朝向":cx,
//                      @"装修":zx
                      //@"是否有二维码":ewm,
                      //@"邀约":yy
                      };
    self.titleData = @[
                       @"面积段(平方米)",
                       //@"面积(平方米)",
                       @"最近一次跟进时间",
                       @"居室"
//                       @"朝向",
//                       @"装修",
                       //@"是否有二维码",
                       //@"邀约"
                       ].mutableCopy;
    
    self.selectData = @{
                        @"面积段(平方米)":@[],
                        //@"面积(平方米)":mj,
                        @"最近一次跟进时间":@[],
                        @"居室":@[]
                        //@"朝向":cx,
                        //@"装修":zx
                        //@"是否有二维码":ewm,
                        //@"邀约":yy
                        }.mutableCopy;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
        [self initMoreDataContent];
        [self initSelectData];
    }
    return self;
}
-(void)initSelectData {
    /*
     @"面积段(平方米)":@[],
     //@"面积(平方米)":mj,
     @"最近一次跟进时间":@[],
     @"居室":@[]
     */
//    NSMutableArray *mjd = [DBTools selectDBValueMoreDataWher:@"1"];
//    NSMutableArray *gjsj = [DBTools selectDBValueMoreDataWher:@"6"];
//    NSMutableArray *js = [DBTools selectDBValueMoreDataWher:@"3"];
//    [self.selectData setObject:mjd forKey:@"面积段(平方米)"];
//    [self.selectData setObject:gjsj forKey:@"最近一次跟进时间"];
//    [self.selectData setObject:js forKey:@"居室"];

}



-(void)initView {
    
    UITableView * moreTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 70) style:UITableViewStylePlain];
    moreTable.delegate = self;
    moreTable.dataSource = self;
    moreTable.tableFooterView = [[UIView alloc] init];
    moreTable.layer.cornerRadius = 8;
    moreTable.layer.masksToBounds = YES;
    moreTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:moreTable];

    self.moreTable = moreTable;
    
    // 清空按钮
    CGFloat cW = 142 * kSCALEWIDTH;
    CGFloat cH = 42;
    CGFloat cX = 22;
    CGFloat cY = self.frame.size.height - 10 - cH;
    
    CGRect CRect = CGRectMake(cX, cY, cW, cH);
    UIButton * clearBtn = [UIButton button:CRect
                                TitleColor:SColor(255, 255, 255)
                                 TitleFont:[UIFont systemFontOfSize:14]
                                      imge:nil
                                  forTitle:@"清空"];
    clearBtn.layer.cornerRadius = 21;
    clearBtn.layer.masksToBounds = YES;
    clearBtn.backgroundColor = SColor(136, 136, 136);
    [clearBtn addTarget:self action:@selector(clearClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:clearBtn];
    
    CGFloat sW = cW;
    CGFloat sH = cH;
    CGFloat sX = self.frame.size.width - 22 - sW;
    CGFloat sY = cY;
    
    
    CGRect sRect = CGRectMake(sX, sY, sW, sH);
    UIButton * sureBtn = [UIButton button:sRect
                               TitleColor:SColor(255, 255, 255)
                                TitleFont:[UIFont systemFontOfSize:14]
                                     imge:nil
                                 forTitle:@"确定"];
    sureBtn.layer.cornerRadius = 21;
    sureBtn.layer.masksToBounds = YES;
    sureBtn.backgroundColor = SColor(47, 150, 255);
    [sureBtn addTarget:self action:@selector(sureClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:sureBtn];
}
/*! 清空 */
-(void)clearClick {
    NSLog(@"clear");
    //[DBTools deleteDBAllInfo];
    [self.selectData removeAllObjects];
    [self.moreTable reloadData];
}
/*! 确认 */
-(void)sureClick {
    NSLog(@"sure");
//    if (!IsStrEmpty(self.inputTText) || IsStrEmpty(self.inputFText)) {
//        [[NSUserDefaults standardUserDefaults ]removeObjectForKey:@"CL"];
//    }
    
    [FilterMannger setInputValue:self.inputFText forTo:self.inputTText];
    // 删库
    //[DBTools deleteDBAllInfo];

    // 存库
    for (NSDictionary * dict in self.selectData) {
        NSArray * values = self.selectData[dict];
        for (MoreData * datas in values) {
            NSString * text = datas.itemText;
            NSString * data = datas.itemData;
            NSString * state = datas.itemState;
           // [DBTools insertDBText:text forData:data forState:state];
        }
    }
    
    
//    NSMutableArray * arr = [DBTools selectDBValueMoreData];
//    
//    if (self.delegate && [self.delegate respondsToSelector:@selector(sureButtonClick:)]) {
//        [self.delegate sureButtonClick:arr];
//    }
}



#pragma mark - UITABLEVIEWDELEGATE
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  self.titleData.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MoreCell * cell = [MoreCell cellWithTable:tableView];
    NSString * key = self.titleData[indexPath.row];
    NSArray * itemAry = self.moreDict[key];
    NSArray * selectItem = self.selectData[key];

    [cell setView:itemAry forState:selectItem forTitle:key];
    
    __weak typeof(self) WeakSelf = self;
    [cell setCellItemBlock:^(UIButton *sender) {
        NSString * btnText = sender.titleLabel.text;
        
        // 1:获取已经选中的数据
        MoreData * currentData = [[MoreData alloc] init];
        for (MoreData * md in itemAry) {
            if ([md.itemText isEqualToString:btnText]) {
                currentData = md;
                break;
            }
        }
        
        NSArray * oldSelectArry = self.selectData[key];
        
        // 2:找当前选中的数据内容
        NSMutableArray * selectStr = [NSMutableArray array];
        for (MoreData * md in oldSelectArry) {
            [selectStr addObject:md.itemText];
        }
        
        // 3:查找当前数据是否在已经选中的数组中
        NSMutableArray  * selectedAry = [[NSMutableArray alloc] initWithArray:oldSelectArry];
        // 如果包含则删除
        if ([selectStr containsObject:btnText]) {
            for (NSInteger index = 0; index < oldSelectArry.count; index++) {
                MoreData * md = oldSelectArry[index];
                if ([md.itemText isEqualToString:btnText]) {
                    [selectedAry removeObjectAtIndex:index];
                    break;
                }
            }
        }else {
            // 添加
            [selectedAry addObject:currentData];
        }
        // 单选控制
        if (indexPath.row == 1) {
            [selectedAry removeAllObjects];
            [selectedAry addObject:currentData];
        }
        
        [WeakSelf.selectData setObject:selectedAry forKey:key];
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        
    }];
    // 清除From单选控制
    [cell setCellToBlock:^(UITextField *field) {

        NSArray * oldSelectArry = self.selectData[key];
        NSMutableArray  * selectedAry = [[NSMutableArray alloc] initWithArray:oldSelectArry];
        [selectedAry removeAllObjects];
        [WeakSelf.selectData setObject:selectedAry forKey:key];
    }];
    
    // 清除To单选控制
    [cell setCellFromBlock:^(UITextField *field) {

        NSArray * oldSelectArry = self.selectData[key];
        NSMutableArray  * selectedAry = [[NSMutableArray alloc] initWithArray:oldSelectArry];
        [selectedAry removeAllObjects];
        [WeakSelf.selectData setObject:selectedAry forKey:key];
    }];
    
    [cell setCellFromEndBlock:^(UITextField *field) {
        self.inputFText = field.text;
    }];
    [cell setCellToEndBlock:^(UITextField *field) {
        self.inputTText = field.text;
    }];
   
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString * key = self.titleData[indexPath.row];
    NSArray * array = self.moreDict[key];
    CGFloat rowHeight = 0.0f;
    if (array.count > 3 && array.count % 3 > 0) {
        rowHeight = ((array.count / 3) + 1) * (30 + 8);
    } else  if ( array.count > 3 && array.count % 3 == 0) {
        rowHeight = ((array.count / 3)) * (30 + 8);
    }
    else if(array.count <= 3) {
        rowHeight =  48;
    }
    return  rowHeight + 49;
}



@end
