//
//  DNSwitch.h
//  163Music
//
//  Created by zjs on 2018/9/29.
//  Copyright © 2018 zjs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKitDefines.h>

NS_ASSUME_NONNULL_BEGIN

@interface DNSwitch : UIControl

@property(nullable, nonatomic, strong) UIColor *onTintColor;
@property(null_resettable, nonatomic, strong) UIColor *tintColor;
@property(nullable, nonatomic, strong) UIColor *thumbTintColor;

@property(nullable, nonatomic, strong) UIImage *onImage;
@property(nullable, nonatomic, strong) UIImage *offImage;

@property(nonatomic,getter=isOn) BOOL on;

- (instancetype)initWithFrame:(CGRect)frame;      // This class enforces a size appropriate for the control, and so the frame size is ignored.
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder;

- (void)setOn:(BOOL)on animated:(BOOL)animated; // does not send action

@end

NS_ASSUME_NONNULL_END
