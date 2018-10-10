//
//  WKWebView+Extension.m
//  163Music
//
//  Created by zjs on 2018/8/1.
//  Copyright © 2018年 zjs. All rights reserved.
//

#import "WKWebView+Extension.h"

@implementation WKWebView (Extension)

- (void)dn_removeBackgroundShadow {
    
    for (UIView * subView in [self.scrollView subviews]) {
        
        if ([subView isKindOfClass:[UIImageView class]] &&
            subView.frame.origin.x <= 500) {
            
            subView.hidden = YES;
            [subView removeFromSuperview];
        }
    }
}

- (void)dn_webViewLoadWithURL:(NSString *)urlStr {
    
    [self loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];
}

@end
