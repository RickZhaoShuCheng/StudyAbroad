
//
//  CZOrganizerAdvisorVC.m
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/11.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZOrganizerAdvisorVC.h"
#import "CZOrganizerAdvisorTableView.h"
#import "CZMJRefreshHelper.h"

@interface CZOrganizerAdvisorVC ()
@property (nonatomic ,strong) CZOrganizerAdvisorTableView *tableView;
@end

@implementation CZOrganizerAdvisorVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initWithUI];
    WEAKSELF
    self.tableView.mj_header = [CZMJRefreshHelper lb_headerWithAction:^{
        [weakSelf.tableView.mj_header endRefreshing];
    }];
    self.tableView.mj_footer = [CZMJRefreshHelper lb_footerWithAction:^{
        [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
    }];
}

/**
 * 初始化UI
 */
- (void)initWithUI{
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

- (CZOrganizerAdvisorTableView *)tableView{
    if (!_tableView) {
        _tableView = [[CZOrganizerAdvisorTableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
    }
    return _tableView;
}
@end
