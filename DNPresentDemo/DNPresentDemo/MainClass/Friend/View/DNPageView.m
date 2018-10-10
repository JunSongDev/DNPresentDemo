//
//  DNPageView.m
//  163Music
//
//  Created by zjs on 2018/8/20.
//  Copyright © 2018年 zjs. All rights reserved.
//

#import "DNPageView.h"

@interface DNPageView ()<UIScrollViewDelegate>
{
    CGFloat buttonWidth;
    CGFloat indicateHeight;
}
/** 标题数组 */
@property (nonatomic, copy) NSArray * titleArray;
/** 控制器数组 */
@property (nonatomic, copy) NSArray * objctArray;
/** 下划线 */
@property (nonatomic, strong) UIView   * indicateView;
/** 当前选中的按钮 */
@property (nonatomic, strong) UIButton * selectButton;
/** 标题 scrollView */
@property (nonatomic, strong) UIScrollView * topTapView;
/** 控制器 scrollView */
@property (nonatomic, strong) UIScrollView * containView;
/** 按钮数组 */
@property (nonatomic, strong) NSMutableArray * buttonArray;
/** 父控制器 */
@property (nonatomic, strong) UIViewController * parentController;
@end

static CGFloat segment_h = 40;

@implementation DNPageView

- (instancetype)initWithTitle:(NSArray *)title controller:(NSArray *)object {
    
    self = [super init];
    if (self) {
        
        if (title.count != object.count) {
            @throw [NSException exceptionWithName:NSStringFromClass([self class])
                                           reason:@"标题、控制器数组数量不一致"
                                         userInfo:nil];
        }
        
        self.titleArray = title;
        self.objctArray = object;
        
        buttonWidth = title.count > 5 ? SCREEN_W/5 : SCREEN_W/title.count;
        indicateHeight = [[UIScreen mainScreen] scale];
    }
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    if (_topTapHeight <= 25) {
        _topTapHeight = 40;
    }
    [self loadViewWithSubviews];
}

- (void)loadViewWithSubviews {
    
    [self addSubview:self.topTapView];
    [self addSubview:self.containView];
    [self.topTapView addSubview:self.indicateView];
    
    [self addTopTapSubviews];
    
}
// 创建顶部 segment 按钮
- (void)addTopTapSubviews {
    
    NSMutableArray * buttonArr = [NSMutableArray array];
    for (int i = 0; i < self.titleArray.count; i++) {
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        button.tag = i;
        button.frame = CGRectMake(i*buttonWidth, 0, buttonWidth, segment_h);
        [button setTitle:self.titleArray[i] forState:UIControlStateNormal];
        [button setTitleColor:UIColor.lightGrayColor forState:UIControlStateNormal];
        [button setTitleColor:UIColor.redColor forState:UIControlStateSelected];
        
        [_topTapView addSubview:button];
        [button addTarget:self action:@selector(didSelectedCick:) forControlEvents:UIControlEventTouchUpInside];
        
        if (i == 0) {
            button.selected = YES;
            self.selectButton = button;
        }
        [buttonArr addObject:button];
    }
    self.buttonArray = [buttonArr copy];
}
// 按钮的响应事件
- (void)didSelectedCick:(UIButton *)sender {
    
    if (sender != self.selectButton) {
        
        self.selectButton.selected = NO;
        sender.selected = YES;
        self.selectButton = sender;
        // 标题按钮的位置适应
        [self justAutoContainViewWithTag:sender.tag];
        // 下划线指示器的位置改变
        [self indicateViewWillScrollWithTag:sender.tag];
        // 根据 tag 来加载对应的控制器
        //[self loadViewControllerWithTag:sender.tag];
    }
    // 根据 tag 来加载对应的控制器
    [self loadViewControllerWithTag:sender.tag];
}
// 下划线指示器的位置改变，及 containScrollView 的 contentOffset
- (void)indicateViewWillScrollWithTag:(NSInteger)tag {
    DNWeak(self)
    [UIView animateWithDuration:0.3 animations:^{
       
        weakself.indicateView.frame = CGRectMake(self->buttonWidth*tag+self->buttonWidth*0.1, segment_h-2, self->buttonWidth*0.8, 2);
        weakself.containView.delegate = nil;
        [weakself.containView setContentOffset:CGPointMake(SCREEN_W*tag, 0) animated:YES];
    } completion:^(BOOL finished) {
        
        weakself.containView.delegate = self;
    }];
}
// 调整 topTapView 的 contentOffset
- (void)justAutoContainViewWithTag:(NSInteger)tag {
    
    CGFloat selectedWidth = self.selectButton.frame.size.width;
    CGFloat offsetX = (SCREEN_W - selectedWidth) / 2;
    
    if (self.selectButton.frame.origin.x <= SCREEN_W / 2) {
        [self.topTapView setContentOffset:CGPointMake(0, 0) animated:true];
    } else if (CGRectGetMaxX(self.selectButton.frame) >= (self.topTapView.contentSize.width - SCREEN_W / 2)) {
        [self.topTapView setContentOffset:CGPointMake(self.topTapView.contentSize.width - SCREEN_W, 0) animated:true];
    } else {
        [self.topTapView setContentOffset:CGPointMake(CGRectGetMinX(self.selectButton.frame) - offsetX, 0) animated:true];
    }
}
// 根据点击或者移动的按钮的 tag ，来加载对应的控制器
- (void)loadViewControllerWithTag:(NSInteger)tag {
    
    UIViewController *viewController = self.objctArray[tag];
    
    [viewController.view setFrame:CGRectMake(SCREEN_W * tag, 0, SCREEN_W, SCREEN_H-self.topTapHeight)];
    [self.parentController addChildViewController:viewController];
    [viewController didMoveToParentViewController:self.parentController];
    [self.containView addSubview:viewController.view];
}

#pragma mark -- UIScrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if ([scrollView isEqual:self.containView]) {
        NSInteger index = (NSInteger)((scrollView.contentOffset.x + SCREEN_W / 2) / SCREEN_W);
        UIButton * button = (UIButton *)self.buttonArray[index];
        [self didSelectedCick:button];
    }
}

#pragma mark -- Getter

- (void)setTopTapHeight:(CGFloat)topTapHeight {
    
    _topTapHeight = topTapHeight;
}

#pragma mark -- Setter

- (NSMutableArray *)buttonArray {
    
    if (!_buttonArray) {
        _buttonArray = [NSMutableArray array];
    }
    return _buttonArray;
}

- (UIView *)indicateView {
    
    if (!_indicateView) {
        
        _indicateView = [[UIView alloc] initWithFrame:CGRectMake(buttonWidth*0.1, segment_h-2, buttonWidth*0.8, 2)];
        _indicateView.backgroundColor = UIColor.redColor;
    }
    return _indicateView;
}

- (UIScrollView *)topTapView {
    
    if (!_topTapView) {
        _topTapView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, _topTapHeight)];
        _topTapView.scrollEnabled = YES;
        _topTapView.alwaysBounceHorizontal = YES;
        _topTapView.showsHorizontalScrollIndicator = NO;
        _topTapView.showsVerticalScrollIndicator = NO;
        _topTapView.bounces = NO;
        _topTapView.scrollsToTop = NO;
        _topTapView.contentSize = CGSizeMake(buttonWidth*self.titleArray.count, 0);
        if (@available(iOS 11.0, *)) {
            _topTapView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _topTapView;
}

- (UIScrollView *)containView {
    
    if (!_containView) {
        _containView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, _topTapHeight, SCREEN_W, SCREEN_H-_topTapHeight)];
        _containView.delegate = self;
        _containView.pagingEnabled = YES;
        _containView.showsHorizontalScrollIndicator = NO;
        _containView.alwaysBounceHorizontal = YES;
        _containView.scrollsToTop = NO;
        _containView.bounces = NO;
        _containView.contentSize = CGSizeMake(SCREEN_W*self.objctArray.count, 0);
        
        UIViewController *viewController = self.objctArray[0];
        viewController.view.frame = CGRectMake(0, 0, SCREEN_W, SCREEN_H-self.topTapHeight);
        [self.parentController addChildViewController:viewController];
        [viewController didMoveToParentViewController:self.parentController];
        [_containView addSubview:viewController.view];
        
        if (@available(iOS 11.0, *)) {
            _containView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _containView;
}

@end
