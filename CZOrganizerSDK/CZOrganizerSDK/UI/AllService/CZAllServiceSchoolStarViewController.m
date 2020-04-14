//
//  CZAllServiceSchoolStarViewController.m
//  CZOrganizerSDK
//
//  Created by zsc on 2020/3/13.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZAllServiceSchoolStarViewController.h"
#import "CZAllServiceSchoolStarView.h"
#import "CZMJRefreshHelper.h"
#import "QSOrganizerHomeService.h"
#import "QSCommonService.h"
#import "QSClient.h"
#import "CZProductModel.h"
#import "CZCommonFilterManager.h"

@interface CZAllServiceSchoolStarViewController ()

@property (nonatomic ,strong) CZAllServiceSchoolStarView *dataView;
@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, strong)CZCommonFilterManager *manager;
@property (nonatomic, strong) DropMenuBar *menuScreeningView;
@end

@implementation CZAllServiceSchoolStarViewController
@synthesize contentScrollView;
@synthesize canScroll;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self requestForProductList];
}

-(void)initUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    [self createDefaultFilterMenu];
    self.dataView = [[CZAllServiceSchoolStarView alloc] init];
    self.dataView.viewController = self;
    self.dataView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.dataView];
    [self.dataView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(CGRectGetMaxY(self.menuScreeningView.frame));
        make.bottom.mas_equalTo(0);
    }];
//    self.dataView.alwaysBounceVertical = YES;
    self.pageIndex = 1;
    WEAKSELF
    self.dataView.mj_header = [CZMJRefreshHelper lb_headerWithAction:^{
        weakSelf.pageIndex = 1;
        [weakSelf requestForProductList];
    }];
    
    self.dataView.mj_footer = [CZMJRefreshHelper lb_footerWithAction:^{
        weakSelf.pageIndex += 1;
        [weakSelf requestForProductList];
    }];
}

-(void)requestForProductList
{
    WEAKSELF
    QSOrganizerHomeService *service = serviceByType(QSServiceTypeOrganizerHome);
    CZHomeParam *param = [[CZHomeParam alloc] init];
    param.userId = [QSClient userId];
    param.serviceSource = @(2);
    param.pageNum = @(self.pageIndex);
    param.pageSize = @(10);
    [service requestForApiProductGetProductListByFilterByParam:param callBack:^(BOOL success, NSInteger code, id  _Nonnull data, NSString * _Nonnull errorMessage) {
        
        if (success) {
        
            dispatch_async(dispatch_get_main_queue(), ^{
                
                NSMutableArray *array = [[NSMutableArray alloc] init];
                
                for (NSDictionary *dic in data) {
                    CZProductModel *model = [CZProductModel modelWithDict:dic];
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
        
    }];
    
    
}

-(void)createDefaultFilterMenu
{
    self.manager = [[CZCommonFilterManager alloc] init];
    self.menuScreeningView = [self.manager actionsForType:CZCommonFilterTypeServiceSchoolStar];
    [self.view addSubview:self.menuScreeningView];
}
@end
