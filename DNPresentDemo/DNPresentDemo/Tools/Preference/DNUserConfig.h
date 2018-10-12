//
//  DNUserConfig.h
//  163Music
//
//  Created by zjs on 2018/8/15.
//  Copyright © 2018年 zjs. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DNUserConfig : NSObject

+ (instancetype)defaultConfig;

//- (void)setObjct:(id)objct forKey:(NSString *)key;
//- (void)setValue:(id)value forKey:(NSString *)key;

- (void)saveConfigWithDict:(NSDictionary *)dict;
- (void)saveUserConfig:(DNUserConfig *)userConfig;

+ (id)objectForKey:(NSString *)strKey;
//+ (void)setObject:(id)value forKey:(NSString *)strKey;
/* 清除所有的存储本地的数据*/
+ (void)clearAllUserDefaultsData;
/*清除所有的存储本地的数据*/
+ (void)cleanAllUserDefault;
@end

NS_ASSUME_NONNULL_END
