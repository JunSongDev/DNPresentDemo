//
//  DNWebViewController.m
//  163Music
//
//  Created by zjs on 2018/8/1.
//  Copyright © 2018年 zjs. All rights reserved.
//

#import "DNWebViewController.h"
#import "NSString+Extension.h"
#import <WebKit/WebKit.h>

@interface DNWebViewController ()<WKNavigationDelegate,WKUIDelegate,DNEmptyViewDelegate>

@property (nonatomic, strong) WKWebView      *webView;
@property (nonatomic, strong) UIProgressView *webProgress;
@property (nonatomic, assign, getter=isAllowZoomScale) BOOL allowZoomScale;
@end

@implementation DNWebViewController

#pragma mark -- LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.allowZoomScale = YES;
    [self setControlForSuper];
    [self addConstrainsForSuper];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (self.urlString.length != 0) {
        
        [self reloadWKWebViewWithURL:self.urlString];
    }
    else {
        // 如果 self.urlString 为空，则抛出异常
        @throw [NSException exceptionWithName:NSStringFromClass([self class])
                                       reason:@"webView 加载网址不能为空"
                                     userInfo:nil];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    // 清除缓存
//    [self removeWebCache];
}

#pragma mark -- DidReceiveMemoryWarning

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- SetControlForSuper
- (void)setControlForSuper
{    
    [self.view addSubview:self.webView];
    [self.view addSubview:self.webProgress];
    
    [self.webView addObserver:self
                   forKeyPath:@"estimatedProgress"
                      options:NSKeyValueObservingOptionNew
                      context:nil];
}

#pragma mark -- AddConstrainsForSuper
- (void)addConstrainsForSuper
{
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.edges.mas_equalTo(self.view);
    }];
    
    [self.webProgress mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.left.right.mas_equalTo(self.view);
        make.height.mas_offset(AUTO_MARGIN(2));
    }];
}

#pragma mark -- Target Methods

- (void)reloadWKWebViewWithURL:(NSString *)urlStr {
    
    if ([urlStr isValidUrl]) {
    
        NSURL * url = [NSURL URLWithString:urlStr];
        NSURLRequest * request = [[NSURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:20];
        [self.webView loadRequest:request];
    }
    else {
        NSString * path = [[NSBundle mainBundle] bundlePath];
        NSURL * urlString  = [NSURL fileURLWithPath:path];
        [self.webView loadHTMLString:urlStr baseURL:urlString];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        self.webProgress.progress = self.webView.estimatedProgress;
        if (self.webProgress.progress == 1) {
            /*
             *添加一个简单的动画，将webProgress的Height变为1.4倍，在开始加载网页的代理中会恢复为1.5倍
             *动画时长0.25s，延时0.3s后开始动画
             *动画结束后将webProgress隐藏
             */
            DNWeak(self)
            [UIView animateWithDuration:0.25f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
                weakself.webProgress.transform = CGAffineTransformMakeScale(1.0f, 1.4f);
            } completion:^(BOOL finished) {
                weakself.webProgress.hidden = YES;
            }];
        }
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}


#pragma mark -- Private Methods

- (void)removeWebCache{
    
    if (@available(iOS 9.0, *)) {
        
        NSSet *websiteDataTypes= [NSSet setWithArray:@[WKWebsiteDataTypeDiskCache,
                                                       //WKWebsiteDataTypeOfflineWebApplication
                                                        WKWebsiteDataTypeMemoryCache,
                                                        //WKWebsiteDataTypeLocal
                                                        WKWebsiteDataTypeCookies,
                                                        //WKWebsiteDataTypeSessionStorage,
                                                        //WKWebsiteDataTypeIndexedDBDatabases,
                                                        //WKWebsiteDataTypeWebSQLDatabases
                                                        ]];
        // All kinds of data
        // NSSet *websiteDataTypes = [WKWebsiteDataStore allWebsiteDataTypes];
        NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
        [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes
                                                   modifiedSince:dateFrom
                                               completionHandler:^{
                
        }];
        [[NSURLCache sharedURLCache] removeAllCachedResponses];
        
    }
    else {
        //先删除cookie
        NSHTTPCookie *cookie;
        NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        for (cookie in [storage cookies]) {
            [storage deleteCookie:cookie];
        }
        
        NSString *libraryDir = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *bundleId  =  [[[NSBundle mainBundle] infoDictionary]
                                objectForKey:@"CFBundleIdentifier"];
        NSString *webkitFolderInLib = [NSString stringWithFormat:@"%@/WebKit",libraryDir];
        NSString *webKitFolderInCaches = [NSString
                                          stringWithFormat:@"%@/Caches/%@/WebKit",libraryDir,bundleId];
        NSString *webKitFolderInCachesfs = [NSString
                                            stringWithFormat:@"%@/Caches/%@/fsCachedData",libraryDir,bundleId];
        NSError *error;
        /* iOS8.0 WebView Cache的存放路径 */
        [[NSFileManager defaultManager] removeItemAtPath:webKitFolderInCaches error:&error];
        [[NSFileManager defaultManager] removeItemAtPath:webkitFolderInLib error:nil];
        /* iOS7.0 WebView Cache的存放路径 */
        [[NSFileManager defaultManager] removeItemAtPath:webKitFolderInCachesfs error:&error];
        NSString *cookiesFolderPath = [libraryDir stringByAppendingString:@"/Cookies"];
        [[NSFileManager defaultManager] removeItemAtPath:cookiesFolderPath error:&error];
        [[NSURLCache sharedURLCache] removeAllCachedResponses];
    }
}

- (void)dealloc {
    
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    
    // 清除缓存
    [self removeWebCache];
    
    [self.webView stopLoading];
    [self.webView removeFromSuperview];
    self.webView = nil;
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    [[NSURLCache sharedURLCache] setDiskCapacity:0];
    [[NSURLCache sharedURLCache] setMemoryCapacity:0];
    
    DNLog(@"%@ dealloc",[self class]);
}

#pragma mark -- UITableView Delegate && DataSource

#pragma mark -- Other Delegate

//
- (void)emptyViewReload {
    
    [self reloadWKWebViewWithURL:self.urlString];
}
// WKWebView Delegate
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    
    DNLog(@"开始加载网页");
    //开始加载网页时展示出webProgress
    //self.webProgress.hidden = NO;
    //开始加载网页的时候将webProgress的Height恢复为1.5倍
    self.webProgress.transform = CGAffineTransformMakeScale(1.0f, 1.5f);
    //防止webProgress被网页挡住
    [self.view bringSubviewToFront:self.webProgress];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {

    DNLog(@"加载完成");
    //加载完成后隐藏webProgress
    //self.webProgress.hidden = YES;
    
    self.allowZoomScale = NO;
    
    //防止内存泄漏
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"WebKitCacheModelPreferenceKey"];
    //本地webkit硬盘图片的缓存；
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"WebKitDiskImageCacheEnabled"];//自己添加的，原文没有提到。
    //静止webkit离线缓存
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"WebKitOfflineWebApplicationCacheEnabled"];//自己添加的，，原文没有提到。
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    DNLog(@"加载失败");
    //加载失败同样需要隐藏webProgress
    //self.webProgress.hidden = YES;

    webView.scrollView.emptyView = [[DNEmptyView alloc] init];
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    DNLog(@"加载失败:%@",error);
    //加载失败同样需要隐藏webProgress
    //self.webProgress.hidden = YES;
    webView.scrollView.emptyView = [[DNEmptyView alloc] init];
}

// 在发送请求之前，决定是否跳转 (在加载的页面中继续操作)
//- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
//
//    if (navigationAction.targetFrame == nil) {
//        [webView loadRequest:navigationAction.request];
//    }
//    decisionHandler(WKNavigationActionPolicyAllow);
//}
// 缩放
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    
    return !self.isAllowZoomScale ? nil : self.webView.scrollView.subviews.firstObject;
}

#pragma mark -- NetWork Methods

#pragma mark -- Setter && Getter

- (UIProgressView *)webProgress {
    
    if (!_webProgress) {
        
        _webProgress = [[UIProgressView alloc] init];
        // 设置进度条的背景颜色
        _webProgress.backgroundColor = UIColor.blueColor;
        _webProgress.transform = CGAffineTransformMakeScale(1.0f, 1.5f);
    }
    return _webProgress;
}

- (WKWebView *)webView {
    
    if (!_webView) {
        _webView = [[WKWebView alloc] init];
        _webView.UIDelegate = self;
        _webView.navigationDelegate  = self;
        _webView.scrollView.delegate = self;
        // 手动设置缩放
        [_webView.scrollView setZoomScale:0.8 animated:NO];
        // 自适应 JS
        //NSString *jSString = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
        
        if (@available(iOS 11.0, *)) {
            _webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    return _webView;
}

@end
