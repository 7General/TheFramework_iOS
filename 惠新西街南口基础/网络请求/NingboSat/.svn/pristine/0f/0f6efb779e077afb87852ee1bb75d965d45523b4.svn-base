//
//  EScrollerTaxView.m
//  eTax
//
//  Created by YSYC on 14-1-22.
//  Copyright (c) 2014年 YSYC. All rights reserved.
//

#import "EScrollerTaxView.h"

@implementation EScrollerTaxView

-(id)initWithFrameRect:(CGRect)rect contentArr:(NSArray *)arr{
    
	if ((self=[super initWithFrame:rect])) {
        self.userInteractionEnabled=YES;
       
        NSMutableArray *tempArray=[NSMutableArray arrayWithArray:arr];
        [tempArray insertObject:[arr objectAtIndex:([arr count]-1)] atIndex:0];
        [tempArray addObject:[arr objectAtIndex:0]];
		contentArray=[NSArray arrayWithArray:tempArray] ;
		viewSize=rect;
        NSUInteger pageCount=[contentArray count];
        scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, viewSize.size.width, viewSize.size.height)];
        scrollView.pagingEnabled = YES;
        scrollView.contentSize = CGSizeMake(viewSize.size.width * pageCount, viewSize.size.height);
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.scrollsToTop = NO;
        scrollView.delegate = self;
      
        
#define viewY  40
        
        for (int i=0; i<pageCount; i++) {
            
            NSDictionary *dic = contentArray[i];
//            
            UIImageView *bgIV = [[UIImageView alloc]initWithFrame:CGRectMake(viewSize.size.width*i, 0, viewSize.size.width, viewSize.size.height)];
            bgIV.image = [UIImage imageNamed:@"escrollertaxview_bg.png"];
            [scrollView addSubview:bgIV];
            
            UILabel *reminderLab = [[UILabel alloc]initWithFrame:CGRectMake(viewSize.size.width*i+20, 10,200, 20)];
            reminderLab.backgroundColor = [UIColor clearColor];
            reminderLab.font = [UIFont systemFontOfSize:12.0];
            reminderLab.textColor = [UIColor grayColor];
            reminderLab.text = @"关注更多您感兴趣的税信账号";
            [scrollView addSubview:reminderLab];
            
            
            NSString *imgURL = dic[@"url"];
            UIImageView *imgView = [[UIImageView alloc] init] ;
            if ([imgURL hasPrefix:@"http://"]) {
                //  [imgView setImageWithURL:[NSURL URLWithString:imgURL]];
            }else{
                
                UIImage *img = [UIImage imageNamed:imgURL];
                [imgView setImage:img];
            }
            
            imgView.frame = CGRectMake(viewSize.size.width*i+20, viewY,40, 40);
            imgView.tag = i;
            [scrollView addSubview:imgView];
            
            UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(viewSize.size.width*i+70, viewY,200, 20)];
            titleLab.backgroundColor = [UIColor clearColor];
            titleLab.font = [UIFont boldSystemFontOfSize:16];
            titleLab.text = dic[@"title"];
            [scrollView addSubview:titleLab];
            
            UILabel *detailLab = [[UILabel alloc]initWithFrame:CGRectMake(viewSize.size.width*i+70, viewY +22,180, 20)];
            detailLab.backgroundColor = [UIColor clearColor];
            detailLab.textColor = [UIColor grayColor];
            detailLab.font = [UIFont systemFontOfSize:12.0];
            detailLab.text = dic[@"detail"];
            [scrollView addSubview:detailLab];
            
            
            
            UIButton *AttentionBut = [UIButton buttonWithType:UIButtonTypeCustom];
            AttentionBut.frame =CGRectMake(viewSize.size.width*i+255,viewY +10,112/2, 25);
            [AttentionBut setImage:[UIImage imageNamed:@"escrollertaxview_attbut.png"] forState:UIControlStateNormal];
            [scrollView addSubview:AttentionBut];
            
            
           


            
        }
        [scrollView setContentOffset:CGPointMake(viewSize.size.width, 0)];
        [self addSubview:scrollView];
        for (int i=0; i<pageCount-2; i++){
            UIImageView *pageControlView = [[UIImageView alloc]initWithFrame:CGRectMake((10*i)+20, viewSize.size.height - 10, 6, 6)];
            pageControlView.image = [UIImage imageNamed:@"pageControlView_bg.png"];
            [self addSubview:pageControlView];

        }
       
        currentPageControlView = [[UIImageView alloc]initWithFrame:CGRectMake(20, viewSize.size.height - 10, 6, 6)];
        
        currentPageControlView.image = [UIImage imageNamed:@"currentPageControlView_bg.png"];
        [self addSubview:currentPageControlView];
    }
    
    return self;
}
- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    currentPageIndex = page;
    
//    NSInteger titleIndex = page - 1;
//
//
//    if (titleIndex == [contentArray count]) {
//        titleIndex = 0;
//    }
//    if (titleIndex < 0) {
//        titleIndex = [contentArray count] - 1;
//    }
    

//    [noteTitle setText:[contentArray objectAtIndex:titleIndex]];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)_scrollView
{


    if (currentPageIndex == 0) {
        
        [_scrollView setContentOffset:CGPointMake(([contentArray count]-2)*viewSize.size.width, 0)];
    }
    if (currentPageIndex == ([contentArray count]-1)) {
        
        [_scrollView setContentOffset:CGPointMake(viewSize.size.width, 0)];
        
    }
    currentPageControlView.frame = CGRectMake((10*(currentPageIndex-1))+20, viewSize.size.height - 10, 6, 6);

}

- (void)imagePressed:(UITapGestureRecognizer *)sender
{
    
}


@end
