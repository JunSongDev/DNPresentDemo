//
//  FriendController.m
//  163Music
//
//  Created by zjs on 2018/5/22.
//  Copyright © 2018年 zjs. All rights reserved.
//

#import "FriendController.h"
#import "FriendViewModel.h"
#import "FriendPageViewModel.h"
#import "DNPageController.h"
#import "DNPageView.h"

@interface FriendController ()

@property (nonatomic, strong) UILabel  * title_label;
@property (nonatomic, strong) UIButton * changeValue;
@property (nonatomic, strong) FriendViewModel * viewModel;
@property (nonatomic, strong) FriendPageViewModel * pageViewModel;
@property (nonatomic, strong) NinaPagerView * pageView;
@end

@implementation FriendController

#pragma mark -- lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[self netWork];
    
    [self setViewModelConfig];
}
#pragma mark -- didReceiveMemoryWarning

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}

- (void)netWork {
    
    [self.view addSubview:self.pageView];
    [self.pageView mas_makeConstraints:^(MASConstraintMaker *make) {

        make.edges.mas_equalTo(self.view);
    }];
    self.pageViewModel = [[FriendPageViewModel alloc] init];
    
}


- (void)setFilter {
    // 获取滤镜
    NSArray * filterArray = [CIFilter filterNamesInCategory:kCICategoryBuiltIn];
    // 输出所有的滤镜
    NSLog(@"%@",filterArray);
    // 获取滤镜可修改的属性
    NSLog(@"%@", [[CIFilter filterWithName:@"CIColorControls"] attributes]);
}

- (void)setViewModelConfig {
    
    [self setControlForSuper];
    [self addConstrainsForSuper];
    [self addViewModelSignal];
}

- (void)addViewModelSignal {
    
    self.viewModel = [[FriendViewModel alloc] init];
    [self.viewModel bindViewToViewModel:self.title_label];
    // 设置当前按钮的标记信号为 viewModel 中的信号
    self.changeValue.rac_command = self.viewModel.command;
    // 接收从 viewModel 传过来的信号 （将要操作的值）
//    @weakify(self);
//    [self.viewModel.command.executionSignals subscribeNext:^(RACSignal * _Nullable signal) {
//        @strongify(self);
//        [signal subscribeNext:^(UILabel * _Nullable label) {
//            //self.title_label.text = label.text;
//            //self.title_label = label;
//        }];
//    }];
    /**
     *  加__kindof修饰后，该方法的返回值原本是UIControl，
     *  但是方法里边却返回了一个UIControl的子类 UIButton，
     *  也就是说，加__kindof修饰后，本类及其子类都是返回，
     *  调用使用时也可以使用本类或者本类的子类去接收方法的返回值
     */
    [[self.changeValue rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable changeButton) {

        [changeButton setTitle:@"点击了" forState:UIControlStateNormal];
        UIColor * color = [UIColor colorWithRed:arc4random_uniform(255)/255.0
                                          green:arc4random_uniform(255)/255.0
                                           blue:arc4random_uniform(255)/255.0
                                          alpha:1.0];
        changeButton.backgroundColor = color;
    }];
}

#pragma mark -- setControlForSuper
- (void)setControlForSuper{
    
    self.title_label = [UILabel dn_labelWithText:@"我姓张"
                                        textFont:15
                                       textColor:UIColor.orangeColor
                                    textAligment:NSTextAlignmentCenter];
    
    self.changeValue = [UIButton dn_buttonWithTitle:@"变变变"
                                          titleFont:17
                                         titleColor:UIColor.whiteColor];
    self.changeValue.backgroundColor = UIColor.orangeColor;
    
    [self.view addSubview:self.title_label];
    [self.view addSubview:self.changeValue];
}

#pragma mark -- addConstrainsForSuper
- (void)addConstrainsForSuper {
    
//    self.title_label.translatesAutoresizingMaskIntoConstraints = NO;
//    [self.title_label.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:SCREEN_W*0.5].active = YES;
//    [self.title_label.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
//    [self.title_label.widthAnchor constraintEqualToConstant:SCREEN_W*0.5].active = YES;
//
//    self.changeValue.translatesAutoresizingMaskIntoConstraints = NO;
//    [self.changeValue.topAnchor constraintEqualToAnchor:self.title_label.bottomAnchor constant:SCREEN_W*0.1].active = YES;
//    [self.changeValue.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
//    [self.changeValue.widthAnchor constraintEqualToConstant:SCREEN_W*0.5].active = YES;
//    [self.changeValue.heightAnchor constraintEqualToConstant:SCREEN_W*0.12].active = YES;
    
    [self.title_label mas_makeConstraints:^(MASConstraintMaker *make) {

        make.top.mas_equalTo(self.view.mas_top).inset(SCREEN_W*0.5);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(@(SCREEN_W*0.5));
    }];

    [self.changeValue mas_makeConstraints:^(MASConstraintMaker *make) {

        make.top.mas_equalTo(self.title_label.mas_bottom).mas_offset(SCREEN_W*0.1);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(@(SCREEN_W*0.5));
        make.height.mas_equalTo(@(SCREEN_W*0.12));
    }];
}

#pragma mark -- target Methods

#pragma mark -- UITableView Delegate && DataSource

/*
 - (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
 return <#NSInteger#>;
 }
 
 - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
 return <#NSInteger#>;
 }
 
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 return <#UITableViewCell#>;
 }
 
 - (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
 return <#CGFloat#>;
 }
 **/

#pragma mark -- other Deleget

#pragma mark -- NetWork Methods

#pragma mark -- Setter && Getter

@end
