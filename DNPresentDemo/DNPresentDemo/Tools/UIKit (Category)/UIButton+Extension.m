//
//  UIButton+Extension.m
//  DNProject
//
//  Created by zjs on 2018/5/18.
//  Copyright © 2018年 zjs. All rights reserved.
//

#import "UIButton+Extension.h"
#import <objc/runtime.h>

//static NSString * touchKey = nil;

@implementation UIButton (Extension)

static char touchKey;


- (void)dn_setButtonConfig:(void (^)(UIButton * _Nonnull))buttonHandler {
    
    buttonHandler(self);
}

+ (UIButton *)dn_buttonWithTitle:(NSString *)title titleFont:(CGFloat)titleFont titleColor:(UIColor *)titleColor {
    
    UIButton * button = [[UIButton alloc] init];
    
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    button.titleLabel.font = AUTO_SYSTEM_FONT_SIZE(titleFont);
    
    return button;
}

// 按钮点击
- (void)dn_addActionHandler:(TouchHandler)touchHandler{
    
    objc_setAssociatedObject(self, &touchKey, touchHandler, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(touchClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)dn_addActionHandler:(TouchHandler)touchHandler forCntrolEvents:(UIControlEvents)events{
    
    objc_setAssociatedObject(self, &touchKey, touchHandler, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(touchClick:) forControlEvents:events];
}
- (void)touchClick:(id)sender{
    
    TouchHandler block = (TouchHandler)objc_getAssociatedObject(self, &touchKey);
    if (block) {
        block();
    }
}

/**
 *  @brief  使用颜色设置按钮背景
 *
 *  @param backgroundColor 背景颜色
 *  @param state           按钮状态
 */
- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state
{
    [self setBackgroundImage:[UIButton imageWithColor:backgroundColor] forState:state];
}

+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (void)dn_layoutButtonEdgeInsetStyle:(DNButtonEdgeInsetStyle)style imageTitlespace:(CGFloat)space{
    
    /**
     *  前置知识点：titleEdgeInsets是title相对于其上下左右的inset，跟tableView的contentInset是类似的，
     *  如果只有title，那它上下左右都是相对于button的，image也是一样；
     *  如果同时有image和label，那这时候image的上左下是相对于button，右边是相对于label的；title的上右下是相对于button，左边是相对于image的。
     */
    
    // 1. 得到imageView和titleLabel的宽、高
    CGFloat imageWith = self.imageView.frame.size.width;
    CGFloat imageHeight = self.imageView.frame.size.height;
    
    CGFloat labelWidth = 0.0;
    CGFloat labelHeight = 0.0;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        // 由于iOS8中titleLabel的size为0，用下面的这种设置
        labelWidth = self.titleLabel.intrinsicContentSize.width;
        labelHeight = self.titleLabel.intrinsicContentSize.height;
    } else {
        labelWidth = self.titleLabel.frame.size.width;
        labelHeight = self.titleLabel.frame.size.height;
    }
    
    // 2. 声明全局的imageEdgeInsets和labelEdgeInsets
    UIEdgeInsets imageEdgeInsets = UIEdgeInsetsZero;
    UIEdgeInsets labelEdgeInsets = UIEdgeInsetsZero;
    // 3. 根据style和space得到imageEdgeInsets和labelEdgeInsets的值
    switch (style) {
        case DNButtonEdgeInsetStyleTop:
        {
            imageEdgeInsets = UIEdgeInsetsMake(-labelHeight - space / 2.0, 0, 0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith, -imageHeight - space / 2.0, 0);
        }
            break;
        case DNButtonEdgeInsetStyleLeft:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, -space / 2.0, 0, space / 2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, space / 2.0, 0, -space / 2.0);
        }
            break;
        case DNButtonEdgeInsetStyleBottom:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, 0, -labelHeight - space / 2.0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(-imageHeight - space / 2.0, -imageWith, 0, 0);
        }
            break;
        case DNButtonEdgeInsetStyleRight:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth + space / 2.0, 0, -labelWidth - space / 2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith - space / 2.0, 0, imageWith + space / 2.0);
        }
            break;
        default:
            break;
    }
}

- (void)dn_layoutButtonEdgeInset:(DNButtonEdgeInsetStyle)style space:(CGFloat)space
{
    CGFloat imageW = self.imageView.frame.size.width;
    CGFloat imageH = self.imageView.frame.size.height;
    
    CGFloat titleW = self.titleLabel.frame.size.width;
    
    CGFloat titleIntrinsicContentSizeW = self.titleLabel.intrinsicContentSize.width;
    CGFloat titleIntrinsicContentSizeH = self.titleLabel.intrinsicContentSize.height;
    
    switch (style)
    {
        case DNButtonEdgeInsetStyleTop:
        {
            self.imageEdgeInsets = UIEdgeInsetsMake(- titleIntrinsicContentSizeH - space,
                                                    0,
                                                    0,
                                                    - titleIntrinsicContentSizeW);
            self.titleEdgeInsets = UIEdgeInsetsMake(0,
                                                    - imageW,
                                                    - imageH - space,
                                                    0);
        }
            break;
        case DNButtonEdgeInsetStyleLeft:
        {
            switch (self.contentHorizontalAlignment)
            {
                case UIControlContentHorizontalAlignmentLeft:
                {
                    self.titleEdgeInsets = UIEdgeInsetsMake(0, space, 0, 0);
                }
                    break;
                case UIControlContentHorizontalAlignmentRight:
                {
                    self.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, space);
                }
                    break;
                    
                default:
                {
                    self.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0.5 * space);
                    self.titleEdgeInsets = UIEdgeInsetsMake(0, 0.5 * space, 0, 0);
                }
                    break;
            }
        }
            break;
            
        case DNButtonEdgeInsetStyleBottom:
        {
            self.imageEdgeInsets = UIEdgeInsetsMake(titleIntrinsicContentSizeH + space,
                                                    0,
                                                    0,
                                                    - titleIntrinsicContentSizeW);
            self.titleEdgeInsets = UIEdgeInsetsMake(0,
                                                    - imageW,
                                                    imageH + space,
                                                    0);
        }
            break;
        case DNButtonEdgeInsetStyleRight:
        {
            switch (self.contentHorizontalAlignment)
            {
                case UIControlContentHorizontalAlignmentLeft:
                {
                    self.imageEdgeInsets = UIEdgeInsetsMake(0, titleW + space, 0, 0);
                    self.titleEdgeInsets = UIEdgeInsetsMake(0, - imageW, 0, 0);
                }
                    break;
                case UIControlContentHorizontalAlignmentRight:
                {
                    self.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, - titleW);
                    self.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, imageW + space);
                }
                    break;
                    
                default:
                {
                    CGFloat imageOffset = titleW + 0.5 * space;
                    CGFloat titleOffset = imageW + 0.5 * space;

                    self.imageEdgeInsets = UIEdgeInsetsMake(0,
                                                            imageOffset,
                                                            0,
                                                            - imageOffset);
                    self.titleEdgeInsets = UIEdgeInsetsMake(0,
                                                            - titleOffset,
                                                            0,
                                                            titleOffset);
                }
                    break;
            }
        }
            break;
        default:
            break;
    }
}

- (void)dn_startWithTime:(NSInteger)time startBlock:(void(^)(void))startBlock finishBlock:(void(^)(void))finishBlock{
    
    // 倒计时时间
    __block NSInteger timeOut = time;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _time = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    // 每秒执行一次
    dispatch_source_set_timer(_time, dispatch_walltime(NULL, 0), 1.0*NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_time, ^{
        // 倒计时结束  关闭
        if (timeOut <= 0)
        {
            dispatch_source_cancel(_time);
            dispatch_async(dispatch_get_main_queue(), ^{
                if (finishBlock) {
                    finishBlock();
                }
                self.userInteractionEnabled = YES;
            });
        }
        else {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (startBlock) {
                    startBlock();
                }
                self.userInteractionEnabled = NO;
            });
            timeOut--;
        }
    });
    dispatch_resume(_time);
}


- (void)dn_startWithTime:(NSInteger)time title:(NSString *)title downTitle:(NSString *)downTitle{
    // 倒计时时间
    __block NSInteger timeOut = time;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _time = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    // 每秒执行一次
    dispatch_source_set_timer(_time, dispatch_walltime(NULL, 0), 1.0*NSEC_PER_SEC, 0);
    
    dispatch_source_set_event_handler(_time, ^{
        // 倒计时结束  关闭
        if (timeOut <= 0) {
            
            dispatch_source_cancel(_time);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                // 倒计时开始时按钮的标题
                [self setTitle:title forState:UIControlStateNormal];
                // 倒计时结束，按钮可交互
                self.userInteractionEnabled = YES;
            });
        }else{
            
            int seconds = timeOut % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                // 倒计时开始时按钮的标题
                [self setTitle: [NSString stringWithFormat:@"%@%@",strTime,downTitle] forState:UIControlStateNormal];
                // 倒计时开始，按钮不可交互
                self.userInteractionEnabled = NO;
            });
            timeOut--;
        }
    });
    dispatch_resume(_time);
}

@end
