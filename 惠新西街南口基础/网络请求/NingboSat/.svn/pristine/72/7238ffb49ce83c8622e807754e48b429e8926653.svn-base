//
//  TaxSearchResultController.m
//  NingboSat
//
//  Created by ysyc_liu on 16/9/21.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "TaxSearchResultController.h"
#import "Config.h"
#import "Masonry.h"
#import "YSTableViewCell.h"
#import "TaxDeclareModel.h"
#import "TaxPayInModel.h"
#import "HomeSegment.h"

@interface TaxSearchResultController()<UITableViewDelegate, UITableViewDataSource, HomeSegmentDelegate>

@property (nonatomic, strong)UILabel *headLabel;
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)HomeSegment *segment;
@property (nonatomic, strong)NSArray *declareArray;
@property (nonatomic, strong)NSArray *payInArray;
@property (nonatomic, assign)NSInteger selectIndex;

@end

@implementation TaxSearchResultController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"申报缴款查询结果";
    [self initView];
    [self initData];
}

- (void)initView {
    {
        NSArray *array = @[@"申报查询", @"缴款查询"];
        HomeSegment *segment = [HomeSegment segmentWithItems:array];
        segment.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:segment];
        [segment mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.and.left.and.right.equalTo(self.view);
            make.height.mas_equalTo(40);
        }];
        segment.delegate = self;
        self.segment = segment;
    }
    {
        UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [self.view addSubview:tableView];
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.segment.mas_bottom);
            make.left.and.right.and.bottom.equalTo(self.view);
        }];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorColor = YSColor(0xe6, 0xe6, 0xe6);
        tableView.layoutMargins = UIEdgeInsetsZero;
        tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 0);
        tableView.backgroundColor = YSColor(0xf5, 0xf5, 0xf5);
        self.tableView = tableView;
        
        {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
            UILabel *label = [[UILabel alloc] init];
            [view addSubview:label];
            label.font = FONT_BOLD_BY_SCREEN(15);
            label.textColor = YSColor(0x50, 0x50, 0x50);
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(view).offset(15);
                make.top.and.bottom.right.equalTo(view);
            }];
            self.headLabel = label;
            self.tableView.tableHeaderView = view;
        }
    }
    
}

- (void)initData {
    self.selectIndex = 0;
    self.headLabel.text = @"申报查询结果";
    @try {
        self.declareArray = [MTLJSONAdapter modelsOfClass:[TaxDeclareModel class] fromJSONArray:self.dataDict[@"declareTax"] error:nil];
        self.payInArray = [MTLJSONAdapter modelsOfClass:[TaxPayInModel class] fromJSONArray:self.dataDict[@"payTaxes"] error:nil];
    } @catch (NSException *exception) {
        
    }
    [self.tableView reloadData];
}


#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (0 == self.selectIndex) {
        return 4;
    }
    else {
        return 7;
    }
    
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (0 == self.selectIndex) {
        return self.declareArray.count;
    }
    else {
        return self.payInArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    YSTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[YSTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        cell.textLabel.font = FONT_BY_SCREEN(15);
        cell.textLabel.textColor = YSColor(0xb4, 0xb4, 0xb4);
        cell.detailTextLabel.font = FONT_BY_SCREEN(15);
        cell.detailTextLabel.textColor = YSColor(0x50, 0x50, 0x50);
    }
    
    NSArray<NSArray *> *textArray = @[@[@"征收项目名称", @"税款所属时期", @"硬补退税额", @"申报日期",],
                                      @[ @"征收项目名称",  @"征收品目名称",  @"税率",  @"应缴税额",  @"预缴税额",  @"税款所属日期",  @"入库日期",]];
    NSArray<NSArray *> *valueKeys = @[@[@"_levyProjectName", @"_taxBelongTime", @"_taxOughtFillAmount", @"_declareDate",], @[@"_levyProjectName", @"_levyTaxItemName", @"_taxRate", @"_taxOughtAmount", @"_taxAdvance", @"_taxBelongTime", @"_putStorageDate",]];
    cell.textLabel.text = textArray[self.selectIndex][indexPath.row];
    NSString *key = valueKeys[self.selectIndex][indexPath.row];
    if (self.selectIndex == 0) {
        cell.detailTextLabel.text = [self.declareArray[indexPath.section] valueForKey:key];
    }
    else {
        cell.detailTextLabel.text = [self.payInArray[indexPath.section] valueForKey:key];

    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

#pragma mark - HomeSegmentDelegate
- (void)segment:(HomeSegment *)segment selected:(NSInteger)index {
    self.selectIndex = index;
    self.headLabel.text = index ? @"缴款查询结果" : @"申报查询结果";
    [self.tableView reloadData];
}

@end
