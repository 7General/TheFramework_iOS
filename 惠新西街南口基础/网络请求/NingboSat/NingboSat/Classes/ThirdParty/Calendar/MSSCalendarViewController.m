//
//  MSSCalendarViewController.m
//  MSSCalendar
//
//  Created by 于威 on 16/4/3.
//  Copyright © 2016年 于威. All rights reserved.
//

#import "MSSCalendarViewController.h"
#import "MSSCalendarCollectionViewCell.h"
#import "MSSCalendarHeaderModel.h"
#import "MSSCalendarManager.h"
#import "MSSCalendarCollectionReusableView.h"
#import "MSSCalendarPopView.h"
#import "MSSCalendarDefine.h"
#import "NSString+AttributeOrSize.h"
#import "UIView+UIViewUtils.h"

@interface MSSCalendarViewController ()
@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)MSSCalendarPopView *popView;
@end

@implementation MSSCalendarViewController

- (instancetype)init
{
    self = [super init];
    if(self) {
        _afterTodayCanTouch = YES;
        _beforeTodayCanTouch = YES;
        _dataArray = [[NSMutableArray alloc]init];
        _showChineseCalendar = NO;
        _showChineseHoliday = NO;
        _showHolidayDifferentColor = NO;
        _showAlertView = NO;
        _isCompare = NO;
    }
    return self;
}


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBarTintColor:MSS_UTILS_COLORRGB(75, 196, 251)];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDataSource];
    [self createUI];
    
    UIButton * cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancleBtn.frame = CGRectMake(0, 0, 40, 44);
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancleBtn setTitleColor:MSS_UTILS_COLORRGB(255, 255, 255) forState:UIControlStateNormal];
    [cancleBtn addTarget:self action:@selector(cancaleClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:cancleBtn];
}

-(void)cancaleClick {
    [self.navigationController popViewControllerAnimated:YES];

}

- (void)viewWillDisappear:(BOOL)animated{
    [self.navigationController.navigationBar setBarTintColor:MSS_UTILS_COLORRGB(255, 255, 255)];
    [super viewWillDisappear:animated];
    if(_popView)
    {
        [_popView removeFromSuperview];
        _popView = nil;
    }
    
}

- (void)initDataSource
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        MSSCalendarManager *manager = [[MSSCalendarManager alloc]initWithShowChineseHoliday:_showChineseHoliday showChineseCalendar:_showChineseCalendar startDate:_startDate];
        NSArray *tempDataArray = [manager getCalendarDataSoruceWithLimitMonth:_limitMonth type:_type];
        dispatch_async(dispatch_get_main_queue(), ^{
            [_dataArray addObjectsFromArray:tempDataArray];
            [self showCollectionViewWithStartIndexPath:manager.startIndexPath];
        });
    });
}

- (void)addWeakView {
    UIView *weekView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSS_SCREEN_WIDTH, MSS_WeekViewHeight)];
    weekView.backgroundColor = MSS_UTILS_COLORRGB(245, 245, 245);
    [self.view addSubview:weekView];
    
    NSArray *weekArray = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
    int i = 0;
    NSInteger width = MSS_SCREEN_WIDTH / 7;
    for(i = 0; i < 7;i++)
    {
        UILabel *weekLabel = [[UILabel alloc]initWithFrame:CGRectMake(i * width, 0, width, MSS_WeekViewHeight)];
        weekLabel.backgroundColor = [UIColor clearColor];
        weekLabel.text = weekArray[i];
        weekLabel.font = [UIFont boldSystemFontOfSize:12.0f];
        weekLabel.textAlignment = NSTextAlignmentCenter;
        if(i == 0 || i == 6)
        {
            weekLabel.textColor = MSS_UTILS_COLORRGB(259, 91, 52);
        }
        else
        {
            weekLabel.textColor = MSS_UTILS_COLORRGB(180, 180, 180);
        }
        [weekView addSubview:weekLabel];
    }
}

- (void)showCollectionViewWithStartIndexPath:(NSIndexPath *)startIndexPath
{
    [self addWeakView];
    [_collectionView reloadData];
    // 滚动到上次选中的位置
    if(startIndexPath)
    {
        [_collectionView scrollToItemAtIndexPath:startIndexPath atScrollPosition:UICollectionViewScrollPositionTop animated:NO];
        _collectionView.contentOffset = CGPointMake(0, _collectionView.contentOffset.y - MSS_HeaderViewHeight);
    }
    else
    {
        if(_type == MSSCalendarViewControllerLastType)
        {
            if([_dataArray count] > 0)
            {
                [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:_dataArray.count - 1] atScrollPosition:UICollectionViewScrollPositionTop animated:NO];
            }
        }
        else if(_type == MSSCalendarViewControllerMiddleType)
        {
            if([_dataArray count] > 0)
            {
                [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:(_dataArray.count - 1) / 2] atScrollPosition:UICollectionViewScrollPositionTop animated:NO];
                _collectionView.contentOffset = CGPointMake(0, _collectionView.contentOffset.y - MSS_HeaderViewHeight);
            }
        }
    }
}

- (void)createUI {
    self.title = @"日期选择";
    NSInteger width = MSS_Iphone6Scale(54);
    NSInteger height = MSS_Iphone6Scale(50);
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.itemSize = CGSizeMake(width, height);
    flowLayout.headerReferenceSize = CGSizeMake(MSS_SCREEN_WIDTH, MSS_HeaderViewHeight);
    flowLayout.sectionInset = UIEdgeInsetsMake(12, 0, 5, 0);
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    

    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, width * 7, MSS_SCREEN_HEIGHT - 64) collectionViewLayout:flowLayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_collectionView];
    
    [_collectionView registerClass:[MSSCalendarCollectionViewCell class] forCellWithReuseIdentifier:@"MSSCalendarCollectionViewCell"];
    [_collectionView registerClass:[MSSCalendarCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MSSCalendarCollectionReusableView"];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [_dataArray count];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    MSSCalendarHeaderModel *headerItem = _dataArray[section];
    return headerItem.calendarItemArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MSSCalendarCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MSSCalendarCollectionViewCell" forIndexPath:indexPath];
    if(cell)
    {
        MSSCalendarHeaderModel *headerItem = _dataArray[indexPath.section];
        MSSCalendarModel *calendarItem = headerItem.calendarItemArray[indexPath.row];
        cell.dateLabel.text = @"";
        cell.dateLabel.textColor = MSS_TextColor;
        cell.subLabel.text = @"";
        //cell.subLabel.textColor = MSS_SelectSubLabelTextColor;
        cell.isSelected = NO;
        cell.userInteractionEnabled = NO;
        if(calendarItem.day > 0) {
            cell.dateLabel.text = [NSString stringWithFormat:@"%ld",(long)calendarItem.day];
            cell.userInteractionEnabled = YES;
           [cell setSelectThem:NO withStr:@""];
        }
        if(_showChineseCalendar)
        {
            cell.subLabel.text = calendarItem.chineseCalendar;
        }
        
        // 开始日期
        if(calendarItem.dateInterval == _startDate)
        {
            cell.isSelected = YES;
            cell.dateLabel.textColor = MSS_SelectTextColor;
            //cell.subLabel.text = MSS_SelectBeginText;
            [cell setSelectThem:NO withStr:@""];
            
        }
        // 结束日期
        else if (calendarItem.dateInterval == _endDate)
        {
            cell.isSelected = YES;
            cell.dateLabel.textColor = MSS_SelectTextColor;
            //cell.subLabel.text = MSS_SelectEndText;
            [cell setSelectThem:NO withStr:@""];
        }
        // 开始和结束之间的日期
        else if(calendarItem.dateInterval > _startDate && calendarItem.dateInterval < _endDate)
        {
            cell.isSelected = YES;
            cell.dateLabel.textColor = MSS_SelectTextColor;
            [cell setSelectThem:NO withStr:@""];
        }
        else
        {
            if(calendarItem.week == 0 || calendarItem.week == 6)
            {
                cell.dateLabel.textColor = MSS_WeekEndTextColor;
                //cell.subLabel.textColor = MSS_WeekEndTextColor;
                [cell setSelectThem:NO withStr:@""];
            }
            if(calendarItem.holiday.length > 0)
            {
                cell.dateLabel.text = calendarItem.holiday;
                if(_showHolidayDifferentColor)
                {
                    cell.dateLabel.textColor = MSS_HolidayTextColor;
                    //cell.subLabel.textColor = MSS_HolidayTextColor;
                    [cell setSelectThem:NO withStr:@""];
                }
                if ([calendarItem.holiday isEqualToString:@"今天"]) {
                    [cell setSelectThem:YES withStr:[NSString stringWithFormat:@"%ld",(long)calendarItem.day]];
                }
            }
        }
        
        if(!_afterTodayCanTouch)
        {
            if(calendarItem.type == MSSCalendarNextType)
            {
                cell.dateLabel.textColor = MSS_TouchUnableTextColor;
                //cell.subLabel.textColor = MSS_TouchUnableTextColor;
                cell.userInteractionEnabled = NO;
                [cell setSelectThem:NO withStr:@""];
            }
        }
        if(!_beforeTodayCanTouch)
        {
            if(calendarItem.type == MSSCalendarLastType)
            {
                cell.dateLabel.textColor = MSS_TouchUnableTextColor;
                //cell.subLabel.textColor = MSS_TouchUnableTextColor;
                cell.userInteractionEnabled = NO;

                [cell setSelectThem:NO withStr:@""];
            }
        }
    }
    return cell;
}

// 添加header
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
   
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        MSSCalendarCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"MSSCalendarCollectionReusableView" forIndexPath:indexPath];
        MSSCalendarHeaderModel *headerItem = _dataArray[indexPath.section];
        headerView.headerLabel.text = headerItem.headerText;
        return headerView;
    }
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    MSSCalendarHeaderModel *headerItem = _dataArray[indexPath.section];
    MSSCalendarModel *calendaItem = headerItem.calendarItemArray[indexPath.row];
   
    _startDate = calendaItem.dateInterval;
    _endDate = 0;
    // 不比较时间
    if ( false == _isCompare) {
        [self delegatePostValue];
    }else {
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat: @"yyyyMMdd"];
        NSString *startDateString = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:_startDate]];
        // 1:比较时间 传入时间和当前选择时间比较
        int res = [_CompareTime compareDate:_CompareTime withDate:startDateString];
        if (res == -1 || res == 0) {
            
            [self delegatePostValue];
        }else {
            [self.view showHUDIndicatorLabelAtCenter:@"请选择今天之前的数据"];
        }
        
    }
    [_collectionView reloadData];
}

// 代理调用
-(void)delegatePostValue {
    if([_delegate respondsToSelector:@selector(calendarViewConfirmClickWithStartDate:endDate:)])
    {
        [_delegate calendarViewConfirmClickWithStartDate:_startDate endDate:_endDate];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if(_popView)
    {
        [_popView removeFromSuperview];
        _popView = nil;
    }
}

- (void)showPopViewWithIndexPath:(NSIndexPath *)indexPath;
{
    if(_showAlertView)
    {
        [_popView removeFromSuperview];
        _popView = nil;
        
        MSSCalendarPopViewArrowPosition arrowPostion = MSSCalendarPopViewArrowPositionMiddle;
        NSInteger position = indexPath.row % 7;
        if(position == 0)
        {
            arrowPostion = MSSCalendarPopViewArrowPositionLeft;
        }
        else if(position == 6)
        {
            arrowPostion = MSSCalendarPopViewArrowPositionRight;
        }
        
        MSSCalendarCollectionViewCell *cell = (MSSCalendarCollectionViewCell *)[_collectionView cellForItemAtIndexPath:indexPath];
        _popView = [[MSSCalendarPopView alloc]initWithSideView:cell.dateLabel arrowPosition:arrowPostion];
        _popView.topLabelText = [NSString stringWithFormat:@"请选择%@日期",MSS_SelectEndText];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"MM月dd日"MSS_SelectBeginText];
        NSString *startDateString = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:_startDate]];
        _popView.bottomLabelText = startDateString;
        [_popView showWithAnimation];
    }
}

@end
