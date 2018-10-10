//
//  FriendPageViewModel.h
//  163Music
//
//  Created by zjs on 2018/10/8.
//  Copyright © 2018 zjs. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FriendPageViewModel : NSObject

@property (nonatomic, strong, readonly) RACCommand * command;


- (void)ninaPagerViewForDataHandler:(void(^)(NinaPagerView *pageView))handler;

@end

NS_ASSUME_NONNULL_END
