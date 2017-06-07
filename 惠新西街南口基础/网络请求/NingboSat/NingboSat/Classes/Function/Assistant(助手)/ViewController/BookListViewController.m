//
//  BookListViewController.m
//  NingboSat
//
//  Created by 王会洲 on 16/11/17.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "BookListViewController.h"
#import "Config.h"
#import "BookItemViewController.h"
#import "RequestBase.h"
#import "ItemListModel.h"

@interface BookListViewController ()<UITableViewDelegate,UITableViewDataSource>
/**可预约事项*/
@property (nonatomic, weak) UITableView * bookListTableView;

/**列表数据*/
@property (nonatomic, strong) NSMutableArray * dataList;
/**图片列表*/
@property (nonatomic, strong) NSMutableArray * pngList;

@end

@implementation BookListViewController
-(NSArray *)dataList {
    if (!_dataList) {
        _dataList = [NSMutableArray new];
    }
    return _dataList;
}
-(NSArray *)pngList {
    if (!_pngList) {
        _pngList = [NSMutableArray new];
    }
    return _pngList;
}





- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"可预约事项";
    [self initVIew];
    
    self.pngList = @[@"swdj",@"swrd",@"fpbl",@"sbns",@"yhbl",@"zmbl"].mutableCopy;
    [self setDataTypeShow];
}
/**设置显示情况*/
-(void)setDataTypeShow{
    if (NetCheckList == self.showType) {
        [self initData];
    }else {
        self.dataList = @[@"税务登记",@"税务认定",@"发票办理",@"申报纳税",@"优惠办理",@"证明办理"].mutableCopy;
    }
}

/**获取可预约事项*/
-(void)initData {
    [self.dataList removeAllObjects];
    NSDictionary * dict = @{@"":@""};
    NSDictionary * param =@{@"jsonParam" : [dict JSONParamString]};
    [RequestBase  requestWith:APITypeGetBookItemList Param:param Complete:^(YSResponseStatus status, id object) {
        if (status == YSResponseStatusSuccess) {
            NSArray * tempArry = object[@"content"];
            for (NSDictionary * dict in tempArry) {
                ItemListModel * model = [ItemListModel itemlistModelWithDict:dict];
                [self.dataList addObject:model];
                [self.bookListTableView reloadData];
            }
        }
    } ShowOnView:self.view];
}

-(void)setReadSpecBlock:(readSpecific)readSpecBlock {
    _readSpecBlock = [readSpecBlock copy];
}

-(void)initVIew {
    self.view.backgroundColor = YSColor(245, 245, 245);
    UITableView * bookListTableView  = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 74) style:UITableViewStyleGrouped];
    bookListTableView.backgroundColor = YSColor(245, 245, 245);
    bookListTableView.delegate = self;
    bookListTableView.dataSource = self;
    bookListTableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:bookListTableView];
    self.bookListTableView = bookListTableView;
}


#pragma mark -TABLEVIEW DELEGATE
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

-(UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * ID = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (self.showType == NetCheckList) {
        ItemListModel * model = self.dataList[indexPath.row];
        cell.textLabel.text = model.mc;
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.imageView.image = nil;
    }else {
        cell.textLabel.text = self.dataList[indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",self.pngList[indexPath.row]]];
    }
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BookItemViewController * item = [[BookItemViewController alloc] init];
    
    if (self.showType == NetCheckList) {
        ItemListModel * model = self.dataList[indexPath.row];
        if (self.readSpecBlock) {
            self.readSpecBlock(L(model.ids),model.mc);
        }
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self.navigationController pushViewController:item animated:YES];
    }
}


@end
