//
//  AccountHeaderView.h
//  163Music
//
//  Created by zjs on 2018/5/22.
//  Copyright © 2018年 zjs. All rights reserved.
//

#import "BaseView.h"

@interface AccountHeaderView : BaseView

/** 头像 */
@property (nonatomic, strong) UIImageView * userImage;

/** 昵称 */
@property (nonatomic, strong) UILabel     * nickName;

/** VIP */
@property (nonatomic, strong) UILabel     * VIP;

/** 签到 */
@property (nonatomic, strong) UIButton    * signBtn;

/** 动态 */
@property (nonatomic, strong) UIButton * trend;

/** 关注 */
@property (nonatomic, strong) UIButton * notice;

/** 粉丝 */
@property (nonatomic, strong) UIButton * fance;

/** 编辑资料 */
@property (nonatomic, strong) UIButton * myInfo;
// 分割线
@property (nonatomic, strong) UIView * line1;
@property (nonatomic, strong) UIView * line2;
@property (nonatomic, strong) UIView * line3;
@property (nonatomic, strong) UIView * line4;
@end
