//
//  LookCanBookViewController.m
//  NingboSat
//
//  Created by 王会洲 on 16/12/2.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "LookCanBookViewController.h"
#import "Config.h"
#import "RequestBase.h"
#import "ItemListModel.h"
#import "LookDetailViewController.h"

@interface LookCanBookViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, weak) UITableView * lookCanTableView;
/**数据源*/
@property (nonatomic, strong) NSMutableArray * lookCanData;
@end

@implementation LookCanBookViewController
-(NSMutableArray *)lookCanData {
    if (_lookCanData == nil) {
        _lookCanData = [NSMutableArray new];
    }
    return _lookCanData;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    [self initData];
}
-(void)initView {
    self.title = @"可预约事项";
    self.view.backgroundColor = YSColor(245, 245, 245);
    UITableView * lookCanTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, SCREEN_HEIGHT - 10) style:UITableViewStylePlain];
    lookCanTableView.delegate = self;
    lookCanTableView.dataSource = self;
    lookCanTableView.tableFooterView = [[UIView alloc] init];
    lookCanTableView.backgroundColor = YSColor(245, 245, 245);
    [self.view addSubview:lookCanTableView];
    self.lookCanTableView = lookCanTableView;
}
-(void)initData {
    NSDictionary * dict = @{@"":@""};
    NSDictionary * param = @{@"jsonParam":[dict JSONParamString]};
    
    [RequestBase requestWith:APITypeGetBookItemList Param:param Complete:^(YSResponseStatus status, id object) {
        if (status == 0) {
            NSArray * tempArry = object[@"content"];
            for (NSDictionary * dict in tempArry) {
                ItemListModel * model = [ItemListModel itemlistModelWithDict:dict];
                [self.lookCanData addObject:model];
                [self.lookCanTableView reloadData];
            }
        }
    } ShowOnView:self.view];
}
#pragma mark -TABLEVIEW DELEGATE
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.lookCanData.count;
}

-(UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * ID = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    ItemListModel * model = self.lookCanData[indexPath.row];
    cell.textLabel.text = model.mc;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.imageView.image = nil;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    LookDetailViewController * lookDetail = [[LookDetailViewController alloc] init];
    ItemListModel * model = self.lookCanData[indexPath.row];
    lookDetail.yysx_id = L(model.ids);
    lookDetail.titleName = model.mc;
    [self.navigationController pushViewController:lookDetail animated:YES];
}


@end
