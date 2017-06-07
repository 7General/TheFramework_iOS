//
//  YSTabBarButton.h
//  NingboSat
//
//  Created by 王会洲 on 16/9/6.
//  Copyright © 2016年 王会洲. All rights reserved.
//



#import "YSTabBarButton.h"
//#import "Config.h"
#import "YSBadgeButton.h"

@interface YSTabBarButton ()
//提醒数字
@property (nonatomic, weak)YSBadgeButton * badgeButton;

@end
@implementation YSTabBarButton
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView.contentMode = UIViewContentModeCenter;
        //self.imageView.backgroundColor = [UIColor redColor];
        //self.titleLabel.backgroundColor = [UIColor yellowColor];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:11];
        [self setTitleColor:YSTabBarButtonTitleColor  forState:UIControlStateNormal];
        [self setTitleColor:YSTabBarButtonTitleSelectedColor forState:UIControlStateSelected];
//        if (!iOS7) {
//             [self setBackgroundImage:[UIImage imageNamed:@"tabbar_home_selected"] forState:UIControlStateSelected];
//        }
        //添加一个提醒数字
        YSBadgeButton *badgeButton = [[YSBadgeButton alloc]init];
        ////
        badgeButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin;
        
        [self addSubview:badgeButton];
        self.badgeButton = badgeButton;
        
    }
    return self;
}

///不需要高亮状态
- (void)setHighlighted:(BOOL)highlighted {}


- (void)setItem:(UITabBarItem *)item {
    _item = item;
    
    [item addObserver:self forKeyPath:@"badgeValue" options:0 context:nil];
    [item addObserver:self forKeyPath:@"title" options:0 context:nil];
    [item addObserver:self forKeyPath:@"image" options:0 context:nil];
    [item addObserver:self forKeyPath:@"selectedImage" options:0 context:nil];
    
    
    [self observeValueForKeyPath:nil ofObject:nil change:nil context:nil];
    
}

-(void)dealloc {
    
    [self.item removeObserver:self forKeyPath:@"badgeValue"];
    [self.item removeObserver:self forKeyPath:@"title"];
    [self.item removeObserver:self forKeyPath:@"image"];
    [self.item removeObserver:self forKeyPath:@"selectedImage"];
}



// 监听到某个对象属性改变了,就会调用
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    
    [self setTitle:self.item.title forState:UIControlStateNormal];
    [self setTitle:self.item.title forState:UIControlStateSelected];
    [self setImage:self.item.image forState:UIControlStateNormal];
    [self setImage:self.item.selectedImage forState:UIControlStateSelected];
    
    
    //设置提醒数字
    self.badgeButton.badgeValue = self.item.badgeValue;
    
    // 设置提醒数字的位置
    //设置frame
    CGFloat badgeY = 5;
    CGFloat badgeX = self.frame.size.width - self.badgeButton.frame.size.width - 10;
    
    CGRect badgeF = self.badgeButton.frame;
    badgeF.origin.x = badgeX;
    badgeF.origin.y = badgeY;
    self.badgeButton.frame = badgeF;
    
    
    
    //CGFloat badgeX = self.frame.size.width - badgeW - 5;
    //self.frame = CGRectMake(badgeX, badgeY, badgeW, badgeH);
    
    
}


- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize {
    NSDictionary * attrs = @{NSFontAttributeName : font};
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    CGFloat imageW = contentRect.size.width;
    CGFloat imageH = contentRect.size.height * YSTabBarButtonRation;
    return CGRectMake(0, 4, imageW, imageH);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    CGFloat titleY = contentRect.size.height * YSTabBarButtonRation;
    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = contentRect.size.height - titleY;
    return CGRectMake(0, titleY - 1, titleW, titleH);
}




@end
