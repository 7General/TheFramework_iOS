//
//  MailResultController.m
//  NingboSat
//
//  Created by ysyc_liu on 16/9/14.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "MailResultController.h"
#import "Masonry.h"
#import "Config.h"
#import "UIButton+YSSolidColorButton.h"

@interface MailResultController()

@property (nonatomic, strong)UILabel *phoneLabel;

@end

@implementation MailResultController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"申请结果";
    self.view.backgroundColor = YSColor(0xfa, 0xfa, 0xfa);
    
    [self initView];
}

- (void)initView {
    UIView * previousView = nil;
    {
        UIImage *image = [UIImage imageNamed:@"successIcon"];
        UIImageView * imageView = [[UIImageView alloc] initWithImage:image];
        [self.view addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).mas_offset(46);
            make.centerX.equalTo(self.view);
        }];
        
        previousView = imageView;
    }
    
    {
        UILabel * label = [[UILabel alloc] init];
        [self.view addSubview:label];
        label.font = FONT_BOLD_BY_SCREEN(19);
        label.textColor = YSColor(0x44, 0x44, 0x44);
        label.text = @"提交成功";
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(previousView.mas_bottom).offset(20);
            make.centerX.equalTo(self.view);
        }];
        
        previousView = label;
    }
    
    {
        UILabel * label = [[UILabel alloc] init];
        [self.view addSubview:label];
        label.font = FONT_BY_SCREEN(13);
        label.textColor = YSColor(0xb4, 0xb4, 0xb4);
        label.numberOfLines = 0;
        label.text = @"如果您提供的资料真实、完整、准确，符合条件，我们承诺受理即办，并将短信通知您。";
        label.textAlignment = NSTextAlignmentCenter;
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(previousView.mas_bottom).offset(19);
            make.left.equalTo(self.view).offset(15);
            make.right.equalTo(self.view).offset(-15);
        }];
        
        previousView = label;
    }
    
    UIView *splitLine = nil;
    {
        UIView * line = [[UIView alloc] init];
        [self.view addSubview:line];
//        line.backgroundColor = YSColor(0xcc, 0xcc, 0xcc);
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(previousView.mas_bottom).offset(6);
            make.left.and.right.equalTo(previousView);
            make.height.mas_equalTo(0.5);
        }];
        splitLine = line;
        previousView = line;
    }
    
    {
        UILabel * label = [[UILabel alloc] init];
        [self.view addSubview:label];
        label.font = FONT_BY_SCREEN(13);
        label.textColor = YSColor(0xb4, 0xb4, 0xb4);
        label.text = @"将向您的收票人手机发送通知短信";
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(previousView.mas_bottom).offset(15);
            make.centerX.equalTo(self.view);
        }];
        
        previousView = label;
    }
    
    {
        UILabel * label = [[UILabel alloc] init];
        [self.view addSubview:label];
        label.font = FONT_BOLD_BY_SCREEN(25);
        label.textColor = YSColor(0x50, 0x50, 0x50);
        label.text = self.phoneNum;//@"18600282345";
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(previousView.mas_bottom).offset(6);
            make.centerX.equalTo(self.view);
        }];
        
        previousView = label;
        self.phoneLabel = label;
    }
    
    {
        [self.view layoutIfNeeded];
        CGFloat topOffset = (CGRectGetHeight(self.view.bounds) - CGRectGetMaxY(previousView.frame) - 64) / 2;
        UIButton *button = [UIButton buttonWithColor:YSColor(0x4b, 0xc4, 0xfb) title:@"关闭"];
        [self.view addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view).offset(35);
            make.right.equalTo(self.view).offset(-35);
            make.centerY.equalTo(previousView.mas_centerY).offset(topOffset);
            make.height.mas_equalTo(44);
        }];
        
        [button addTarget:self action:@selector(commitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [[self class] drawDashLine:splitLine lineLength:3 lineSpacing:1 lineColor:YSColor(0xcc, 0xcc, 0xcc)];
}

#pragma mark - button click action
- (void)commitBtnClick {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

/**
 *  绘制虚线.
 *
 *  @param lineView    需要绘制成虚线的view.
 *  @param lineLength  虚线的宽度.
 *  @param lineSpacing 虚线的间距.
 *  @param lineColor   虚线的颜色.
 */
+ (void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:lineView.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame))];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:lineColor.CGColor];
    //  设置虚线宽度
    [shapeLayer setLineWidth:CGRectGetHeight(lineView.frame)];
    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, CGRectGetWidth(lineView.frame), 0);
    [shapeLayer setPath:path];
    CGPathRelease(path);
    //  把绘制好的虚线添加上来
    [lineView.layer addSublayer:shapeLayer];
}

@end
