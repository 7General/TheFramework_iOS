//
//  MailInvoiceController.m
//  NingboSat
//
//  Created by ysyc_liu on 16/9/13.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "MailInvoiceController.h"
#import "MailInvoiceRequestModel.h"
#import "Config.h"
#import "MailNormalCell.h"
#import "MailLocateCell.h"
#import "TextFieldCustom.h"
#import "UIButton+YSSolidColorButton.h"
#import "YSAlertView.h"
#import "TaxStationModel.h"
#import "NewInvoiceModel.h"
#import "RequestBase.h"
#import "Masonry.h"

#import "MailInvoiceReadMeController.h"
#import "MailResultController.h"
#import "MailAddressController.h"
#import "ChooseTaxStationController.h"
#import "AddInvoiceController.h"


@interface MailInvoiceController()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)UITextField *pretectPriceField;
@property (nonatomic, strong)UISwitch *pretectPriceSwitch;
@property (nonatomic, strong)UIButton *submitBtn;

@property (nonatomic, strong)MailAddressModel *addressModel;
@property (nonatomic, strong)TaxStationModel *taxStationModel;
@property (nonatomic, strong)NSMutableArray<NewInvoiceModel *> *invoiceItems;

@end

@implementation MailInvoiceController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self reloadTable];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"邮寄发票申请";
    self.view.backgroundColor = YSColor(0xf5, 0xf5, 0xf5);
    [self initView];
    [self initData];
}

- (void)initData {
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:[NSObject getTaxNumber], @"taxpayer_code", nil];
    [RequestBase requestWith:APITypeIsApplyForEmailInvoice Param:@{@"jsonParam" : [param JSONParamString]} Complete:^(YSResponseStatus status, id object) {
        if (status == YSResponseStatusFailure) {
            if ([object[@"code"] integerValue] == 999) {
                YSAlertView *alertview = [YSAlertView alertWithMessage:@"您有尚未处理完成的发票领用申请,请您在现有申请处理完成之后再进行申领" sureButtonTitle:@"确定"];
                [alertview alertButtonClick:^(NSInteger buttonIndex) {
                    [self.navigationController popViewControllerAnimated:YES];
                }];
                [alertview show];
            }
        }
    } ShowOnView:self.view];
    [RequestBase requestWith:APITypeTaxPayerDefAddress Param:@{@"jsonParam" : [param JSONParamString]} Complete:^(YSResponseStatus status, id object) {
        if (status == YSResponseStatusSuccess) {
            if (object[@"content"]) {
                self.addressModel = [MTLJSONAdapter modelOfClass:[MailAddressModel class] fromJSONDictionary:object[@"content"][@"address"] error:nil];
                [self reloadTable];
            }
        }
    } ShowOnView:self.view];
}

- (void)initView {
    UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStyleGrouped];
    [self.view addSubview:tableView];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorColor = YSColor(0xe6, 0xe6, 0xe6);
    tableView.backgroundColor = self.view.backgroundColor;
    if (SYSTEM_VERSION >= 8.0) {
        tableView.layoutMargins = UIEdgeInsetsZero;
    }
    tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 0);
    tableView.tableFooterView = [self tableFooterView];
    
    self.tableView = tableView;
}

- (UIView *)tableFooterView {
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44 + 30 * 2)];
    UIButton * button = [UIButton buttonWithColor:YSColor(0x4b, 0xc4, 0xfb) title:@"提交申请"];
    [view addSubview:button];
    button.frame = CGRectMake(35, 30, SCREEN_WIDTH - 35 * 2, 44);
    [button addTarget:self action:@selector(commitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.submitBtn = button;
    return view;
}

#pragma mark - set and get
- (UISwitch *)pretectPriceSwitch {
    if (!_pretectPriceSwitch) {
        _pretectPriceSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
        [_pretectPriceSwitch addTarget:self action:@selector(pretectPriceSwitchChange:) forControlEvents:UIControlEventValueChanged];
    }
    return _pretectPriceSwitch;
}
- (UITextField *)pretectPriceField {
    if (!_pretectPriceField) {
        _pretectPriceField = [[TextFieldCustom alloc] initWithFrame:CGRectMake(0, 0, 180, 50)];
        _pretectPriceField.textColor = YSColor(0x50, 0x50, 0x50);
        _pretectPriceField.font = FONT_BY_SCREEN(15);
        _pretectPriceField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入保价金额" attributes:@{NSFontAttributeName:FONT_BY_SCREEN(15), NSForegroundColorAttributeName:YSColor(0xb4, 0xb4, 0xb4)}];
        _pretectPriceField.textAlignment = NSTextAlignmentRight;
        _pretectPriceField.tintColor = YSColor(0x50, 0x50, 0x50);
        _pretectPriceField.text = @"";
    }
    return _pretectPriceField;
}

- (NSMutableArray <NewInvoiceModel *> *)invoiceItems {
    if (!_invoiceItems) {
        _invoiceItems = [NSMutableArray array];
    }
    return _invoiceItems;
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 2;
        case 1:
            return 2;
//        case 2:
//            if (![self.invoiceRequestModel.isProtectPrice isEqualToString:@"1"]) {
//                return 1;
//            }
//            else {
//                return 2;
//            }
        case 2:
            return self.invoiceItems.count + 1;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString * identifier = @"normalCell";
    if (indexPath.section == 1 && 0 == indexPath.row && self.addressModel) {
        identifier = @"locateCell";
        MailLocateCell * locateCell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!locateCell) {
            locateCell = [[MailLocateCell alloc] initWithReuseIdentifier:identifier];
        }
        MailAddressModel * addressModel = self.addressModel;
        [locateCell setCellByModel:addressModel isEdit:NO];
        return locateCell;
    }
    else {
        MailNormalCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[MailNormalCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        }
        cell.rightLabel.highlighted = NO;
        MailNormalCellModel *cellModel = [self cellModelByIndexPath:indexPath];
        [cell setCellByModel:cellModel];
        if (indexPath.section == 1) {
            if (0 == indexPath.row) {
                cell.rightLabel.highlighted = !self.addressModel;
            }
            else {
                cell.rightLabel.highlighted = !(self.taxStationModel);
            }
        }
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1 && indexPath.row == 0) {
        if (self.addressModel) {
            MailAddressModel * addressModel = self.addressModel;
            return [MailLocateCell heightNeededByModel:addressModel andWidth:CGRectGetWidth(tableView.bounds) isEdit:NO];
        }
    }
    MailNormalCellModel *cellModel = [self cellModelByIndexPath:indexPath];
    return [MailNormalCell heightNeededByModel:cellModel andWidth:SCREEN_WIDTH];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (0 == section) {
        return 0.01;
    }
    return 11;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    __weak typeof(self) weakSelf = self;
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
//            self.addressModel = [[MailAddressModel alloc] init];
//            self.addressModel.name = @"点开链";
//            self.addressModel.phone = @"1231231231123";
//            self.addressModel.address = @"的空间奥克兰的房间案发肯德基发地方大家发达";
//            return;
            MailAddressController *vc = [[MailAddressController alloc] init];
            vc.selectBlock = ^(MailAddressModel *model) {
                weakSelf.addressModel = model;
                [weakSelf reloadTable];
            };
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if (indexPath.row == 1) {
//            self.taxStationModel = [[TaxStationModel alloc] init];
//            self.taxStationModel.name = @"打开的减肥就俺俩的叫法打开的减肥就俺俩的叫法打开的减肥就俺俩的叫法";
//            return;
            ChooseTaxStationController *vc = [[ChooseTaxStationController alloc] init];
            vc.preSelectTaxStation = self.taxStationModel;
            vc.selectBlock = ^(TaxStationModel *model) {
                weakSelf.taxStationModel = model;
                [weakSelf reloadTable];
            };
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    else if (indexPath.section == 2) { //增加发票种类
        if (indexPath.row == self.invoiceItems.count) { // 新增
//            NewInvoiceModel *tModel = [[NewInvoiceModel alloc] init];
//            tModel.type = @"123";
//            tModel.name = @"给大家看京东方爱的是房间爱空间的发掘";
//            tModel.number = @"10";
//            tModel.maxNumber = @"100";
//            [self.invoiceItems addObject:tModel];
//            [self reloadTable];
//            return;
            AddInvoiceController *vc = [[AddInvoiceController alloc] init];
            vc.addedItems = self.invoiceItems;
            vc.selectBlock = ^(NewInvoiceModel *model) {
                if (!model) {
                    return;
                }
                if (weakSelf.invoiceItems.count > 0) {
                    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K = %@", @"type", model.type];
                    NSArray *array = [weakSelf.invoiceItems filteredArrayUsingPredicate:predicate];
                    if (array.count > 0) {
                        NewInvoiceModel *sourceModel = array.firstObject;
                        [sourceModel addNumberWithModel:model];
                        [weakSelf reloadTable];
                        return;
                    }
                }
                
                [weakSelf.invoiceItems addObject:model];
                [weakSelf reloadTable];
            };
            [self.navigationController pushViewController:vc animated:YES];
        }
        else { //修改
            AddInvoiceController *vc = [[AddInvoiceController alloc] init];
            NewInvoiceModel *selectedModel = self.invoiceItems[indexPath.row];
            vc.preInvoiceModel = [selectedModel mutableCopy];
            NSMutableArray *addedItems = [self.invoiceItems mutableCopy];
            [addedItems removeObject:selectedModel];
            vc.addedItems = addedItems;
            vc.selectBlock = ^(NewInvoiceModel *model) {
                NSInteger index = indexPath.row;
                [self.invoiceItems removeObjectAtIndex:index];
                if (![selectedModel.type isEqualToString:model.type] && weakSelf.invoiceItems.count > 0) {
                    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K = %@", @"type", model.type];
                    NSArray *array = [weakSelf.invoiceItems filteredArrayUsingPredicate:predicate];
                    if (array.count > 0) {
                        NewInvoiceModel *sourceModel = array.firstObject;
                        [sourceModel addNumberWithModel:model];
                        [weakSelf reloadTable];
                        return;
                    }
                }
                else {
                    [self.invoiceItems insertObject:model atIndex:index];
                }
                [self reloadTable];
            };
            vc.deleteBlock = ^(NewInvoiceModel *model) {
                [weakSelf.invoiceItems removeObject:model];
                [weakSelf reloadTable];
            };
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

#pragma mark - cell method
- (MailNormalCellModel *)cellModelByIndexPath:(NSIndexPath *)indexPath {
    MailNormalCellModel *cellModel = [[MailNormalCellModel alloc] init];
    switch (indexPath.section) {
        case 0: {
            if (0 == indexPath.row) {
                cellModel.leftText = @"纳税人识别号";
                cellModel.rightText = [NSObject getTaxNumber];
            }
            else if (1 == indexPath.row) {
                cellModel.leftText = @"纳税人名称";
                cellModel.rightText = [NSObject getTaxName];
            }
            break;
        }
        case 1: {
            if (0 == indexPath.row) {
                if (!self.addressModel) {
                    cellModel.image = [UIImage imageNamed:@"locationIcon"];
                    cellModel.leftText = @"添加收票地址";
                    cellModel.rightText = @"点击选择";
                    cellModel.rightArrow = YES;
                }
            }
            else {
                cellModel.leftText = @"办税服务厅";
                cellModel.rightText = (self.taxStationModel) ? self.taxStationModel.name : @"点击选择";
                cellModel.rightArrow = YES;
            }
            break;
        }
        case 2: {
            if (self.invoiceItems.count == indexPath.row) {
                cellModel.image = [UIImage imageNamed:@"addIcon"];
                cellModel.leftText = @"新增发票申请信息";
                cellModel.rightArrow = YES;
            }
            else {
                NewInvoiceModel * model = self.invoiceItems[indexPath.row];
                cellModel.leftText = model.name;
                cellModel.rightText = [NSString stringWithFormat:@"%@份", model.number];
                cellModel.rightArrow = YES;
            }
            break;
        }
            
        default:
            break;
    }
    return cellModel;
}

#pragma mark - button click action
- (void)commitBtnClick {
    YSAlertView * alertView = [YSAlertView alertWithTitle:@"是否确认提交申请" message:nil buttonTitles:@"取消", @"确定", nil];
    [alertView show];
    
    [alertView alertButtonClick:^(NSInteger buttonIndex) {
        if (buttonIndex == 1) {
            NSArray *invoiceOrder = [MTLJSONAdapter JSONArrayFromModels:self.invoiceItems error:nil];
            NSDictionary *userDict = [NSDictionary dictionaryWithObjectsAndKeys:[NSObject getTaxName],@"nsrmc", [NSObject getTaxNumber], @"nsrsbh", self.taxStationModel.code, @"swjgdm", nil];//
            MailInvoiceOrder *mailOrderModel = [[MailInvoiceOrder alloc] init];
            mailOrderModel.lprzjlx = self.addressModel.idType;
            mailOrderModel.nsrmc = [NSObject getTaxName];
            mailOrderModel.nsrsbh = [NSObject getTaxNumber];
            mailOrderModel.addressId = self.addressModel.aid;
            mailOrderModel.fplqfs = @"1";
            mailOrderModel.lprzjhm = self.addressModel.idNumber;
            mailOrderModel.lprdh = self.addressModel.phone;
            mailOrderModel.lprmc = self.addressModel.name;
            mailOrderModel.bsfwtdm = self.taxStationModel.code;
            mailOrderModel.spdzshen = @"浙江省";
            mailOrderModel.spdzshi = @"宁波市";
            mailOrderModel.spdzqu = self.taxStationModel.district;
            mailOrderModel.spdz = self.addressModel.desAddress;
            mailOrderModel.zgswjgdm = self.taxStationModel.code;
            mailOrderModel.zgswjgmc = self.taxStationModel.name;
            NSDictionary *mailOrder = [MTLJSONAdapter JSONDictionaryFromModel:mailOrderModel error:nil];
            NSDictionary *param = @{@"fpfs_ordermx":invoiceOrder, @"data_status":userDict, @"fpfs_order":mailOrder};
            [RequestBase requestWith:APITypeApplyForEmailInvoice Param:@{@"jsonParam":[param JSONParamString]} Complete:^(YSResponseStatus status, id object) {
                if (status == YSResponseStatusSuccess) {
                    MailResultController *vc = [MailResultController new];
                    vc.phoneNum = mailOrderModel.lprdh;
                    [self.navigationController pushViewController:vc animated:YES];
                }
            } ShowOnView:self.view];
        }
    }];
}

- (void)pretectPriceSwitchChange:(UISwitch *)sender {
//    self.invoiceRequestModel.isProtectPrice = [NSString stringWithFormat:@"%d", sender.on];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:2];
    if (sender.on) {
        [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
    }
    else {
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
    }
}

#pragma mark - other method
- (UIView *)rightArrowView {
    UIImage *image = [UIImage imageNamed:@"rightArrow"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    return imageView;
}

+ (void)pushMailInvoiceControllerByController:(UIViewController *)controller {
    static NSString * readMeFlag = @"readMeFlag";
    NSNumber *flagValue = [[NSUserDefaults standardUserDefaults] valueForKey:readMeFlag];
    if (flagValue.boolValue) {
        [controller.navigationController pushViewController:[MailInvoiceController new] animated:YES];
    }
    else if ([controller isKindOfClass:[MailInvoiceReadMeController class]]) {
        [[NSUserDefaults standardUserDefaults] setValue:@(YES) forKey:readMeFlag];
        [controller.navigationController pushViewController:[MailInvoiceController new] animated:YES];
    }
    else {
        [controller.navigationController pushViewController:[MailInvoiceReadMeController new] animated:YES];
    }
}

- (void)reloadTable {
    [self submitCheck];
    [self.tableView reloadData];
}
- (void)submitCheck {
    if (!self.addressModel
        || !self.taxStationModel
        || self.invoiceItems.count == 0) {
        self.submitBtn.enabled = NO;
        return;
    }
    
    self.submitBtn.enabled = YES;
}

@end
