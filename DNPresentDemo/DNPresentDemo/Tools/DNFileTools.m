//
//  DNFileTools.m
//  163Music
//
//  Created by zjs on 2018/9/25.
//  Copyright © 2018 zjs. All rights reserved.
//

#import "DNFileTools.h"

static DNFileTools * _fileManager = nil;

@implementation DNFileTools

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!_fileManager) {
            _fileManager = [super allocWithZone:zone];
        }
    });
    return _fileManager;
}

+ (instancetype)defaultManager {
    _fileManager = [[self alloc] init];
    return _fileManager;
}

- (id)copyWithZone:(NSZone *)zone {
    return _fileManager;
}

// 写入沙盒文件
- (void)dn_writeToFile:(id)content FileName:(NSString *)fileName CompletionHandler:(FileWriteSuccessHandler)completionHandler {
    
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString * path = paths.firstObject;
    
    NSString * filePath = [path stringByAppendingPathComponent:fileName];
    
    NSError * error;
    
    if ([content isKindOfClass:NSString.class]) {
        [content writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:&error];
    }
    else {
        [content writeToFile:filePath atomically:YES];
    }
    
    if (!error) {
        completionHandler();
    }
}

// 读取沙盒文件
- (void)dn_readFromFile:(id)fileName FileType:(DNFileType)fileType CompletionHandler:(FileReadFailureHandler)completionHandler {
    
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString * path = paths.firstObject;
    
    NSString * filePath = [path stringByAppendingPathComponent:fileName];
    
    NSError * error;
    
    if (fileType == String) {
        
        NSString * content = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
        if (!error) {
            completionHandler(content);
        }
    }
    else if (fileType == Array) {
        
        NSArray * content = [NSArray arrayWithContentsOfFile:filePath];
        
        completionHandler(content);
    }
    else {
        
        NSDictionary * content = [NSDictionary dictionaryWithContentsOfFile:filePath];
        
        completionHandler(content);
    }
}

// 存储用户偏好设置到NSUserDefults
- (void)dn_writeUserDataWithValue:(id)data forKey:(NSString *)key {
    
    if (data == nil) {
        return;
    }
    else {
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:key];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

// 读取用户偏好设置
- (id)dn_readUserDataWithKey:(NSString *)key {
    
    id temp = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    
    if(temp != nil) {
        
        return temp;
    }
    return nil;
}

// 删除用户偏好设置
- (void)dn_removeUserDataWithkey:(NSString *)key {
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
}

@end
