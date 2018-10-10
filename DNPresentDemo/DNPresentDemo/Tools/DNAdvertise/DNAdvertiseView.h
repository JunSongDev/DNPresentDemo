//
//  DNAdvertiseView.h
//  163Music
//
//  Created by zjs on 2018/7/24.
//  Copyright © 2018年 zjs. All rights reserved.
//

#import <UIKit/UIKit.h>

UIKIT_EXTERN NSString *const NotificationContants_Advertise_Key;

@interface DNAdvertiseView : UIView
// 图片路径
@property (nonatomic, copy) NSString *filePath;
/** 广告页面显示*/
- (void)advertiseViewShow;
@end
