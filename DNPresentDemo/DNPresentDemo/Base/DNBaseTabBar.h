//
//  DNBaseTabBar.h
//  163Music
//
//  Created by zjs on 2018/7/23.
//  Copyright © 2018年 zjs. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DNPlusButtonDelegate <NSObject>

@required;
- (void)dnPlusButtonSelected:(UIButton *)sender;
@end

@interface DNBaseTabBar : UITabBar

@property (nonatomic, weak) id<DNPlusButtonDelegate> dnDelegate;
@end
