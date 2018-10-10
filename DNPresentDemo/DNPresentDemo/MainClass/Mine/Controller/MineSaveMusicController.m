//
//  MineSaveMusicController.m
//  163Music
//
//  Created by zjs on 2018/5/22.
//  Copyright © 2018年 zjs. All rights reserved.
//

#import "MineSaveMusicController.h"
#import "NSString+Extension.h"
#import "UIView+Extension.h"

@interface MineSaveMusicController ()

@end

@implementation MineSaveMusicController

#pragma mark -- lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self initNavigateTitle];
}

#pragma mark -- didReceiveMemoryWarning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark -- setControlForSuper
- (void)setControlForSuper{
    
}

#pragma mark -- addConstrainsForSuper
- (void)addConstrainsForSuper{
    
    
}

#pragma mark -- target Methods

- (void)initNavigateTitle
{
    NSString * str = @"我的音乐云盘总容量（16G）";
    
    
    UILabel * titleLabel = [[UILabel alloc]init];
    titleLabel.dn_size = CGSizeMake(SCREEN_W*0.4, 44);
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    titleLabel.attributedText = [str dn_changeFont:AUTO_SYSTEM_FONT_SIZE(12)
                                          andRange:NSMakeRange(6, str.length-6)];;
    
    self.navigationItem.titleView = titleLabel;
}

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
