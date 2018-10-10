//
//  BaseView.h
//  163Music
//
//  Created by zjs on 2018/5/22.
//  Copyright © 2018年 zjs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseView : UIView

/** 添加控件 */
- (void)setControlForSuper;

/** 添加约束 */
- (void)addConstraintsForSuper;

/** 找到该视图的父视图 */
- (UIViewController *)viewForSuperBaseView;

@end
