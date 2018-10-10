//
//  DNBaseNetWork.m
//  163Music
//
//  Created by zjs on 2018/8/21.
//  Copyright © 2018年 zjs. All rights reserved.
//

#import "DNBaseNetWork.h"


#define SELF_SHARE  [DNBaseNetWork shareInstance]
#define MainWindow  [UIApplication sharedApplication].keyWindow


@interface DNBaseNetWork ()

@property (nonatomic, strong) AFHTTPSessionManager * requestManager;

@end

static DNBaseNetWork * _share = nil;

@implementation DNBaseNetWork

#pragma mark -- 单例创建
/** 单例创建 */
+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!_share) {
            _share = [[self alloc] init];
        }
    });
    return _share;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!_share) {
            _share = [super allocWithZone:zone];
        }
    });
    return _share;
}

- (id)copyWithZone:(NSZone *)zone {
    return _share;
}

#pragma mark -- Request

+ (void)GETWithUrl:(NSString *)urlStr isNeedMBP:(BOOL)isNeedMBP params:(NSDictionary *)params sucessHandler:(CompleteHandler)sucessHandler failureHandler:(FailureHandler)failureHandler {
    
}

+ (void)POSTWithUrl:(NSString *)urlStr isNeedMBP:(BOOL)isNeedMBP params:(NSDictionary *)params sucessHandler:(CompleteHandler)sucessHandler failureHandler:(FailureHandler)failureHandler {
    
}

#pragma mark -- Methods

/**
 *  @brief  根据返回的code 弹出对应的提示框
 *
 *  @param  errorCode 错误代码
 */
- (void)showErrorToastWithErrorCode:(NSInteger)errorCode {
    switch (errorCode)
    {
        case -1001:
            [SELF_SHARE showErrorMessage:@"请求超时,请检查网络是否异常"];
            break;
        case -1009:
            [SELF_SHARE showErrorMessage:@"连接网络失败,请检查网络是否异常"];
            break;
        default:
            [SELF_SHARE showErrorMessage:@"未能连接到服务器,请检查服务是否异常"];
            break;
    }
}

/** 弹窗 */
- (void)showErrorMessage:(NSString *)message {
    [MainWindow makeToast:message duration:1.5 position:CSToastPositionCenter];
}


// MBP show

- (void)showMBP {
    [MBProgressHUD showHUDAddedTo:MainWindow animated:YES];
}
// MBP hide
- (void)hideMBP {
    [MBProgressHUD hideHUDForView:MainWindow animated:YES];
}

// 检测当前的网络状态
+ (void)netWorkMonitoring {
    //__block DNBaseNetWorkMonitorStatus * netWorkStatus;
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        //netWorkStatus = (DNBaseNetWorkMonitorStatus *)status;
        switch (status)
        {
            case -1:
                DNLog(@"未识别网络");
                break;
            case 0:
                DNLog(@"未连接网络");
                break;
            case 1:
                DNLog(@"3G/4G网络");
                break;
            case 2:
                DNLog(@"WIFI网络");
                break;
            default:
                break;
        }
        NSString * statusStr = [NSString stringWithFormat:@"%ld",(long)status];
        // 保存设置状态
        [[NSUserDefaults standardUserDefaults] setObject:statusStr forKey:@"NetStatus"];
        [[NSUserDefaults standardUserDefaults] synchronize];// 及时存储
    }];
    //return netWorkStatus;
}

#pragma mark -- lazy load

- (AFHTTPSessionManager *)requestManager {
    
    if (!_requestManager) {
        _requestManager = [AFHTTPSessionManager manager];
        _requestManager.requestSerializer.timeoutInterval = 3.f;
        [_requestManager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        [_requestManager.requestSerializer didChangeValueForKey: @"timeoutInterval"];
        
        NSSet * set = [NSSet setWithObjects:@"text/html", @"text/plain", @"application/json", nil];
        _requestManager.responseSerializer.acceptableContentTypes = [_requestManager.responseSerializer.acceptableContentTypes setByAddingObjectsFromSet:set];
        
        _requestManager.requestSerializer  = [AFHTTPRequestSerializer serializer];
        _requestManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    }
    return _requestManager;
}

@end
