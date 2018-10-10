//
//  NavigationController.m
//  163Music
//
//  Created by zjs on 2018/5/22.
//  Copyright © 2018年 zjs. All rights reserved.
//

#import "NavigationController.h"

@interface NavigationController ()<UINavigationControllerDelegate>

@property (nonatomic, weak) id gesDelegate;
@end

@implementation NavigationController

#pragma mark -- lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavigationBarTheme];
    
    self.gesDelegate = self.interactivePopGestureRecognizer.delegate;
    self.delegate = self;
}
#pragma mark -- didReceiveMemoryWarning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark -- setControlForSuper
- (void)setControlForSuper{
    
}

#pragma mark -- addConstrainsForSuper
- (void)addConstrainsForSuper{
    
}

#pragma mark -- target Methods

/**
 导航栏设置
 */
- (void)setupNavigationBarTheme
{
    UINavigationBar *appearance = [UINavigationBar appearance];
    // 设置标题 按钮
    NSMutableDictionary *textAttrs            = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    textAttrs[NSFontAttributeName]            = AUTO_SYSTEM_FONT_SIZE(18);
    [appearance setTitleTextAttributes:textAttrs];
    
    appearance.translucent = NO;
    appearance.tintColor = [UIColor whiteColor];
    // 设置导航栏背景颜色
    appearance.barTintColor = [UIColor dn_colorWithRed:224
                                                 green:0
                                                  blue:18];
    // 设置状态样式
    appearance.barStyle = UIBarStyleBlackOpaque;
}

// 自定义初始化方法
- (instancetype)initWithRootViewController:(UIViewController *)root
                                     title:(NSString *)title
                               normalImage:(NSString *)nomalImage
                               selectImage:(NSString *)selectImage
{
    self = [super initWithRootViewController:root];
    
    if (self) {
    
        self.tabBarItem.title = title;
        
        self.tabBarItem.image = [[UIImage imageNamed:nomalImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        self.tabBarItem.selectedImage = [[UIImage imageNamed:selectImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    return self;
}
// 重写 push 方法，push 时隐藏 TabBar
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (self.childViewControllers.count > 0) {
        
        viewController.hidesBottomBarWhenPushed = YES;
        
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[IMAGE(@"back") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                                                           style:UIBarButtonItemStylePlain
                                                                                          target:self
                                                                                          action:@selector(backClick:)];
    }
    [super pushViewController:viewController animated:animated];
}

- (void)backClick:(id)sender
{
    [self popViewControllerAnimated:YES];
}

#pragma mark -- other Deleget

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (viewController == self.viewControllers[0]) {
        
        self.interactivePopGestureRecognizer.delegate = self.gesDelegate;
    }
    else {
        self.interactivePopGestureRecognizer.delegate = nil;
    }
}

#pragma mark -- NetWork Methods

#pragma mark -- Setter && Getter


@end
