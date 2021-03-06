//
//  BookItemViewController.m
//  NingboSat
//
//  Created by 王会洲 on 16/11/17.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "BookItemViewController.h"
#import "Config.h"
#import "BookItemCell.h"
#import "RequestBase.h"
#import "BookSpecMdoel.h"
#import "BookSpecFrame.h"

@interface BookItemViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, weak) UITableView * bookItemTableView;

/**数据源*/
@property (nonatomic, strong) NSMutableArray * bookSpecData;
@end

@implementation BookItemViewController

-(NSMutableArray *)bookSpecData {
    if (_bookSpecData == nil) {
        _bookSpecData = [NSMutableArray new];
    }
    return _bookSpecData;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = YSColor(245, 245, 245);
    self.title = self.titleName;
    [self initView];
    [self initData];
}

-(void)initView {
    UITableView * bookItemTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, SCREEN_HEIGHT - 74) style:UITableViewStylePlain];
    bookItemTableView.delegate = self;
    bookItemTableView.dataSource = self;
    bookItemTableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:bookItemTableView];
    self.bookItemTableView = bookItemTableView;
}
-(void)setReadSpecBlock:(readSpecifics)readSpecBlock {
    _readSpecBlock = [readSpecBlock copy];
}


-(void)initData {
    NSDictionary * dict = @{@"taxpayer_code":TAXPAYER_CODE,@"yysx":self.bswd_id,@"bswd_id":@""};
    [self.bookSpecData removeAllObjects];
    
    NSDictionary * param = @{@"jsonParam":[dict JSONParamString]};
    [RequestBase requestWith:APITypeBookItemSepcFile Param:param Complete:^(YSResponseStatus status, id object) {
        if (status == YSResponseStatusSuccess) {
            for (NSDictionary * dict in object[@"content"]) {
                BookSpecMdoel * model = [BookSpecMdoel bookSpecModelWithDict:dict];
                BookSpecFrame * frames = [[BookSpecFrame alloc] init];
                frames.specModel = model;
                [self.bookSpecData addObject:frames];
                [self.bookItemTableView reloadData];
            }
        }
    } ShowOnView:self.view];
}

#pragma mark -TABLEVIEW DELEGATE
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.bookSpecData.count;
}

-(UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BookItemCell * cell = [BookItemCell cellWithTableView:tableView];
    cell.SpecFrame = self.bookSpecData[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    BookSpecFrame * frams = self.bookSpecData[indexPath.row];
    return frams.cellHeight;
}
// 点击完成即可返回
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BookSpecFrame * frams = self.bookSpecData[indexPath.row];
    BookSpecMdoel * model = frams.specModel;
    if (self.readSpecBlock) {
        self.readSpecBlock(L(model.qstb),model.mc,L(model.ids),L(model.cnnid),L(model.docid));
    }
    [self.navigationController popViewControllerAnimated:YES];
}





@end
