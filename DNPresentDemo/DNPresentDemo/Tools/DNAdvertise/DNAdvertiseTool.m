//
//  DNAdvertiseTool.m
//  163Music
//
//  Created by zjs on 2018/7/24.
//  Copyright © 2018年 zjs. All rights reserved.
//

#import "DNAdvertiseTool.h"
#import "DNAdvertiseView.h"

static NSString *const adImageName = @"adImageName";

@implementation DNAdvertiseTool

static DNAdvertiseTool *_shareInstance = nil;

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!_shareInstance) {
            _shareInstance = [super allocWithZone:zone];
        }
    });
    return _shareInstance;
}

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!_shareInstance) {
            _shareInstance = [[self alloc] init];
        }
    });
    return _shareInstance;
}
- (id)copyWithZone:(NSZone *)zone {
    return _shareInstance;
}

+ (void)showAdvertiseView:(NSString *)imageName {
    
    // 1.判断沙盒中是否存在广告图片，如果存在，直接显示
    NSString *filePath = [[DNAdvertiseTool shareInstance] getFilePathWithImageName:[NSUserDefaults.standardUserDefaults valueForKey:adImageName]];
    
    BOOL isExist = [[DNAdvertiseTool shareInstance] isFileExistWithFilePath:filePath];
    
    if (isExist) {// 图片存在
        DNAdvertiseView *advertiseView = [[DNAdvertiseView alloc] initWithFrame:UIScreen.mainScreen.bounds];
        advertiseView.filePath = filePath;
        [advertiseView advertiseViewShow];
    }
    // 2.无论沙盒中是否存在广告图片，都需要重新调用广告接口，判断广告是否更新
    [[DNAdvertiseTool shareInstance] getAdvertisingImage:imageName];
}

/**
 *  初始化广告页面
 */
- (void)getAdvertisingImage:(NSString *)imageUrl
{
    NSArray *stringArr = [imageUrl componentsSeparatedByString:@"/"];
    NSString *imageName = stringArr.lastObject;
    // 拼接沙盒路径
    NSString *filePath = [self getFilePathWithImageName:imageName];
    BOOL isExist = [self isFileExistWithFilePath:filePath];
    if (!isExist){// 如果该图片不存在，则删除老图片，下载新图片
        [self downloadAdImageWithUrl:imageUrl imageName:imageName];
    }
}
/**
 *  下载新图片
 */
- (void)downloadAdImageWithUrl:(NSString *)imageUrl imageName:(NSString *)imageName
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
        NSString *filePath = [self getFilePathWithImageName:imageName]; // 保存文件的名称
        
        if ([data writeToFile:filePath atomically:YES]) {// 保存成功
            DNLog(@"保存成功");
            [self deleteOldImage];
            [NSUserDefaults.standardUserDefaults setValue:imageName forKey:adImageName];
            [NSUserDefaults.standardUserDefaults synchronize];
            // 如果有广告链接，将广告链接也保存下来
        }else{
            DNLog(@"保存失败");
        }
        
    });
}

/**
 *  删除旧图片
 */
- (void)deleteOldImage
{
    NSString *imageName = [NSUserDefaults.standardUserDefaults valueForKey:adImageName];
    if (imageName) {
        NSString *filePath = [self getFilePathWithImageName:imageName];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager removeItemAtPath:filePath error:nil];
    }
}

/**
 *  判断文件是否存在
 */
- (BOOL)isFileExistWithFilePath:(NSString *)filePath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDirectory = FALSE;
    return [fileManager fileExistsAtPath:filePath isDirectory:&isDirectory];
}
/**
 *  根据图片名拼接文件路径
 */
- (NSString *)getFilePathWithImageName:(NSString *)imageName
{
    if (imageName) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES);
        NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:imageName];
        return filePath;
    }
    return nil;
}
@end
