//
//  CZAdvisorViewController.m
//  CZOrganizerSDK
//
//  Created by zsc on 2020/2/29.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZAdvisorViewController.h"
#import "CZAdvisorView.h"
#import "CZMJRefreshHelper.h"
#import "QSOrganizerHomeService.h"
#import "QSCommonService.h"
#import "QSClient.h"
#import "CZAdvisorModel.h"
#import "CZAdvisorDetailViewController.h"
#import "CZActivityListVC.h"
#import "CZSchoolStarModel.h"
#import "DropMenuBar.h"
#import "CZCommonFilterManager.h"

@interface CZAdvisorViewController ()

@property (nonatomic ,strong) CZAdvisorView *dataView;
@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, strong) CZHomeParam *param;
@property (nonatomic, strong) DropMenuBar *menuScreeningView;
@property (nonatomic, strong)CZCommonFilterManager *manager;
@end

@implementation CZAdvisorViewController
@synthesize contentScrollView;
@synthesize canScroll;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self requestForAdvisors];
}

-(void)initUI
{
    self.view.backgroundColor = CZColorCreater(245, 245, 249, 1.0);

    if (!self.param) {
        self.param = [[CZHomeParam alloc] init];
    }
    self.param.userId = [QSClient userId];
    if (self.model) {
        NSData *data = [self.model.jsonParams dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        self.param.productCategory = dic[@"productCategory"];
    }
    
    self.dataView = [[CZAdvisorView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];

    [self.view addSubview:self.dataView];
    if (!self.model) {
        self.contentScrollView = self.dataView;
    }
    
    if (self.keywords) {
        self.contentScrollView = nil;
    }
    else
    {
        [self createDefaultFilterMenu];
    }
    
    [self.dataView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (self.menuScreeningView) {
            make.top.mas_equalTo(self.menuScreeningView.mas_bottom);
        }
        else
        {
            make.top.mas_equalTo(0);
        }
        make.left.right.mas_equalTo(0);
        
        make.bottom.mas_equalTo(0);
        
    }];
//    self.dataView.alwaysBounceVertical = YES;
    self.pageIndex = 1;
    WEAKSELF
    self.dataView.mj_header = [CZMJRefreshHelper lb_headerWithAction:^{
        weakSelf.pageIndex = 1;
        [weakSelf requestForAdvisors];
    }];
    
    self.dataView.mj_footer = [CZMJRefreshHelper lb_footerWithAction:^{
        weakSelf.pageIndex += 1;
        [weakSelf requestForAdvisors];
    }];
    
    //点击cell
    self.dataView.selectedBlock = ^(NSString * _Nonnull counselorId) {
        CZAdvisorDetailViewController *detailVC = [[CZAdvisorDetailViewController alloc]init];
        detailVC.counselorId = counselorId;
        detailVC.hidesBottomBarWhenPushed = YES;
        [weakSelf.navigationController pushViewController:detailVC animated:YES];
    };
}

-(void)requestForAdvisors
{
    if (self.keywords && self.keywords.length == 0) {
        return;
    }
    
    WEAKSELF
    QSOrganizerHomeService *service = serviceByType(QSServiceTypeOrganizerHome);
    self.param.pageNum = @(self.pageIndex);
    self.param.pageSize = @(10);
    self.param.name = self.keywords && self.keywords.length > 0 ?self.keywords:nil;
    QSOrganizerHomeBack block = ^(BOOL success, NSInteger code, id  _Nonnull data, NSString * _Nonnull errorMessage) {
            
            if (success) {
            
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    NSMutableArray *array = [[NSMutableArray alloc] init];
                    
                    for (NSDictionary *dic in data) {
                        CZAdvisorModel *model = [CZAdvisorModel modelWithDict:dic];
                        [array addObject:model];
                    }
                    
                    [weakSelf.dataView.mj_header endRefreshing];
                    
                    if (weakSelf.pageIndex == 1) {
                        [weakSelf.dataView.dataArr removeAllObjects];
                        [weakSelf.dataView.dataArr addObjectsFromArray:array];
                    }
                    else
                    {
                        [weakSelf.dataView.dataArr addObjectsFromArray:array];
                    }
                    
                    if (array.count < 10) {
                        [weakSelf.dataView.mj_footer endRefreshingWithNoMoreData];
                    }
                    else
                    {
                        [weakSelf.dataView.mj_footer endRefreshing];
                    }
                    
                    [weakSelf.dataView reloadData];
                    
                    if (self.dataView.dataArr.count > 0) {
    //                    [self.dataTableView hideNoData];
                    }
                    else
                    {
    //                    [self.dataTableView showNodataView];
                    }
                });
                
            }
            
    };
    
    if (!self.keywords) {
        [service requestForApiCounselorGetCounselorListByFilterByParam:self.param callBack:block];
    }
    else
    {
        [service requestForApiCounselorSearchCounselorListByNameByParam:self.param callBack:block];
    }
}

-(void)createDefaultFilterMenu
{
    WEAKSELF
    self.manager = [[CZCommonFilterManager alloc] init];
    self.manager.param = self.param;
    self.menuScreeningView = [self.manager actionsForType:self.model?CZCommonFilterTypeAdvisor:CZCommonFilterTypeHomeAdvisor];
    [self.view addSubview:self.menuScreeningView];
    self.manager.selectBlock = ^(CZHomeParam * _Nonnull param) {
        weakSelf.pageIndex = 1;
        [weakSelf requestForAdvisors];
    };
    self.manager.filterViewShow = self.filterViewShow;
}

-(void)reloadData
{
    if (self.isViewLoaded) {
        self.pageIndex = 1;
        [self requestForAdvisors];
    }
}
@end
