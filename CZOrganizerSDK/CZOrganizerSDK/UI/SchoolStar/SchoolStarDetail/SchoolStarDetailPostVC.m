
//
//  SchoolStarDetailPostVC.m
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/4/6.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "SchoolStarDetailPostVC.h"
#import "QSCommonService.h"
#import "CZAdvisorDetailService.h"
#import "CZCaseModel.h"
#import "CZMJRefreshHelper.h"
@interface SchoolStarDetailPostVC ()
@property (nonatomic ,assign) NSInteger pageNum;
@end

@implementation SchoolStarDetailPostVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageNum = 1;
    [self initWithUI];
    [self actionMethod];
    [self requestForApiMyDynamicPersonalHomepage];
    
}

- (void)actionMethod{
    WEAKSELF
    self.tableView.mj_footer = [CZMJRefreshHelper lb_footerWithAction:^{
        weakSelf.pageNum ++;
        [weakSelf requestForApiMyDynamicPersonalHomepage];
    }];
}
//获取达人详情信息
- (void)requestForApiMyDynamicPersonalHomepage{
    WEAKSELF
    CZAdvisorDetailService *service = [QSCommonService service:QSServiceTypeAdvisorDetail];
    [service requestForApiMyDynamicPersonalHomepage:self.userId type:1 pageNum:self.pageNum pageSize:20 callBack:^(BOOL success, NSInteger code, id  _Nonnull data, NSString * _Nonnull errorMessage) {
        if (success) {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSMutableArray *tempArr = [NSMutableArray array];
                for (NSDictionary *dic in data[@"list"]) {
                    CZCaseModel *model = [CZCaseModel modelWithDict:dic];
                    [tempArr addObject:model];
                }
                if (weakSelf.pageNum == 1) {
                    [weakSelf.tableView.dataArr removeAllObjects];
                    [weakSelf.tableView.dataArr addObjectsFromArray:tempArr];
                }else{
                    [weakSelf.tableView.dataArr addObjectsFromArray:tempArr];
                }
                [weakSelf.tableView reloadData];
                if (weakSelf.pageNum == 1) {
                    [weakSelf.tableView.mj_header endRefreshing];
                }
                if (tempArr.count < 20) {
                    [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
                }else{
                    [weakSelf.tableView.mj_footer endRefreshing];
                }
            });
        }
    }];
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

- (SchoolStarDetailPostTableView *)tableView{
    if (!_tableView) {
        _tableView = [[SchoolStarDetailPostTableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    }
    return _tableView;
}

@end
