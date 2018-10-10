//
//  DNBaseNetWork.h
//  163Music
//
//  Created by zjs on 2018/8/21.
//  Copyright © 2018年 zjs. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger ,DNBaseNetWorkMonitorStatus) {
    
    DNBaseNetWorkMonitorStatusUnknown          = -1,
    DNBaseNetWorkMonitorStatusNotReachable     = 0,
    DNBaseNetWorkMonitorStatusReachableViaWWAN = 1,
    DNBaseNetWorkMonitorStatusReachableViaWiFi = 2,
};

typedef void(^CompleteHandler)(NSDictionary * responseObjc);
typedef void(^FailureHandler)(id failureObjc);

@interface DNBaseNetWork : NSObject

+ (instancetype)shareInstance;

//- (void)requestBymonitorNetworking;

/**
 *  @brief GET 请求
 *
 *  @param urlStr         请求网址
 *  @param isNeedMBP      是否弹窗
 *  @param params         参数字典
 *  @param sucessHandler  完成回调
 *  @param failureHandler 失败回调
 */
+ (void)GETWithUrl:(NSString *)urlStr isNeedMBP:(BOOL)isNeedMBP params:(NSDictionary *)params sucessHandler:(CompleteHandler)sucessHandler failureHandler:(FailureHandler)failureHandler;

/**
 *  @brief POST 请求
 *
 *  @param urlStr         请求网址
 *  @param isNeedMBP      是否弹窗
 *  @param params         参数字典
 *  @param sucessHandler  完成回调
 *  @param failureHandler 失败回调
 */
+ (void)POSTWithUrl:(NSString *)urlStr isNeedMBP:(BOOL)isNeedMBP params:(NSDictionary *)params sucessHandler:(CompleteHandler)sucessHandler failureHandler:(FailureHandler)failureHandler;

@end
