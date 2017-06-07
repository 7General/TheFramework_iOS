//
//  CustomSearchViewController.m
//  LongFor
//
//  Created by ruantong on 17/5/18.
//  Copyright © 2017年 admin. All rights reserved.
//


#import "CustomSearchViewController.h"
#import "ConfigUI.h"

#define searchHistory @"searchHistoryArr"


@interface CustomSearchViewController ()

@property(nonatomic,retain)NSMutableArray* searchHistoryArr;

@property(nonatomic,retain)UIView* backView;

@end

@implementation CustomSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    
    self.searchView.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.searchView.autocorrectionType = UITextAutocorrectionTypeNo;//不自动修正
    self.searchView.delegate = self;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    
    [self readTextHistory];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

-(void)showSearchHistoryView{

    if (!_backView) {
        _backView = [[UIView alloc] initWithFrame:CGRectMake(20, 100, SCREEN_WIDTH-40, 250)];
        NSLog(@"www = %.2f pp=%.2f",self.view.width ,SCREEN_WIDTH);
        self.backView.tag = 7365251;
        [self.view addSubview:self.backView];
    }else{
        [self.backView removeAllSubviews];
    }
    
    for (int i=0;i<self.searchHistoryArr.count;i++) {
        NSString* str = self.searchHistoryArr[i];
        UIButton* la = [UIButton buttonWithType:UIButtonTypeCustom];
        la.tag = 987300+i;
        la.frame = CGRectMake(10, 50*i, SCREEN_WIDTH/2.0, 33);
        la.backgroundColor = [UIColor grayColor];
        la.layer.cornerRadius = 12;
        la.titleLabel.font = [UIFont systemFontOfSize:13];
        [la setTitle:str forState:UIControlStateNormal];
        la.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        la.contentEdgeInsets = UIEdgeInsetsMake(0,10, 0, 0);
        la.layer.masksToBounds=YES;
        [la addTarget:self action:@selector(historyBut:) forControlEvents:UIControlEventTouchUpInside];
        [self.backView addSubview:la];
    }

}


-(void)historyBut:(UIButton*)bu{

    NSLog(@"点击了%@",bu.titleLabel.text);
    self.searchView.text = bu.titleLabel.text;
    [self.searchHistoryArr removeObjectAtIndex:bu.tag-987300];
    [self SearchBut:nil];
}

//读取历史搜索内容
-(void)readTextHistory{
    NSUserDefaults *nf = [NSUserDefaults standardUserDefaults];
    self.searchHistoryArr = [NSMutableArray arrayWithArray:[nf objectForKey:searchHistory]];
    if (self.searchHistoryArr == nil) {
        self.searchHistoryArr = [NSMutableArray array];
    }
    [self showSearchHistoryView];
}
- (IBAction)cancelHistory:(id)sender {
    NSLog(@"清除历史记录");
    NSUserDefaults *nf = [NSUserDefaults standardUserDefaults];
    [nf setObject:[NSArray array] forKey:searchHistory];
    [nf synchronize];
    [self readTextHistory];
}

//保存历史搜索内容
-(void)saveTextHistoryWithStr:(NSString*)str{
    if (!(str.length>0)) {
        NSLog(@"搜索条件为空，不进入记录");
        return;
    }
    
    if(self.searchHistoryArr.count>=5){
        [self.searchHistoryArr insertObject:str atIndex:0];
        [self.searchHistoryArr removeLastObject];
    }else{
        [self.searchHistoryArr insertObject:str atIndex:0];
    }
    
    NSUserDefaults *nf = [NSUserDefaults standardUserDefaults];
    [nf setObject:self.searchHistoryArr forKey:searchHistory];
    [nf synchronize];
    
    [self readTextHistory];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //取消第一响应(官方的的说法)---》实际上就是收键盘
    NSLog(@"收到点击");
    [self.searchView resignFirstResponder];
}

- (IBAction)SearchBut:(id)sender {
    //官方 取消第⼀一响应者(就是退出编辑模式收键盘)
    [self.searchView resignFirstResponder];

    [self saveTextHistoryWithStr:self.searchView.text];
}

- (IBAction)cancelSearchBut:(id)sender {
    NSLog(@"取消搜索");
    
    [self.searchView resignFirstResponder];
    self.searchView.text= @"";
}




#pragma mark - textFileDelegate
//是否可以进入编辑模式(是否可进入输入状态)
- (BOOL)textFieldShouldBeginEditing:(UITextField
                                     *)textField{
    return YES;//NO进入不了编辑模式
}
//进入编辑模式
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    NSLog(@"进入编辑模式时调用");
}
//是否退出编辑模式(是否可以结束输入状态)
- (BOOL)textFieldShouldEndEditing:(UITextField
                                   *)textField{
    return YES;//NO 退出不了编辑模式
}
//退出编辑模式// 结束输入状态后调用
- (void)textFieldDidEndEditing:(UITextField *)textField{
    NSLog(@"退出编辑模式");
}
//是否可以点击清除按钮
- (BOOL)textFieldShouldClear:(UITextField *)textField{
    //textField.text = @"已经清除";
    return NO;//NO不清除
}
// 点击键盘上Return按钮时候调用
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self SearchBut:nil];
   	return YES;
}
//当输入任何字符时,代理调用该方法
-(BOOL)textField:(UITextField *)field
shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string
//当输入任何字符时,代理调用该方法,如果返回YES则这次输入可以成功,如 果返回NO,不能输入成功
//range表示光标位置,只有location,length == 0; //string表示这次输入的字符串。
{
//    NSLog(@"range = %@ string= %@",NSStringFromRange(range),string);
//    return str.length < 10;
    //textField.text超过了10个字符,返回NO,不让输入成功。(最多输入10个)
    //textField.text输入后不到10个字符,返回YES,使输入成功。 
    return YES;
}

@end
