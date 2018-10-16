//
//  DNPageControl.m
//  DNPresentDemo
//
//  Created by zjs on 2018/10/15.
//  Copyright © 2018 zjs. All rights reserved.
//

#import "DNPageControl.h"

@implementation DNPageControl

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    _pagesSpace = 5;
    _currentPage = 0;
    _numberOfPages = 0;
    _pageSize = CGSizeMake(12, 4);
    _cornerRadius = self.pageSize.height/2.0;
    _currentPageIndicatorTintColor = UIColor.cyanColor;
    _pageIndicatorTintColor = UIColor.lightGrayColor;
}

- (void)setPageSize:(CGSize)pageSize {
    _pageSize = pageSize;
    [self layoutSubviews];
}

- (void)setNumberOfPages:(int)numberOfPages {
    _numberOfPages = numberOfPages;
    [self layoutSubviews];
}

- (void)setCurrentPage:(int)currentPage {
    _currentPage = currentPage;
    [self layoutSubviews];
}

- (void)setPageIndicatorTintColor:(UIColor *)pageIndicatorTintColor {
    _pageIndicatorTintColor = pageIndicatorTintColor;
    [self layoutSubviews];
}

- (void)setCurrentPageIndicatorTintColor:(UIColor *)currentPageIndicatorTintColor {
    _currentPageIndicatorTintColor = currentPageIndicatorTintColor;
    [self layoutSubviews];
}

- (void)setHideForSingalPage:(BOOL)hideForSingalPage {
    _hideForSingalPage = hideForSingalPage;
    [self layoutSubviews];
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    _cornerRadius = cornerRadius;
    [self layoutSubviews];
}

- (void)setHasConerRadius:(BOOL)hasConerRadius {
    _hasConerRadius = hasConerRadius;
    [self layoutSubviews];
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    for (UIView * item in self.subviews) {
        [item removeFromSuperview];
    }
    
    CGFloat firstDotOriginX = (self.frame.size.width - self.numberOfPages*self.pageSize.width - self.pagesSpace*(self.numberOfPages-1))*0.5;
    CGFloat firstDotOriginY = (self.frame.size.height - self.pageSize.height)*0.5;
    
    for (int i = 0; i < self.numberOfPages; i ++) {
        if (self.numberOfPages <= 1 && self.isHideForSingalPage) {
            return;
        }
        UIView *pageView = [[UIView alloc] initWithFrame:CGRectMake(firstDotOriginX + i*(self.pagesSpace+self.pageSize.width), firstDotOriginY, self.pageSize.width, self.pageSize.height)];
//        pageView.translatesAutoresizingMaskIntoConstraints = NO;
//        [pageView.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:(firstDotOriginX + i*(self.pagesDistance+self.pageSize.width))].active = YES;
//        [pageView.topAnchor constraintEqualToAnchor:self.topAnchor constant: firstDotOriginY].active = YES;
//        [pageView.widthAnchor constraintEqualToConstant:self.pageSize.width].active = YES;
//        [pageView.heightAnchor constraintEqualToConstant:self.pageSize.height].active = YES;
        if (i == self.currentPage) {
            pageView.backgroundColor = self.currentPageIndicatorTintColor;
        }
        else {
            pageView.backgroundColor = self.pageIndicatorTintColor;
        }
        // 是否切圆角
        pageView.layer.cornerRadius = self.hasConerRadius ? 0.f:self.cornerRadius;
        
        [self addSubview:pageView];
    }
}

@end
