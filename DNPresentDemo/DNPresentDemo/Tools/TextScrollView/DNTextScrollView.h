//
//  DNTextScrollView.h
//  163Music
//
//  Created by zjs on 2018/9/12.
//  Copyright © 2018年 zjs. All rights reserved.
//

#import "BaseView.h"

// 点击文字轮播的代理
@protocol DNTextScrollViewDelegate <NSObject>

@optional;
- (void)dn_textScrollViewSelectedAtIndex:(NSInteger)index text:(NSString *)text;

@end

@interface DNTextScrollView : UIView


@property (nonatomic,   copy) NSArray *dataArray;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIColor *BGColor;
@property (nonatomic, assign) CGFloat textFontSize;

@property (nonatomic, weak) id<DNTextScrollViewDelegate> delegate;

- (instancetype)initWithDataArray:(NSArray *)dataArray;

@end
