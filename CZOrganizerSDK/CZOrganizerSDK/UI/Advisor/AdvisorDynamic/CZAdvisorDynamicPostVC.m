//
//  AdvisorDynamicPostVC.m
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/21.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZAdvisorDynamicPostVC.h"

@interface CZAdvisorDynamicPostVC ()

@end

@implementation CZAdvisorDynamicPostVC

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

- (CZAdvisorDynamicPostTableView *)tableView{
    if (!_tableView) {
        _tableView = [[CZAdvisorDynamicPostTableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    }
    return _tableView;
}

@end
