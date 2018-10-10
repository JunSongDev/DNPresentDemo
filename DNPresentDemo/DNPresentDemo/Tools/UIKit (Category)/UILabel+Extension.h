//
//  UILabel+Extension.h
//  DNProject
//
//  Created by zjs on 2018/7/20.
//  Copyright © 2018年 zjs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Extension)

/**
 *  @brief  快速创建一个 label
 *
 *  @param  text          文本
 *  @param  textFont      字体大小
 *  @param  textColor     文本颜色
 *  @param  textAligment  对齐方式
 */
+ (UILabel *)dn_labelWithText:(NSString *)text
                     textFont:(CGFloat)textFont
                    textColor:(UIColor *)textColor
                 textAligment:(NSTextAlignment)textAligment;

@end
