//
//  DNGuideTool.h
//  163Music
//
//  Created by zjs on 2018/7/24.
//  Copyright © 2018年 zjs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DNGuideTool : NSObject

+ (instancetype)shareInstance;

+ (void)showGuidePageView:(NSArray *)imageArray;

@end
