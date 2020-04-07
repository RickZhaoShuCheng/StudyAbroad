//
//  CZBoardSchoolStarViewController.m
//  CZOrganizerSDK
//
//  Created by 赵曙诚 on 2020/3/20.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZBoardSchoolStarViewController.h"

#import "CZBoardSchoolStarView.h"
#import "CZMJRefreshHelper.h"
#import "QSOrganizerHomeService.h"
#import "QSCommonService.h"
#import "QSClient.h"
#import "CZSchoolStarModel.h"
#import "UIImageView+WebCache.h"
#import "SchoolStarShopDetailVC.h"
//#import "CZAdvisorDetailViewController.h"

@interface CZBoardSchoolStarViewController ()

@property (nonatomic ,strong) CZBoardSchoolStarView *dataView;
@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic ,strong) UIImageView *headImageView;

@end

@implementation CZBoardSchoolStarViewController
@synthesize contentScrollView;
@synthesize canScroll;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self requestForSchoolStars];
}

-(void)initUI
{
    self.view.backgroundColor = CZColorCreater(245, 245, 249, 1.0);

    self.dataView = [[CZBoardSchoolStarView alloc] init];
    [self.view addSubview:self.dataView];
    [self.dataView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-50);
    }];
//    self.dataView.alwaysBounceVertical = YES;
    
    WEAKSELF
    self.dataView.mj_header = [CZMJRefreshHelper lb_headerWithAction:^{
        weakSelf.pageIndex = 1;
        [weakSelf requestForSchoolStars];
    }];
    
    self.dataView.mj_footer = [CZMJRefreshHelper lb_footerWithAction:^{
        weakSelf.pageIndex += 1;
        [weakSelf requestForSchoolStars];
    }];
    
    self.headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.width/375.0*116)];
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:self.model.content2] placeholderImage:nil];
    self.dataView.tableHeaderView = self.headImageView;
    
    //查看达人
    [self.dataView setSelectedSchoolStarCell:^(CZSchoolStarModel * _Nonnull model) {
        SchoolStarShopDetailVC *detailVC = [[SchoolStarShopDetailVC alloc]init];
        detailVC.sportUserId = model.sportUserId;
        detailVC.hidesBottomBarWhenPushed = YES;
        [weakSelf.navigationController pushViewController:detailVC animated:YES];
//        SchoolStarDetailVC *detailVC = [[SchoolStarDetailVC alloc]init];
//        detailVC.model = model;
//        detailVC.hidesBottomBarWhenPushed = YES;
//        [weakSelf.navigationController pushViewController:detailVC animated:YES];
    }];
    
    //查看商品
    [self.dataView setSelectedProductCell:^(CZProductVoListModel * _Nonnull model) {
        UIViewController *prodDetailVC = [QSClient instanceProductDetailVCByOptions:@{@"productId":model.productId}];
        [weakSelf.navigationController pushViewController:prodDetailVC animated:YES];
    }];
}

-(void)requestForSchoolStars
{
    WEAKSELF
    QSOrganizerHomeService *service = serviceByType(QSServiceTypeOrganizerHome);
    CZHomeParam *param = [[CZHomeParam alloc] init];
    param.pageNum = @(self.pageIndex);
    param.pageSize = @(10);
    [service requestForApiSportUserGetSportUserTopListByParam:param callBack:^(BOOL success, NSInteger code, id  _Nonnull data, NSString * _Nonnull errorMessage) {
        
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
        
    }];
}


@end

