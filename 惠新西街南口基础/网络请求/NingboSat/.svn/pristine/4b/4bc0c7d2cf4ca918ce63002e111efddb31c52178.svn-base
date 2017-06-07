//
//  TaxSearchView.h
//  NingboSat
//
//  Created by ysyc_liu on 16/9/20.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "PageScrollView.h"

@protocol TaxSearchViewDelegate <NSObject>

- (void)TaxDeclarePayInSearch:(id)sender;
- (void)unReachable;

@end

@interface TaxSearchView : PageScrollView

@property (nonatomic, weak)id<TaxSearchViewDelegate> delegate;

- (void)resetView;

@end
