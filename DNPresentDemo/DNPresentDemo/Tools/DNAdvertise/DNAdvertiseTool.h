//
//  DNAdvertiseTool.h
//  163Music
//
//  Created by zjs on 2018/7/24.
//  Copyright © 2018年 zjs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DNAdvertiseTool : NSObject

+ (instancetype)shareInstance;

+ (void)showAdvertiseView:(NSString *)imageName;
@end
