//
//  CustomConfig.h
//  NingboSat
//
//  Created by 王会洲 on 16/9/6.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#ifndef CustomConfig_h
#define CustomConfig_h

#define YSTabBarButtonRation 0.6

// 1.判断是否为iOS7
#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)

// 2.获得RGB颜色
#define YColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

// 按钮的默认文字颜色
#define YSTabBarButtonTitleColor YColor(80,80,80)
//
#define YSTabBarButtonTitleSelectedColor YColor(21,85,200)

#endif /* CustomConfig_h */
