//
//  NSObject+Extension.m
//  163Music
//
//  Created by zjs on 2018/7/31.
//  Copyright © 2018年 zjs. All rights reserved.
//

#import "NSObject+Extension.h"

@implementation NSObject (Extension)

+ (void)dn_methodSwizzlingWithOriginalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector {
    
    Class class = [self class];
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    BOOL didAddMethod = class_addMethod(class,originalSelector,
                                        method_getImplementation(swizzledMethod),
                                        method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {
        class_replaceMethod(class,swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}
@end
