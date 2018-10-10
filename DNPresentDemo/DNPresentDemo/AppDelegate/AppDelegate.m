//
//  AppDelegate.m
//  DNPresentDemo
//
//  Created by zjs on 2018/10/10.
//  Copyright © 2018 zjs. All rights reserved.
//

#import "AppDelegate.h"
#import "TabBarController.h"
#import "DNGuideTool.h"
#import "DNAdvertiseTool.h"
#import "YYFPSLabel.h"
#import "DNFPSLabel.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // 让线程睡 2 秒，从而达到启动图长时间显示的效果
    //[NSThread sleepForTimeInterval:2.0];
    // 初始化窗口
    [self initWindow];
    // 显示广告页和引导页
    [self showGuideAndAdvertiseView];
    
    
    
    CGFloat Y = [UIApplication sharedApplication].statusBarFrame.size.height;
    DNFPSLabel * label = [[DNFPSLabel alloc] initWithFrame:CGRectMake(10, Y, 60, 44)];
    label.textColor = UIColor.whiteColor;
    [[UIApplication sharedApplication].keyWindow addSubview:label];
    
    NSArray *languages = [NSLocale preferredLanguages];
    
    NSString *language = [languages objectAtIndex:0];
    
    if ([language hasPrefix:@"zh"]) {//检测开头匹配，是否为中文
        
        [[NSUserDefaults standardUserDefaults] setObject:@"zh-Hans" forKey:@"appLanguage"];//App语言设置为中文
    }else{//其他语言
        //App语言设置为英文
        [[NSUserDefaults standardUserDefaults] setObject:@"en" forKey:@"appLanguage"];
    }
    return YES;
}



- (void)showGuideAndAdvertiseView {
    
    //本地缓存的版本号 第一次启动的时候本地是没有缓存版本号的
    NSString *versionCache = [[NSUserDefaults standardUserDefaults] objectForKey:@"VersionCache"];
    //当前应用版本号
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    // 通过判断当前 APP 的版本号 是否为空，或者与本地保存的是否一致来判断 APP 是否第一次启动
    if (version == nil || ![versionCache isEqualToString:version]) {
        // 引导页
        [DNGuideTool showGuidePageView:@[@"new_feature_1",
                                         @"new_feature_2",
                                         @"new_feature_3",
                                         @"new_feature_4"]];
        [[NSUserDefaults standardUserDefaults] setObject:version forKey:@"VersionCache"];
    }
    else {
        DNLog(@"Not first resume");
    }
    // 广告页的地址
    NSString *imagesURLS = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1495189872684&di=03f9df0b71bb536223236235515cf227&imgtype=0&src=http%3A%2F%2Fatt1.dzwww.com%2Fforum%2F201405%2F29%2F1033545qqmieznviecgdmm.gif";
    // 广告页
    [DNAdvertiseTool showAdvertiseView:imagesURLS];
}

- (void)initWindow
{
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    TabBarController * tabBar = [[TabBarController alloc]init];
    
    self.window.rootViewController = tabBar;
    
    [self.window makeKeyAndVisible];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
