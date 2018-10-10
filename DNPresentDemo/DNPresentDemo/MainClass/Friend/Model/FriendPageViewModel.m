//
//  FriendPageViewModel.m
//  163Music
//
//  Created by zjs on 2018/10/8.
//  Copyright © 2018 zjs. All rights reserved.
//

#import "FriendPageViewModel.h"
#import "DNPageController.h"

@interface FriendPageViewModel ()

@property (nonatomic, strong) RACCommand * command;
@property (nonatomic, strong) NinaPagerView * pagerView;
@end

@implementation FriendPageViewModel

- (void)ninaPagerViewForDataHandler:(void(^)(NinaPagerView *pageView))handler {
    
    NSDictionary * dic = [NSDictionary dictionary];
    [NSBaseNetManager POSTRequestWithURL:@"https://www.apiopen.top/journalismApi"
                                   param:dic
                               isNeedSVP:YES
                         completeHandler:^(NSDictionary *dict) {
                             NSMutableArray * array = [NSMutableArray array];
                             NSMutableArray * value = [NSMutableArray array];
                             NSDictionary * dataDic = dict[@"data"];
                             [dataDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                                 
                                 [array addObject:key];
                                 [value addObject:obj];
                             }];
                             self.pagerView = [self addPageMenuWithTitleArray:array dataArray:value];
                             NSLog(@"%@",self.pagerView);
                         } faildHandler:^(id data) {
                             
                             
                         }];
    handler(_pagerView);
}

- (NinaPagerView *)addPageMenuWithTitleArray:(NSArray *)titleArray dataArray:(NSArray *)dataArray{
    
    NSMutableArray * titleArr   = [NSMutableArray array];
    NSMutableArray * controller = [NSMutableArray array];
    [titleArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [titleArr addObject:obj];
        
        DNPageController * con = [[DNPageController alloc] init];
        con.baseArray = dataArray[idx];
        [controller addObject:con];
    }];
    
    NinaPagerView *ninaPageView = [[NinaPagerView alloc] initWithFrame:CGRectZero WithTitles:titleArr WithObjects:controller];
    
    return ninaPageView;
}

@end
