//
//  DNGuideView.m
//  163Music
//
//  Created by zjs on 2018/7/24.
//  Copyright © 2018年 zjs. All rights reserved.
//

#import "DNGuideView.h"

@interface DNGuideView ()<UIScrollViewDelegate>

@property (nonatomic,   copy) NSArray       *imageArray;
@property (nonatomic, strong) UIScrollView  *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@end

@implementation DNGuideView

+ (instancetype)showGuideWithFrame:(CGRect)frame imageArray:(NSArray *)imageArray {
    
    DNGuideView *guideView = [[self alloc] initWithFrame:frame];
    guideView.imageArray = imageArray;
    return guideView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self scrollViewAddGesture];
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self scrollViewAddGesture];
    }
    return self;
}
// 给 scrollView 添加手势
- (void)scrollViewAddGesture {
    
    self.backgroundColor = UIColor.clearColor;
    
    UITapGestureRecognizer * gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTapFrom)];
    [self.scrollView addGestureRecognizer:gesture];
}

- (void)handleSingleTapFrom {
    // 判断是不是最后一张图片，如果是则相应单机手势
    if (_pageControl.currentPage == self.imageArray.count-1) {
        
        [self removeFromSuperview];
    }
}

- (void)loadGuideView {
    
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.scrollView.contentSize = CGSizeMake((self.imageArray.count+1) * SCREEN_W,
                                             SCREEN_H);
    self.pageControl.numberOfPages = self.imageArray.count;
    
    [self addSubview:self.scrollView];
    [self addSubview:self.pageControl];
    
    [self.imageArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        // 创建 UIImageView
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(idx * SCREEN_W,
                                                                                0,
                                                                                SCREEN_W,
                                                                                SCREEN_H)];
        // 判断数组中的对象是否为字符串或者 UIImage
        if ([obj isKindOfClass:[NSString class]]) {
            imageView.image = [UIImage imageNamed:obj];
        }
        else if ([obj isKindOfClass:[UIImage class]]) {
            imageView.image = obj;
        }
        else {
            DNLog(@"当前不支持该类型");
        }
        [self.scrollView addSubview:imageView];
    }];
}
#pragma mark -- scrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 监听 scrollView 滚动的偏移量
    CGPoint offSet = scrollView.contentOffset;
    // 从而获得 pageControl 的当前页码
    NSInteger page = (offSet.x / (self.bounds.size.width) + 0.5);
    //计算当前的页码
    self.pageControl.currentPage = page;
    self.pageControl.hidden = (page > self.imageArray.count - 1);
}
// 当 scrollView 的偏移量超出一定范围，则移除视图
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x >= _imageArray.count * SCREEN_W) {
        
        [self removeFromSuperview];
    }
}

#pragma mark -- Setter && Getter
- (void)setImageArray:(NSArray *)imageArray {
    
    _imageArray = imageArray;
    [self loadGuideView];
}

- (UIScrollView *)scrollView {
    
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _scrollView.bounces = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.delegate = self;
    }
    return _scrollView;
}

- (UIPageControl *)pageControl {
    
    if (!_pageControl) {
        
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(SCREEN_W/2,
                                                                       SCREEN_H-60,
                                                                       0,
                                                                       40)];
        _pageControl.pageIndicatorTintColor = UIColor.cyanColor;
        _pageControl.currentPageIndicatorTintColor = UIColor.orangeColor;
    }
    return _pageControl;
}

@end
