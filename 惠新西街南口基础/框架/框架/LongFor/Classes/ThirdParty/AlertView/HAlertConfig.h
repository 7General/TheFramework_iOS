//
//  HAlertConfig.h
//  AlertView
//
//  Created by 王会洲 on 16/9/21.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#ifndef HAlertConfig_h
#define HAlertConfig_h

/**新设置界面属性*/
#define HSYSALERTWIDTH 286
#define HSYSALERTHEIGHT 156
// 距离左右间距
#define HSYSALERTPADDING 48
// 系统内容宽度 =  alet宽度 - （左边距 + 右边距）
#define HSYSCONTENTWIDTH (HSYSALERTWIDTH - (HSYSALERTPADDING * 2))
#define BBAlertLeavel  300

#define SYSBUTTONFONT [UIFont systemFontOfSize:15.0f]


#define TITLEFONT(obj) [UIFont fontWithName:@"STHeitiSC-Light" size:obj]
#define CONTENTFONT [UIFont systemFontOfSize:16.0f]

#define HColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define HFONT(obj) [UIFont fontWithName:@"STHeitiSC-Light" size:obj]

// 系统底部按钮高度
#define buttonPartHeight 44
#endif /* HAlertConfig_h */
