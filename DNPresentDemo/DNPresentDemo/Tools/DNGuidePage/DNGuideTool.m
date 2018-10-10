//
//  DNGuideTool.m
//  163Music
//
//  Created by zjs on 2018/7/24.
//  Copyright © 2018年 zjs. All rights reserved.
//

#import "DNGuideTool.h"
#import "DNGuideView.h"

@interface DNGuideTool ()

@property (nonatomic, strong) DNGuideView * guideView;
@end

@implementation DNGuideTool

static DNGuideTool *shareInstance_ = nil;

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!shareInstance_) {
            shareInstance_ = [super allocWithZone:zone];
        }
    });
    return shareInstance_;
}

+ (instancetype)shareInstance {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!shareInstance_) {
            shareInstance_ = [[self alloc] init];
        }
    });
    return shareInstance_;
}

- (id)copyWithZone:(NSZone *)zone {
    return shareInstance_;
}

+ (void)showGuidePageView:(NSArray *)imageArray {
    
    if (![DNGuideTool shareInstance].guideView) {
        
        [DNGuideTool shareInstance].guideView = [DNGuideView showGuideWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H) imageArray:imageArray];
    }
    [[UIApplication sharedApplication].keyWindow addSubview:[DNGuideTool shareInstance].guideView];
}

@end
