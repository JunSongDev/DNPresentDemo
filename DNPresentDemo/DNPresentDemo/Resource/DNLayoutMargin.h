//
//  DNLayoutMargin.h
//  DNPresentDemo
//
//  Created by zjs on 2018/10/10.
//  Copyright © 2018 zjs. All rights reserved.
//

#ifndef DNLayoutMargin_h
#define DNLayoutMargin_h


// 国际化
#define Localized(name) NSLocalizedString(name, nil)

// 自定义 NSLog
#ifdef DEBUG
#define DNLog(fmt, ...) NSLog((@"[文件名:%s]\n" "[函数名:%s]\n" "[行号:%d] \n" fmt), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DNLog(...);
#endif

// weak 弱引用
#define DNWeak(name)        __weak typeof(name) weak##name = name;

// 图片
#define IMAGE(name)         [UIImage imageNamed:name]

// 颜色
#define RGB(r, g, b, a)     [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define TABLEVIEW_COLOR     RGB(225, 225, 225, 0.6)

// 屏幕宽高
#define SCREEN_W    [UIScreen mainScreen].bounds.size.width
#define SCREEN_H    [UIScreen mainScreen].bounds.size.height

// 自适应字体大小
#define AUTO_FONT_SIZE(size)           size*(SCREEN_W/375.0)
#define AUTO_SYSTEM_FONT_SIZE(size)    [UIFont systemFontOfSize:AUTO_FONT_SIZE(size)]

// 自适应边距
#define AUTO_MARGIN(margin)            margin*(SCREEN_W/375.0)

//IphoneX适配
//#define iPhone_X ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone_X (([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone) && ([[[UIApplication sharedApplication] delegate] window].safeAreaInsets.bottom > 0.0))

//Iphone4S
#define iPhone_4s ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(320, 480), [[UIScreen mainScreen] currentMode].size) : NO)

// 状态栏高度
#define STATUS_BAR_HEIGHT (iPhone_X ? 44.f : 20.f)

// 导航栏高度
#define NAVIGATION_BAR_HEIGHT (iPhone_X ? 88.f : 64.f)

// tabBar高度
#define TAB_BAR_HEIGHT (iPhone_X ? (49.f+34.f) : 49.f)

// home indicator
#define HOME_INDICATOR_HEIGHT (iPhone_X ? 34.f : 0.f)

#endif /* DNLayoutMargin_h */
