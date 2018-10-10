//
//  NSBaseNetManager.h
//  DNProject
//
//  Created by zjs on 2018/6/27.
//  Copyright © 2018年 zjs. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^CompleteHandler)(NSDictionary * dict);
typedef void(^FaildHandler)(id data);

@interface NSBaseNetManager : NSObject
/** 单例创建*/
+ (instancetype)shareInstance;
/**
 *  @brief GET 请求
 *
 *  @param url      请求网址
 *  @param param    参数字典
 *  @param complete 完成回调
 *  @param faild    失败回调
 */
+ (void)GETRequestWithURL:(NSString *)url
                    param:(NSDictionary *)param
                isNeedSVP:(BOOL)isNeed
          completeHandler:(CompleteHandler)complete
             faildHandler:(FaildHandler)faild;

/**
 *  @brief POST 请求
 *
 *  @param url      请求网址
 *  @param param    参数字典
 *  @param complete 完成回调
 *  @param faild    失败回调
 */
+ (void)POSTRequestWithURL:(NSString *)url
                     param:(NSDictionary *)param
                 isNeedSVP:(BOOL)isNeed
           completeHandler:(CompleteHandler)complete
              faildHandler:(FaildHandler)faild;

/**
 *  @brief JSON 上传
 *
 *  @param url      请求网址
 *  @param param    参数字典
 *  @param complete 完成回调
 *  @param faild    失败回调
 */
+ (void)POSTRequestWithURL:(NSString *)url
                 JSONParam:(NSDictionary *)param
                 isNeedSVP:(BOOL)isNeed
           completeHandler:(CompleteHandler)complete
              faildHandler:(FaildHandler)faild;

/**
 *  @brief 单图上传
 *
 *  @param url        请求网址
 *  @param paramImage 参数字典
 *  @param complete   完成回调
 *  @param faild      失败回调
 */
+ (void)POSTImageWithURL:(NSString *)url
                   param:(UIImage *)paramImage
         completeHandler:(CompleteHandler)complete
            faildHandler:(FaildHandler)faild;

/**
 *  @brief 单图上传
 *
 *  @param url      请求网址
 *  @param paramArr 参数字典
 *  @param complete 完成回调
 *  @param faild    失败回调
 */
+ (void)POSTImageWithURL:(NSString *)url
                  params:(NSArray *)paramArr
         completeHandler:(CompleteHandler)complete
            faildHandler:(FaildHandler)faild;

@end
