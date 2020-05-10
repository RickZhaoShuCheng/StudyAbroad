//
//  CZMoreSchoolStarVC.m
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/4/1.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZMoreSchoolStarVC.h"
#import "CZMoreSchoolStarTableView.h"
#import "CZCommonFilterManager.h"
#import "DropMenuBar.h"
#import "QSOrganizerHomeService.h"
#import "QSCommonService.h"
#import "QSClient.h"
#import "CZSchoolStarModel.h"
#import "CZMJRefreshHelper.h"
#import "QSClient.h"
#import "CZSchoolStarShopDetailVC.h"
#import "CZSchoolStarDetailVC.h"
#import "CZSchoolStarShopDetailVC.h"
#import "CXSearchViewController.h"
@interface CZMoreSchoolStarVC ()
@property (nonatomic ,strong) UIButton *backBtn;
@property (nonatomic ,strong) UIButton *searchBtn;
@property (nonatomic ,strong) CZMoreSchoolStarTableView *tableView;
@property (nonatomic ,strong) DropMenuBar *menuBar;
@property (nonatomic ,strong) CZCommonFilterManager *manager;
@property (nonatomic ,assign) NSInteger pageNum;
@property (nonatomic ,strong) CZHomeParam *param;
@end

@implementation CZMoreSchoolStarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.param = [[CZHomeParam alloc]init];
    self.pageNum = 1;
    [self initWithUI];
    [self requestForSchoolStars];
    WEAKSELF
    [self.manager setSelectBlock:^(CZHomeParam * _Nonnull param) {
        weakSelf.pageNum = 1;
        weakSelf.param = param;
        [weakSelf requestForSchoolStars];
    }];
    
    self.tableView.mj_header = [CZMJRefreshHelper lb_headerWithAction:^{
        weakSelf.pageNum = 1;
        [weakSelf requestForSchoolStars];
    }];
    
    self.tableView.mj_footer = [CZMJRefreshHelper lb_footerWithAction:^{
        weakSelf.pageNum ++;
        [weakSelf requestForSchoolStars];
    }];
    //查看商品
    [self.tableView setSelectedProductCell:^(CZProductVoListModel * _Nonnull model) {
        //安卓没有此功能，暂时注掉
//        UIViewController *prodDetailVC = [QSClient instanceProductDetailVCByOptions:@{@"productId":model.productId}];
//        [weakSelf.navigationController pushViewController:prodDetailVC animated:YES];
    }];
    //查看达人
    [self.tableView setSelectedSchoolStarCell:^(CZSchoolStarModel * _Nonnull model) {
        //店铺详情
        CZSchoolStarShopDetailVC *detailVC = [[CZSchoolStarShopDetailVC alloc]init];
        detailVC.sportUserId = model.sportUserId;
        [weakSelf.navigationController pushViewController:detailVC animated:YES];
        //个人详情
//        CZSchoolStarDetailVC *detailVC = [[CZSchoolStarDetailVC alloc]init];
//        detailVC.userId = model.userId;
//        [weakSelf.navigationController pushViewController:detailVC animated:YES];
    }];
}

-(void)requestForSchoolStars
{
    WEAKSELF
    QSOrganizerHomeService *service = serviceByType(QSServiceTypeOrganizerHome);
    self.param.userId = [QSClient userId];
    self.param.pageNum = @(self.pageNum);
    self.param.pageSize = @(20);
    [service requestForApiSportUserGetMoreSportUserListByParam:self.param callBack:^(BOOL success, NSInteger code, id  _Nonnull data, NSString * _Nonnull errorMessage) {
        if (success) {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSMutableArray *array = [[NSMutableArray alloc] init];
                for (NSDictionary *dic in data) {
                    CZSchoolStarModel *model = [CZSchoolStarModel modelWithDict:dic];
                    [array addObject:model];
                }
                [weakSelf.tableView.mj_header endRefreshing];
                
                if (weakSelf.pageNum == 1) {
                    [weakSelf.tableView.dataArr removeAllObjects];
                    [weakSelf.tableView.dataArr addObjectsFromArray:array];
                }
                else
                {
                    [weakSelf.tableView.dataArr addObjectsFromArray:array];
                }
                
                if (array.count < 20) {
                    [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
                }
                else
                {
                    [weakSelf.tableView.mj_footer endRefreshing];
                }
                
                [weakSelf.tableView reloadData];
                
                if (self.tableView.dataArr.count > 0) {
//                    [self.dataTableView hideNoData];
                }
                else
                {
//                    [self.dataTableView showNodataView];
                }
            });
            
        }
        
    }];
}

/**
 * 初始化UI
 */
- (void)initWithUI{
    self.title = @"留学达人";
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
    self.menuBar = [self.manager actionsForType:CZCommonFilterTypeMoreSchoolStar];
    [self.view addSubview:self.menuBar];
    [self.menuBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.top.mas_equalTo(self.view);
        make.height.mas_equalTo(ScreenScale(80));
    }];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(ScreenScale(80));
        make.leading.trailing.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view);
    }];
}

- (CZMoreSchoolStarTableView *)tableView{
    if (!_tableView) {
        _tableView = [[CZMoreSchoolStarTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
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
