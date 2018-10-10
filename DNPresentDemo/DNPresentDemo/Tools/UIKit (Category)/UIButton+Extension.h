//
//  UIButton+Extension.h
//  DNProject
//
//  Created by zjs on 2018/5/18.
//  Copyright © 2018年 zjs. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^TouchHandler)(void);

typedef NS_ENUM(NSInteger, DNButtonEdgeInsetStyle) {
    // 图片在上，文字在下
    DNButtonEdgeInsetStyleTop,
    // 图片在左，文字在右
    DNButtonEdgeInsetStyleLeft,
    // 图片在下，文字在上
    DNButtonEdgeInsetStyleBottom,
    // 图片在右，文字在左
    DNButtonEdgeInsetStyleRight
};

@interface UIButton (Extension)


- (void)dn_setButtonConfig:(void(^)(UIButton *button))buttonHandler;

/**
 *  @brief  快速创建一个按钮
 *
 *  @param  title       点击回调
 *  @param  titleFont   字体大小
 *  @param  titleColor  字体颜色
 */
+ (UIButton *)dn_buttonWithTitle:(NSString *)title titleFont:(CGFloat)titleFont titleColor:(UIColor *)titleColor;

/**
 *  @brief  按钮点击事件
 *
 *  @param  touchHandler 点击回调
 */
- (void)dn_addActionHandler:(TouchHandler)touchHandler;

- (void)dn_addActionHandler:(TouchHandler)touchHandler forCntrolEvents:(UIControlEvents)events;


/**
 *  @brief  使用颜色设置按钮背景
 *
 *  @param backgroundColor 背景颜色
 *  @param state           按钮状态
 */
- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;


/**
 *  @brief  按钮图文显示
 *
 *  @param  style   图文排列方式
 *  @prama  space   图文相距间隔
 */
- (void)dn_layoutButtonEdgeInsetStyle:(DNButtonEdgeInsetStyle)style imageTitlespace:(CGFloat)space;

- (void)dn_layoutButtonEdgeInset:(DNButtonEdgeInsetStyle)style space:(CGFloat)space;

/**
 *  @brief  倒计时按钮
 *
 *  @param time        倒计时时间
 *  @param startBlock  开始回调
 *  @param finishBlock 完成回调
 */
- (void)dn_startWithTime:(NSInteger)time startBlock:(void(^)(void))startBlock finishBlock:(void(^)(void))finishBlock;

/**
 *  @brief 倒计时按钮
 
 *  @param time        倒计时时间
 *  @param title       未开始时title
 *  @param downTitle   开始倒计时标题
 */
- (void)dn_startWithTime:(NSInteger)time title:(NSString *)title downTitle:(NSString *)downTitle;

@end

NS_ASSUME_NONNULL_END
