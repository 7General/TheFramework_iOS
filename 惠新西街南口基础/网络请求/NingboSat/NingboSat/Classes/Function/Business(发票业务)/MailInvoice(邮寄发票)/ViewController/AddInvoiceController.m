//
//  AddInvoiceController.m
//  NingboSat
//
//  Created by ysyc_liu on 16/9/19.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "AddInvoiceController.h"
#import "Masonry.h"
#import "Config.h"
#import "TextFieldCustom+MailAddress.h"
#import "UIButton+YSSolidColorButton.h"
#import "YSAlertView.h"
#import "TypeActionSheet.h"
#import "RequestBase.h"

@interface AddInvoiceController()<UITextFieldDelegate>

@property (nonatomic, strong)UITextField *invoiceTypeTextField;
@property (nonatomic, strong)UITextField *maxNumTextField;
@property (nonatomic, strong)UITextField *numberTextField;
@property (nonatomic, strong)UILabel *tipsLabel;
@property (nonatomic, strong)UIButton *submitBtn;

@property (nonatomic, strong)NewInvoiceModel *invoiceModel;
@property (nonatomic, strong)NSArray *invoiceArray;


@end

@implementation AddInvoiceController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"新增发票申请信息";
    self.view.backgroundColor = YSColor(0xf5, 0xf5, 0xf5);
    
    if (self.preInvoiceModel) {
        UIBarButtonItem * barButton = [[UIBarButtonItem alloc] initWithTitle:@"删除" style:UIBarButtonItemStylePlain target:self action:@selector(deleteBtnClick)];
        self.navigationItem.rightBarButtonItem = barButton;
        [self.navigationItem.rightBarButtonItem setTintColor:YSColor(0x50, 0x50, 0x50)];
    }
    
    [self initView];
    self.maxNumTextField.userInteractionEnabled = NO;
    
    self.invoiceModel = self.preInvoiceModel;
    [self loadViewData];
}

- (void)loadViewData {
    if (self.invoiceModel) {
        self.invoiceTypeTextField.text = self.invoiceModel.name;
        self.maxNumTextField.text = [self calculateMaxNum];//self.invoiceModel.maxNumber; // 计算剩余最大数量.
        self.numberTextField.text = self.invoiceModel.number;
        self.numberTextField.enabled = (self.maxNumTextField.text.integerValue);
    }
    else {
        self.invoiceTypeTextField.text = nil;
        self.maxNumTextField.text = nil;
        self.numberTextField.text = nil;
        self.numberTextField.enabled = NO;
    }
    self.tipsLabel.hidden = YES;
    [self submitCheck];
}
- (NSString *)calculateMaxNum {
    NSInteger realMaxNumber = self.invoiceModel.maxNumber.integerValue;
    NSInteger addedMaxNumber = 0;
    NSArray *addedSameItems = [self.addedItems filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"%K = %@", @"type", self.invoiceModel.type]];
    for (NewInvoiceModel *model in addedSameItems) {
        NSInteger number = model.number.integerValue;
        addedMaxNumber += number;
    }
    return [NSString stringWithFormat:@"%ld", (long)(realMaxNumber - addedMaxNumber)];
}

- (void)showErrorMsg:(NSString *)errorMsg {
    self.tipsLabel.text = errorMsg;
    self.tipsLabel.hidden = NO;
}

- (void)initData:(void(^)(void))completeBlock {
//    NSMutableArray *tmpArray = [NSMutableArray array];
//    {
//        NewInvoiceModel *model = [[NewInvoiceModel alloc] init];
//        model.type = @"1";
//        model.name = @"发票发票发票发票发票发票发票发票发票发票发票发票发票发票发票发票a";
//        model.maxNumber = @"222250";
//        [tmpArray addObject:model];
//    }
//    {
//        NewInvoiceModel *model = [[NewInvoiceModel alloc] init];
//        model.type = @"2";
//        model.name = @"发票b";
//        model.maxNumber = @"150";
//        [tmpArray addObject:model];
//    }
//    {
//        NewInvoiceModel *model = [[NewInvoiceModel alloc] init];
//        model.type = @"3";
//        model.name = @"发票c";
//        model.maxNumber = @"800";
//        [tmpArray addObject:model];
//    }
//    {
//        NewInvoiceModel *model = [[NewInvoiceModel alloc] init];
//        model.type = @"4";
//        model.name = @"发票d";
//        model.maxNumber = @"10";
//        [tmpArray addObject:model];
//    }
//    self.invoiceArray = [tmpArray copy];
//    if (completeBlock) {
//        completeBlock();
//    }
//    return;
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:[NSObject getTaxNumber], @"taxpayer_code", nil];
    [RequestBase requestWith:APITypeQueryCanReceiveInvoice Param:@{@"jsonParam" : [param JSONParamString]} Complete:^(YSResponseStatus status, id object) {
        if (status == YSResponseStatusSuccess) {
            if (object[@"content"] && [object[@"content"] isKindOfClass:[NSArray class]]) {
                self.invoiceArray = [MTLJSONAdapter modelsOfClass:[NewInvoiceModel class] fromJSONArray:object[@"content"] error:nil];
            }
        }
        if (completeBlock) {
            completeBlock();
        }
    } ShowOnView:self.view];
}

- (void)initView {
    UIView *mainBgView = self.view;
    
    UIView *previousView = nil;
    {
        NSArray *titles = @[@"发票种类", @"可领取份数", @"领取份数"];
        NSArray *placeholders = @[@"请选择发票种类", @"", @"请填写发票数据"];
        NSArray *isSelects = @[@(1), @(0), @(0)];
        NSArray *keyPathArray = @[@"_invoiceTypeTextField", @"_maxNumTextField", @"_numberTextField"];
        
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(-0.5, 10, SCREEN_WIDTH + 1, 50 * titles.count)];
        [mainBgView addSubview:bgView];
        bgView.backgroundColor = [UIColor whiteColor];
        bgView.layer.borderColor = YSColor(0xe6, 0xe6, 0xe6).CGColor;
        bgView.layer.borderWidth = 0.5;
        previousView = bgView;
        
        for (NSInteger i = 0; i < titles.count; i++) {
            UITextField *textField = [TextFieldCustom textFieldWithTitle:titles[i] placeholder:placeholders[i] isSelect:[isSelects[i] boolValue]];
            [bgView addSubview:textField];
            [textField mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(bgView).offset(50 * i);
                make.left.equalTo(bgView).offset(15);
                make.right.equalTo(bgView).offset(-10);
                make.height.mas_equalTo(50);
            }];
            
            textField.delegate = self;
            textField.tag = i;
            [self setValue:textField forKey:keyPathArray[i]];
            textField.keyboardType = UIKeyboardTypeNumberPad;
        }
        
        // 分割线
        for (NSInteger i = 1; i < titles.count; i++) {
            UIView *line = [[UIView alloc] init];
            [bgView addSubview:line];
            line.backgroundColor = YSColor(0xe6, 0xe6, 0xe6);
            [line mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(bgView).offset(50 * i - 0.25);
                make.left.equalTo(bgView).offset(15);
                make.right.equalTo(bgView);
                make.height.mas_equalTo(0.5);
            }];
        }
    }
    
    {
        UILabel *label = [[UILabel alloc] init];
        [mainBgView addSubview:label];
        label.font = FONT_BY_SCREEN(13);
        label.textColor = YSColor(255, 0, 0);
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(previousView.mas_bottom).offset(10);
            make.left.equalTo(mainBgView).offset(15);
        }];
        self.tipsLabel = label;
    }
    
    {
        UIButton *button = [UIButton buttonWithColor:YSColor(0x4b, 0xc4, 0xfb) title:@"保存"];
        [mainBgView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(mainBgView).offset(-10);
            make.height.mas_equalTo(44);
            make.left.equalTo(mainBgView).offset(35);
            make.right.equalTo(mainBgView).offset(-35);
        }];
        [button addTarget:self action:@selector(commitBtnClick) forControlEvents:UIControlEventTouchUpInside];
        self.submitBtn = button;
    }
}

#pragma mark - set and get

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField == self.invoiceTypeTextField) {
        [self selectInvoiceType];
        return NO;
    }
    else {
        return YES;
    }
}
//numberTextField
- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField == self.numberTextField) {
        [self submitCheck];
    }
}

#pragma mark - 
- (void)selectInvoiceType {
    //TODO: 选择发票种类
    if ([self.invoiceArray count] <= 0) {
        [self initData:^{
            if ([self.invoiceArray count] > 0) {
                [self showInvoiceType];
            }
            else {
                YSAlertView *alertView = [YSAlertView alertWithTitle:@"您目前没有可以申请邮寄的发票！请您至税局办理相关业务。" message:nil buttonTitles:@"确定", nil];
                [alertView alertButtonClick:^(NSInteger buttonIndex) {
                    [self.navigationController popViewControllerAnimated:YES];
                }];
                [alertView show];
            }
        }];
        return;
    }
    
    [self showInvoiceType];
}

- (void)showInvoiceType {
    NSArray *array = [self.invoiceArray valueForKeyPath:@"@unionOfObjects.name"];
    TypeActionSheet * actionSheetView = [[TypeActionSheet alloc] initWithItems:array];
    [actionSheetView show];
    __weak typeof(self) weakSelf = self;
    [actionSheetView setActionSheetClickBlock:^(NSInteger buttonIndex) {
        if (weakSelf.invoiceModel) {
            weakSelf.invoiceModel.number = nil;
        }
        weakSelf.invoiceModel = weakSelf.invoiceArray[buttonIndex];
        [weakSelf loadViewData];
        
    }];
}

#pragma mark - button click action
- (void)commitBtnClick {
    //TODO: 保存
    self.invoiceModel.number = self.numberTextField.text;
    if (self.selectBlock) {
        self.selectBlock([self.invoiceModel mutableCopy]);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)deleteBtnClick {
    YSAlertView * alertView = [YSAlertView alertWithTitle:@"是否删除该条发票信息?" message:nil buttonTitles:@"取消", @"确定", nil];
    [alertView alertButtonClick:^(NSInteger buttonIndex) {
        if (buttonIndex == 1) {
            //TODO: 删除
            if (self.deleteBlock) {
                self.deleteBlock(self.preInvoiceModel);
            }
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
    [alertView show];
}

#pragma mark - other method
- (void)submitCheck {
    [self showErrorMsg:nil];
    self.invoiceModel.number = self.numberTextField.text;
    if (self.invoiceModel.type.length < 1) {
        self.submitBtn.enabled = NO;
        return;
    }
    if (self.invoiceModel.number.length < 1) {
        self.submitBtn.enabled = NO;
        return;
    }
    NSInteger number = self.invoiceModel.number.integerValue;
    NSString *maxNumber = [self calculateMaxNum];
    if (number <= 0) {
        [self showErrorMsg:@"领取份数必须大于0"];
        self.submitBtn.enabled = NO;
        return;
    }
    else if (number % 5 != 0 || number > maxNumber.integerValue) {
        [self showErrorMsg:[NSString stringWithFormat:@"领取份数必须为5的倍数，且不多于%@份", maxNumber]];
        self.submitBtn.enabled = NO;
        return;
    }
    
    self.submitBtn.enabled = YES;
    
}


@end
