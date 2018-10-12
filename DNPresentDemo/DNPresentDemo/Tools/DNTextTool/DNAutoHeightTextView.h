//
//  DNAutoHeightTextView.h
//  DNProject
//
//  Created by zjs on 2018/7/19.
//  Copyright © 2018年 zjs. All rights reserved.
//

#import <UIKit/UIKit.h>
// 可自适应高度的 TextView
@interface DNAutoHeightTextView : UITextView

@property (nonatomic, assign) NSUInteger currentLength;
@property (nonatomic, assign) NSUInteger maxLength;

@property (nonatomic, assign, getter=isShowLength) BOOL showLength;

@property (nonatomic, copy) IBInspectable NSString * placeholder;
@property (nonatomic, copy) NSAttributedString * attributePlaceholder;

@property (nonatomic) IBInspectable double fadeTime;
@property (nonatomic, retain) UIColor * placeholderTextColor;
@end
