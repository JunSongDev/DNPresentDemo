//
//  VedioViewModel.m
//  163Music
//
//  Created by zjs on 2018/8/9.
//  Copyright © 2018年 zjs. All rights reserved.
//

#import "VedioViewModel.h"
#import "VedioModel.h"
#import "VedioTableViewCell.h"

@interface VedioViewModel ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) RACCommand * vedioCommand;

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSMutableArray * dataArray;
@end

@implementation VedioViewModel

- (void)bindViewToViewModel:(UIView *)view {
    
    self.tableView = (UITableView *)view;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    [self.tableView registerNib:[UINib nibWithNibName:@"VedioTableViewCell" bundle:nil] forCellReuseIdentifier:@"VedioTableViewCell"];
    
    [self requestForData];
}

- (void)requestForData {
    
     @weakify(self);
    _vedioCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        @strongify(self)
       
        RACSignal *requestSingal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            
            [NSBaseNetManager POSTRequestWithURL:@"http://118.31.38.226:8081/app/clertType/carouselFigure.do"
                                           param:[NSDictionary dictionary]
                                       isNeedSVP:YES
                                 completeHandler:^(NSDictionary *dict) {
                                     
                                     [subscriber sendNext:dict];
                                     [subscriber sendCompleted];
                                 } faildHandler:^(id data) {
                                     
                                     [subscriber sendError:nil];
                                     [subscriber sendCompleted];
                                 }];
            return nil;
        }];
        return [requestSingal map:^id _Nullable(NSDictionary * _Nullable value) {
            
            if ([value[@"code"] integerValue] == 0) {
                
                NSArray * array = [VedioModel mj_objectArrayWithKeyValuesArray:value[@"data"]];
                self.dataArray = [NSMutableArray arrayWithArray:array];
                [self.tableView reloadData];
            }
            return nil;
        }];
    }];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    VedioModel * model = self.dataArray[indexPath.row];
    VedioTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"VedioTableViewCell"];
    if (!cell) {
        cell = [[VedioTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"VedioTableViewCell"];
    }
    /**
     *  @brief cell 的 accessoryType
     *
     *  @param  UITableViewCellAccessoryNone                    无效果
     *  @param  UITableViewCellAccessoryCheckmark               勾选
     *  @param  UITableViewCellAccessoryDetailButton            警告按钮
     *  @param  UITableViewCellAccessoryDisclosureIndicator     小箭头
     *  @param  UITableViewCellAccessoryDetailDisclosureButton  按钮 + 箭头
     */
    // 仅可点击的警告按钮
    //cell.accessoryType = UITableViewCellAccessoryCheckmark;
    // 可改变 accessory 的颜色
    //cell.tintColor = UIColor.orangeColor;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = model;
    return cell;
}

@end
