//
//  MBProgressHUD+DN.h
//  DNProject
//
//  Created by zjs on 2018/5/9.
//  Copyright © 2018年 zjs. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (DN)

/**
 *  @brief 自定义图片
 *
 *  @param iconName 自定义图片名称
 *  @param title    标题
 *  @param view     父视图
 */
+ (void)showCustomIcon:(NSString *)iconName title:(NSString *)title ToView:(UIView *)view;

/**
 *  @brief 成功弹窗（默认图）
 *
 *  @param successMsg 提示信息
 *  @param view       父视图
 */
+ (void)showSuccess:(NSString *)successMsg toView:(UIView *)view;

/**
 *  @brief 失败弹窗（默认图）
 *
 *  @param errorMsg 提示信息
 *  @param view     父视图
 */
+ (void)showError:(NSString *)errorMsg toView:(UIView *)view;

/**
 *  @brief 自动消失（默认图）
 *
 *  @param info     提示信息
 *  @param view     父视图
 */
+ (void)showInfo:(NSString *)info toView:(UIView *)view;


/**
 *  @brief 自动消失（默认图）
 *
 *  @param warn     提示信息
 *  @param view     父视图
 */
+ (void)showWarn:(NSString *)warn toView:(UIView *)view;

/**
 *  @brief 自动消失
 *
 *  @param message  提示信息
 *  @param view     父视图
 */
+ (void)showAutoDismissMessage:(NSString *)message toView:(UIView *)view;

/**
 *  @brief 自定义停留时间，有图
 *
 *  @param message 提示信息
 *  @param view    要添加的View
 *  @param time    停留时间
 */
+(void)showIconMessage:(NSString *)message ToView:(UIView *)view RemainTime:(CGFloat)time;


/**
 *  @brief 自定义停留时间，无图
 *
 *  @param message  提示信息
 *  @param view     要添加的View
 *  @param time     停留时间
 */
+(void)showMessage:(NSString *)message ToView:(UIView *)view RemainTime:(CGFloat)time;

/**
 *  @brief  快速显示一条消息
 *
 *  @param  message 提示信息
 */
+ (void)showFastMessage:(NSString *)message;

/**
 *  @brief  隐藏弹窗
 */
+ (void)hideHUDForView:(UIView *)view;

@end
