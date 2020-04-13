//
//  OrganizerDynamicPostVC.m
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/23.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZOrganizerDynamicPostVC.h"

@interface CZOrganizerDynamicPostVC ()

@end

@implementation CZOrganizerDynamicPostVC

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

- (CZOrganizerDynamicPostTableView *)tableView{
    if (!_tableView) {
        _tableView = [[CZOrganizerDynamicPostTableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    }
    return _tableView;
}

@end
