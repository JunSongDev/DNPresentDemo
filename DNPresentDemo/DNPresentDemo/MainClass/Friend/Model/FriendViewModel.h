//
//  FriendViewModel.h
//  163Music
//
//  Created by zjs on 2018/8/9.
//  Copyright © 2018年 zjs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FriendViewModel : NSObject

@property (nonatomic, strong, readonly) RACCommand * command;

- (void)bindViewToViewModel:(UIView *)view;

@end
