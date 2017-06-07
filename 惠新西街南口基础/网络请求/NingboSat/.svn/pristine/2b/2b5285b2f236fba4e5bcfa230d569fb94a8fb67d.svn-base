//
//  AboutUsViewController.m
//  NingboSat
//
//  Created by 田广 on 16/9/20.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "AboutUsViewController.h"
#import "Masonry.h"
#import "Config.h"

@interface AboutUsViewController ()

@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"关于";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initView];
}

- (void)initView {
    UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"AboutUsBg"] stretchableImageWithLeftCapWidth:0.5 topCapHeight:0.5]];
    [self.view addSubview:bgImageView];
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    bgImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    UIImageView *logoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"AboutUsLogoIcon"]];
    [self.view addSubview:logoImageView];
    [logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(66);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(logoImageView.image.size);
    }];
    
    UILabel *versionLabel = [[UILabel alloc] init];
    [self.view addSubview:versionLabel];
    versionLabel.font = FONT_BY_SCREEN(15);
    versionLabel.textColor = YSColor(0x50, 0x50, 0x50);
    versionLabel.text = [NSString stringWithFormat:@"宁波国税 V%@", APP_VERSION];
    [versionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(logoImageView.mas_bottom).offset(10);
        make.centerX.equalTo(self.view);
    }];
    
    UILabel *copyrightLabel = [[UILabel alloc] init];
    [self.view addSubview:copyrightLabel];
    copyrightLabel.font = FONT_BY_SCREEN(13);
    copyrightLabel.textColor = YSColor(0x50, 0x50, 0x50);
    copyrightLabel.text = [NSString stringWithFormat:@"Copyright©2016,宁波国税"];
    [copyrightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-20);
        make.centerX.equalTo(self.view);
    }];
}

@end
