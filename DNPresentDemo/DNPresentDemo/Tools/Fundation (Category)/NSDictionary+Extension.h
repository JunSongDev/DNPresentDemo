//
//  NSDictionary+Extension.h
//  163Music
//
//  Created by zjs on 2018/7/31.
//  Copyright © 2018年 zjs. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (Extension)

// 字典转 json 字符串
- (NSString *)dn_dictToJsonString;

// 字典转 URL 字符串
- (NSString *)dn_dictToURLString;
@end

NS_ASSUME_NONNULL_END
