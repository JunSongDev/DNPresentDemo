//
//  UILabel+Extension.m
//  DNProject
//
//  Created by zjs on 2018/7/20.
//  Copyright © 2018年 zjs. All rights reserved.
//

#import "UILabel+Extension.h"

@implementation UILabel (Extension)

+ (UILabel *)dn_labelWithText:(NSString *)text
                     textFont:(CGFloat)textFont
                    textColor:(UIColor *)textColor
                 textAligment:(NSTextAlignment)textAligment {
    
    UILabel * label     = [[UILabel alloc] init];
    label.text          = text;
    label.font          = AUTO_SYSTEM_FONT_SIZE(textFont);
    label.textColor     = textColor;
    label.textAlignment = textAligment;
    
    return label;
}

@end
