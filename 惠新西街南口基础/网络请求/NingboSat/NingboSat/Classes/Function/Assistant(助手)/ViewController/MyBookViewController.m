//
//  MyBookViewController.m
//  NingboSat
//
//  Created by 王会洲 on 16/11/28.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "MyBookViewController.h"
#import "Config.h"

#import "BookInfoViewController.h"
#import "RequestBase.h"

#import "BookHistoryViewController.h"
#import "BookModel.h"
#import "BookCell.h"
#import "BookSearchViewController.h"

@interface MyBookViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView * MyBookTableView;
/**数据源*/
@property (nonatomic, strong) NSMutableArray * MyBookData;
/**预约时间数据源*/
@property (nonatomic, strong) NSMutableArray * yyrqData;

@end

@implementation MyBookViewController

-(NSMutableArray *)MyBookData {
    if (_MyBookData == nil) {
        _MyBookData = [NSMutableArray new];
    }
    return _MyBookData;
}
-(NSMutableArray *)yyrqData {
    if (_yyrqData == nil) {
        _yyrqData = [NSMutableArray new];
    }
    return _yyrqData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    [self initData];
}

-(void)initView {
    self.title = @"我的预约";
    self.view.backgroundColor = YSColor(245, 245, 245);
    /**预约记录*/
    UIButton * myBook = [UIButton buttonWithType:UIButtonTypeCustom];
    myBook.frame = CGRectMake(0, 0, 80, 50);
    myBook.titleLabel.font = FONTLIGHT(15);
    myBook.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -35);
    [myBook setTitleColor:YSColor(88, 207, 252) forState:UIControlStateNormal];
    [myBook addTarget:self action:@selector(myBookClick) forControlEvents:UIControlEventTouchUpInside];
    [myBook setTitle:@"预约记录" forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:myBook];
    
    UITableView * MyBookTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 ) style:UITableViewStylePlain];
    MyBookTableView.delegate = self;
    MyBookTableView.dataSource = self;
    MyBookTableView.tableFooterView = [[UIView alloc] init];
    MyBookTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    MyBookTableView.backgroundColor = YSColor(245, 245, 245);
    [self.view addSubview:MyBookTableView];
    
    self.MyBookTableView = MyBookTableView;
}

/**加载预约记录*/
-(void)initData {
    [self.MyBookData removeAllObjects];
    [self.yyrqData removeAllObjects];
    NSDictionary * dict = @{@"taxpayer_code":TAXPAYER_CODE,@"yyzt":@"1",@"yyrq_q":@"",@"yyrq_z":@""};
    NSDictionary * param = @{@"jsonParam":[dict JSONParamString]};
    [RequestBase requestWith:APITypeBooklistData Param:param Complete:^(YSResponseStatus status, id object) {
        if (status == 0) {
            for (NSDictionary * dict in object[@"content"]) {
                BookModel * model = [BookModel bookModelWithDict:dict];
                [self.MyBookData addObject:model];
                [self.MyBookTableView reloadData];
            }
        }
    } ShowOnView:self.view];
}

/**我的预约记录*/
-(void)myBookClick {
    BookSearchViewController * bookSe = [[BookSearchViewController alloc] init];
    [self.navigationController pushViewController:bookSe animated:YES];
}

#pragma mark -TABLEVIEW DELEGATE
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.MyBookData.count;
}

-(UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BookCell * cell = [BookCell cellWithTableView:tableView];
    [cell setCellModel:self.MyBookData[indexPath.row]];
    return  cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    BookModel * model = self.MyBookData[indexPath.row];
    if (model.bswd_mc.length >= 15) {
        return 176 + 30;
    }else {
       return 176;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BookInfoViewController * book = [[BookInfoViewController alloc] init];
    book.cellModel = self.MyBookData[indexPath.row];

    [book setChangeBlock:^(NSInteger ids) {
        BookCell * cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.stateRun.text = @"已取消";
        cell.imgeIcon.image = [UIImage imageNamed:@"run_cancle"];
        BookModel * model = self.MyBookData[indexPath.row];
        model.yyzt = 2;
    }];
    [self.navigationController pushViewController:book animated:YES];
}




@end
