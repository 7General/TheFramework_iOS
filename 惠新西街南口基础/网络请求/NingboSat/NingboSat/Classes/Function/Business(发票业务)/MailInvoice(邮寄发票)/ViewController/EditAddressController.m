//
//  EditAddressController.m
//  NingboSat
//
//  Created by ysyc_liu on 16/9/18.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "EditAddressController.h"
#import "Config.h"
#import "UIButton+YSSolidColorButton.h"
#import "TextFieldCustom+MailAddress.h"
#import "Masonry.h"
#import "YSAlertView.h"
#import "TypeActionSheet.h"
#import "PickerViewModel.h"
#import "TextViewCustom.h"
#import "RequestBase.h"
#import "NSObject+InputFormatCheck.h"


@interface EditAddressController() <UITextFieldDelegate, UITextViewDelegate>

@property (nonatomic, strong)UITextField *nameTextField;
@property (nonatomic, strong)UITextField *phoneTextField;
@property (nonatomic, strong)UITextField *idTypeTextField;
@property (nonatomic, strong)UITextField *idNumberTextField;
@property (nonatomic, strong)UITextField *addressTextField;
@property (nonatomic, strong)TextViewCustom *descriptionAddressTextView;
@property (nonatomic, strong)UILabel *tipsLabel;
@property (nonatomic, strong)UIButton *submitBtn;

@property (nonatomic, strong)MailAddressModel *addressModel;

@property (nonatomic, strong)NSArray *addressData;
@property (nonatomic, copy)NSArray *selectIds;

@end

@implementation EditAddressController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"新增收票人地址";
    self.view.backgroundColor = YSColor(0xf5, 0xf5, 0xf5);
    
    if (self.preAddressModel) {
        self.title = @"编辑收票人地址";
        UIBarButtonItem * barButton = [[UIBarButtonItem alloc] initWithTitle:@"删除" style:UIBarButtonItemStylePlain target:self action:@selector(deleteBtnClick)];
        self.navigationItem.rightBarButtonItem = barButton;
        [self.navigationItem.rightBarButtonItem setTintColor:YSColor(0x50, 0x50, 0x50)];
    }
    
    self.selectIds = @[@"身份证", @"驾驶证", @"军官证", @"护照"];
    [self initView];
    [self showTips:@"温馨提示：以上信息请您填写完整后提交申请"];
    [self initData];
    [self submitCheck];
}

- (void)initData {
    if (!self.preAddressModel) {
        self.addressModel.idType = @"1";
    }
    else {
        self.addressModel = self.preAddressModel.copy;
    }
    
    [self loadViewData];
}

- (void)loadViewData {
    MailAddressModel *model = self.addressModel;
    self.nameTextField.text = model.name;
    self.phoneTextField.text = model.phone;
    self.idTypeTextField.text = [self idTypeStrBy:model.idType.integerValue - 1];
    self.idNumberTextField.text = model.idNumber;
    self.addressTextField.text = model.address;
    self.descriptionAddressTextView.text = model.desAddress;
}

- (void)initView {
    UIScrollView *bgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 64)];
    [self.view addSubview:bgScrollView];
    bgScrollView.backgroundColor = self.view.backgroundColor;
    bgScrollView.showsVerticalScrollIndicator = NO;
    bgScrollView.showsHorizontalScrollIndicator = NO;
    
    {
        UILabel *title = [[UILabel alloc] init];
        [bgScrollView addSubview:title];
        title.font = FONT_BY_SCREEN(13);
        title.textColor = YSColor(0xb4, 0xb4, 0xb4);
        title.text = @"领票人信息";
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(bgScrollView);
            make.left.equalTo(bgScrollView).offset(15);
            make.height.mas_equalTo(38);
        }];
    }
    
    UIView *inputView = nil;
    {
        NSArray *titles = @[@"选择领票人", @"移动电话", @"领票人证件类型", @"领票人证件号码", @"收票地址"];
        NSArray *placeholders = @[@"请输入领票人姓名", @"请输入领票人移动电话", @"", @"请输入证件号码", @"点击选择收票地址"];
        NSArray *isSelects = @[@(0), @(0), @(1), @(0), @(1)];
        NSArray *keyPathArray = @[@"_nameTextField", @"_phoneTextField", @"_idTypeTextField", @"_idNumberTextField", @"_addressTextField"];
        
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(-0.5, 38, SCREEN_WIDTH + 1, 50 * titles.count + 100)];
        [bgScrollView addSubview:bgView];
        bgView.backgroundColor = [UIColor whiteColor];
        bgView.layer.borderColor = YSColor(0xe6, 0xe6, 0xe6).CGColor;
        bgView.layer.borderWidth = 0.5;
        inputView = bgView;
        
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
        }
        
        {
            TextViewCustom *textView = [[TextViewCustom alloc] init];
            [bgView addSubview:textView];
            [textView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(bgView).offset(50 * titles.count);
                make.height.mas_equalTo(100);
                make.left.equalTo(bgView).offset(15);
                make.right.equalTo(bgView).offset(-10);
            }];
            textView.font = FONT_BY_SCREEN(15);
            textView.textColor = YSColor(0x50, 0x50, 0x50);
            textView.placeholder = @"请补充收票详细地址";
            textView.placeholderColor = YSColor(0xb4, 0xb4, 0xb4);
            textView.tintColor = YSColor(0x50, 0x50, 0x50);
            textView.delegate = self;
            self.descriptionAddressTextView = textView;
        }
        
        // 分割线.
        for (NSInteger i = 0; i < titles.count; i++) {
            UIView *line = [[UIView alloc] init];
            [bgView addSubview:line];
            line.backgroundColor = YSColor(0xe6, 0xe6, 0xe6);
            [line mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(bgView).offset(50 * i + 49.75);
                make.left.equalTo(bgView).offset(15);
                make.right.equalTo(bgView);
                make.height.mas_equalTo(0.5);
            }];
        }
    }
    {
        UILabel *label = [[UILabel alloc] init];
        [bgScrollView addSubview:label];
        label.textColor = YSColor(0xb2, 0xb2, 0xb2);
        label.font = FONT_BY_SCREEN(13);
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(inputView.mas_bottom).offset(12);
            make.left.equalTo(bgScrollView).offset(15);
        }];
        self.tipsLabel = label;
    }
    
    bgScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 38 + 350);
    
    {
        UIButton *button = [UIButton buttonWithColor:YSColor(0x4b, 0xc4, 0xfb) title:@"保存"];
        [self.view addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.view).offset(-10);
            make.height.mas_equalTo(44);
            make.left.equalTo(self.view).offset(35);
            make.right.equalTo(self.view).offset(-35);
        }];
        [button addTarget:self action:@selector(commitBtnClick) forControlEvents:UIControlEventTouchUpInside];
        self.submitBtn = button;
    }
    
    self.phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
}

#pragma mark - set and get

- (MailAddressModel *)addressModel {
    if (!_addressModel) {
        _addressModel = [[MailAddressModel alloc] init];
    }
    return _addressModel;
}
#pragma mark - button click action
- (void)commitBtnClick {
    self.addressModel.name = self.nameTextField.text;
    self.addressModel.phone = self.phoneTextField.text;
//    self.addressModel.idType = self.idTypeTextField.text;
    self.addressModel.idNumber = self.idNumberTextField.text;
    self.addressModel.address = self.addressTextField.text;
    self.addressModel.desAddress = self.descriptionAddressTextView.text;
    
    if (self.addressModel.phone.length < 1) {
        return;
    }
    if (![NSObject CheckPhone:self.addressModel.phone]) {
        YSAlertView *alert = [YSAlertView alertWithTitle:@"输入的手机号码格式不正确" message:nil buttonTitles:@"确认", nil];
        [alert show];
        return;
    }
    
    NSMutableDictionary *param = [[MTLJSONAdapter JSONDictionaryFromModel:self.addressModel error:nil] mutableCopy];
    [param setObject:[NSObject getTaxNumber] forKey:@"taxpayer_code"];
    APIType apiType = (self.preAddressModel) ? APITypeTaxPayerAddressUpdate : APITypeTaxPayerAddressInsert;
    [RequestBase requestWith:apiType Param:@{@"jsonParam":[param JSONParamString]} Complete:^(YSResponseStatus status, id object) {
        if (status == YSResponseStatusSuccess) {
            if (apiType == APITypeTaxPayerAddressInsert) {
                self.addressModel = [MTLJSONAdapter modelOfClass:[MailAddressModel class] fromJSONDictionary:object[@"content"][@"address"] error:nil];
            }
            if (self.commitBlock) {
                self.commitBlock(self.addressModel);
            }
            [self.navigationController popViewControllerAnimated:YES];
        }
    } ShowOnView:self.view];
}

- (void)deleteBtnClick {
    YSAlertView * alertView = [YSAlertView alertWithTitle:@"是否删除该条地址信息?" message:nil buttonTitles:@"取消", @"确定", nil];
    [alertView alertButtonClick:^(NSInteger buttonIndex) {
        if (buttonIndex == 1) {
            NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:[NSObject getTaxNumber], @"taxpayer_code", self.preAddressModel.aid, @"id", nil];
            [RequestBase requestWith:APITypeTaxPayerAddressDelete Param:@{@"jsonParam":[param JSONParamString]} Complete:^(YSResponseStatus status, id object) {
                if (status == YSResponseStatusSuccess) {
                    if (self.deleteBlock) {
                        self.deleteBlock(self.preAddressModel);
                    }
                    [self.navigationController popViewControllerAnimated:YES];
                }
            } ShowOnView:self.view];
            
        }
    }];
    [alertView show];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField.tag == 2) {
        [self selectIdType];
        [self.view endEditing:NO];
        return NO;
    }
    else if (textField.tag == 4) {
        [self selectMailAddress];
        [self.view endEditing:NO];
        return NO;
    }
    else {
        return YES;
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self submitCheck];
}

#pragma mark - 选择证件类型
- (void)selectIdType {
    
    TypeActionSheet * actionSheetView = [[TypeActionSheet alloc] initWithItems:self.selectIds];
    [actionSheetView show];
    __weak typeof(self) weakSelf = self;
    [actionSheetView setActionSheetClickBlock:^(NSInteger buttonIndex) {
        weakSelf.idTypeTextField.text = [self idTypeStrBy:buttonIndex];
        weakSelf.addressModel.idType = @(buttonIndex + 1).stringValue;
        [weakSelf submitCheck];
    }];
}
#pragma mark - 选择收票地址
- (void)selectMailAddress {
    if (!self.addressData) {
        [RequestBase requestWith:APITypeNingboDistricts Param:@{} Complete:^(YSResponseStatus status, id object) {
            if (status == YSResponseStatusSuccess) {
                if (!object[@"content"] || ![object[@"content"] isKindOfClass:[NSDictionary class]]
                    || !object[@"content"][@"districts"] || ![object[@"content"][@"districts"] isKindOfClass:[NSArray class]]) {
                    return;
                }
                self.addressData = @[@[@"浙江省宁波市"], object[@"content"][@"districts"]];
                [self selectMailAddressShow];
            }
        } ShowOnView:self.view];
    }
    else {
        [self selectMailAddressShow];
    }
}

- (void)selectMailAddressShow {
    PickerViewModel *viewModel = [[PickerViewModel alloc] init];
    viewModel.dataArray = self.addressData;
    PickerActionSheet *actionSheet = [[PickerActionSheet alloc] initWithViewModel:viewModel];
    viewModel.confirmBlock = ^(NSArray *selectedArray) {
        NSMutableString *result = [NSMutableString string];
        for (NSInteger i = 0; i < viewModel.dataArray.count; i++) {
            NSArray *array = self.addressData[i];
            NSInteger index = [selectedArray[i] integerValue];
//            if (result.length > 0) {
//                [result appendString:@"-"];
//            }
            [result appendString:array[index]];
        }
        self.addressTextField.text = result;
        [self submitCheck];
    };
    [actionSheet show];
}
#pragma mark - other method
- (NSString *)idTypeStrBy:(NSInteger)index {
    @try {
        return self.selectIds[index];
    } @catch (NSException *exception) {
        return self.selectIds[0];
    }
}

- (void)submitCheck {
    self.addressModel.name = self.nameTextField.text;
    self.addressModel.phone = self.phoneTextField.text;
    //    self.addressModel.idType = self.idTypeTextField.text;
    self.addressModel.idNumber = self.idNumberTextField.text;
    self.addressModel.address = self.addressTextField.text;
    self.addressModel.desAddress = self.descriptionAddressTextView.text;
    if (self.addressModel.name.length < 1
        || self.addressModel.phone.length < 1
        || self.addressModel.idType.length < 1
        || self.addressModel.idNumber.length < 1
        || self.addressModel.address.length < 1) {
        self.submitBtn.enabled = NO;
        return;
    }
    
    self.submitBtn.enabled = YES;
}

- (void)showTips:(NSString *)str {
    self.tipsLabel.text = str;
}

#pragma mark - UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@""]) {//这个是汉语联想的时候的他会出现的，第一次暂时让其联想，下次输入就不能联想了，因为第一次联想它不给自己算lenth，下次再联想词汇就会算上上次输入的，这个是苹果自己的BUG 如果是textfiled，一样 检测每个字符的变化。
        return YES;
    }
    if (textView.text.length>=300)
    {
        return NO;
    }
    else
    {
        return YES;
    }
    return YES;
    
}

@end
