//
//  BaseView.m
//  163Music
//
//  Created by zjs on 2018/5/22.
//  Copyright © 2018年 zjs. All rights reserved.
//

#import "BaseView.h"

@implementation BaseView

- (instancetype)init{
    
    self = [super init];
    if (self) {
        
        [self setControlForSuper];
        [self addConstraintsForSuper];
    }
    return self;
}

#pragma mark -- setControlForSuper
- (void)setControlForSuper
{
    
}

#pragma mark -- addConstraintsForSuper
- (void)addConstraintsForSuper
{
    
    
}

- (UIViewController *)viewForSuperBaseView{
    
    for (UIView * next = self.superview; next; next = next.superview)
    {
        UIResponder * nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]])
        {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

@end
