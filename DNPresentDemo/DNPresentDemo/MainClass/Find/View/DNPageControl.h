//
//  DNPageControl.h
//  DNPresentDemo
//
//  Created by zjs on 2018/10/15.
//  Copyright © 2018 zjs. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DNPageControl : UIControl
/**
 *  显示的圆点的总数量
 */
@property (nonatomic, assign) int numberOfPages;
/**
 *  当前显示的圆点的 index
 */
@property (nonatomic, assign) int currentPage;
/**
 *  每个圆点的大小
 */
@property (nonatomic, assign) CGSize pageSize;
/**
 *  每个圆点之间的间距
 */
@property (nonatomic, assign) CGFloat pagesSpace;
/**
 *  每个圆点的圆角大小
 */
@property (nonatomic, assign) CGFloat cornerRadius;
/**
 *  当前显示的圆点的颜色
 */
@property (nonatomic, strong) UIColor * currentPageIndicatorTintColor;
/**
 *  不是当前显示的圆点的颜色
 */
@property (nonatomic, strong) UIColor * pageIndicatorTintColor;
/**
 *  是否隐藏圆点
 */
@property (nonatomic, assign, getter=isHideForSingalPage) BOOL hideForSingalPage;
/**
 *  是否设置圆角
 */
@property (nonatomic, assign, getter=isHasCornerRadius) BOOL hasConerRadius;

@end

NS_ASSUME_NONNULL_END
