//
//  MineHeaderView.m
//  163Music
//
//  Created by zjs on 2018/5/22.
//  Copyright © 2018年 zjs. All rights reserved.
//

#import "MineHeaderView.h"

@implementation MineHeaderView

- (void)setControlForSuper{
    
    [self addSubview:self.extensionBtn];
    [self addSubview:self.editorButton];
    
    self.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
}

- (void)addConstraintsForSuper{
    
    [self.editorButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.right.bottom.mas_equalTo(self).inset(10);
        make.width.mas_offset(SCREEN_W*0.25);
    }];
    
    [self.extensionBtn mas_makeConstraints:^(MASConstraintMaker *make) {

        make.top.left.bottom.mas_equalTo(self).inset(10);
        make.right.mas_equalTo(self.editorButton.mas_left).mas_offset(0);
    }];
}

- (UIButton *)extensionBtn{
    
    if (!_extensionBtn) {
        
        _extensionBtn = [[UIButton alloc]init];
        _extensionBtn.titleLabel.textColor = [UIColor grayColor];
        // 按钮文字左对齐
        [_extensionBtn.titleLabel setFont:[UIFont systemFontOfSize:AUTO_FONT_SIZE(15)]];
        [_extensionBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_extensionBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    }
    return _extensionBtn;
}

- (UIButton *)editorButton{
    
    if (!_editorButton) {
        
        _editorButton = [[UIButton alloc]init];
        [_editorButton setTitle:@"编辑" forState:UIControlStateNormal];
        [_editorButton.titleLabel setFont:[UIFont systemFontOfSize:AUTO_FONT_SIZE(15)]];
        [_editorButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    }
    return _editorButton;
}

- (void)drawRect:(CGRect)rect {
    
    CGFloat W = rect.size.width;
    CGFloat H = rect.size.height;
    
    UIBezierPath * path = [UIBezierPath bezierPath];
    // 线条的基本设置
    [[UIColor grayColor] set];
    path.lineWidth     = 1.0;
    path.lineCapStyle  = kCGLineCapRound;
    path.lineJoinStyle = kCGLineJoinRound;
    // 画线
    [path moveToPoint:CGPointMake(0, H)];
    [path addLineToPoint:CGPointMake(W, H)];
    // 填充
    [path stroke];
}
@end
