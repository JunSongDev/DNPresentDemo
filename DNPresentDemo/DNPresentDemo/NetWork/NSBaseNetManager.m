//
//  NSBaseNetManager.m
//  DNProject
//
//  Created by zjs on 2018/6/27.
//  Copyright © 2018年 zjs. All rights reserved.
//

#import "NSBaseNetManager.h"

#define HOST        @""
#define SELFSHARE   [NSBaseNetManager shareInstance]
#define MAINWINDOW  [UIApplication sharedApplication].keyWindow

@interface NSBaseNetManager ()

@property (nonatomic, strong) AFHTTPSessionManager * sessionManager;
@end

static NSBaseNetManager * instanceManager;

@implementation NSBaseNetManager

/** 重写 allocWithZone: 方法 */
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (instanceManager == nil) {
            instanceManager = [super allocWithZone:zone];
        }
    });
    return instanceManager;
}
/** 重写 copyWithZone: 方法 */
- (id)copyWithZone:(NSZone *)zone {
    return instanceManager;
}
/** 单例模式创建  */
+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!instanceManager) {
            instanceManager = [[self alloc] init];
        }
    });
    return instanceManager;
}

// Lazy Load sessionManager
- (AFHTTPSessionManager *)sessionManager
{
    if (!_sessionManager)
    {
        _sessionManager = [AFHTTPSessionManager manager];
        _sessionManager.requestSerializer.timeoutInterval = 3.f;
        [_sessionManager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        [_sessionManager.requestSerializer didChangeValueForKey: @"timeoutInterval"];
        
        NSSet * set = [NSSet setWithObjects:@"text/html", @"text/plain", @"application/json", nil];
        _sessionManager.responseSerializer.acceptableContentTypes = [_sessionManager.responseSerializer.acceptableContentTypes setByAddingObjectsFromSet:set];
        
        _sessionManager.requestSerializer  = [AFHTTPRequestSerializer serializer];
        _sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    }
    return _sessionManager;
}
/**
 *  @brief  GET 请求
 */
+ (void)GETRequestWithURL:(NSString *)url param:(NSDictionary *)param isNeedSVP:(BOOL)isNeed completeHandler:(CompleteHandler)complete faildHandler:(FaildHandler)faild
{
    // 检查当前网络状态
    [self netWorkMonitoring];
    // 拼接 URL
    url = [HOST stringByAppendingString:url];
    DNLog(@"请求地址：%@%@",url,[self paramsStrWith:param]);
    
    // 是否需要 MBP 菊花
    if (isNeed == YES)
    {
        [MBProgressHUD showHUDAddedTo:MAINWINDOW animated:YES];
    }
    
    [SELFSHARE.sessionManager GET:url parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 是否需要 MBP 菊花
        if (isNeed == YES)
        {
            [MBProgressHUD hideHUDForView:MAINWINDOW animated:YES];
        }
        // 成功，解析 respoObject
        NSDictionary * dict = [NSBaseNetManager dataReserveForDictionaryWithData:responseObject];
        if (dict) {
            // 判断后台返回的 code 是否为零
            if ([dict[@"code"] integerValue] == 0) {
                complete(dict);
            }
            else {
                faild(dict);
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 是否需要 MBP 菊花
        if (isNeed == YES) {
            [MBProgressHUD hideHUDForView:MAINWINDOW animated:YES];
        }
        // 失败
        [SELFSHARE showErrorToastWithErrorCode:error.code];
    }];
}
/**
 *  @brief  POST 请求
 */
+ (void)POSTRequestWithURL:(NSString *)url param:(NSDictionary *)param isNeedSVP:(BOOL)isNeed completeHandler:(CompleteHandler)complete faildHandler:(FaildHandler)faild
{
    // 检查当前网络状态
    [self netWorkMonitoring];
    // 拼接 URL
    url = [HOST stringByAppendingString:url];
    DNLog(@"请求地址：%@%@",url,[self paramsStrWith:param]);
    
    // 是否需要 MBP 菊花
    if (isNeed == YES) {
        [MBProgressHUD showHUDAddedTo:MAINWINDOW animated:YES];
    }
    // POST 请求
    [SELFSHARE.sessionManager POST:url parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 是否需要 MBP 菊花
        if (isNeed == YES)
        {
            [MBProgressHUD hideHUDForView:MAINWINDOW animated:YES];
        }
        // 成功，解析 respoObject
        NSDictionary * dict = [NSBaseNetManager dataReserveForDictionaryWithData:responseObject];
        if (dict) {
            // 判断后台返回的 code 是否为零
            if ([dict[@"code"] integerValue] == 200 ||
                [dict[@"code"] integerValue] == 0) {
                complete(dict);
            }
            else {
                faild(dict);
            }
//            if ([dict[@"code"] integerValue] == 0) {
//                complete(dict);
//            }
//            else {
//                faild(dict);
//            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 是否需要 SVP 菊花
        if (isNeed == YES) {
            [MBProgressHUD hideHUDForView:MAINWINDOW animated:YES];
        }
        // 失败
        [SELFSHARE showErrorToastWithErrorCode:error.code];
    }];
}

/**
 *  @brief  JSON 字符串上传
 */
+ (void)POSTRequestWithURL:(NSString *)url JSONParam:(NSDictionary *)param isNeedSVP:(BOOL)isNeed completeHandler:(CompleteHandler)complete faildHandler:(FaildHandler)faild
{
    // 检查当前网络状态
    [self netWorkMonitoring];
    // 拼接 URL
    url = [HOST stringByAppendingString:url];
    DNLog(@"请求地址：%@%@",url,[self paramsStrWith:param]);
    
    NSMutableURLRequest * request = [SELFSHARE.sessionManager.requestSerializer requestWithMethod:@"POST"
                                                                                        URLString:url
                                                                                       parameters:nil
                                                                                            error:nil];
    request.timeoutInterval = 3.f;
    [request setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    //[request setValue:token forHTTPHeaderField:@"token"];
    
    NSString * uploadSTr = [self convertToJsonData:param];
    NSData   * data      = [uploadSTr dataUsingEncoding:NSUTF8StringEncoding];
    
    request.HTTPBody     = data;
    // 是否需要 SVP 菊花
    if (isNeed == YES) {
        [MBProgressHUD showHUDAddedTo:MAINWINDOW animated:YES];
    }
    
    [[SELFSHARE.sessionManager.session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        // 是否需要 SVP 菊花
        if (isNeed == YES) {
            [MBProgressHUD hideHUDForView:MAINWINDOW animated:YES];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            // 成功，解析 respoObject
            NSDictionary * dict = [NSBaseNetManager dataReserveForDictionaryWithData:data];
            if (!error) {
                if ([dict isKindOfClass:[NSDictionary class]]) {
                    // 请求成功数据处理
                    complete(dict);
                }
                else {
                    faild(dict);
                }
            }
            else {
                // 失败
                [SELFSHARE showErrorToastWithErrorCode:error.code];
            }
        });
    }] resume];// 启动task
}


/**
 *  @brief  单图上传
 *
 */
+ (void)POSTImageWithURL:(NSString *)url param:(UIImage *)paramImage completeHandler:(CompleteHandler)complete faildHandler:(FaildHandler)faild
{
    // 检查当前网络状态
    [self netWorkMonitoring];
    // 拼接 URL
    url = [HOST stringByAppendingString:url];
    DNLog(@"请求地址：%@",url);
    // 显示 MBP 菊花
    [MBProgressHUD showHUDAddedTo:MAINWINDOW animated:YES];
    SELFSHARE.sessionManager.requestSerializer.timeoutInterval = 15.f;
    
    [SELFSHARE.sessionManager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSString * dateStr = [self GETCurrentDate];
        NSString * fileName = [NSString stringWithFormat:@"%@.png",dateStr];
        
        NSData * imageData = UIImageJPEGRepresentation(paramImage, 1);
        double scaleNum = (double)300*1024/imageData.length;
        imageData = scaleNum < 1 ? UIImageJPEGRepresentation(paramImage, scaleNum):UIImageJPEGRepresentation(paramImage, 0.1);
        
        [formData appendPartWithFileData:imageData
                                    name:@"file"
                                fileName:fileName
                                mimeType:@"image/jpg/png/jpeg"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [MBProgressHUD hideHUDForView:MAINWINDOW animated:YES];
        // 成功，解析 respoObject
        NSDictionary * dict = [NSBaseNetManager dataReserveForDictionaryWithData:responseObject];
        if (dict) {
            // 判断后台返回的 code 是否为零
            if ([dict[@"code"] integerValue] == 0) {
                complete(dict);
            }
            else {
                faild(dict);
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [MBProgressHUD hideHUDForView:MAINWINDOW animated:YES];
        // 失败
        [SELFSHARE showErrorToastWithErrorCode:error.code];
    }];
}

/**
 *  @brief  多图上传
 *
 */

+ (void)POSTImageWithURL:(NSString *)url params:(NSArray *)paramArr completeHandler:(CompleteHandler)complete faildHandler:(FaildHandler)faild
{
    // 检查当前网络状态
    [self netWorkMonitoring];
    // 拼接 URL
    url = [HOST stringByAppendingString:url];
    DNLog(@"请求地址：%@",url);
    // 显示 MBP 菊花
    [MBProgressHUD showHUDAddedTo:MAINWINDOW animated:YES];
    [SELFSHARE.sessionManager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        // 遍历数组
        for (int i = 0; i < paramArr.count; i ++) {
            // 将数组中的 URL 转成 data
            NSData  * data = [NSData dataWithContentsOfURL:paramArr[i]];
            UIImage * image = [UIImage imageWithData:data];
            
            NSString * dateStr  = [self GETCurrentDate];
            NSString * fileName = [NSString stringWithFormat:@"%@.png",dateStr];
            
            NSData * imageData = UIImageJPEGRepresentation(image, 1);
            double   scaleNum  = (double)300*1024/imageData.length;
            imageData = scaleNum < 1 ? UIImageJPEGRepresentation(image, scaleNum):UIImageJPEGRepresentation(image, 0.1);
            
            [formData appendPartWithFileData:imageData
                                        name:@"file"
                                    fileName:fileName
                                    mimeType:@"image/jpg/png/jpeg"];
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [MBProgressHUD hideHUDForView:MAINWINDOW animated:YES];
        // 成功，解析 respoObject
        NSDictionary * dict = [NSBaseNetManager dataReserveForDictionaryWithData:responseObject];
        if (dict) {
            // 判断后台返回的 code 是否为零
            if ([dict[@"code"] integerValue] == 0) {
                complete(dict);
            }
            else {
                faild(dict);
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [MBProgressHUD hideHUDForView:MAINWINDOW animated:YES];
        // 失败
        [SELFSHARE showErrorToastWithErrorCode:error.code];
    }];
}

/**
 *  @brief  data 转 字典
 */
+ (NSDictionary *)dataReserveForDictionaryWithData:(id)data {
    return [NSJSONSerialization JSONObjectWithData:data
                                           options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves
                                             error:nil];
}

/**
 *  @brief  字典转json字符串方法
 *  @param dict 字典
 *  @return 字符串
 */
+ (NSString *)convertToJsonData:(NSDictionary *)dict {
    NSError * error;
    // 字典转 data
    NSData  * jsonData = [NSJSONSerialization dataWithJSONObject:dict
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    NSString *jsonString;
    if (!jsonData) {
        DNLog(@"字典转json字符串错误：%@",error);
    }
    else {
        jsonString = [[NSString alloc]initWithData:jsonData
                                          encoding:NSUTF8StringEncoding];
        // 替换掉 url 地址中的 \/
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\\/" withString:@"/"];
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    //去掉字符串中的空格
    NSRange range = {0,jsonString.length};
    [mutStr replaceOccurrencesOfString:@" "
                            withString:@""
                               options:NSLiteralSearch range:range];
    
    //去掉字符串中的换行符
    NSRange range2 = {0,mutStr.length};
    [mutStr replaceOccurrencesOfString:@"\n"
                            withString:@""
                               options:NSLiteralSearch range:range2];
    
    return mutStr;
}

/**
 *  @brief  拼接参数
 *  @param  paramsDict 参数字典
 */
+ (NSString * )paramsStrWith:(NSDictionary *)paramsDict
{
    NSString *str = paramsDict.count == 0 ? @"":@"?";
    for (NSString *key in paramsDict) {
        str = [str stringByAppendingString:key];
        str = [str stringByAppendingString:@"="];
        str = [str stringByAppendingString:[NSString stringWithFormat:@"%@",[paramsDict objectForKey:key]]];
        str = [str stringByAppendingString:@"&"];
    }
    if (str.length > 1) {
        str = [str substringToIndex:str.length - 1];
    }
    return str;
}

/**
 *  @brief  获取当前时间
 *  @return 字符串
 */
+ (NSString *)GETCurrentDate {
    NSDate *date = [NSDate date];
    NSDateFormatter *formormat = [[NSDateFormatter alloc]init];
    [formormat setDateFormat:@"HH-mm-ss-sss"];
    
    return [formormat stringFromDate:date];
}

// 检测当前的网络状态
+ (void)netWorkMonitoring {
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
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
//        if (status == AFNetworkReachabilityStatusReachableViaWWAN ||
//            status == AFNetworkReachabilityStatusReachableViaWiFi)
//        {
//            DNLog(@"有网");
//        }else{
//            DNLog(@"没网");
//        }
    }];
}

/**
 *  @brief  根据返回的code 弹出对应的提示框
 *
 *  @param  errorCode 错误代码
 */
- (void)showErrorToastWithErrorCode:(NSInteger)errorCode {
    switch (errorCode)
    {
        case -1001:
            [SELFSHARE showErrorMessage:@"请求超时,请检查网络是否异常"];
            break;
        case -1009:
            [SELFSHARE showErrorMessage:@"连接网络失败,请检查网络是否异常"];
            break;
        default:
            [SELFSHARE showErrorMessage:@"未能连接到服务器,请检查服务是否异常"];
            break;
    }
}
/** 弹窗 */
- (void)showErrorMessage:(NSString *)message {
    [MAINWINDOW makeToast:message duration:1.5 position:CSToastPositionCenter];
}

@end
