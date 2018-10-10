//
//  DNTextFieild.m
//  163Music
//
//  Created by zjs on 2018/8/8.
//  Copyright © 2018年 zjs. All rights reserved.
//

#import "DNTextFieild.h"

@implementation DNTextFieild

- (instancetype)init {
    
    self = [super init];
    if (self) {
        // 添加观察者，监听UITextField 的 text 变化
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:UITextFieldTextDidChangeNotification object:self];
    }
    return self;
}

- (void)textDidChange:(NSNotification *)aNotification
{
    // 判断当前 UITextField 的 text 是否为小数点开头
    if ([self.text hasPrefix:@"."]) {
        // 判断当前的 text 长度是否为 1
        if (self.text.length == 1) {
            
            self.text = [NSString stringWithFormat:@"0%@",self.text];
        }
        else {
            self.text = [NSString stringWithFormat:@"0%@",[self.text substringFromIndex:1]];
        }
    }
}

- (void)dealloc {
    // 移除观察者
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:self];
}


@end
