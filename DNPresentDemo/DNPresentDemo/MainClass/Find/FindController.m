//
//  FindController.m
//  163Music
//
//  Created by zjs on 2018/5/22.
//  Copyright © 2018年 zjs. All rights reserved.
//

#import "FindController.h"
#import "DNWebViewController.h"
#import "DNSheetAlert.h"
#import "UIImage+Extension.h"
#import "LMJScrollTextView.h"
#import "DNTextFieild.h"
#import "DNAutoHeightTextView.h"
#import "SelwynExpandableTextView.h"
#import "DNTextScrollView.h"
#import "DNSwitch.h"
#import "TestModel.h"


@interface FindController ()<DNSheetAlertDelegate, SDCycleScrollViewDelegate, DNTextScrollViewDelegate>

@end

@implementation FindController

#pragma mark -- lifeCycle
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setControlForSuper];
    [self setAdvertiseScrollView];
    NSArray * array = [NSArray dn_getPropertiesForModel:[TestModel class]];
    NSLog(@"%@",array);
    
    //DNLog(@"%@",NSStringFromClass([[UIApplication sharedApplication].keyWindow class]));
}

#pragma mark -- didReceiveMemoryWarning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)setAdvertiseScrollView {
    
    LMJScrollTextView * scrollTextView = [[LMJScrollTextView alloc] initWithFrame:CGRectMake(0,
                                                                                             0,
                                                                                             SCREEN_W,
                                                                                             30)
                                                                  textScrollModel:LMJTextScrollContinuous
                                                                        direction:LMJTextScrollMoveLeft];
    [scrollTextView startScrollWithText:@"那就按空间开发空间圣诞节疯狂哈师大金风科技爱神的箭开发商坚实的扣积分卡收到货房间卡的说法" textColor:UIColor.redColor font:[UIFont systemFontOfSize:16]];
    [self.view addSubview:scrollTextView];
}

#pragma mark -- setControlForSuper
- (void)setControlForSuper {
    
    DNTextFieild * textFieild = [[DNTextFieild alloc] init];
    textFieild.placeholder = @"HHH";
    textFieild.textAlignment = NSTextAlignmentCenter;
    textFieild.layer.borderWidth = .8;
    textFieild.layer.borderColor = UIColor.redColor.CGColor;
    [self.view addSubview:textFieild];
    
    [textFieild mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(self.view.mas_top).inset(SCREEN_W*0.12);
        make.centerX.mas_equalTo(self.view);
        make.width.mas_offset(SCREEN_W*0.5);
        make.height.mas_offset(50);
    }];
    
    DNWeak(self)
    UIButton * button = [[UIButton alloc] init];
    [button setTitle:@"WebView" forState:UIControlStateNormal];
    button.backgroundColor = UIColor.orangeColor;
    [self.view addSubview:button];
    [button dn_addActionHandler:^{
        
        [weakself buttonClick];
    }];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(self.view.mas_top).inset(SCREEN_W);
        make.centerX.mas_equalTo(self.view);
        make.width.mas_offset(SCREEN_W*0.5);
        make.height.mas_offset(50);
    }];
    SelwynExpandableTextView * textView = [[SelwynExpandableTextView alloc] init];
    textView.showLength = YES;
    textView.maxLength = 20;
    textView.currentLength = textView.text.length;
    textView.placeholder   = @"哈哈啊哈";
    textView.placeholderTextColor = UIColor.whiteColor;
    textView.backgroundColor = UIColor.lightGrayColor;
    [self.view addSubview:textView];
    
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(textFieild.mas_bottom).mas_offset(SCREEN_W*0.05);
        make.centerX.mas_equalTo(self.view);
        make.width.mas_offset(SCREEN_W*0.5);
        make.height.mas_offset(50);
    }];
    
    DNTextScrollView * scrolltext = [[DNTextScrollView alloc] init];
    scrolltext.dataArray = @[@"who are you",@"how are you????",@"$%^$^*&**&*("];
    [self.view addSubview:scrolltext];
    scrolltext.delegate = self;
    [scrolltext mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(textView.mas_bottom).mas_offset(SCREEN_W*0.05);
        make.centerX.mas_equalTo(self.view);
        make.width.mas_offset(SCREEN_W);
        make.height.mas_offset(50);
    }];
}

#pragma mark -- addConstrainsForSuper
- (void)addConstrainsForSuper{
    
}

#pragma mark -- target Methods

- (void)buttonClick {
    
    DNWebViewController * webController = [[DNWebViewController alloc] init];
    webController.urlString = @"http://www.baidu.com";
    [self.navigationController pushViewController:webController animated:YES];
    
//    [[DNSheetAlert shareInstance] alertWithData:@[@[@"相册",@"相机"],@[@"取消"]]
//                                       Delegate:self];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
}

#pragma mark -- UITableView Delegate && DataSource

#pragma mark -- other Deleget

- (void)dnSheetAlertSelectedIdentifier:(NSString *)identifier selectIndex:(NSIndexPath *)selectIndex {
    
    NSLog(@"%@--%ld--%ld",identifier, (long)selectIndex.section, (long)selectIndex.row);
}

- (void)dn_textScrollViewSelectedAtIndex:(NSInteger)index text:(NSString *)text {
    
    NSLog(@"%ld===%@",index,text);
}

#pragma mark -- NetWork Methods

#pragma mark -- Setter && Getter

@end
