//
//  DNPageView.h
//  163Music
//
//  Created by zjs on 2018/8/20.
//  Copyright © 2018年 zjs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DNPageView : UIView


@property (nonatomic, assign) CGFloat topTapHeight;

- (instancetype)initWithTitle:(NSArray *)title controller:(NSArray *)object;

@end
