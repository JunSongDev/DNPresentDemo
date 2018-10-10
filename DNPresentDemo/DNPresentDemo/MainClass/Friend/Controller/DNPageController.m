//
//  DNPageController.m
//  163Music
//
//  Created by zjs on 2018/8/17.
//  Copyright © 2018年 zjs. All rights reserved.
//

#import "DNPageController.h"

@interface DNPageController ()

@end

@implementation DNPageController

#pragma mark -- LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.baseArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        
    }];
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    DNLog(@"%s",__FUNCTION__);
}
- (void)dealloc{
    
    NSLog(@"dealloc");
}

/**

- (void)viewWillAppear:(BOOL)animated {
[super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
[super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
[super viewWillDisappear:animated];
}

-(void)viewDidDisappear:(BOOL)animated {
[super viewDidDisappear:animated];
}
*/


#pragma mark -- DidReceiveMemoryWarning

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- SetControlForSuper
- (void)setControlForSuper
{    
    
}

#pragma mark -- AddConstrainsForSuper
- (void)addConstrainsForSuper
{

}

#pragma mark -- Target Methods

#pragma mark -- Private Methods

#pragma mark -- UITableView Delegate && DataSource

/**

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
return <#section#>;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
return <#row#>;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
return <# UITableViewCell #>;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
return <#height#>;
}
*/

#pragma mark -- Other Delegate

#pragma mark -- NetWork Methods

#pragma mark -- Setter && Getter

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
