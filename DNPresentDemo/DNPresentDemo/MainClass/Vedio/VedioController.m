//
//  VedioController.m
//  163Music
//
//  Created by zjs on 2018/5/22.
//  Copyright © 2018年 zjs. All rights reserved.
//

#import "VedioController.h"
#import "NSBaseNetManager.h"
#import "MineController.h"
#import "VedioViewModel.h"

@interface VedioController ()<DNEmptyViewDelegate, SDCycleScrollViewDelegate>

@property (nonatomic, assign) NSInteger num;
@property (nonatomic, strong) NSMutableArray * dataArray;
@property (nonatomic, strong) VedioViewModel * viewModel;
@property (nonatomic, strong) SDCycleScrollView * bannerView;
@end

@implementation VedioController

#pragma mark -- lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setControlForSuper];
    [self addConstrainsForSuper];
    
    self.viewModel = [[VedioViewModel alloc] init];
    [self.viewModel bindViewToViewModel:self.tableView];
    
    [self netWorkGetData];
    
    DNWeak(self)
    [self.tableView dn_startHeaderRefreshWithRefreshBlock:^{
       
        [weakself netWorkGetData];
    }];
}

- (void)netWorkGetData {
    
    [[self.viewModel.vedioCommand execute:nil] subscribeNext:^(id  _Nullable x) {
        
    }];
}

#pragma mark -- didReceiveMemoryWarning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark -- setControlForSuper
- (void)setControlForSuper {
    
    //self.tableView.tableHeaderView = self.bannerView;
    self.tableView.emptyView = [[DNEmptyView alloc] initWithDelegate:self];
    [self.view addSubview:self.tableView];
}

#pragma mark -- addConstrainsForSuper
- (void)addConstrainsForSuper{
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.edges.mas_equalTo(self.view);
    }];
}

#pragma mark -- target Methods

- (void)refreshClick {

    [self.dataArray removeAllObjects];
    [self.tableView reloadData];
}

#pragma mark -- UITableView Delegate && DataSource

#pragma mark -- other Deleget

- (void)emptyViewReload {
    
    [self netWorkGetData];
}

#pragma mark -- NetWork Methods

#pragma mark -- Setter && Getter

@end
