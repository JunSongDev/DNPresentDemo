//
//  WKWebView+Extension.h
//  163Music
//
//  Created by zjs on 2018/8/1.
//  Copyright © 2018年 zjs. All rights reserved.
//

#import <WebKit/WebKit.h>

@interface WKWebView (Extension)

// 移除 webView 的背景阴影
- (void)dn_removeBackgroundShadow;

// webView 加载网址
- (void)dn_webViewLoadWithURL:(NSString *)urlStr;

@end
