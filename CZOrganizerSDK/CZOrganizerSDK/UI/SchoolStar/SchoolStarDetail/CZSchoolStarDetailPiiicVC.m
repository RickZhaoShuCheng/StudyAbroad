//
//  SchoolStarDetailPiiicVC.m
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/4/6.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZSchoolStarDetailPiiicVC.h"

@interface CZSchoolStarDetailPiiicVC ()

@end

@implementation CZSchoolStarDetailPiiicVC

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

- (CZSchoolStarDetailPiiicTableView *)tableView{
    if (!_tableView) {
        _tableView = [[CZSchoolStarDetailPiiicTableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    }
    return _tableView;
}
@end
