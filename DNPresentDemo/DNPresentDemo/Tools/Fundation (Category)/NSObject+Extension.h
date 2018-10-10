//
//  NSObject+Extension.h
//  163Music
//
//  Created by zjs on 2018/7/31.
//  Copyright © 2018年 zjs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Extension)

+ (void)dn_methodSwizzlingWithOriginalSelector:(SEL)originalSelector
                              swizzledSelector:(SEL)swizzledSelector;
@end
