//
//  FriendViewModel.m
//  163Music
//
//  Created by zjs on 2018/8/9.
//  Copyright © 2018年 zjs. All rights reserved.
//

#import "FriendViewModel.h"

@interface FriendViewModel ()

@property (nonatomic, strong) RACCommand * command;
@property (nonatomic, strong) UILabel * title_label;
@end


@implementation FriendViewModel

- (void)bindViewToViewModel:(UIView *)view {
    
    self.title_label = (UILabel *)view;
    
    [self command];
}

- (RACCommand *)command {

    if (!_command) {

        _command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {

            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {

                self.title_label.text = @"viewModel";
                self.title_label.textColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0
                                                             green:arc4random_uniform(255)/255.0
                                                              blue:arc4random_uniform(255)/255.0
                                                             alpha:1.0];
                [subscriber sendCompleted];
                return nil;
            }];
        }];
    }
    return _command;
}

@end
