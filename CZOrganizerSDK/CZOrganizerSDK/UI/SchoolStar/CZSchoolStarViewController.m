//
//  CZSchoolStarViewController.m
//  CZOrganizerSDK
//
//  Created by zsc on 2020/2/29.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZSchoolStarViewController.h"
#import "CZSchoolStarListView.h"
#import "CZMJRefreshHelper.h"
#import "QSOrganizerHomeService.h"
#import "QSCommonService.h"
#import "QSClient.h"
#import "CZSchoolStarModel.h"
#import "DropMenuBar.h"
#import "CZCommonFilterManager.h"
#import "QSClient.h"
#import "CZSchoolStarShopDetailVC.h"
#import "CZProductVoListModel.h"
#import "CZSchoolStarModel.h"
#import "CZSchoolStarDetailVC.h"
@interface CZSchoolStarViewController ()

@property (nonatomic ,strong) CZSchoolStarListView *dataView;
@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, strong) CZHomeParam *param;
@property (nonatomic, strong) DropMenuBar *menuScreeningView;
@property (nonatomic, strong)CZCommonFilterManager *manager;

@end

@implementation CZSchoolStarViewController
@synthesize contentScrollView;
@synthesize canScroll;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self requestForSchoolStars];
}

-(void)initUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    if (!self.param) {
        self.param = [[CZHomeParam alloc] init];
    }
    self.param.userId = [QSClient userId];
    if (self.model) {
        NSData *data = [self.model.jsonParams dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        self.param.productCategory = dic[@"productCategory"];
    }
        
    self.dataView = [[CZSchoolStarListView alloc] init];
    self.dataView.backgroundColor = [UIColor whiteColor];
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
        
        if (self.keywords) {
            make.bottom.mas_equalTo(-100);
        }
        else
        {
            make.bottom.mas_equalTo(!self.model?0:-100);
        }
    }];
//    self.dataView.alwaysBounceVertical = YES;
    self.pageIndex = 1;
    WEAKSELF
    self.dataView.mj_header = [CZMJRefreshHelper lb_headerWithAction:^{
        weakSelf.pageIndex = 1;
        [weakSelf requestForSchoolStars];
    }];
    
    self.dataView.mj_footer = [CZMJRefreshHelper lb_footerWithAction:^{
        weakSelf.pageIndex += 1;
        [weakSelf requestForSchoolStars];
    }];
    
    //查看商品
    [self.dataView setSelectedProductCell:^(CZProductVoListModel * _Nonnull model) {
        UIViewController *prodDetailVC = [QSClient instanceProductDetailVCByOptions:@{@"productId":model.productId}];
        prodDetailVC.hidesBottomBarWhenPushed = YES;
        [weakSelf.navigationController pushViewController:prodDetailVC animated:YES];
    }];
    //查看达人
    [self.dataView setSelectedSchoolStarCell:^(CZSchoolStarModel * _Nonnull model) {
        CZSchoolStarShopDetailVC *detailVC = [[CZSchoolStarShopDetailVC alloc]init];
        detailVC.sportUserId = model.sportUserId;
        detailVC.hidesBottomBarWhenPushed = YES;
        [weakSelf.navigationController pushViewController:detailVC animated:YES];
    }];
}

-(void)requestForSchoolStars
{
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
                        CZSchoolStarModel *model = [CZSchoolStarModel modelWithDict:dic];
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
        [service requestForApiSportUserGetSportUserListByFilterByParam:self.param callBack:block];
    }
    else
    {
        [service requestForApiSportUserSearchSportUserListByNameByParam:self.param callBack:block];
    }
}

-(void)createDefaultFilterMenu
{
    WEAKSELF
    self.manager = [[CZCommonFilterManager alloc] init];
    self.manager.param = self.param;
    self.menuScreeningView = [self.manager actionsForType:self.model?CZCommonFilterTypeSchoolStar:CZCommonFilterTypeHomeSchoolStar];
    [self.view addSubview:self.menuScreeningView];
    self.manager.selectBlock = ^(CZHomeParam * _Nonnull param) {
        weakSelf.pageIndex = 1;
        [weakSelf requestForSchoolStars];
    };
    self.manager.filterViewShow = self.filterViewShow;
}

-(void)reloadData
{
    if (self.isViewLoaded) {
        self.pageIndex = 1;
        [self requestForSchoolStars];
    }
}
@end
