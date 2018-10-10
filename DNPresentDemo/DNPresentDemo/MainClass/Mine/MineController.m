//
//  MineController.m
//  163Music
//
//  Created by zjs on 2018/5/22.
//  Copyright © 2018年 zjs. All rights reserved.
//

#import "MineController.h"
#import "MineHeaderView.h"
#import "MineSaveMusicController.h"

@interface MineController ()

@property (nonatomic, strong) NSMutableArray * openArray;
@end

@implementation MineController

#pragma mark -- lifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的音乐";
    
    [self leftNavigateItem];
    [self setControlForSuper];
    [self addConstrainsForSuper];
}

#pragma mark -- didReceiveMemoryWarning

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark -- setControlForSuper

- (void)setControlForSuper{
 
    [self.view addSubview:self.tableView];
}

#pragma mark -- addConstrainsForSuper

- (void)addConstrainsForSuper {
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.mas_equalTo(self.view);
    }];
}

#pragma mark -- target Methods
- (void)leftNavigateItem
{
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithImage:[IMAGE(@"云") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                                 style:UIBarButtonItemStylePlain
                                                                target:self
                                                                action:@selector(leftClick:)];
    
    self.navigationItem.leftBarButtonItem = leftItem;
}

- (void)leftClick:(id)sender {
    
    MineSaveMusicController * vc = [[MineSaveMusicController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -- UITableView Delegate && DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 1;
    }
    else {
        NSString * sectionStr = [NSString stringWithFormat:@"%ld",(long)section];
        return [self.openArray containsObject:sectionStr] ? 4:0;
    }
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
    cell.textLabel.text = @"HHHHHHHH";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 点击弹起
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

/*================*/
//  header
/*================*/
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return [[UIView alloc]init];
    }
    else {
        MineHeaderView * mineHeader = [[MineHeaderView alloc] init];
        NSString * str = section == 1 ? @"我创建的歌单":@"我收藏的歌单";
        mineHeader.extensionBtn.tag = section;
        [mineHeader.extensionBtn setTitle:str forState:UIControlStateNormal];
        [mineHeader.extensionBtn addTarget:self action:@selector(headButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        NSString * sectionStr = [NSString stringWithFormat:@"%ld",(long)section];
        if ([self.openArray containsObject:sectionStr]) {
            [mineHeader.editorButton setTitle:@"展开了" forState:UIControlStateNormal];
        }
        else {
            [mineHeader.editorButton setTitle:@"关闭中" forState:UIControlStateNormal];
        }
        return mineHeader;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return section == 0 ? 0.01:40;
}

- (void)headButtonClick:(UIButton *)sender {
    
    NSString * sectionStr = [NSString stringWithFormat:@"%ld",(long)sender.tag];
    // 判断数组中是否包含当前点击的 section
    if ([self.openArray containsObject:sectionStr]) {
        // 包含 ---> 则移除
        [self.openArray removeObject:sectionStr];
    }
    else {
        // 不包含 ---> 则添加
        [self.openArray addObject:sectionStr];
    }
    // 刷新当前对应的 section
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:sender.tag] withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark -- other Deleget

#pragma mark -- NetWork Methods

#pragma mark -- Setter && Getter

- (NSMutableArray *)openArray {
    if (!_openArray) {
        _openArray = [NSMutableArray array];
    }
    return _openArray;
}

@end
