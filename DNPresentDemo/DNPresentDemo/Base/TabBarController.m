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

@interface TabBarController ()

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
}
#pragma mark -- didReceiveMemoryWarning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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

//- (void)dnPlusButtonSelected:(UIButton *)sender {
//
//    DNLog(@"HHHHHHHHHHH");
//}

#pragma mark -- NetWork Methods

#pragma mark -- Setter && Getter

@end
