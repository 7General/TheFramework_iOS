//
//  ProjectSelectView.m
//  LongFor
//
//  Created by ruantong on 17/5/19.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "ProjectSelectView.h"
#import "UIView+Additions.h"
#import "UIColor+Helper.h"
#import "FilterMannger.h"


@interface ProjectSelectView ()



@end


@implementation ProjectSelectView

-(instancetype)initWithFrame:(CGRect)frame{
   return [super initWithFrame:frame];
}


/**
 设置列表数据源
 设置完之后会刷新UI
 @param yuanDataArr 数据源
 */
-(void)setYuanDataArr:(NSArray *)yuanDataArr{
    if ([yuanDataArr isKindOfClass:[NSNull class]] || !yuanDataArr) {
        return;
    }
    _yuanDataArr = yuanDataArr;
    self.showBiaoArr = [NSMutableArray array];
    
    for (int i=0; i<self.yuanDataArr.count; i++) {
        
        if ([self.yuanDataArr[i][@"sid"] isEqualToString:self.selectProjectDic[CITY_ID]]) {
            [self.showBiaoArr addObject:@"1"];
        }else{
            [self.showBiaoArr addObject:@"0"];
        }
    }
    [self.myTableView reloadData];
}

-(void)makeUI{
    //self.backgroundColor = [UIColor clearColor];
    
    self.dianType = 0;
    
    UIView* heitouView = [[UIView alloc] initWithFrame:self.bounds];
    heitouView.backgroundColor = [UIColor blackColor];
    heitouView.alpha = 0.8;
    [self addSubview:heitouView];
    
    
    UIView* whiteBackView = [[UIView alloc] initWithFrame:CGRectMake(15, 15, self.width-30, self.height-30)];
    whiteBackView.backgroundColor = [UIColor whiteColor];
    [self addSubview:whiteBackView];
    whiteBackView.layer.cornerRadius = 5;
    whiteBackView.layer.masksToBounds=YES;
    [self addSubview:whiteBackView];
    
    _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(20, 0, whiteBackView.width-40, whiteBackView.height) style:UITableViewStyleGrouped];
    _myTableView.backgroundColor = [UIColor whiteColor];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [whiteBackView addSubview:self.myTableView];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.yuanDataArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([self.showBiaoArr[section] isEqualToString:@"0"]) {
        return 0;
    }else{
        NSArray* arr = self.yuanDataArr[section][@"projectList"];
        if (arr.count>0) {
            return arr.count;
        }else{
            return 0;
        }
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 45;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView* backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.width, 50)];
    backView.backgroundColor = [UIColor whiteColor];
    
    UIView* lineView = [[UIView alloc] initWithFrame:CGRectMake(0, backView.height-0.5, backView.width, 0.5)];
    lineView.backgroundColor = [UIColor grayColor];
    lineView.alpha = 0.4;
    [backView addSubview:lineView];
    
    UILabel* cityNameLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 150, backView.height)];
    cityNameLab.textColor = [UIColor colorWithHexString:@"#888888"];
    cityNameLab.font = [UIFont systemFontOfSize:17];
    cityNameLab.text = self.yuanDataArr[section][@"name"];
    [backView addSubview:cityNameLab];
    
    UIButton* bu = [UIButton buttonWithType:UIButtonTypeCustom];
    bu.frame = backView.bounds;
    bu.tag = 837000+section;
    [bu addTarget:self action:@selector(zuBut:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:bu];
    
    UIImageView* biaoImgView = [[UIImageView alloc] initWithFrame:CGRectMake(backView.width-15-10, (backView.height-6)/2.0, 10, 6)];
    if ([self.showBiaoArr[section] isEqualToString:@"0"]) {
        biaoImgView.image = [UIImage imageNamed:@"liebiaoxiala-down"];
    }else{
        biaoImgView.image = [UIImage imageNamed:@"liebiaoxiala-up"];
    }
    
    [backView addSubview:biaoImgView];
    
    return backView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIView* backView = [[UIView alloc] initWithFrame:CGRectMake(80, 0, tableView.width-80, 45)];
        backView.backgroundColor = [UIColor colorWithHexString:@"f8f8f8"];
        backView.tag = 827162;
        [cell.contentView addSubview:backView];
        
        UILabel* nameLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, backView.width-15, backView.height)];
        nameLab.textColor = [UIColor colorWithHexString:@"#333333"];
        nameLab.tag = 827163;
        nameLab.font = [UIFont systemFontOfSize:17];
        [backView addSubview:nameLab];
        
        UIView* lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, backView.width, 0.5)];
        lineView.backgroundColor = [UIColor grayColor];
        lineView.alpha = 0.4;
        lineView.tag = 83672;
        [backView addSubview:lineView];
    }
    

    
    UIView* liview = [cell.contentView viewWithTag:83672];
    if(indexPath.row == 0){
        liview.hidden = YES;
    }else{
        liview.hidden = NO;
    }
    
    NSArray* arr = self.yuanDataArr[indexPath.section][@"projectList"];
    NSDictionary* projectDic = arr[indexPath.row];
    
    UILabel* nameLab = [cell.contentView viewWithTag:827163];
    UIView* backView = [cell.contentView viewWithTag:827162];
    if (![projectDic[@"sid"] isEqualToString:self.selectProjectDic[PROJECT_ID]]) {
        backView.backgroundColor = [UIColor colorWithHexString:@"f8f8f8"];
        nameLab.textColor = [UIColor blackColor];
    }else{
        backView.backgroundColor = [UIColor colorWithHexString:@"2F96FF"];
        nameLab.textColor = [UIColor whiteColor];
    }
    nameLab.text = projectDic[@"name"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"row点击了%d组%d个",indexPath.section,indexPath.row);
    NSDictionary* cityDic =  self.yuanDataArr[indexPath.section];
    NSDictionary* projectDic = cityDic[@"projectList"][indexPath.row];
    NSLog(@"记录\n%@\n%@",cityDic[@"name"],projectDic[@"name"]);
    
    if ([self.selectProjectDic[PROJECT_ID] isEqualToString:projectDic[@"sid"]] && [self.selectProjectDic[CITY_ID] isEqualToString:cityDic[@"sid"]]) {
        [self performSelector:@selector(xiaoshi2) withObject:nil afterDelay:0.4];
        NSLog(@"点中了同一个项目无需回调");
        return;
    }
     NSDictionary* dic = @{@"cityName":cityDic[@"name"],CITY_ID:cityDic[@"sid"],@"projectName":projectDic[@"name"],PROJECT_ID:projectDic[@"sid"]};
    self.selectProjectDic = dic;
    [tableView reloadData];
    
    [self performSelector:@selector(xiaoshi:) withObject:dic afterDelay:0.4];
}
-(void)xiaoshi:(NSDictionary*)dic{
    if (!(self.dianType == 1)) {
        [FilterMannger setSelectCity_ProjectDic:dic];
    }
    
    if ([self.delegate respondsToSelector:@selector(changeCityProjectStatus:)]) {
        [self.delegate changeCityProjectStatus:dic];
    }
    self.hidden = YES;
}
-(void)xiaoshi2{
    self.hidden = YES;
}



-(void)zuBut:(UIButton*)bu{
    NSLog(@"点击了%d",bu.tag);
    NSInteger dian = bu.tag - 837000;
    NSString* str = self.showBiaoArr[dian];
    NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:dian];
    if ([str isEqualToString:@"0"]) {
        [self.showBiaoArr replaceObjectAtIndex:dian withObject:@"1"];
        [self.myTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
    }else{
        [self.showBiaoArr replaceObjectAtIndex:dian withObject:@"0"];
        [self.myTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
    }
    
   // [self.myTableView insertRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationFade];
}

@end
