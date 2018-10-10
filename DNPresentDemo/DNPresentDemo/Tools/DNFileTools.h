//
//  DNFileTools.h
//  163Music
//
//  Created by zjs on 2018/9/25.
//  Copyright © 2018 zjs. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, DNFileType) {
    
    Array = 0,
    Dictionary = 1,
    String = 2
};
// 文件写入成功回调
typedef void(^FileWriteSuccessHandler)(void);

// 文件读取失败回调
typedef void(^FileReadFailureHandler)(id content);

@interface DNFileTools : NSObject

/**
 * 工具类单例
 */
+ (instancetype)defaultManager;

/**
 写入文件
 */
-(void)dn_writeToFile:(id)content FileName:(NSString *)fileName CompletionHandler:(FileWriteSuccessHandler)completionHandler;

/**
 读取文件
 */
-(void)dn_readFromFile:(id)fileName FileType:(DNFileType)fileType CompletionHandler:(FileReadFailureHandler)completionHandler;

/**
 写入NSUserDefaults
 */
-(void)dn_writeUserDataWithValue:(id)data forKey:(NSString*)key;

/**
 读取NSUserDefaults
 */
- (id)dn_readUserDataWithKey:(NSString*)key;

/**
 删除NSUserDefaults
 */
- (void)dn_removeUserDataWithkey:(NSString*)key;

@end

NS_ASSUME_NONNULL_END
