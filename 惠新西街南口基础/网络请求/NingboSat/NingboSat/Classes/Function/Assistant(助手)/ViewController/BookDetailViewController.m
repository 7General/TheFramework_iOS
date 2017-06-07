//
//  BookDetailViewController.m
//  NingboSat
//
//  Created by 王会洲 on 16/11/17.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "BookDetailViewController.h"
#import "Config.h"
#import "BookFootView.h"
#import "Masonry.h"
#import "BookListViewController.h"
#import "bookTimeCell.h"
#import "BookItemViewController.h"
#import "CustomDatePicker.h"
#import "RequestBase.h"
#import "CompanyModel.h"
#import "SelectBookTimeViewController.h"
#import "SuccessViewController.h"
#import "CheckDataViewController.h"
#import "MyBookViewController.h"
#import "BookSearchViewController.h"
#import "LookCanBookViewController.h"
#import "NSString+AttributeOrSize.h"


@interface BookDetailViewController ()<UITableViewDelegate,UITableViewDataSource,CustomDatePickerDataSource,CustomDatePickerDelegate>
/**预约详情*/
@property (nonatomic, weak) UITableView * bookTableView;
/**数据源*/
@property (nonatomic, strong) NSDictionary * dataDict;
/**确认预约*/
@property (nonatomic, weak) UIButton * sureBtn;
/**可预约事项ID----用于预约按钮发送*/
@property (nonatomic, strong) NSString * bswd_id;
/**预约事项*/
@property (nonatomic, strong) NSString * yysx;

/**全市通办标示*/
@property (nonatomic, strong) NSString * qstb;
/**具体预约事项*/
@property (nonatomic, strong) NSString * jtyysx;
/**具体预约事项ID----用于预约按钮发送*/
@property (nonatomic, strong) NSString * jtyysx_id;
/**docID----用于预约按钮发送*/
@property (nonatomic, strong) NSString * docid;
/**办税网点信息*/
@property (nonatomic, strong) NSString * bswd_xx;
/**办税网点id(*)----用于预约按钮发送*/
@property (nonatomic, strong) NSString * bswd_id_new;

@property (nonatomic, strong) NSMutableArray * compayData;

/**预约日期----用于预约按钮发送*/
@property (nonatomic, strong) NSString * yyrq;
/**当前选中预约事项时间对象----用于预约按钮发送*/
@property (nonatomic, strong) SelectBookTimeModel * selectTimeModel;
/**用户获取 查看办理所需资料*/
@property (nonatomic, strong) NSString * cnnid;

/**是否有违约记录*/
@property (nonatomic, assign) BOOL  haveBreakBook;
/**底部视图-控制按钮*/
@property (nonatomic, strong) BookFootView * bookFoot;

@end

@implementation BookDetailViewController

-(NSMutableArray *)compayData {
    if (_compayData == nil) {
        _compayData = [NSMutableArray new];
    }
    return _compayData;
}


-(NSDictionary *)dataDict {
    if (_dataDict == nil) {
        _dataDict = [NSDictionary dictionary];
    }
    return _dataDict;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"预约办税";
    [self initView];
    self.haveBreakBook = NO;
    self.dataDict = @{@"first":@[@"预约事项",@"具体事项",@"办税服务厅"],@"two":@[@"预约时间"]};
    [self checkTaxerBook];
    [self RegeistKVO];
}
-(void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];;
}

/**添加KVO*/
-(void)RegeistKVO {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changSkines) name:@"SKINES" object:nil];
}

/**修改样式*/
-(void)changSkines {
    /**修改确认按钮背景色*/
    self.sureBtn.backgroundColor = YSColor(219, 219, 219);
    /**修改背景色*/
    self.bookTableView.backgroundColor = YSColor(255, 255, 255);
}


/**获取用户是否可以预约*/
-(void)checkTaxerBook {
    NSDictionary * dict = @{@"taxpayer_code":TAXPAYER_CODE};
    NSDictionary * param = @{@"jsonParam":[dict JSONParamString]};
    [RequestBase requestWith:APITypeCheckTaxerBook Param:param Complete:^(YSResponseStatus status, id object) {
        if (status == 0) {
            /**没有违约记录*/
            self.haveBreakBook = NO;
        }else {
            /**有违约记录*/
            self.haveBreakBook = YES;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"SKINES" object:nil];
        }
        [self.bookTableView reloadData];
    } ShowOnView:self.view];
}

-(void)initView {
    self.view.backgroundColor = [UIColor whiteColor];
    UITableView * bookTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)  style:UITableViewStyleGrouped];
    bookTableView.delegate = self;
    bookTableView.dataSource = self;
    [self.view addSubview:bookTableView];
    self.bookTableView = bookTableView;
    self.bookFoot = [[BookFootView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 400)];
    [self.bookFoot.needFile addTarget:self action:@selector(needfileClick) forControlEvents:UIControlEventTouchUpInside];
    
    /**查看办理所需要的资料*/
    [self.bookFoot.bookItem addTarget:self action:@selector(bookItemClick) forControlEvents:UIControlEventTouchUpInside];
    /**查看可预约事项*/
    self.bookTableView.tableFooterView = self.bookFoot;
    
    UIButton * sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sureBtn setTitle:@"确认预约" forState:UIControlStateNormal];
    [sureBtn setTitleColor:YSColor(255, 255, 255) forState:UIControlStateNormal];
    sureBtn.titleLabel.font = FONT_BOLD_BY_SCREEN(17);
    sureBtn.backgroundColor = YSColor(220, 220, 220);
    sureBtn.userInteractionEnabled = NO;
    sureBtn.layer.cornerRadius = 8;
    sureBtn.layer.masksToBounds = YES;
    [sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(35 * KWidthScale);
        make.right.equalTo(self.view.mas_right).offset(-35 * KWidthScale);
        make.bottom.equalTo(self.view.mas_bottom).offset(-10 * KHeightScale);
        make.height.mas_equalTo(44);
    }];
    self.sureBtn = sureBtn;
    
//    
//        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        btn.frame = CGRectMake(100, 100, 100, 100);
//        btn.backgroundColor = [UIColor redColor];
//        [btn addTarget:self action:@selector(successClick) forControlEvents:UIControlEventTouchUpInside];
//        [self.view addSubview:btn];
}



/**查看办理所需资料>*/
-(void)needfileClick {
    if (IsStrEmpty(self.docid) || IsStrEmpty(self.cnnid)) return;
    CheckDataViewController * checkData = [[CheckDataViewController alloc] init];
    checkData.docid = self.docid;
    checkData.cpnid =  self.cnnid;
    checkData.titles = self.jtyysx;
    [self.navigationController pushViewController:checkData animated:YES];
}
/**查看可预约事项*/
-(void)bookItemClick {
    LookCanBookViewController * lookCan = [[LookCanBookViewController alloc] init];
    [self.navigationController pushViewController:lookCan animated:YES];
}




#pragma mark -TABLEVIEW DELEGATE
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return [self.dataDict[@"first"] count];
    }else {
        return [self.dataDict[@"two"] count];
    }
}

-(UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        static NSString * ID = @"cell";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = FONT_BY_SCREEN(15);
        cell.textLabel.textColor = YSColor(68, 68, 68);
        
        cell.detailTextLabel.font = FONT_BY_SCREEN(15);
        cell.detailTextLabel.textColor = YSColor(136, 136, 136);
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        NSArray * arry = self.dataDict[@"first"];
        cell.textLabel.text = arry[indexPath.row];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"请您选择%@",arry[indexPath.row]];
        
        /**有--违约记录*/
        if (self.haveBreakBook) {
            cell.backgroundColor = YSColor(219, 219, 219);
            if (indexPath.section == 0) {
                cell.textLabel.textColor = YSColor(136, 136, 136);
            }
        }else {
            /**无--违约记录*/
            cell.backgroundColor = YSColor(250, 250, 250);
            if (indexPath.section == 0 && 0 != indexPath.row ) {
                cell.textLabel.textColor = YSColor(136, 136, 136);
            }
        }
        // 从办税地图跳转
        if (self.isUserSelectModel && indexPath.row == 2) {
            cell.detailTextLabel.text = self.selectReveModel.swjgmc;
        }
        
        
        return  cell;
    }else { // 选着预约时间
        bookTimeCell * cells = [bookTimeCell cellWith:tableView];
        if (self.haveBreakBook) {
            cells.backgroundColor = YSColor(219, 219, 219);
        }else {
            cells.backgroundColor = YSColor(250, 250, 250);
        }
        return cells;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    __weak typeof(self) weakSelf = self;
    // 可预约事项 并且没有违约记录
    if (indexPath.section == 0 && indexPath.row == 0 && NO == self.haveBreakBook) {
        BookListViewController * bookList = [[BookListViewController alloc] init];
        bookList.showType = NetCheckList;
        // 执行点击返回 获取具体可预约事项
        [bookList setReadSpecBlock:^(NSString *ids,NSString * mc) {
            UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
            cell.detailTextLabel.text = mc;
            // 检查清空数据
            [weakSelf clearClickbyBSWDID:ids withMC:mc];
            [weakSelf TextLabel:weakSelf.yysx tableView:tableView withIndexPath:indexPath];
        }];
        [self.navigationController pushViewController:bookList animated:YES];
    }
    
    // 选中具体预约事项
    if (indexPath.section == 0 && indexPath.row == 1) {
        // 没有改变 就不能选择
        if ([self.yysx containsString:@"请您"] || IsStrEmpty(self.yysx)) return;
        
        UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
        BookItemViewController * bookItem = [[BookItemViewController alloc] init];
        bookItem.titleName = (self.dataDict[@"first"])[indexPath.row];
        bookItem.bswd_id = self.bswd_id;
        // 执行点击返回 获取具体可预约事项
        [bookItem setReadSpecBlock:^(NSString *qstb,NSString * mc,NSString * jtyysxid,NSString * cnnid,NSString * docid) {
            cell.detailTextLabel.text = mc;
            self.jtyysx = mc;
            self.jtyysx_id = jtyysxid;
            self.qstb = qstb;
            self.cnnid = cnnid;
            self.docid = docid;
            [self TextLabel:self.jtyysx tableView:tableView withIndexPath:indexPath];
            // 更新page
            [self updateClickButonMAS];
            if (self.isUserSelectModel) {
                /**记录*/
                self.bswd_xx = self.selectReveModel.swjgmc;
                self.bswd_id_new = L(self.selectReveModel.ids);
                // 跟新UI
                NSIndexPath * pathSection = [NSIndexPath indexPathForRow:0 inSection:1];
                bookTimeCell * cell = [self.bookTableView cellForRowAtIndexPath:pathSection];
                cell.itemName.textColor = YSColor(68, 68, 68);
            }
        }];
        [self.navigationController pushViewController:bookItem animated:YES];
    }
    
    
    // 选中下拉框办税网点信息 && 用户数据设置成没有使用
    if (indexPath.section == 0 && indexPath.row == 2 && (NO == self.isUserSelectModel)) {
        if ([self.jtyysx containsString:@"请您"] || IsStrEmpty(self.jtyysx)) return;
        [self checkInCompanyItem];
    }
    
    /**预约时间*/
    if (indexPath.section == 1) {
        if ([self.bswd_xx containsString:@"请您"] || IsStrEmpty(self.bswd_xx)) return;
        SelectBookTimeViewController * seletTime = [[SelectBookTimeViewController alloc] init];
        /**办税网点ID*/
        seletTime.bswd_id = self.bswd_id_new;
        /**有后端传数据-选择时间、选中预约时间块数据*/
        [seletTime setCheckBlock:^(NSString *dateStr, SelectBookTimeModel *selectTimeModel) {
            self.yyrq = dateStr;
            self.selectTimeModel = selectTimeModel;
            bookTimeCell * cell = [tableView cellForRowAtIndexPath:indexPath];
            cell.dateShortStr.text = dateStr;
            cell.timeShortStr.text = [NSString stringWithFormat:@"%@-%@",selectTimeModel.yysj_q,selectTimeModel.yysj_z];
            [self checkEmptyStrSetSureBtn];
        }];
        [self.navigationController pushViewController:seletTime animated:YES];
    }
}

/**检查属性 监控确定按钮属性*/
-(void)checkEmptyStrSetSureBtn {
    if (!IsStrEmpty(self.bswd_id_new) &&
        !IsStrEmpty(self.yyrq) &&
        !IsStrEmpty(self.selectTimeModel.yysj_q) &&
        !IsStrEmpty(self.selectTimeModel.yysj_z) &&
        !IsStrEmpty(self.bswd_id) &&
        !IsStrEmpty(self.jtyysx_id)) {
        self.sureBtn.backgroundColor = YSColor(75, 196, 251);
        self.sureBtn.userInteractionEnabled = YES;
    }else {
        self.sureBtn.backgroundColor = YSColor(220, 220, 220);
        self.sureBtn.userInteractionEnabled = NO;
    }
}
/**清空点击非当前数据*/
-(void)clearClickbyBSWDID:(NSString *)ids withMC:(NSString *)mc{
    if ([self.bswd_id isEqualToString:ids]) {
        return;
    }
    else{
        self.bswd_id = ids;
        self.yysx = mc;
        self.jtyysx = @"请您选中具体事项";
        self.bswd_xx = @"请您选择办税服务厅";
        bookTimeCell * cells = [self.bookTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
        cells.itemName.textColor = YSColor(136, 136, 136);
        cells.dateShortStr.text = @"";
        cells.timeShortStr.text = @"";
        NSIndexPath * index1 = [NSIndexPath indexPathForRow:1 inSection:0];
        NSIndexPath * index2 = [NSIndexPath indexPathForRow:2 inSection:0];
        NSIndexPath * index3 = [NSIndexPath indexPathForRow:0 inSection:1];
        [self.bookTableView reloadRowsAtIndexPaths:@[index1,index2,index3] withRowAnimation:UITableViewRowAnimationNone];
        // 复位约束
        [self.bookFoot resetButtonMASON];
    }
}
/**更新约束*/
-(void)updateClickButonMAS {
    [self.bookFoot updateButtonMASON];
}

/**获取下拉框办税网点信息*/
-(void)checkInCompanyItem {
    NSDictionary * dict = @{@"taxpayer_code":TAXPAYER_CODE,@"qstb":self.qstb};
    NSDictionary * param = @{@"jsonParam":[dict JSONParamString]};
    
    [self.compayData removeAllObjects];
    
    [RequestBase requestWith:APITypeCheckInCompanyItem Param:param Complete:^(YSResponseStatus status, id object) {
        if (status == YSResponseStatusSuccess) {
            for (NSDictionary * dict in object[@"content"]) {
                CompanyModel * model = [CompanyModel CompanyModelWithDict:dict];
                [self.compayData addObject:model];
            }
            
            CustomDatePicker * pickerView = [[CustomDatePicker alloc] initWithSureBtnTitle:@"取消" otherButtonTitle:@"确定"];
            pickerView.delegate = self;
            pickerView.dataSource = self;
            [pickerView show];
        }
    } ShowOnView:self.view];
}
#pragma mark - 地区选择代理
-(NSInteger)CpickerView:(UIPickerView *)pickerView numberOfRowsInPicker:(NSInteger)component {
    return self.compayData.count;
}

-(UIView *)CpickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    CompanyModel * model = self.compayData[row];
    UILabel * cellTitle = [[UILabel alloc] init];
    cellTitle.text = model.bswd_mc;
    cellTitle.textColor = YSColor(80, 80, 80);
    cellTitle.font = FONTLIGHT(17);
    cellTitle.textAlignment = NSTextAlignmentCenter;
    return cellTitle;
}

/**确定事件*/
-(void)CpickerViewdidSelectRow:(NSInteger)row {
    CompanyModel * model = self.compayData[row];
    /**更新cell*/
    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:2 inSection:0];
    [self.bookTableView cellForRowAtIndexPath:indexPath].detailTextLabel.text = model.bswd_mc;
    /**记录*/
    self.bswd_xx = model.bswd_mc;
    self.bswd_id_new = L(model.bswd_id);
    /**点击确定按钮之后 确认*/
    NSIndexPath * pathSection = [NSIndexPath indexPathForRow:0 inSection:1];
    bookTimeCell * cell = [self.bookTableView cellForRowAtIndexPath:pathSection];
    cell.itemName.textColor = YSColor(68, 68, 68);
}
/**取消事件*/
-(void)CpickerViewCancleClick {
    
}

-(CGFloat)CpickerView:(UIPickerView *)pickerView rowHeightForPicker:(NSInteger)component {
    return 43;
}





/**
 *  更具cell判断detailtext时候有选择数据
 *
 *  @param tableView <#tableView description#>
 *  @param indexPath <#indexPath description#>
 *
 *  @return 包含“请选中”返回YES,否则返回NO
 */
-(void)TextLabel:(NSString *)mc tableView:(UITableView *)tableView withIndexPath:(NSIndexPath *)indexPath{
    // 没有改变 就不能选择
    if ([mc containsString:@"请您"] || IsStrEmpty(mc)) return;
    UITableViewCell * nextCell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row + 1 inSection:indexPath.section]];
    nextCell.textLabel.textColor = YSColor(68, 68, 68);
}




-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

// 设置距离左右各10的距离
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.bookTableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    if ([self.bookTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.bookTableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    
    if ([self.bookTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.bookTableView setLayoutMargins:UIEdgeInsetsZero];
    }
}

/**确认预约按钮*/
-(void)sureBtnClick {
    
    NSDictionary * dict = @{
                            @"taxpayer_code":TAXPAYER_CODE,
                            @"taxpayer_name":@"测试纳税人",
                            @"sz_id":L(self.selectTimeModel.ids),
                            @"bswd_id":self.bswd_id_new,
                            @"phone":@"15957400686",
                            @"yyrq":[self.yyrq stringTimeWithFormat],
                            @"yysj_q":self.selectTimeModel.yysj_q,
                            @"yysj_z":self.selectTimeModel.yysj_z ,
                            @"kyysl":L(self.selectTimeModel.kyysl),
                            @"yysj_bz":L(self.selectTimeModel.yysj_bz),
                            @"sxid1":self.bswd_id,
                            @"sxid2":self.jtyysx_id
                            };
    NSDictionary * param = @{@"jsonParam":[dict JSONParamString]};
    
    [RequestBase requestWith:APITypeBookFunClick Param:param Complete:^(YSResponseStatus status, id object) {
        if (status == 0) {
            SuccessViewController * success = [[SuccessViewController alloc] init];
            success.bookNumber = L([object[@"content"] integerValue]);
            success.bookAddress = self.bswd_xx;
            success.bookTimeModel = self.selectTimeModel;
            success.bookTime = self.yyrq;
            /**恢复至初始化状态*/
            [self resbackSetAppearce];
            [self.navigationController pushViewController:success animated:YES];
        }
    } ShowOnView:self.view];
}


-(void)successClick {

}
// 恢复致初始化状态
-(void)resbackSetAppearce {
    [self.bookTableView reloadData];
    self.bswd_id = @"";
    self.yysx = @"请您";
    self.jtyysx = @"请您";
    self.bswd_xx = @"请您";
    
    bookTimeCell * cells = [self.bookTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    cells.itemName.textColor = YSColor(136, 136, 136);
    cells.dateShortStr.text = @"";
    cells.timeShortStr.text = @"";
    self.sureBtn.backgroundColor = YSColor(220, 220, 220);
    self.sureBtn.userInteractionEnabled = NO;
}


@end
