//
//  CZBoardOrganizerViewController.m
//  CZOrganizerSDK
//
//  Created by zsc on 2020/3/9.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZBoardOrganizerViewController.h"
#import "CZBoardOrganizerView.h"
#import "CZMJRefreshHelper.h"
#import "QSOrganizerHomeService.h"
#import "QSCommonService.h"
#import "QSClient.h"
#import "CZOrganizerModel.h"
#import "CZAdvisorDetailViewController.h"
#import "CZOrganizerDetailViewController.h"
#import "UIImageView+WebCache.h"
#import "CZOrganizerVC.h"

@interface CZBoardOrganizerViewController ()

@property (nonatomic ,strong) CZBoardOrganizerView *dataView;
@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic ,strong) UIImageView *headImageView;

@end

@implementation CZBoardOrganizerViewController
@synthesize contentScrollView;
@synthesize canScroll;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self requestForOrganizers];
}

-(void)initUI
{
    self.view.backgroundColor = CZColorCreater(245, 245, 249, 1.0);
    self.dataView = [[CZBoardOrganizerView alloc] init];
    [self.view addSubview:self.dataView];
    [self.dataView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-50);
    }];
    
    WEAKSELF
    self.dataView.mj_header = [CZMJRefreshHelper lb_headerWithAction:^{
        weakSelf.pageIndex = 1;
        [weakSelf requestForOrganizers];
    }];
    
    self.dataView.mj_footer = [CZMJRefreshHelper lb_footerWithAction:^{
        weakSelf.pageIndex += 1;
        [weakSelf requestForOrganizers];
    }];
    
    self.headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.width/375.0*116)];
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:self.model.content2] placeholderImage:nil];
    self.dataView.tableHeaderView = self.headImageView;
    
    //点击cell
    self.dataView.selectedBlock = ^(NSString * _Nonnull organId) {
        CZOrganizerVC *organizerVC = [[CZOrganizerVC alloc]init];
        organizerVC.organId = organId;
        organizerVC.hidesBottomBarWhenPushed = YES;
        [weakSelf.navigationController pushViewController:organizerVC animated:YES];
    };
    
    self.dataView.selectedProductBlock = ^(NSString * _Nonnull productId) {
        UIViewController *prodDetailVC = [QSClient instanceProductDetailVCByOptions:@{@"productId":productId}];
        [weakSelf.navigationController pushViewController:prodDetailVC animated:YES];
    };
}


-(void)requestForOrganizers
{
    WEAKSELF
    QSOrganizerHomeService *service = serviceByType(QSServiceTypeOrganizerHome);
    CZHomeParam *param = [[CZHomeParam alloc] init];
    param.pageNum = @(self.pageIndex);
    param.pageSize = @(10);
    [service requestForApiOrganGetOrganTopListByParam:param callBack:^(BOOL success, NSInteger code, id  _Nonnull data, NSString * _Nonnull errorMessage) {
        
        if (success) {
        
            dispatch_async(dispatch_get_main_queue(), ^{
                
                NSMutableArray *array = [[NSMutableArray alloc] init];
                
                for (NSDictionary *dic in data) {
                    CZOrganizerModel *model = [CZOrganizerModel modelWithDict:dic];
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


@end

