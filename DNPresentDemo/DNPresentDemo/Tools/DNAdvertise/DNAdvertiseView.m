//
//  DNAdvertiseView.m
//  163Music
//
//  Created by zjs on 2018/7/24.
//  Copyright © 2018年 zjs. All rights reserved.
//

#import "DNAdvertiseView.h"

NSString *const NotificationContants_Advertise_Key = @"NotificationContants_Advertise_Key";

@interface DNAdvertiseView ()

@property (nonatomic, assign) NSUInteger  count;
@property (nonatomic, strong) UIButton    *timeButton;
@property (nonatomic, strong) UIImageView *advertise;
@property (nonatomic, strong) dispatch_source_t GCDTimer;
@end


static const NSUInteger showtime = 4;

@implementation DNAdvertiseView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setAdvertiseUIWithFrame:frame];
        
        UITapGestureRecognizer * gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushToAdvertise)];
        [self.advertise addGestureRecognizer:gesture];
    }
    return self;
}

- (void)setAdvertiseUIWithFrame:(CGRect)frame {
    
    self.advertise = [[UIImageView alloc] initWithFrame:frame];
    self.advertise.clipsToBounds = YES;
    self.advertise.userInteractionEnabled = YES;
    self.advertise.contentMode = UIViewContentModeScaleAspectFill;
    
    CGFloat timeButton_W = SCREEN_W*0.12;
    CGFloat timeButton_H = SCREEN_W*0.08;
    CGFloat timeButton_Y = [UIApplication sharedApplication].statusBarFrame.size.height + timeButton_H;
    self.timeButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_W - 2*timeButton_W,
                                                                 timeButton_Y,
                                                                 timeButton_W,
                                                                 timeButton_H)];
    self.timeButton.titleLabel.font = AUTO_SYSTEM_FONT_SIZE(15);
    [self.timeButton setTitle:[NSString stringWithFormat:@"跳过%lu",(unsigned long)showtime] forState:UIControlStateNormal];
    [self.timeButton setTitleColor:UIColor.orangeColor forState:UIControlStateNormal];
    [self.timeButton setBackgroundColor:UIColor.whiteColor forState:UIControlStateNormal];
    self.timeButton.layer.cornerRadius = 5.f;
    [self.timeButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:self.advertise];
    [self addSubview:self.timeButton];
}
// 开启倒计时
- (void)advertiseStartTimeDown {
    
    __block int timeout = showtime + 1;
    DNWeak(self)
    self.GCDTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    // 每秒执行一次
    dispatch_source_set_timer(self.GCDTimer, dispatch_time(DISPATCH_TIME_NOW, 0), 1 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(self.GCDTimer, ^{
       
        if (timeout <= 0) {
            
            [weakself dismiss];
        }
        else {
            dispatch_async(dispatch_get_main_queue(), ^{
               
                [self.timeButton setTitle:[NSString stringWithFormat:@"跳过%d",timeout] forState:UIControlStateNormal];
            });
            timeout--;
        }
    });
    dispatch_resume(self.GCDTimer);
}

- (void)drawRect:(CGRect)rect {
    
    
}

- (void)pushToAdvertise {
    
    [self dismiss];
    DNLog(@"HHHHH");
}
// 广告页显示
- (void)advertiseViewShow {
    // 开启倒计时
    [self advertiseStartTimeDown];
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

- (void)dismissAnimation {
        
    [UIView animateWithDuration:0.6 animations:^{

        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft
                               forView:self
                                 cache:YES];
    } completion:^(BOOL finished) {


    }];
}

// 消失
- (void)dismiss {
    
    [self dismissAnimation];
    if (_GCDTimer) {
        dispatch_cancel(_GCDTimer);
    }
    _GCDTimer = nil;
    dispatch_async(dispatch_get_main_queue(), ^{
       
        [UIView animateWithDuration:0.5f animations:^{
            self.alpha = 0.f;
        } completion:^(BOOL finished) {
            
            [self removeFromSuperview];
        }];
    });
}
// 界面销毁时 self.GCDTimer 置空
- (void)dealloc {
    _GCDTimer = nil;
}

- (void)setFilePath:(NSString *)filePath {
    
    _filePath = filePath;
    NSData * data = [NSData dataWithContentsOfFile:filePath];
    self.advertise.image = [UIImage sd_animatedGIFWithData:data];
//    self.advertise.image = [UIImage imageWithContentsOfFile:filePath];
}

@end
