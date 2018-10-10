//
//  DNBaseTabBar.m
//  163Music
//
//  Created by zjs on 2018/7/23.
//  Copyright © 2018年 zjs. All rights reserved.
//

#import "DNBaseTabBar.h"
#import "UIView+Extension.h"

@interface DNBaseTabBar ()

@property (nonatomic, strong) UIButton * plusButton;
@end

@implementation DNBaseTabBar

- (UIButton *)plusButton {
    
    if (!_plusButton) {
        
        _plusButton = [[UIButton alloc] init];
        _plusButton.backgroundColor = UIColor.orangeColor;
        [_plusButton addTarget:self action:@selector(buttonSelected:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _plusButton;
}

- (void)buttonSelected:(UIButton *)sender {
    
    if (_dnDelegate && [_dnDelegate respondsToSelector:@selector(dnPlusButtonSelected:)]) {
        
        [_dnDelegate dnPlusButtonSelected:sender];
    }
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    CGFloat W = self.dn_width;
    CGFloat H = self.dn_height;
    self.plusButton.frame  = CGRectMake(0, 0, 48, H - HOME_INDICATOR_HEIGHT);
    self.plusButton.center = CGPointMake(W * 0.5, H * 0.5);
    self.plusButton.dn_y = 0;
    
    int index = 0;
    
    CGFloat tabBar_W = W / 5;
    CGFloat tabBar_H = H - HOME_INDICATOR_HEIGHT;
    CGFloat tabBar_Y = 0;
    
    for (UIView * view in self.subviews) {
        
        if (![NSStringFromClass(view.class) isEqualToString:@"UITabBarButton"]) continue;
        CGFloat tabBar_X = index * tabBar_W;
        
        if (index >= 2) {
            
            tabBar_X += tabBar_W;
        }
        view.frame = CGRectMake(tabBar_X, tabBar_Y, tabBar_W, tabBar_H);
        index++;
    }
    [self addSubview:self.plusButton];
//    [self bringSubviewToFront:self.plusButton];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    if (self.isHidden == NO) {
        
        CGPoint newPoint = [self convertPoint:point toView:self.plusButton];
        
        if ([self.plusButton pointInside:newPoint withEvent:event]) {
            
            return self.plusButton;
        }
        else {
            return [super hitTest:point withEvent:event];
        }
    }
    else {
        
        return [super hitTest:point withEvent:event];
    }
}

@end
