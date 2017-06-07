//
//  WebImageDetailView.m
//  NingboSat
//
//  Created by ysyc_liu on 16/10/6.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "WebImageDetailView.h"
#import "Masonry.h"
#import "Config.h"
#import "UIImageView+WebCache.h"

static NSMutableArray * sg_webImageDetailArray = nil;
#define kScreenWidth SCREEN_WIDTH
#define kScreenHeight SCREEN_HEIGHT

@interface WebImageDetailView()<UIScrollViewDelegate>
{
    
    BOOL isTwiceTaping;
    BOOL _isDoubleTapingForZoom;
    BOOL _isTwiceTaping;
    CGFloat _currentScale;
    CGFloat _sourceScale;
    CGFloat _touchX;
    CGFloat _touchY;
    CGFloat _offsetY;
    
    UIImageView *_imgView;
    UIScrollView *_scrollView;
}

@property (nonatomic, copy)NSString *urlStr;

@end

@implementation WebImageDetailView

+ (void)loadImageByURLStr:(NSString *)urlStr {
    if (!sg_webImageDetailArray) {
        sg_webImageDetailArray = [NSMutableArray array];
    }
    
    WebImageDetailView *imageView = [[self alloc] initWithUrlStr:urlStr];
    [sg_webImageDetailArray addObject:imageView];
    [imageView show];
}


- (instancetype)initWithUrlStr:(NSString *)urlStr {
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        self.windowLevel = UIWindowLevelStatusBar + 0.1;
        self.alpha = 0;
        
        self.urlStr = urlStr;
        
        [self initView];
    }
    
    return self;
}

- (void)initView {
    UIScrollView *bgView = [[UIScrollView alloc] initWithFrame:self.bounds];
    bgView.delegate = self;
    bgView.maximumZoomScale = 5.0;
    bgView.minimumZoomScale = 1.0;
    [self addSubview:bgView];
    _scrollView = bgView;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:bgView.bounds];
    [bgView addSubview:imageView];
    imageView.userInteractionEnabled = YES;
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.urlStr]];
//    imageView.image = [UIImage imageNamed:@"query_banner"];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    _imgView = imageView;
    _sourceScale = MIN(imageView.image.size.width / SCREEN_WIDTH, imageView.image.size.height / SCREEN_HEIGHT);
    _currentScale = _sourceScale;
    
    
    bgView.contentSize = self.bounds.size;
    
    
    UITapGestureRecognizer *tapImgView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImgViewHandle)];
    tapImgView.numberOfTapsRequired = 1;
    tapImgView.numberOfTouchesRequired = 1;
    [self addGestureRecognizer:tapImgView];
    
    UITapGestureRecognizer *tapImgViewTwice = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImgViewHandleTwice:)];
    tapImgViewTwice.numberOfTapsRequired = 2;
    tapImgViewTwice.numberOfTouchesRequired = 1;
    [self addGestureRecognizer:tapImgViewTwice];
    [tapImgView requireGestureRecognizerToFail:tapImgViewTwice];
}

- (void)show {
    self.hidden = NO;
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 1;
    }];
}

- (void)dismiss {
    [UIView animateWithDuration:0.1 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        self.hidden = YES;
        [self resignKeyWindow];
        [sg_webImageDetailArray removeObject:self];
    }];
}

#pragma mark - UIscrollViewDelegate zoom

-(void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale{
    _currentScale = scale;
}
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return _imgView;
}
-(void)scrollViewDidZoom:(UIScrollView *)scrollView{
    //当捏或移动时，需要对center重新定义以达到正确显示未知
    CGFloat xcenter = scrollView.center.x,ycenter = scrollView.center.y;
    NSLog(@"adjust position,x:%f,y:%f",xcenter,ycenter);
    xcenter = scrollView.contentSize.width > scrollView.frame.size.width?scrollView.contentSize.width/2 :xcenter;
    ycenter = scrollView.contentSize.height > scrollView.frame.size.height ?scrollView.contentSize.height/2 : ycenter;
    //双击放大时，图片不能越界，否则会出现空白。因此需要对边界值进行限制。
    if(_isDoubleTapingForZoom){
        NSLog(@"taping center");
        xcenter = _currentScale*(kScreenWidth - _touchX);
        ycenter = _currentScale*(kScreenHeight - _touchY);
        if(xcenter > (_currentScale - 0.5)*kScreenWidth){//放大后左边超界
            xcenter = (_currentScale - 0.5)*kScreenWidth;
        }else if(xcenter <0.5*kScreenWidth){//放大后右边超界
            xcenter = 0.5*kScreenWidth;
        }
        if(ycenter > (_currentScale - 0.5)*kScreenHeight){//放大后左边超界
            ycenter = (_currentScale - 0.5)*kScreenHeight +_offsetY*_currentScale;
        }else if(ycenter <0.5*kScreenHeight){//放大后右边超界
            ycenter = 0.5*kScreenHeight +_offsetY*_currentScale;
        }
        NSLog(@"adjust postion sucess, x:%f,y:%f",xcenter,ycenter);
    }
    [_imgView setCenter:CGPointMake(xcenter, ycenter)];
}

#pragma mark - tap
-(void)tapImgViewHandle{
    NSLog(@"%d",_isTwiceTaping);
    if(_isTwiceTaping){
        return;
    }
    
    [UIView animateWithDuration:0.1
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         _imgView.frame = CGRectMake(_scrollView.contentOffset.x+SCREEN_WIDTH/2, _scrollView.contentOffset.y+SCREEN_HEIGHT/2, 0, 0);
                         self.alpha = 0.0;
                     }
                     completion:^(BOOL finished){
                         [self dismiss];
                     }
     ];
    
}

-(void)tapImgViewHandleTwice:(UIGestureRecognizer *)sender{
    _touchX = [sender locationInView:sender.view].x;
    _touchY = [sender locationInView:sender.view].y;
    if(_isTwiceTaping){
        return;
    }
    _isTwiceTaping = YES;
    
    _currentScale += 1;
    [_scrollView setZoomScale:_currentScale animated:YES];
    
    _isDoubleTapingForZoom = NO;
    //延时做标记判断，使用户点击3次时的单击效果不生效。
    [self performSelector:@selector(twiceTaping) withObject:nil afterDelay:0.65];
}

-(void)twiceTaping{
    NSLog(@"no");
    _isTwiceTaping = NO;
}

@end
