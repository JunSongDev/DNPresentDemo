//
//  TabBarController.m
//  163Music
//
//  Created by zjs on 2018/5/22.
//  Copyright © 2018年 zjs. All rights reserved.
//

#import "TabBarController.h"
#import "NavigationController.h"
#import "FindController.h"
#import "VedioController.h"
#import "MineController.h"
#import "FriendController.h"
#import "AccountController.h"

#import "DNBaseTabBar.h"

@interface TabBarController ()<UITabBarControllerDelegate>

@end

@implementation TabBarController

#pragma mark -- lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setControlForSuper];
    
//    DNBaseTabBar * tabBar = [[DNBaseTabBar alloc] init];
//    tabBar.dnDelegate = self;
//    [self setValue:tabBar forKeyPath:@"tabBar"];
    
    // 设置TabBar背景颜色
    self.tabBar.barTintColor = [UIColor colorWithWhite:0.0 alpha:0.3];
    // 设置TabBar字体颜色
    self.tabBar.tintColor = [UIColor whiteColor];
    
    self.tabBarController.delegate = self;
}
#pragma mark -- didReceiveMemoryWarning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)animationWithIndex:(NSInteger) index {
    NSMutableArray * tabbarbuttonArray = [NSMutableArray array];
    
    for (UIView *tabBarButton in self.tabBar.subviews) {
        
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            
            [tabbarbuttonArray addObject:tabBarButton];
        }
    }
    
    CABasicAnimation*pulse = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    
    pulse.timingFunction= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    pulse.duration = 0.08;
    
    pulse.repeatCount= 1;
    
    pulse.autoreverses= YES;
    
    pulse.fromValue= [NSNumber numberWithFloat:0.7];
    
    pulse.toValue= [NSNumber numberWithFloat:1.3];
    
    [[tabbarbuttonArray[index] layer] addAnimation:pulse forKey:nil];
}

- (void)tabBarAnimationWithItem:(UITabBarItem *)item {
    
    CABasicAnimation*pulse = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    
    pulse.timingFunction= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    pulse.duration = 0.08;
    
    pulse.repeatCount= 1;
    
    pulse.autoreverses= YES;
    
    pulse.fromValue= [NSNumber numberWithFloat:0.7];
    
    pulse.toValue= [NSNumber numberWithFloat:1.3];
    
    for (UIView *tabBarButton in self.tabBar.subviews) {
        
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarItem")]) {
            [tabBarButton.layer addAnimation:pulse forKey:nil];
        }
    }
}

#pragma mark -- setControlForSuper
- (void)setControlForSuper{
    
    
    NavigationController * find = [[NavigationController alloc]initWithRootViewController:[[FindController alloc]init]
                                                                                    title:Localized(@"find_tab")
                                                                              normalImage:@"cm2_btm_icn_discovery"
                                                                              selectImage:@"cm2_btm_icn_discovery_prs"];
    
    NavigationController * vedio = [[NavigationController alloc]initWithRootViewController:[[VedioController alloc]init]
                                                                                    title:Localized(@"video_tab")
                                                                              normalImage:@"cm4_btm_icn_video"
                                                                              selectImage:@"cm4_btm_icn_video_prs"];
    
    NavigationController * mine = [[NavigationController alloc]initWithRootViewController:[[MineController alloc]init]
                                                                                    title:Localized(@"mine_tab")
                                                                              normalImage:@"cm2_btm_icn_music"
                                                                              selectImage:@"cm2_btm_icn_music_prs"];
    
    NavigationController * friend = [[NavigationController alloc]initWithRootViewController:[[FriendController alloc]init]
                                                                                    title:Localized(@"friend_tab")
                                                                              normalImage:@"cm2_btm_icn_friend"
                                                                              selectImage:@"cm2_btm_icn_friend_prs"];
    
    NavigationController * account = [[NavigationController alloc]initWithRootViewController:[[AccountController alloc]init]
                                                                                    title:Localized(@"account_tab")
                                                                              normalImage:@"cm2_btm_icn_account"
                                                                              selectImage:@"cm2_btm_icn_account_prs"];
    
    
    self.viewControllers = @[find,vedio,mine,friend,account];
}

#pragma mark -- addConstrainsForSuper
- (void)addConstrainsForSuper{
    
    
}

#pragma mark -- target Methods

#pragma mark -- UITableView Delegate && DataSource

#pragma mark -- other Deleget

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {

    [self animationWithIndex:[self.tabBar.items indexOfObject:item]];
}

//- (void)dnPlusButtonSelected:(UIButton *)sender {
//
//    DNLog(@"HHHHHHHHHHH");
//}

#pragma mark -- NetWork Methods

#pragma mark -- Setter && Getter

@end
