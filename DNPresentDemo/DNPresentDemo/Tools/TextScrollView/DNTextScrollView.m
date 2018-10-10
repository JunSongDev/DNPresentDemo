//
//  DNTextScrollView.m
//  163Music
//
//  Created by zjs on 2018/9/12.
//  Copyright © 2018年 zjs. All rights reserved.
//

#import "DNTextScrollView.h"

@interface DNTextScrollView ()<UIScrollViewDelegate>
{
    CGFloat  titleFontSize;
    UIColor *titleTextColor;
    UIColor *backGroundColor;
}

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) UIScrollView *bgScrollView;
@end

@implementation DNTextScrollView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
    }
    return self;
}

- (instancetype)initWithDataArray:(NSArray *)dataArray {
    self = [super init];
    if (self) {
        self.dataArray = dataArray;
    }
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    titleFontSize = self.textFontSize ? :18;
    titleTextColor = self.textColor ? :UIColor.blackColor;
    backGroundColor = self.BGColor ? :UIColor.whiteColor;
    
    [self addSubViewsForSuper];
}

- (void)addSubViewsForSuper {
    
    self.backgroundColor = backGroundColor;
    [self addSubview:self.bgScrollView];
    self.bgScrollView.frame = CGRectMake(0,
                                         0,
                                         self.frame.size.width,
                                         self.frame.size.height);
    self.bgScrollView.contentSize = CGSizeMake(self.frame.size.width,
                                               self.frame.size.height*self.dataArray.count);
    
    if (self.dataArray == nil) {
        [self removeTimer];
        return;
    }
    
    if (self.dataArray.count == 1) {
        [self removeTimer];
    }
    // 防止重复添加
    [self.bgScrollView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [obj removeFromSuperview];
    }];
    // 遍历数组，创建 UILabel
    [self.dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UILabel * label = [self createScrollTextLabelWithTag:idx text:obj];
        [self.bgScrollView addSubview:label];
    }];
}


- (UILabel *)createScrollTextLabelWithTag:(NSInteger)tag text:(NSString *)text {
    
    UILabel * label = [[UILabel alloc] init];
    label.text = text;
    label.userInteractionEnabled = YES;
    label.font = [UIFont systemFontOfSize:titleFontSize];
    label.textColor = titleTextColor;
    label.textAlignment = NSTextAlignmentCenter;
    label.frame = CGRectMake(0, tag*self.frame.size.height, self.frame.size.width, self.frame.size.height);
    // 添加点击事件
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTheLabel:)];
    [label addGestureRecognizer:tap];
    tap.view.tag = tag;
    
    return label;
}

// 手势的响应事件
- (void)clickTheLabel:(UITapGestureRecognizer *)gesture {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(dn_textScrollViewSelectedAtIndex:text:)]) {
        
        [self.delegate dn_textScrollViewSelectedAtIndex:gesture.view.tag
                                                   text:self.dataArray[gesture.view.tag]];
    }
}
// 定时器的响应事件
- (void)nextLabel {
    
    CGPoint oldPoint = self.bgScrollView.contentOffset;
    oldPoint.y += self.bgScrollView.frame.size.height;
    [self.bgScrollView setContentOffset:oldPoint animated:YES];
}

#pragma mark - - - NSTimer
- (void)addTimer {
    
    /*
     scheduledTimerWithTimeInterval:  滑动视图的时候timer会停止
     这个方法会默认把Timer以NSDefaultRunLoopMode添加到主Runloop上，而当你滑tableView的时候，就不是NSDefaultRunLoopMode了，这样，你的timer就会停了。
     */
    [self removeTimer];
    self.timer = [NSTimer timerWithTimeInterval:3 target:self selector:@selector(nextLabel) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)removeTimer {
    [_timer invalidate];
    _timer = nil;
}

- (void)dealloc {
    [_timer invalidate];
    _timer = nil;
}

#pragma mark -- UIScrollView Delegate

//当滚动时调用scrollView的代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 当滚动到最底部时，返回（0，0）
    if (self.bgScrollView.contentOffset.y == self.bgScrollView.frame.size.height*(self.dataArray.count)) {
        [self.bgScrollView setContentOffset:CGPointMake(0, 0) animated:NO];
    }
}

// 开始拖拽的时候调用
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    [self removeTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    //开启定时器
    [self addTimer];
}

#pragma mark -- Setter

- (void)setDataArray:(NSArray *)dataArray {
    _dataArray = dataArray;
    [self addTimer];
}

#pragma mark -- Getter

- (UIScrollView *)bgScrollView {
    
    if (!_bgScrollView) {
        _bgScrollView = [[UIScrollView alloc] init];
        _bgScrollView.backgroundColor = UIColor.clearColor;
        _bgScrollView.showsHorizontalScrollIndicator = NO;
        _bgScrollView.showsVerticalScrollIndicator = NO;
        _bgScrollView.scrollEnabled = NO;
        _bgScrollView.pagingEnabled = YES;
        _bgScrollView.bounces = NO;
        _bgScrollView.delegate = self;
        [self addSubview:_bgScrollView];
    }
    return _bgScrollView;
}

@end


