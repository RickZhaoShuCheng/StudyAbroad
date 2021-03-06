//
//  CZAdvisorDynamicQAVC.m
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/4/28.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZAdvisorDynamicQAVC.h"

@interface CZAdvisorDynamicQAVC ()

@end

@implementation CZAdvisorDynamicQAVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initWithUI];
//    [self actionMethod];
    
}

/**
 * 初始化UI
 */
- (void)initWithUI{
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

- (CZAdvisorDynamicQATableView *)tableView{
    if (!_tableView) {
        _tableView = [[CZAdvisorDynamicQATableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    }
    return _tableView;
}

@end
