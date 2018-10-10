//
//  AccountController.m
//  163Music
//
//  Created by zjs on 2018/5/22.
//  Copyright © 2018年 zjs. All rights reserved.
//

#import "AccountController.h"
#import "AccountHeaderView.h"

@interface AccountController ()

@property (nonatomic, strong) NSArray * titleArray;
@property (nonatomic, strong) AccountHeaderView * tableHeader;
@end

@implementation AccountController

- (AccountHeaderView *)tableHeader{
    
    if (!_tableHeader) {
        
        _tableHeader = [[AccountHeaderView alloc]initWithFrame:CGRectMake(0,
                                                                          0,
                                                                          SCREEN_W,
                                                                          SCREEN_W*0.5)];
    }
    return _tableHeader;
}

#pragma mark -- lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"账号";
    
    self.titleArray = @[@[@"我的消息"],
                        @[@"VIP会员",@"商城",@"游戏推荐Beta",@"在线听歌免流量"],
                        @[@"设置",@"扫一扫",@"个性换肤",@"夜间模式",@"定时关闭",@"音乐闹钟",@"驾驶模式",@"优惠券"],
                        @[@"分享网易云音乐",@"关于"],
                        @[@"退出登录"]];
    
    [self setControlForSuper];
    [self addConstrainsForSuper];
}
#pragma mark -- didReceiveMemoryWarning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark -- setControlForSuper
- (void)setControlForSuper{
    
    self.tableView.tableHeaderView = self.tableHeader;
    [self.view addSubview:self.tableView];
}

#pragma mark -- addConstrainsForSuper
- (void)addConstrainsForSuper{
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view.mas_bottom).inset(TAB_BAR_HEIGHT);
    }];
}

#pragma mark -- target Methods

#pragma mark -- UITableView Delegate && DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.titleArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.titleArray[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 防重用
    NSString * identifier = [NSString stringWithFormat:@"%ld%ld",(long)indexPath.section,(long)indexPath.row];
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault
                                     reuseIdentifier:identifier];
    }
    cell.textLabel.text = self.titleArray[indexPath.section][indexPath.row];
    
    if (indexPath.section == self.titleArray.count - 1) {
        // 最后一个分组 居中显示 、红色
        cell.textLabel.textColor = [UIColor redColor];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    } else {
        // cell 右侧箭头
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 点击弹起
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//============  footer
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[UIView alloc]init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

/*
 - (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
 return <#CGFloat#>;
 }
 **/

#pragma mark -- other Deleget

#pragma mark -- NetWork Methods

#pragma mark -- Setter && Getter

@end
