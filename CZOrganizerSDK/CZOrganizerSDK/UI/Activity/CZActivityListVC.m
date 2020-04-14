

//
//  CZActivityListVC.m
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/23.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZActivityListVC.h"
#import "CZActivityListTableView.h"
#import "CZActivityDetailVC.h"
#import "CZCommonFilterManager.h"
#import "DropMenuBar.h"
#import "CZAdvisorDetailService.h"
#import "QSCommonService.h"
#import "CZActivityModel.h"
#import "CZMJRefreshHelper.h"
#import "CXSearchViewController.h"
@interface CZActivityListVC ()
@property (nonatomic ,strong) UIButton *backBtn;
@property (nonatomic ,strong) UIButton *searchBtn;
@property (nonatomic ,strong) CZActivityListTableView *tableView;
@property (nonatomic ,strong) DropMenuBar *menuBar;
@property (nonatomic ,strong) CZCommonFilterManager *manager;
@property (nonatomic ,assign) NSInteger pageNum;
@property (nonatomic ,assign) NSInteger pageSize;
@property (nonatomic ,strong) NSDictionary *paramDic;
@end

@implementation CZActivityListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"全部活动";
    self.pageNum = 1;
    self.pageSize = 20;
    [self initWithUI];
    [self addActionHandle];
    self.paramDic = @{@"serviceSource":@"1",@"smartSort":@"",@"countryId":@"",@"cityId":@"",@"majorId":@"",@"productCategory":@"",@"educationType":@"",@"superviseType":@"",@"minPrice":@"",@"maxPrice":@""};
    [self requestForApiProductActivitySelectProductActivityByFilter:self.paramDic];
}

- (void)addActionHandle{
    WEAKSELF
    [self.tableView setDidSelectCell:^(NSString * _Nonnull str) {
        CZActivityDetailVC *detailVC = [[CZActivityDetailVC alloc]init];
        detailVC.activityId = str;
        [weakSelf.navigationController pushViewController:detailVC animated:YES];
    }];
    
    self.tableView.mj_header = [CZMJRefreshHelper lb_headerWithAction:^{
        weakSelf.pageNum = 1;
        [weakSelf requestForApiProductActivitySelectProductActivityByFilter:weakSelf.paramDic];
    }];
    
    self.tableView.mj_footer = [CZMJRefreshHelper lb_footerWithAction:^{
        weakSelf.pageNum ++;
        [weakSelf requestForApiProductActivitySelectProductActivityByFilter:weakSelf.paramDic];
    }];
    
    [self.manager setSelectBlock:^(CZHomeParam * _Nonnull param) {
        weakSelf.pageNum = 1;
        weakSelf.paramDic = [param dictonary];
        [weakSelf requestForApiProductActivitySelectProductActivityByFilter:weakSelf.paramDic];
    }];
}

/**
 获取活动
 */
- (void)requestForApiProductActivitySelectProductActivityByFilter:(NSDictionary *)filterDic{
    WEAKSELF
    CZAdvisorDetailService *service = serviceByType(QSServiceTypeAdvisorDetail);
    [service requestForApiProductActivitySelectProductActivityByFilter:filterDic pageNum:self.pageNum pageSize:self.pageSize callBack:^(BOOL success, NSInteger code, id  _Nonnull data, NSString * _Nonnull errorMessage) {
        if (success){
            dispatch_async(dispatch_get_main_queue(), ^{
                NSMutableArray *array = [[NSMutableArray alloc] init];
                for (NSDictionary *dic in data) {
                    CZActivityModel *model = [CZActivityModel modelWithDict:dic];
                    [array addObject:model];
                }
                if (weakSelf.pageNum == 1) {
                    [weakSelf.tableView.dataArr removeAllObjects];
                    [weakSelf.tableView.dataArr addObjectsFromArray:array];
                }else{
                    [weakSelf.tableView.dataArr addObjectsFromArray:array];
                }
                [weakSelf.tableView reloadData];
                if (weakSelf.pageNum == 1) {
                    [weakSelf.tableView.mj_header endRefreshing];
                }
                if (array.count < weakSelf.pageSize) {
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
    self.view.backgroundColor = [UIColor whiteColor];
    //返回按钮
    self.backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [self.backBtn setImage:[CZImageProvider imageNamed:@"tong_yong_fan_hui"] forState:UIControlStateNormal];
    [self.backBtn addTarget:self action:@selector(actionForBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:self.backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    //右边按钮
    self.searchBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];//heise_fenxiang@2x   guwen_fenxiang
    [self.searchBtn setImage:[CZImageProvider imageNamed:@"sousuo_heise"] forState:UIControlStateNormal];
    [self.searchBtn addTarget:self action:@selector(searchItemClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rbackItem = [[UIBarButtonItem alloc]initWithCustomView:self.searchBtn];
    self.navigationItem.rightBarButtonItem = rbackItem;
    
    self.manager = [[CZCommonFilterManager alloc]init];
    self.menuBar = [self.manager actionsForType:CZCommonFilterTypeMoreActivity];
    [self.view addSubview:self.menuBar];
    [self.menuBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.top.mas_equalTo(self.view);
        make.height.mas_equalTo(ScreenScale(80));
    }];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view.mas_top).offset(ScreenScale(80));
    }];
}

- (CZActivityListTableView *)tableView{
    if (!_tableView) {
        _tableView = [[CZActivityListTableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    }
    return _tableView;
}

//返回
-(void)actionForBack{
    [self.navigationController popViewControllerAnimated:YES];
}
//搜索
- (void)searchItemClick{
    CXSearchViewController *searchViewController = [[CXSearchViewController alloc] initWithNibName:@"CXSearchViewController" bundle:[NSBundle bundleForClass:[self class]]];
    [self.navigationController pushViewController:searchViewController animated:YES];
}
@end
