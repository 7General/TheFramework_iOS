//
//  TallyButtonView.h
//  LongFor
//
//  Created by ruantong on 17/5/25.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomAddModel.h"


/**
 设置协议，当选中切换城市时会调用
 */
@protocol ChangeBiaoQian <NSObject>

- (void)changeBiaoQianStatus:(NSString*)selectStr andViewKey:(NSString*) viewKey andBiao:(NSString*)biao;
@end

/**
 标签控件view
 */
@interface TallyButtonView : UIView

//数据源
@property(nonatomic,retain)NSArray* tallyButtonsArr;

@property(nonatomic,retain)NSString* biao;
@property(nonatomic,retain)NSString* viewKey;

@property(nonatomic,weak)UIViewController<ChangeBiaoQian>* delegate;

/**
 创造标签控件view
 
 @param frame 设置整个View的frame，但是最后返回的view的高会变
 @param strArr 设置标签数据源
 @param num 设置标签一行多少个
 @param buheight 设置标签button高度
 @param Hjianju 标签button上下间距，一行的话用不到
 @param buWith 标签button的宽度
 @param delegate 标签代理
 @param viewKey 标签对应的Key
 @param biao 对应的表
 
 */
-(void)makeViewWith:(CGRect)frame andDataStrArr:(NSArray*)strArr andNum:(int)num andButtonHeight:(CGFloat)buheight andButtonHJianju:(CGFloat)Hjianju  andButtonWithForFrameWith:(CGFloat)buWith andDelegate:(UIViewController<ChangeBiaoQian>*)delegate andViewKey:(NSString*)viewKey andBiao:(NSString*)biao;

@end
