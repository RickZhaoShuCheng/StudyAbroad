
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
#import "CZAdvisorDetailService.h"
#import "QSCommonService.h"
#import "CZAdvisorDetailViewController.h"

@interface CZOrganizerAdvisorVC ()
@property (nonatomic ,strong) UIButton *backBtn;//返回按钮
@property (nonatomic ,strong) CZOrganizerAdvisorTableView *tableView;
@end

@implementation CZOrganizerAdvisorVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initWithUI];
    WEAKSELF
    self.tableView.mj_header = [CZMJRefreshHelper lb_headerWithAction:^{
        [weakSelf requestForApiCounselorGetCounselorListByOrganId];
    }];
//    self.tableView.mj_footer = [CZMJRefreshHelper lb_footerWithAction:^{
        
//    }];
    [self requestForApiCounselorGetCounselorListByOrganId];
    
    [self.tableView setSelectAdvisorBlock:^(CZAdvisorModel * _Nonnull model) {
        CZAdvisorDetailViewController *detailVC = [[CZAdvisorDetailViewController alloc]init];
        detailVC.counselorId = model.counselorId;
        [weakSelf.navigationController pushViewController:detailVC animated:YES];
    }];
    self.title = @"全部顾问";
}

/**
获取顾问
*/
- (void)requestForApiCounselorGetCounselorListByOrganId{
    WEAKSELF
    CZAdvisorDetailService *service = serviceByType(QSServiceTypeAdvisorDetail);
    [service requestForApiCounselorGetCounselorListByOrganId:self.idStr callBack:^(BOOL success, NSInteger code, id  _Nonnull data, NSString * _Nonnull errorMessage) {
        if (success){
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.tableView.dataArr removeAllObjects];
                [weakSelf.tableView.dataArr addObjectsFromArray:data];
                [weakSelf.tableView reloadData];
                [weakSelf.tableView.mj_header endRefreshing];
            });
        }
    }];
}

/**
 * 初始化UI
 */
- (void)initWithUI{
    self.view.backgroundColor = [UIColor whiteColor];
    
    //返回按钮
    self.backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];//baise_fanhui@2x  tong_yong_fan_hui
    [self.backBtn setImage:[CZImageProvider imageNamed:@"tong_yong_fan_hui"] forState:UIControlStateNormal];
    [self.backBtn addTarget:self action:@selector(actionForBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:self.backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    
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

//返回
-(void)actionForBack{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
