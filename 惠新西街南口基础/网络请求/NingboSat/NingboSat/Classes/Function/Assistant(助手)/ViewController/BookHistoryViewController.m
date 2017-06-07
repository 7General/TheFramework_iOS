//
//  BookHistoryViewController.m
//  NingboSat
//
//  Created by 王会洲 on 16/11/29.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "BookHistoryViewController.h"
#import "Config.h"

#import "BookInfoViewController.h"
#import "RequestBase.h"

#import "BookModel.h"
#import "BookCell.h"

@interface BookHistoryViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView * bookHistoryTableView;
/**数据源*/
@property (nonatomic, strong) NSMutableArray * bookHistoryData;
/**预约时间数据源*/
//@property (nonatomic, strong) NSMutableArray * yyrqData;
@end

@implementation BookHistoryViewController

-(NSMutableArray *)bookHistoryData {
    if (_bookHistoryData == nil) {
        _bookHistoryData = [NSMutableArray new];
    }
    return _bookHistoryData;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    [self initData];
}

-(void)initView {
    self.title = @"预约记录";
    self.view.backgroundColor = YSColor(245, 245, 245);
    
    UITableView * bookHistoryTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
    bookHistoryTableView.delegate = self;
    bookHistoryTableView.dataSource = self;
    bookHistoryTableView.tableFooterView = [[UIView alloc] init];
    bookHistoryTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    bookHistoryTableView.backgroundColor = YSColor(245, 245, 245);
    [self.view addSubview:bookHistoryTableView];
    self.bookHistoryTableView = bookHistoryTableView;
}

/**加载预约记录*/
-(void)initData {
    [self.bookHistoryData removeAllObjects];
    NSDictionary * dict = @{@"taxpayer_code":TAXPAYER_CODE,@"yyzt":@"",@"yyrq_q":self.startTime,@"yyrq_z":self.endTime};
    NSDictionary * param = @{@"jsonParam":[dict JSONParamString]};
    [RequestBase requestWith:APITypeBooklistData Param:param Complete:^(YSResponseStatus status, id object) {
        if (status == 0) {
            for (NSDictionary * dict in object[@"content"]) {
                
                BookModel * book = [BookModel bookModelWithDict:dict];
                
                [self.bookHistoryData addObject:book];
                [self.bookHistoryTableView reloadData];
            }
        }
    } ShowOnView:self.view];
}


#pragma mark -TABLEVIEW DELEGATE
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.bookHistoryData.count;
}

-(UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BookCell * cell = [BookCell cellWithTableView:tableView];
    [cell setCellModel:self.bookHistoryData[indexPath.row]];
    return  cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    BookModel * book = self.bookHistoryData[indexPath.row];
    if (book.bswd_mc.length >= 15) {
        return 176 + 30;
    }else {
        return 176;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BookInfoViewController * book = [[BookInfoViewController alloc] init];
    book.cellModel = self.bookHistoryData[indexPath.row];
    [self.navigationController pushViewController:book animated:YES];
}

@end
