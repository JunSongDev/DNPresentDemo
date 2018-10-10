//
//  NSDictionary+Extension.m
//  163Music
//
//  Created by zjs on 2018/7/31.
//  Copyright © 2018年 zjs. All rights reserved.
//

#import "NSDictionary+Extension.h"

@implementation NSDictionary (Extension)

- (NSString *)dn_dictToJsonString {
    
    if ([NSJSONSerialization isValidJSONObject:self]) {
        NSError *error = nil;
        // 1.转化为 JSON 格式的 NSData
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&error];
        if (error) {
            DNLog(@"字典转JSON字符串失败：%@", error);
        }
        // 2.转化为 JSON 格式的 NSString
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return nil;
}

- (NSString *)dn_dictToURLString {
    
    NSMutableString * mutableString = [NSMutableString string];
    // 判断当前字典是否为空
    if (dn_isEmpty(self)) {
        return mutableString;
    }
    else {
        // 不为空则遍历字典，拼接
        [mutableString appendFormat:@"?"];
        [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            
            [mutableString appendFormat:@"%@=",key];
            [mutableString appendFormat:@"%@",obj];
            [mutableString appendFormat:@"%@",@"&"];
        }];
        
        NSString * result = [mutableString copy];
        // 判断是否以 @"&" 结尾，则去掉 @"&"
        if ([result hasSuffix:@"&"]) {
            result = [result substringToIndex:result.length-1];
        }
        return result;
    }
}

/** 判断对象是否为空 */
static inline BOOL dn_isEmpty(id thing) {
    return thing == nil ||
    [thing isEqual:[NSNull null]] ||
    [thing isEqual:@"null"] ||
    [thing isEqual:@"(null)"] ||
    ([thing respondsToSelector:@selector(length)]
     && [(NSData *)thing length] == 0) ||
    ([thing respondsToSelector:@selector(count)]
     && [(NSArray *)thing count] == 0);
}
@end
