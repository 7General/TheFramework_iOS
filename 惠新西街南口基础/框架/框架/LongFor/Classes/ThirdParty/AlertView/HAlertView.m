//
//  HAlertView.m
//  AlertView
//
//  Created by 王会洲 on 16/9/19.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "HAlertView.h"
#import "UIView+Additions.h"
#import "HAlertConfig.h"
#import "NSString+Size.h"


@interface HAlertView ()

/****内容相关*****/
@property (nonatomic, strong) UITextView * bodyTextView;
@property (nonatomic, strong) UILabel * bodyTextLabel;
/**
 *  抬头
 */
@property (nonatomic, strong) UILabel * titleLabel;
/**
 *  自定义view
 */
@property (nonatomic, strong) UIView * customView;

// 点击按钮的TAG
@property (nonatomic, assign) NSInteger  clickedButtonIndex;

// 是否已经显示
@property (nonatomic, assign) BOOL  visible;

@property (nonatomic, strong) UIView * backgroundView;

/**
 *  设备旋转办法
 */
@property (nonatomic, assign) UIInterfaceOrientation orientation;

@property (nonatomic, assign) CGFloat padding;

@end


static CGFloat kTransitionDuration = 0.3f;
static NSMutableArray * gAlertViewStack = nil;
static UIWindow *gPreviouseKeyWindow = nil;
static UIWindow * gMaskWindow = nil;


@implementation HAlertView

/**懒加载数据**/
-(UIView *)contentView {
    if (_contentView == nil) {
        _contentView = [[UIView alloc] init];
        [self addSubview:_contentView];
    }
    return _contentView;
}

- (UIButton *)cancelButton{
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelButton setTitleColor:HColor(134, 134, 134) forState:UIControlStateNormal];
        [_cancelButton setTitle:(@"Ok") forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
        _cancelButton.layer.borderWidth = 1;
        _cancelButton.layer.borderColor = HColor(247, 247, 247).CGColor;
        _cancelButton.layer.masksToBounds = YES;
        _cancelButton.layer.cornerRadius = 42 * 0.5;
        
        
    }
    return _cancelButton;
}

- (UIButton *)otherButton{
    if (!_otherButton) {
        _otherButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_otherButton setTitleColor:HColor(63, 204, 243) forState:UIControlStateNormal];
        [_otherButton setTitle:(@"Ok") forState:UIControlStateNormal];
        [_otherButton addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
        _otherButton.layer.borderWidth = 1;
        _otherButton.layer.borderColor = HColor(63, 204, 243).CGColor;
        _otherButton.layer.masksToBounds = YES;
        _otherButton.layer.cornerRadius = 42 * 0.5;
    }
    return _otherButton;
}
- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.backgroundColor = [UIColor clearColor];
    }
    return _titleLabel;
}

- (UILabel *)bodyTextLabel
{
    if (!_bodyTextLabel) {
        _bodyTextLabel = [[UILabel alloc] init];
        _bodyTextLabel.numberOfLines = 0;
        _bodyTextLabel.backgroundColor = [UIColor clearColor];
        _bodyTextLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _bodyTextLabel;
}

- (UITextView *)bodyTextView
{
    if (!_bodyTextView) {
        _bodyTextView = [[UITextView alloc] init];
        //        _bodyTextView.textAlignment = _contentAlignment;
        _bodyTextView.bounces = NO;
        _bodyTextView.backgroundColor = [UIColor clearColor];
        _bodyTextView.editable = NO;
    }
    return _bodyTextView;
}


#pragma mark -按钮点击事件
#pragma mark button action
- (void)buttonTapped:(id)sender
{
    UIButton *button = (UIButton *)sender;
    NSInteger tag = button.tag;
    self.clickedButtonIndex = tag;
    
    if ([self.delegate conformsToProtocol:@protocol(HAlertViewDelegate)]) {
        if ([self.delegate respondsToSelector:@selector(alertView:willDismissWithButtonIndex:)]) {
            // 调用代理函数
            [self.delegate alertView:self willDismissWithButtonIndex:tag];
        }
    }
    
    if (button == self.cancelButton) {
        if (self.cancelBlock) {
            self.cancelBlock();
        }
        [self dismiss];
    }
    else if (button == self.otherButton)
    {
        
        if (self.confirmBlock) {
            self.confirmBlock();
        }
        if (_shouldDismissAfterConfirm) {
            [self dismiss];
        }
    }
    
}

/***************************/
/**
 *  显示
 */
- (void)show
{
    if (_visible) {
        return;
    }
    _visible = YES;
    
    //[self registerObservers];//添加消息，在设备发生旋转时会有相应的处理
    //[self sizeToFitOrientation:NO];
    
    
    //如果栈中没有alertview,就表示maskWindow没有弹出，所以弹出maskWindow
    if (![HAlertView getStackTopAlertView]) {
        [HAlertView presentMaskWindow];
    }
    
    //如果有背景图片，添加背景图片
    if (nil != self.backgroundView && ![[gMaskWindow subviews] containsObject:self.backgroundView]) {
        [gMaskWindow addSubview:self.backgroundView];
    }
    //将alertView显示在window上
    [HAlertView addAlertViewOnMaskWindow:self];
    
    self.alpha = 1.0;
    
    //alertView弹出动画
    [self bounce0Animation];
}

/**
 *  把当前的alertView添加到当前队列中
 *
 *  @param alertView <#alertView description#>
 */
+ (void)addAlertViewOnMaskWindow:(HAlertView *)alertView{
    if (!gMaskWindow ||[gMaskWindow.subviews containsObject:alertView]) {
        return;
    }
    
    [gMaskWindow addSubview:alertView];
    alertView.hidden = NO;
    
    HAlertView *previousAlertView = [HAlertView getStackTopAlertView];
    if (previousAlertView) {
        previousAlertView.hidden = YES;
    }
    [HAlertView pushAlertViewInStack:alertView];
}

/**
 *  取得最靠前的window
 */
+ (void)presentMaskWindow{
    
    if (!gMaskWindow) {
        gMaskWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        
        //edited by gjf 修改alertview leavel
        gMaskWindow.windowLevel = UIWindowLevelStatusBar + BBAlertLeavel;
        gMaskWindow.backgroundColor = [UIColor clearColor];
        gMaskWindow.hidden = YES;
        
        // FIXME: window at index 0 is not awalys previous key window.
        gPreviouseKeyWindow = [[UIApplication sharedApplication].windows objectAtIndex:0];
        [gMaskWindow makeKeyAndVisible];
        
        // Fade in background
        gMaskWindow.alpha = 0;
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        gMaskWindow.alpha = 1;
        [UIView commitAnimations];
    }
}

/**
 *  消失
 */
- (void)dismiss
{
    if (!_visible) {
        return;
    }
    _visible = NO;
    
    UIView *__bgView = self->_backgroundView;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:kTransitionDuration];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(dismissAlertView)];
    self.alpha = 0;
    [UIView commitAnimations];
    
    if (__bgView && [[gMaskWindow subviews] containsObject:__bgView]) {
        [__bgView removeFromSuperview];
    }
}


- (void)dismissAlertView{
    [HAlertView removeAlertViewFormMaskWindow:self];
    
    // If there are no dialogs visible, dissmiss mask window too.
    if (![HAlertView getStackTopAlertView]) {
        [HAlertView dismissMaskWindow];
    }
    
    if ([self.delegate conformsToProtocol:@protocol(HAlertViewDelegate)]) {
        if ([self.delegate respondsToSelector:@selector(alertView:didDismissWithButtonIndex:)]) {
            [self.delegate alertView:self didDismissWithButtonIndex:self.clickedButtonIndex];
        }
    }
}
+ (void)removeAlertViewFormMaskWindow:(HAlertView *)alertView{
    if (!gMaskWindow || ![gMaskWindow.subviews containsObject:alertView]) {
        return;
    }
    
    [alertView removeFromSuperview];
    alertView.hidden = YES;
    
    [HAlertView popAlertViewFromStack];
    HAlertView *previousAlertView = [HAlertView getStackTopAlertView];
    if (previousAlertView) {
        previousAlertView.hidden = NO;
        [previousAlertView bounce0Animation];
    }
}


#pragma mark -出栈
+ (void)popAlertViewFromStack{
    if (![gAlertViewStack count]) {
        return;
    }
    [gAlertViewStack removeLastObject];
    
    if ([gAlertViewStack count] == 0) {
        gAlertViewStack = nil;
    }
}


#pragma mark -入栈
+ (void)pushAlertViewInStack:(HAlertView *)alertView{
    if (!gAlertViewStack) {
        gAlertViewStack = [[NSMutableArray alloc] init];
    }
    [gAlertViewStack addObject:alertView];
}


#pragma mark - 栈区顶层的view
+ (HAlertView *)getStackTopAlertView{
    HAlertView * topItem = nil;
    if (0 != [gAlertViewStack count]) {
        topItem = [gAlertViewStack lastObject];
    }
    return topItem;
}
+ (void)dismissMaskWindow{
    // make previouse window the key again
    if (gMaskWindow) {
        [gPreviouseKeyWindow makeKeyWindow];
        gPreviouseKeyWindow = nil;
        
        gMaskWindow = nil;
    }
}

#pragma mark block setter block构造器
- (void)setCancelBlock:(HZBasicActionBlock)block {
    _cancelBlock = [block copy];
}
- (void)setConfirmBlock:(HZBasicActionBlock)block {
    _confirmBlock = [block copy];
}









-(id)initWithBasicTitle:(NSString *)title
                message:(NSString *)message
                iconStr:(NSString *)iconName
               delegate:(id<HAlertViewDelegate>)delegate
      cancelButtonTitle:(NSString *)cancelButtonTitle
      otherButtonTitles:(NSString *)otherButtonTitle {
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        [self initData];
        _delegate = delegate;
        
        //标题
        CGFloat tX = 0;
        CGFloat tY = self.padding;
        CGFloat tW = HSYSALERTWIDTH;
        CGFloat tH = 14;
        
        CGFloat cX = 20;
        CGFloat cY = tY + tH + 25;
        CGFloat cW = HSYSALERTWIDTH - cX * 2;
        CGFloat cH = [message getSpaceLabelHeightwithSpeace:0 withFont:TITLEFONT(17) withWidth:cW];
        
        CGFloat contH = cH > 17 ? cH - 17 : 0;
        
        UIView *alertMainView = [[UIView alloc] init];
        alertMainView.frame = CGRectMake(0, 0, HSYSALERTWIDTH,HSYSALERTHEIGHT + contH);
        alertMainView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:alertMainView];
        
        self.titleLabel.text = title;
        self.titleLabel.font = TITLEFONT(12);
        self.titleLabel.textColor = [UIColor blackColor];
        self.titleLabel.adjustsFontSizeToFitWidth = YES;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.frame = CGRectMake(tX, tY, tW, tH);
        [alertMainView addSubview:self.titleLabel];
        
        UIColor * teColot =  HColor(44,200,247);
        if ([message containsString:@"异常"]) {
            teColot = HColor(246, 114, 42);
        }else {
            teColot = HColor(44,200,247);
        }
    
        self.bodyTextLabel.attributedText = [message stringWithParagraphlineSpeace:0 textColor:teColot textFont:TITLEFONT(17)];
        self.bodyTextLabel.frame = CGRectMake(cX, cY, cW, cH);
        [alertMainView addSubview:self.bodyTextLabel];

        self.contentView.backgroundColor = HColor(255, 255, 255);
        self.contentView.center = CGPointMake(self.centerX, self.centerY);
        self.contentView.layer.cornerRadius = 5;
        self.contentView.layer.masksToBounds = YES;
        
        self.contentView.bounds = CGRectMake(0, 0, HSYSALERTWIDTH, HSYSALERTHEIGHT + contH);
//
        
        //buttons
        CGFloat lineHeight = 42;
        CGFloat partButtonHeight = CGRectGetMaxY(self.bodyTextLabel.frame) + 25 + lineHeight * 0.5;
        
        if (cancelButtonTitle && otherButtonTitle) {
            [self.cancelButton.titleLabel setFont:SYSBUTTONFONT];
            [self.cancelButton setTitle:cancelButtonTitle forState:UIControlStateNormal];
            [self.cancelButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
            self.cancelButton.center = CGPointMake(self.contentView.width / 4,partButtonHeight);
            self.cancelButton.bounds = CGRectMake(0, 0, 114, lineHeight);
            [self.cancelButton setTag:0];
        
            
            [self.otherButton setTitle:otherButtonTitle forState:UIControlStateNormal];
            [self.otherButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
            self.otherButton.center = CGPointMake(self.contentView.width * 3 / 4,partButtonHeight);
            self.otherButton.bounds = CGRectMake(0, 0, 114, lineHeight);
            [self.otherButton.titleLabel setFont:SYSBUTTONFONT];
            [self.otherButton setTag:1];
            
            [alertMainView addSubview:self.cancelButton];
            [alertMainView addSubview:self.otherButton];
        }else if (cancelButtonTitle){
            
            [self.cancelButton setTitle:cancelButtonTitle?cancelButtonTitle:otherButtonTitle forState:UIControlStateNormal];
            [self.cancelButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
            [self.cancelButton.titleLabel setFont:SYSBUTTONFONT];
            self.cancelButton.center  = CGPointMake(self.contentView.width * 0.5, partButtonHeight);
            self.cancelButton.bounds = CGRectMake(0, 0, 114, lineHeight);
            [self.cancelButton setTag:0];
            [alertMainView addSubview:self.cancelButton];
        }else if (otherButtonTitle){
            
            [self.otherButton setTitle:cancelButtonTitle?cancelButtonTitle:otherButtonTitle forState:UIControlStateNormal];
            [self.otherButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
            [self.otherButton.titleLabel setFont:SYSBUTTONFONT];
            self.otherButton.center  = CGPointMake(self.contentView.width * 0.5, partButtonHeight);
            self.otherButton.bounds = CGRectMake(0, 0, 114, lineHeight);
            [self.otherButton setTag:0];
            [alertMainView addSubview:self.otherButton];
        }
    }
    
    return self;
}




-(id)initWithTitle:(NSString *)title
                message:(NSString *)message
               delegate:(id<HAlertViewDelegate>)delegate
      cancelButtonTitle:(NSString *)cancelButtonTitle
      otherButtonTitles:(NSString *)otherButtonTitle {
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        [self initData];
        _delegate = delegate;
        
        
        
        UIView *alertMainView = [[UIView alloc] init];
        alertMainView.frame = CGRectMake(0, 0, HSYSALERTWIDTH,HSYSALERTHEIGHT);
        alertMainView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:alertMainView];
        
        CGFloat tX = 70;
        CGFloat tY = 20;
        CGFloat tW = 36;
        CGFloat tH = 24;
        
        UILabel * takePhone = [[UILabel alloc] initWithFrame:CGRectMake(tX, tY, tW, tH)];
        takePhone.text = @"拍照";
        takePhone.textColor = HColor(0, 0, 0);
        takePhone.font = TITLEFONT(17);
        [alertMainView addSubview:takePhone];
        
        CGFloat pX = CGRectGetMaxX(takePhone.frame) + 15;
        CGFloat pY = tY;
        CGFloat pW = 50;
        CGFloat pH = 50;
        UIButton * phone = [UIButton buttonWithType:UIButtonTypeCustom];
        phone.frame = CGRectMake(pX, pY, pW, pH);
        [phone setImage:[UIImage imageNamed:@"take_phone_alert"] forState:UIControlStateNormal];
         [alertMainView addSubview:phone];
        
        
        
        
        self.contentView.backgroundColor = HColor(255, 255, 255);
        self.contentView.center = CGPointMake(self.centerX, self.centerY);
        self.contentView.layer.cornerRadius = 5;
        self.contentView.layer.masksToBounds = YES;
        self.contentView.bounds = CGRectMake(0, 0, HSYSALERTWIDTH, HSYSALERTHEIGHT);
        
        //buttons
        CGFloat lineHeight = 42;
        CGFloat partButtonHeight = HSYSALERTHEIGHT - 24 - lineHeight * 0.5;
        //CGRectGetMaxY(self.bodyTextLabel.frame) + 25 + lineHeight * 0.5;
        
        if (cancelButtonTitle && otherButtonTitle) {
            [self.cancelButton.titleLabel setFont:SYSBUTTONFONT];
            [self.cancelButton setTitle:cancelButtonTitle forState:UIControlStateNormal];
            [self.cancelButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
            self.cancelButton.center = CGPointMake(self.contentView.width / 4,partButtonHeight);
            self.cancelButton.bounds = CGRectMake(0, 0, 114, lineHeight);
            [self.cancelButton setTag:0];
            
            
            [self.otherButton setTitle:otherButtonTitle forState:UIControlStateNormal];
            [self.otherButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
            self.otherButton.center = CGPointMake(self.contentView.width * 3 / 4,partButtonHeight);
            self.otherButton.bounds = CGRectMake(0, 0, 114, lineHeight);
            [self.otherButton.titleLabel setFont:SYSBUTTONFONT];
            [self.otherButton setTag:1];
            
            [alertMainView addSubview:self.cancelButton];
            [alertMainView addSubview:self.otherButton];
        }else if (cancelButtonTitle){
            
            [self.cancelButton setTitle:cancelButtonTitle?cancelButtonTitle:otherButtonTitle forState:UIControlStateNormal];
            [self.cancelButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
            [self.cancelButton.titleLabel setFont:SYSBUTTONFONT];
            self.cancelButton.center  = CGPointMake(self.contentView.width * 0.5, partButtonHeight);
            self.cancelButton.bounds = CGRectMake(0, 0, 114, lineHeight);
            [self.cancelButton setTag:0];
            [alertMainView addSubview:self.cancelButton];
        }else if (otherButtonTitle){
            
            [self.otherButton setTitle:cancelButtonTitle?cancelButtonTitle:otherButtonTitle forState:UIControlStateNormal];
            [self.otherButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
            [self.otherButton.titleLabel setFont:SYSBUTTONFONT];
            self.otherButton.center  = CGPointMake(self.contentView.width * 0.5, partButtonHeight);
            self.otherButton.bounds = CGRectMake(0, 0, 114, lineHeight);
            [self.otherButton setTag:0];
            [alertMainView addSubview:self.otherButton];
        }
    }
    
    return self;
}










- (void)dealloc {
    _delegate = nil;
    _cancelBlock = nil;
    _confirmBlock = nil;
    [self removeObserver:self forKeyPath:@"dimBackground"];
    [self removeObserver:self forKeyPath:@"contentAlignment"];
}

/**
 *  初始化数据
 */
- (void)initData {
    self.padding = 17;
    self.shouldDismissAfterConfirm = YES;
    //_dimBackground = YES;
    self.backgroundColor = [UIColor clearColor];
    //_contentAlignment = UITextAlignmentCenter;
    
    [self addObserver:self  forKeyPath:@"dimBackground"   options:NSKeyValueObservingOptionNew  context:NULL];
    
    [self addObserver:self  forKeyPath:@"contentAlignment"  options:NSKeyValueObservingOptionNew   context:NULL];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if ([keyPath isEqualToString:@"dimBackground"]) {
        [self setNeedsDisplay];
    }else if ([keyPath isEqualToString:@"contentAlignment"]){
        //self.bodyTextLabel.textAlignment = self.contentAlignment;
        //self.bodyTextView.textAlignment = self.contentAlignment;
    }
}











/**
 *  画背景渐变效果
 */
-(void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    size_t gradLocationsNum = 2;
    CGFloat gradLocations[2] = {0.0f, 0.0f};
    CGFloat gradColors[8] = {
        0.0f,0.0f,0.0f,
        0.0f,0.0f,0.0f,
        0.0f,0.40f
    };
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, gradColors, gradLocations, gradLocationsNum);
    CGColorSpaceRelease(colorSpace);
    //Gradient center
    CGPoint gradCenter = self.contentView.center;
    //Gradient radius
    float gradRadius = 320 ;
    //Gradient draw
    CGContextDrawRadialGradient (context, gradient, gradCenter,
                                 0, gradCenter, gradRadius,
                                 kCGGradientDrawsAfterEndLocation);
    CGGradientRelease(gradient);
}

#pragma mark -
#pragma mark animation
- (void)bounce0Animation{
    self.contentView.transform = CGAffineTransformScale([self transformForOrientation], 0.001f, 0.001f);
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:kTransitionDuration/1.5f];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(bounce1AnimationDidStop)];
    self.contentView.transform = CGAffineTransformScale([self transformForOrientation], 1.1f, 1.1f);
    [UIView commitAnimations];
}

- (void)bounce1AnimationDidStop{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:kTransitionDuration/2];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(bounce2AnimationDidStop)];
    self.contentView.transform = CGAffineTransformScale([self transformForOrientation], 0.9f, 0.9f);
    [UIView commitAnimations];
}

- (void)bounce2AnimationDidStop{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:kTransitionDuration/2];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(bounceDidStop)];
    self.contentView.transform = [self transformForOrientation];
    [UIView commitAnimations];
}

- (void)bounceDidStop{
    
}

- (CGAffineTransform)transformForOrientation
{
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    if (orientation == UIInterfaceOrientationLandscapeLeft) {
        return CGAffineTransformMakeRotation(M_PI*1.5f);
    } else if (orientation == UIInterfaceOrientationLandscapeRight) {
        return CGAffineTransformMakeRotation(M_PI/2.0f);
    } else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
        return CGAffineTransformMakeRotation(-M_PI);
    } else {
        return CGAffineTransformIdentity;
    }
}

/**
 *  计算字体size
 *
 *  @param text    <#text description#>
 *  @param font    <#font description#>
 *  @param maxSize <#maxSize description#>
 *
 *  @return <#return value description#>
 */
+ (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize {
    NSDictionary * attrs = @{NSFontAttributeName : font};
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UIView * hitView=[self hitTest:[[touches anyObject] locationInView:self] withEvent:nil];
    if (hitView == self) {
        //        NSLog(@"touches moved in the view");
        //        [self dismiss];
    }else{
        //        NSLog(@"touches moved in the subview");
    }
}

/**
 *  画线FUNC
 *
 *  @param rect <#rect description#>
 */
-(void)dracetLine:(CGRect)rect {
    UIView * lineView = [[UIView alloc] initWithFrame:rect];
    lineView.backgroundColor = HColor(225, 225, 225);
    [self.contentView addSubview:lineView];
}
-(void)dracetLine:(CGRect)rect backGroundColor:(UIColor *)color {
    UIView * lineView = [[UIView alloc] initWithFrame:rect];
    lineView.backgroundColor = color;//HColor(218, 218, 222);
    [self.contentView addSubview:lineView];
}

- (NSAttributedString *)stringWithUIImage:(NSString *) contentStr {
    // 设置段落
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 5;
    NSDictionary *attributes = @{ NSParagraphStyleAttributeName:paragraphStyle};
    
    // 创建一个富文本
    NSMutableAttributedString * attriStr = [[NSMutableAttributedString alloc] initWithString:contentStr attributes:attributes];
    // 修改富文本中的不同文字的样式-----手机号修改成功
    [attriStr addAttribute:NSForegroundColorAttributeName value:HColor(68, 68, 68) range:NSMakeRange(0, 8)];
    [attriStr addAttribute:NSFontAttributeName value:HFONT(15) range:NSMakeRange(0, 8)];
    // 修改富文本中的不同文字的样式-----您的新手机号:
    [attriStr addAttribute:NSForegroundColorAttributeName value:HColor(136, 136, 136) range:NSMakeRange(8, 9)];
    [attriStr addAttribute:NSFontAttributeName value:HFONT(11) range:NSMakeRange(8, 9)];
    
    //    // 修改富文本中的不同文字的样式-----15010206793
    [attriStr addAttribute:NSForegroundColorAttributeName value:HColor(247, 87, 16) range:NSMakeRange(15, 12)];
    [attriStr addAttribute:NSFontAttributeName value:HFONT(11) range:NSMakeRange(15, 12)];
    
    return attriStr;
}





@end
