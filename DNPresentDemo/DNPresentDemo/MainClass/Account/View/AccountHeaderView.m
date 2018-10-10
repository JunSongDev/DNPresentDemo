//
//  AccountHeaderView.m
//  163Music
//
//  Created by zjs on 2018/5/22.
//  Copyright © 2018年 zjs. All rights reserved.
//

#import "AccountHeaderView.h"
#import "PersonalController.h"
#import "TrendController.h"
#import "NoticeController.h"
#import "FanceController.h"
#import "EditorInfoController.h"
#import "SigninController.h"

@implementation AccountHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        
        [self setControlForSuper];
        [self addConstraintsForSuper];
        [self addTarget];
        // 设置为可交互
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                              action:@selector(tapClick:)];
        // 添加手势
        [self addGestureRecognizer:tap];
    }
    return self;
}
// 手势响应事件
- (void)tapClick:(id)sender
{
    PersonalController * vc = [[PersonalController alloc]init];
    [[self viewForSuperBaseView].navigationController pushViewController:vc
                                                                animated:YES];;
}
// 添加控件
- (void)setControlForSuper
{
    [self addSubview:self.userImage];
    [self addSubview:self.nickName];
    [self addSubview:self.VIP];
    [self addSubview:self.signBtn];
    [self addSubview:self.trend];
    [self addSubview:self.notice];
    [self addSubview:self.fance];
    [self addSubview:self.myInfo];
    [self addSubview:self.line1];
    [self addSubview:self.line2];
    [self addSubview:self.line3];
    [self addSubview:self.line4];
}
// 添加约束
- (void)addConstraintsForSuper
{
    [self.trend mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.bottom.mas_equalTo(self).inset(0);
        make.width.mas_offset(SCREEN_W*0.25);
        make.height.mas_offset(SCREEN_W*0.15);
    }];
    
    [self.notice mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.mas_equalTo(self.trend.mas_right).mas_offset(0);
        make.bottom.mas_equalTo(self).inset(0);
        make.width.mas_offset(SCREEN_W*0.25);
        make.height.mas_offset(SCREEN_W*0.15);
    }];
    
    [self.fance mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.mas_equalTo(self.notice.mas_right).mas_offset(0);
        make.bottom.mas_equalTo(self).inset(0);
        make.width.mas_offset(SCREEN_W*0.25);
        make.height.mas_offset(SCREEN_W*0.15);
    }];

    [self.myInfo mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.mas_equalTo(self.fance.mas_right).mas_offset(0);
        make.bottom.mas_equalTo(self).inset(0);
        make.width.mas_offset(SCREEN_W*0.25);
        make.height.mas_offset(SCREEN_W*0.15);
    }];
    
    [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.mas_equalTo(self).inset(0);
        make.bottom.mas_equalTo(self.myInfo.mas_top).mas_offset(0);
        make.height.mas_offset(0.8);
    }];
    
    [self.line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.trend.mas_right).mas_offset(0);
        make.top.mas_equalTo(self.line1.mas_bottom).mas_offset(SCREEN_W*0.04);
        make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-SCREEN_W*0.04);
        make.width.mas_offset(0.8);
    }];
    
    [self.line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.notice.mas_right).mas_offset(0);
        make.top.mas_equalTo(self.line1.mas_bottom).mas_offset(SCREEN_W*0.04);
        make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-SCREEN_W*0.04);
        make.width.mas_offset(0.8);
    }];
    
    [self.line4 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.fance.mas_right).mas_offset(0);
        make.top.mas_equalTo(self.line1.mas_bottom).mas_offset(SCREEN_W*0.04);
        make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-SCREEN_W*0.04);
        make.width.mas_offset(0.8);
    }];
    
    DNWeak(self)
    [self.userImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.mas_top).inset(SCREEN_W*0.06);
        make.left.mas_equalTo(self.mas_left).inset(SCREEN_W*0.03);
        make.bottom.mas_equalTo(self.line1.mas_top).mas_offset(-SCREEN_W*0.06);
        make.width.mas_equalTo(weakself.userImage.mas_height);
    }];
    
    [self.signBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(self.mas_top).inset(SCREEN_W*0.125);
        make.right.mas_equalTo(self.mas_right).inset(SCREEN_W*0.02);
        make.bottom.mas_equalTo(self.line1.mas_top).mas_offset(-SCREEN_W*0.125);
        make.width.mas_offset(SCREEN_W*0.2);
    }];
    
    [self.nickName mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(self.mas_top).inset(SCREEN_W*0.1);
        make.left.mas_equalTo(self.userImage.mas_right).mas_offset(8);
        make.width.mas_offset(SCREEN_W*0.5);
        make.height.mas_offset(SCREEN_W*0.08);
    }];
    
    [self.VIP mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.nickName.mas_bottom).mas_offset(0);
        make.left.mas_equalTo(self.userImage.mas_right).mas_offset(8);
        make.width.mas_offset(SCREEN_W*0.15);
        make.height.mas_offset(SCREEN_W*0.07);
    }];
}
// 添加按钮响应事件
- (void)addTarget
{
    DNWeak(self)
    // 动态
    [self.trend dn_addActionHandler:^{
        
        TrendController * vc = [[TrendController alloc]init];
        [[weakself viewForSuperBaseView].navigationController pushViewController:vc
                                                                        animated:YES];
    }];
    // 关注
    [self.notice dn_addActionHandler:^{
       
        NoticeController * vc = [[NoticeController alloc]init];
        [[weakself viewForSuperBaseView].navigationController pushViewController:vc
                                                                        animated:YES];
    }];
    // 粉丝
    [self.fance dn_addActionHandler:^{
        
        FanceController * vc = [[FanceController alloc]init];
        [[weakself viewForSuperBaseView].navigationController pushViewController:vc
                                                                        animated:YES];
    }];
    // 编辑资料
    [self.myInfo dn_addActionHandler:^{
        
        EditorInfoController * vc = [[EditorInfoController alloc]init];
        [[weakself viewForSuperBaseView].navigationController pushViewController:vc
                                                                        animated:YES];
    }];
    // 签到
    [self.signBtn dn_addActionHandler:^{
        
        SigninController * vc = [[SigninController alloc]init];
        [[weakself viewForSuperBaseView].navigationController pushViewController:vc
                                                                        animated:YES];
    }];
}
#pragma mark -- Setter && Getter
- (UIImageView *)userImage{
    
    if (!_userImage) {
        
        _userImage = [[UIImageView alloc]init];
        _userImage.image = IMAGE(@"头像");
    }
    return _userImage;
}

- (UILabel *)nickName{
    
    if (!_nickName) {
        
        _nickName = [[UILabel alloc]init];
        _nickName.text = @"戴假发圣诞节开发";
    }
    return _nickName;
}

- (UILabel *)VIP{
    
    if (!_VIP) {
        
        _VIP = [[UILabel alloc]init];
        _VIP.text = @"VIP 6";
        _VIP.backgroundColor = UIColor.orangeColor;
        _VIP.layer.cornerRadius = SCREEN_W*0.035;
        _VIP.clipsToBounds = YES;
        _VIP.textAlignment = NSTextAlignmentCenter;
    }
    return _VIP;
}

- (UIButton *)signBtn{
    
    if (!_signBtn) {
        
        _signBtn = [[UIButton alloc]init];
        [_signBtn setTitle:@"签到" forState:UIControlStateNormal];
        [_signBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        
        _signBtn.layer.borderWidth = 1.0;
        _signBtn.layer.borderColor = [UIColor redColor].CGColor;
        
        _signBtn.layer.cornerRadius = 15;
        _signBtn.layer.masksToBounds = YES;
    }
    return _signBtn;
}

- (UIButton *)trend{
    
    if (!_trend) {
        
        _trend = [[UIButton alloc]init];
        [_trend setTitle:@"动态" forState:UIControlStateNormal];
        [_trend setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_trend.titleLabel setFont:AUTO_SYSTEM_FONT_SIZE(14)];
    }
    return _trend;
}

- (UIButton *)notice{
    
    if (!_notice) {
        
        _notice = [[UIButton alloc]init];
        [_notice setTitle:@"关注" forState:UIControlStateNormal];
        [_notice setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_notice.titleLabel setFont:AUTO_SYSTEM_FONT_SIZE(14)];
    }
    return _notice;
}

- (UIButton *)fance{
    
    if (!_fance) {
        
        _fance = [[UIButton alloc]init];
        [_fance setTitle:@"粉丝" forState:UIControlStateNormal];
        [_fance setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_fance.titleLabel setFont:AUTO_SYSTEM_FONT_SIZE(14)];
    }
    return _fance;
}

- (UIButton *)myInfo{
    
    if (!_myInfo) {
        
        _myInfo = [[UIButton alloc]init];
        [_myInfo setTitle:@"编辑资料" forState:UIControlStateNormal];
        [_myInfo setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        //[_myInfo setImage:IMAGE(@"mt_editorweb") forState:UIControlStateNormal];
        [_myInfo.titleLabel setFont:AUTO_SYSTEM_FONT_SIZE(14)];
        //[_myInfo dn_layoutButtonEdgeInset:DNButtonEdgeInsetStyleRight space:8];
    }
    return _myInfo;
}

- (UIView *)line1{
    
    if (!_line1) {
        _line1 = [[UIView alloc]init];
        _line1.backgroundColor = [UIColor lightGrayColor];
    }
    return _line1;
}

- (UIView *)line2{
    
    if (!_line2) {
        _line2 = [[UIView alloc]init];
        _line2.backgroundColor = [UIColor lightGrayColor];
    }
    return _line2;
}

- (UIView *)line3{
    
    if (!_line3) {
        _line3 = [[UIView alloc]init];
        _line3.backgroundColor = [UIColor lightGrayColor];
    }
    return _line3;
}

- (UIView *)line4{
    
    if (!_line4) {
        _line4 = [[UIView alloc]init];
        _line4.backgroundColor = [UIColor lightGrayColor];
    }
    return _line4;
}
@end
