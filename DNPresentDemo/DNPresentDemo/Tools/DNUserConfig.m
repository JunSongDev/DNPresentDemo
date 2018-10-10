//
//  DNUserConfig.m
//  163Music
//
//  Created by zjs on 2018/8/15.
//  Copyright © 2018年 zjs. All rights reserved.
//

#import "DNUserConfig.h"

static DNUserConfig * _userConfig = nil;

@implementation DNUserConfig

/**
 *  懒汉式: 第一次用单例对象时,进行创建,推荐使用
 *  懒汉式是典型的时间换空间，也就是每次获取实例都会进行判断，看是否需要创建实例，浪费判断的时间。当然，如果一直没有人使用的话，那就不会创建实例，则节约内存空间。
 *  饿汉式: 一进入程序就创建该对象,不推荐使用
 *  饿汉式是典型的空间换时间，当类装载的时候就会创建类实例，不管你用不用，先创建出来，然后每次调用的时候，就不需要再判断了，节省了运行时间。
 *  非 ARC 重写以下方法：
 *      - (oneway void)release { }
 *      - (id)retain { return self; }
 *      - (NSUInteger)retainCount { return 1;}
 *      - (id)autorelease { return self;}
 */
// 单例模式（懒汉式（不使用 GCD））ARC 环境下
//+ (instancetype)allocWithZone:(struct _NSZone *)zone {
//    // 防止频繁加锁
//    if (!imagePicker) {
//        // 加锁
//        @synchronized(self) {
//            // 防止频繁创建
//            if (!imagePicker) {
//                imagePicker = [super allocWithZone:zone];
//            }
//        }
//    }
//    return imagePicker;
//}
//
//+ (instancetype)shareImagePicker {
//
//    if (!imagePicker) {
//        @synchronized(self) {
//
//            if (!imagePicker) {
//
//                imagePicker = [[self alloc] init];
//            }
//        }
//    }
//    return imagePicker;
//}
//
//- (id)copyWithZone:(NSZone *)zone {
//
//    return imagePicker;
//}
// 单例模式（饿汉式）ARC 环境下
//+ (void)load {
//
//    imagePicker = [[self alloc] init];
//}
//
//+ (instancetype)allocWithZone:(struct _NSZone *)zone {
//
//    if (!imagePicker) {
//        imagePicker = [super allocWithZone:zone];
//    }
//    return imagePicker;
//}
//
//+ (instancetype)shareImagePicker {
//
//    return imagePicker;
//}
//
//- (id)copyWithZone:(NSZone *)zone {
//
//    return imagePicker;
//}

+ (instancetype)defaultConfig {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!_userConfig) {
            _userConfig = [[self alloc] init];
        }
    });
    return _userConfig;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!_userConfig) {
            _userConfig = [super allocWithZone:zone];
        }
    });
    return _userConfig;
}
- (id)copyWithZone:(NSZone *)zone {
    return _userConfig;
}

///===============================================================

- (void)saveConfigWithDict:(NSDictionary *)dict {
    
    DNUserConfig * userConfig = [[DNUserConfig alloc] initWithDict:dict];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:userConfig];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"USERS"];
    //及时存储数据
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (instancetype)initWithDict:(NSDictionary *)dict {
    
    self = [super init];
    if (self) {
        [self mj_setKeyValues:dict];
    }
    return self;
}
/** 保存当前的 userConfig */
- (void)saveUserConfig:(DNUserConfig *)userConfig {
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:userConfig];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"USERS"];
    [[NSUserDefaults standardUserDefaults] synchronize];//及时存储数据
}

+ (instancetype)objectForKey:(NSString *)strKey
{
    NSUserDefaults *config = [NSUserDefaults standardUserDefaults];
    return [config objectForKey:strKey];
}

+ (void)setObject:(id)value forKey:(NSString *)strKey
{
    NSUserDefaults *config = [NSUserDefaults standardUserDefaults];
    [config setObject:value forKey:strKey];
}

/*清除所有的存储本地的数据*/
+ (void)cleanAllUserDefault{
    
    NSUserDefaults *config = [NSUserDefaults standardUserDefaults];
    NSDictionary * dic = [config dictionaryRepresentation];
    for (id key in dic) {
        [config removeObjectForKey:key];
    }
}
/* 清除所有的存储本地的数据*/
+ (void)clearAllUserDefaultsData
{
    NSString * appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
}

@end
