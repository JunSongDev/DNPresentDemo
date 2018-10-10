//
//  MBProgressHUD+DN.m
//  DNProject
//
//  Created by zjs on 2018/5/9.
//  Copyright © 2018年 zjs. All rights reserved.
//

#import "MBProgressHUD+DN.h"

@implementation MBProgressHUD (DN)


+ (void)showSuccess:(NSString *)successMsg toView:(UIView *)view
{
    return [self showCustomIcon:@"MBHUD_Success" title:successMsg ToView:view];;
}

+ (void)showError:(NSString *)errorMsg toView:(UIView *)view
{
    return [self showCustomIcon:@"MBHUD_Error" title:errorMsg ToView:view];
}

+ (void)showInfo:(NSString *)info toView:(UIView *)view
{
    return [self showCustomIcon:@"MBHUD_Info" title:info ToView:view];
}

+ (void)showWarn:(NSString *)warn toView:(UIView *)view
{
    return [self showCustomIcon:@"MBHUD_Warn" title:warn ToView:view];
}

// 自动消失，无图
+ (void)showAutoDismissMessage:(NSString *)message toView:(UIView *)view {
    
    return [self showMessage:message ToView:view RemainTime:1 Model:MBProgressHUDModeText];
}
// 自定义时间，有图
+ (void)showIconMessage:(NSString *)message ToView:(UIView *)view RemainTime:(CGFloat)time
{
    return [self showMessage:message ToView:view RemainTime:time Model:MBProgressHUDModeIndeterminate];
}
// 自定义时间，无图
+ (void)showMessage:(NSString *)message ToView:(UIView *)view RemainTime:(CGFloat)time {
    
    return [self showMessage:message ToView:view RemainTime:time Model:MBProgressHUDModeText];
}

// 快速显示一条
+ (void)showFastMessage:(NSString *)message {
    
    return [self showAutoDismissMessage:message toView:nil];
}
/**
 *  隐藏弹窗
 */
+ (void)hideHUDForView:(UIView *)view{
    
    if (view == nil) {
        view = [UIApplication sharedApplication].delegate.window;
    }
    [self hideHUDForView:view animated:YES];
}

+ (void)showMessage:(NSString *)message ToView:(UIView *)view RemainTime:(CGFloat)time Model:(MBProgressHUDMode)model{

    if (view == nil) {
        view = [UIApplication sharedApplication].delegate.window;
    }
    // 创建提示框
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    // 提示信息
    hud.label.text = message;
    hud.label.font = [UIFont systemFontOfSize:15];
    // 设置模式
    hud.mode = model;
    // 蒙版
    hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
    // 隐藏时从俯视图移除
    hud.removeFromSuperViewOnHide = YES;
    // time 后消失
    [hud hideAnimated:YES afterDelay:time];
}

+ (void)showCustomIcon:(NSString *)iconName title:(NSString *)title ToView:(UIView *)view{
    
    if (view == nil) {
        view = [UIApplication sharedApplication].delegate.window;
    }
    // 创建提示框
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    // 提示信息
    hud.label.text = title;
    hud.label.font = [UIFont systemFontOfSize:15];
    // 添加自定义图片为 customView
    hud.customView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:iconName]];
    // 设置模式
    hud.mode = MBProgressHUDModeCustomView;
    // 蒙版
    hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
    // 隐藏时从俯视图移除
    hud.removeFromSuperViewOnHide = YES;
    // 3 秒后消失
    [hud hideAnimated:YES afterDelay:1];
}
@end
