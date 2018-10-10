//
//  UIScrollView+Extension.m
//  DNProject
//
//  Created by zjs on 2018/7/20.
//  Copyright © 2018年 zjs. All rights reserved.
//

#import "UIScrollView+Extension.h"
#import <objc/runtime.h>

@interface DNEmptyView ()

@property (nonatomic, strong) UIImageView *logoImageView;
@property (nonatomic, strong) UILabel  *titleLabel;
@property (nonatomic, strong) UILabel  *subtitleLabel;
@property (nonatomic, strong) UIButton *requirementButton;
@end

@implementation DNEmptyView

- (instancetype)init {
    
    self = [super init];
    if (self) {
        self.frame = [UIScreen mainScreen].bounds;
        [self setControlForSuper];
        [self addConstraintsForSuper];
    }
    return self;
}

- (instancetype)initWithDelegate:(id<DNEmptyViewDelegate>)delegate {
    
    self = [super init];
    if (self) {
        self.frame = [UIScreen mainScreen].bounds;
        self.delegate = delegate;
        [self setControlForSuper];
        [self addConstraintsForSuper];
    }
    return self;
}

- (void)setControlForSuper {
    
    self.logoImageView = [[UIImageView alloc] init];
    UIImage * logoImage = self.logoImageName ? [UIImage imageNamed:self.logoImageName] : [UIImage imageNamed:@"empty"];
    self.logoImageView.image = logoImage;
    
    self.titleLabel = [UILabel dn_labelWithText:@"抱歉，当前数据为空!"
                                       textFont:18
                                      textColor:UIColor.grayColor
                                   textAligment:NSTextAlignmentCenter];
    self.titleLabel.text = !self.titleLabelText ? @"抱歉，当前数据为空!":self.titleLabelText;
    
    self.subtitleLabel = [UILabel dn_labelWithText:@"请稍后再试。。。"
                                          textFont:14
                                         textColor:UIColor.grayColor
                                      textAligment:NSTextAlignmentCenter];
    self.subtitleLabel.text = !self.subTitleLabelText ? @"请稍后再试...":self.subTitleLabelText;
    
    self.requirementButton = [UIButton dn_buttonWithTitle:@"重新加载"
                                                titleFont:16
                                               titleColor:UIColor.orangeColor];
    self.requirementButton.layer.cornerRadius = 6.0f;
    self.requirementButton.layer.borderWidth = 2.0f;
    self.requirementButton.layer.borderColor = UIColor.orangeColor.CGColor;
    
    [self.requirementButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:self.logoImageView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.subtitleLabel];
    [self addSubview:self.requirementButton];
}

- (void)addConstraintsForSuper {
    
    [self.logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self).inset(SCREEN_W*0.3);
        make.height.mas_offset(SCREEN_W*0.38);
        make.width.mas_offset(SCREEN_W*0.3);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self.logoImageView.mas_bottom).mas_offset(AUTO_MARGIN(20));
    }];
    
    [self.subtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_offset(AUTO_MARGIN(10));
    }];
    
    [self.requirementButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self.subtitleLabel.mas_bottom).mas_offset(AUTO_MARGIN(30));
        make.height.mas_equalTo(AUTO_MARGIN(45));
        make.width.mas_equalTo(AUTO_MARGIN(120));
    }];
}

- (void)buttonClick:(UIButton *)sender {
    
//    [self.logoImageView removeFromSuperview];
//    [self.titleLabel removeFromSuperview];
//    [self.subtitleLabel removeFromSuperview];
//    [self.requirementButton removeFromSuperview];
    [self removeFromSuperview];
    if (_delegate && [_delegate respondsToSelector:@selector(emptyViewReload)]) {
        
        [_delegate emptyViewReload];
    }
}

#pragma mark -- Setter && Getter
- (void)setTitleColor:(UIColor *)titleColor {
    
    _titleColor = titleColor;
    
    self.titleLabel.textColor = !titleColor ? UIColor.grayColor:titleColor;
    self.subtitleLabel.textColor = !titleColor ? UIColor.grayColor:titleColor;
}

- (void)setRequireButtonBGColor:(UIColor *)requireButtonBGColor {
    
    _requireButtonBGColor = requireButtonBGColor;
    
    self.requirementButton.backgroundColor = !requireButtonBGColor ? UIColor.clearColor : requireButtonBGColor;
}

- (void)setRequireButtonTextColor:(UIColor *)requireButtonTextColor {
    
    _requireButtonTextColor = requireButtonTextColor;
    
    UIColor * color = !requireButtonTextColor ? UIColor.orangeColor : requireButtonTextColor;
    [self.requirementButton setTitleColor:color forState:UIControlStateNormal];
}

@end


NSString * const DNEmptyViewKey;

@implementation UIScrollView (Extension)


static char blockKey;
static char autoFootKey;
static char backFootKey;

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self nextResponder] touchesBegan:touches withEvent:event];
    [super touchesBegan:touches withEvent:event];
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self nextResponder] touchesMoved:touches withEvent:event];
    [super touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self nextResponder] touchesEnded:touches withEvent:event];
    [super touchesEnded:touches withEvent:event];
}


///================================================
///     下拉刷新
///================================================
- (void)dn_startHeaderRefreshWithRefreshBlock:(RefreshBlock)refreshBlock{
    DNWeak(self)
    self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            refreshBlock();
            [weakself.mj_header endRefreshing];
        });
    }];
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    self.mj_header.automaticallyChangeAlpha = YES;
}

// 带图片下拉刷新
- (void)dn_startGifHeaderWithIdleImages:(NSArray *)idleImages
                             pullImages:(NSArray *)pullImages
                          refreshImages:(NSArray *)refreshImages
                       refreshWithBlock:(RefreshBlock)refreshBlock
{
    objc_setAssociatedObject(self, &blockKey, refreshBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    MJRefreshGifHeader * header = [MJRefreshGifHeader headerWithRefreshingTarget:self
                                                                refreshingAction:@selector(headerRefresh:)];
    
    [header setImages:idleImages    forState:MJRefreshStateIdle];
    [header setImages:pullImages    forState:MJRefreshStatePulling];
    [header setImages:refreshImages forState:MJRefreshStateRefreshing];
//
//    // 设置自动切换透明度(在导航栏下面自动隐藏)
//    header.automaticallyChangeAlpha = YES;
    self.mj_header = header;
    
    
}
- (void)headerRefresh:(MJRefreshGifHeader *)header{
    
    RefreshBlock block = (RefreshBlock)objc_getAssociatedObject(self, &blockKey);
    if (block) {
        block();
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        // 设置自动切换透明度(在导航栏下面自动隐藏)
        header.automaticallyChangeAlpha = YES;
        [header endRefreshing];
    });
    
}


///================================================
///     上拉加载
///================================================
- (void)dn_startFooterUploadRefreshBlock:(RefreshBlock)refreshBlock
{
    DNWeak(self)
    self.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            refreshBlock();
            [weakself.mj_footer endRefreshing];
        });
    }];
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    self.mj_footer.automaticallyChangeAlpha = YES;
}
// 带图片自动加载
- (void)dn_startGIFAutoFootWithIdleImages:(NSArray *)idleImages
                               pullImages:(NSArray *)pullImages
                            refreshImages:(NSArray *)refreshImages
                         refreshWithBlock:(RefreshBlock)refreshBlock
{
    // runtime 发送消息
    objc_setAssociatedObject(self, &autoFootKey, refreshBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    // 上拉控件及添加事件
    MJRefreshAutoGifFooter * footer = [MJRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(autoFooterRefresh:)];
    // 设置图片
    [footer setImages:idleImages    forState:MJRefreshStateIdle];
    [footer setImages:pullImages    forState:MJRefreshStatePulling];
    [footer setImages:refreshImages forState:MJRefreshStateRefreshing];
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    footer.automaticallyChangeAlpha = YES;
    // 设置上拉控件
    self.mj_footer = footer;
}

- (void)autoFooterRefresh:(MJRefreshAutoGifFooter *)footer
{
    // runtime 接收消息
    RefreshBlock block = (RefreshBlock)objc_getAssociatedObject(self, &autoFootKey);
    // block 传递事件
    if (block) {
        block();
    }
    // 1.0 秒后添加到队列
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 设置自动切换透明度(在导航栏下面自动隐藏)
        footer.automaticallyChangeAlpha = YES;
        // 结束上拉加载
        [footer endRefreshing];
    });
}

// 带图片上拉加载
- (void)dn_startGIFBackFootWithIdleImages:(NSArray *)idleImages
                               pullImages:(NSArray *)pullImages
                            refreshImages:(NSArray *)refreshImages
                         refreshWithBlock:(RefreshBlock)refreshBlock
{
    objc_setAssociatedObject(self, &backFootKey, refreshBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    MJRefreshBackGifFooter * footer = [MJRefreshBackGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(backFooterRefresh:)];
    
    [footer setImages:idleImages    forState:MJRefreshStateIdle];
    [footer setImages:pullImages    forState:MJRefreshStatePulling];
    [footer setImages:refreshImages forState:MJRefreshStateRefreshing];
    
    self.mj_footer = footer;
}

- (void)backFooterRefresh:(MJRefreshBackFooter *)footer{
    
    RefreshBlock block = (RefreshBlock)objc_getAssociatedObject(self, &backFootKey);
    if (block) {
        block();
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 设置自动切换透明度(在导航栏下面自动隐藏)
        footer.automaticallyChangeAlpha = YES;
        // 结束刷新
        [footer endRefreshing];
    });
}

///=============================================================================
///         设置空白页
///=============================================================================

- (void)acs_reload {
    
    if (![self acs_canDisplay]) {
        return;
    }
    if (!self.emptyView) {
        return;
    }
    if ([self acs_itemsCount] == 0) {
        
        if (!self.emptyView.superview) {
            if (([self isKindOfClass:[UITableView class]] || [self isKindOfClass:[UICollectionView class]]) && self.subviews.count > 1) {
                [self insertSubview:self.emptyView atIndex:0];
            }
            else {
                [self addSubview:self.emptyView];
            }
        }
    }
    else {
        [self.emptyView removeFromSuperview];
    }
}
- (BOOL)acs_canDisplay {
    // 判断是否为 UITableView || UICollectionView || UIScrollView
    if ([self isKindOfClass:[UITableView class]] ||
        [self isKindOfClass:[UICollectionView class]] ||
        [self isKindOfClass:[UIScrollView class]]) {
        // 判断 emptyView 是否为空
        if (self.emptyView) {
            return YES;
        }
    }
    return NO;
}

- (NSInteger)acs_itemsCount {
    
    NSInteger items = 0;
    if (![self respondsToSelector:@selector(dataSource)]) {
        return items;
    }
    if ([self isKindOfClass:[UITableView class]]) {
        
        UITableView *tableView = (UITableView *)self;
        id <UITableViewDataSource> dataSource = tableView.dataSource;
        
        NSInteger sections = 1;
        
        if (dataSource && [dataSource respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
            // 获取 tableView 返回的 section
            sections = [dataSource numberOfSectionsInTableView:tableView];
        }
        
        if (dataSource && [dataSource respondsToSelector:@selector(tableView:numberOfRowsInSection:)]) {
            for (NSInteger section = 0; section < sections; section++) {
                // 获取 tableView 的每个 section 返回的 item
                items += [dataSource tableView:tableView numberOfRowsInSection:section];
            }
        }
    }
    else if ([self isKindOfClass:[UICollectionView class]]) {
        
        UICollectionView *collectionView = (UICollectionView *)self;
        id <UICollectionViewDataSource> dataSource = collectionView.dataSource;
        
        NSInteger sections = 1;
        
        if (dataSource && [dataSource respondsToSelector:@selector(numberOfSectionsInCollectionView:)]) {
            sections = [dataSource numberOfSectionsInCollectionView:collectionView];
        }
        
        if (dataSource && [dataSource respondsToSelector:@selector(collectionView:numberOfItemsInSection:)]) {
            for (NSInteger section = 0; section < sections; section++) {
                items += [dataSource collectionView:collectionView numberOfItemsInSection:section];
            }
        }
    }
    return items;
}

/** category 中不会生成 Setter && Getter 方法，
 *  需用 runtime 动态添加
 */
- (void)setEmptyView:(DNEmptyView *)emptyView {
    
    objc_setAssociatedObject(self, &DNEmptyViewKey, emptyView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self swizzleIfPossible:@selector(reloadData)];
    
    // Exclusively for UITableView, we also inject -dzn_reloadData to -endUpdates
    if ([self isKindOfClass:[UITableView class]]) {
        [self swizzleIfPossible:@selector(endUpdates)];
    }
}

- (DNEmptyView *)emptyView {
    
    return objc_getAssociatedObject(self, &DNEmptyViewKey);
}

#pragma mark - Method Swizzling

static NSMutableDictionary *_impLookupTable;
static NSString *const DZNSwizzleInfoOwnerKey    = @"owner";
static NSString *const DZNSwizzleInfoPointerKey  = @"pointer";
static NSString *const DZNSwizzleInfoSelectorKey = @"selector";

void dzn_original_implementation(id self, SEL _cmd)
{
    Class baseClass = acs_baseClassToSwizzleForTarget(self);
    NSString *key = acs_implementationKey(baseClass, _cmd);
    
    NSDictionary *swizzleInfo = [_impLookupTable objectForKey:key];
    NSValue *impValue = [swizzleInfo valueForKey:DZNSwizzleInfoPointerKey];
    
    IMP impPointer = [impValue pointerValue];
    
    [self acs_reload];
    
    if (impPointer) {
        ((void(*)(id,SEL))impPointer)(self,_cmd);
    }
}

NSString *acs_implementationKey(Class class, SEL selector)
{
    if (!class || !selector) {
        return nil;
    }
    NSString *className    = NSStringFromClass([class class]);
    NSString *selectorName = NSStringFromSelector(selector);
    return [NSString stringWithFormat:@"%@_%@",className,selectorName];
}

Class acs_baseClassToSwizzleForTarget(id target)
{
    if ([target isKindOfClass:[UITableView class]]) {
        return [UITableView class];
    }
    else if ([target isKindOfClass:[UICollectionView class]]) {
        return [UICollectionView class];
    }
    else if ([target isKindOfClass:[UIScrollView class]]) {
        return [UIScrollView class];
    }
    return nil;
}

- (void)swizzleIfPossible:(SEL)selector
{
    if (![self respondsToSelector:selector]) {
        return;
    }
    
    if (!_impLookupTable) {
        _impLookupTable = [[NSMutableDictionary alloc] initWithCapacity:3];
    }
    
    for (NSDictionary *info in [_impLookupTable allValues]) {
        Class class = [info objectForKey:DZNSwizzleInfoOwnerKey];
        NSString *selectorName = [info objectForKey:DZNSwizzleInfoSelectorKey];
        
        if ([selectorName isEqualToString:NSStringFromSelector(selector)]) {
            if ([self isKindOfClass:class]) {
                return;
            }
        }
    }
    
    Class baseClass = acs_baseClassToSwizzleForTarget(self);
    NSString *key = acs_implementationKey(baseClass, selector);
    NSValue *impValue = [[_impLookupTable objectForKey:key] valueForKey:DZNSwizzleInfoPointerKey];
    
    if (impValue || !key || !baseClass) {
        
        return;
    }
    
    Method method = class_getInstanceMethod(baseClass, selector);
    IMP dzn_newImplementation = method_setImplementation(method, (IMP)dzn_original_implementation);
    
    NSDictionary *swizzledInfo = @{DZNSwizzleInfoOwnerKey: baseClass,
                                   DZNSwizzleInfoSelectorKey: NSStringFromSelector(selector),
                                   DZNSwizzleInfoPointerKey: [NSValue valueWithPointer:dzn_newImplementation]};
    
    [_impLookupTable setObject:swizzledInfo forKey:key];
}

@end
