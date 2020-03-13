//
//  CZOrganizerListViewController.m
//  CZOrganizerSDK
//
//  Created by zsc on 2020/3/1.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZOrganizerListViewController.h"
#import "CZOrganizerListView.h"
#import "CZMJRefreshHelper.h"
#import "QSOrganizerHomeService.h"
#import "QSCommonService.h"
#import "QSClient.h"
#import "CZOrganizerModel.h"
#import "CZAdvisorDetailViewController.h"
#import "CZOrganizerDetailViewController.h"
#import "CZOrganizerVC.h"

@interface CZOrganizerListViewController ()

@property (nonatomic ,strong) CZOrganizerListView *dataView;
@property (nonatomic, assign) NSInteger pageIndex;

@end

@implementation CZOrganizerListViewController
@synthesize contentScrollView;
@synthesize canScroll;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self requestForOrganizers];
}

-(void)initUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    
//    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
//    CGFloat coverWidth = (screenWidth - 15*3)/2.0;
//    
//    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
//    layout.itemSize = CGSizeMake(coverWidth, coverWidth/165.0*294);
//    [layout setSectionInset:UIEdgeInsetsMake(0, 15, 0, 15)];
//    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    self.dataView = [[CZOrganizerListView alloc] init];
    self.dataView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.dataView];
    if (!self.model) {
        self.contentScrollView = self.dataView;
    }
    [self.dataView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(!self.model?0:-100);
    }];
//    self.dataView.alwaysBounceVertical = YES;
    
    WEAKSELF
    self.dataView.mj_header = [CZMJRefreshHelper lb_headerWithAction:^{
        weakSelf.pageIndex = 1;
        [weakSelf requestForOrganizers];
    }];
    
    self.dataView.mj_footer = [CZMJRefreshHelper lb_footerWithAction:^{
        weakSelf.pageIndex += 1;
        [weakSelf requestForOrganizers];
    }];
    
    //点击cell
    self.dataView.selectedBlock = ^(NSString * _Nonnull organId) {
        CZOrganizerVC *organizerVC = [[CZOrganizerVC alloc]init];
        organizerVC.organId = organId;
        organizerVC.hidesBottomBarWhenPushed = YES;
        [weakSelf.navigationController pushViewController:organizerVC animated:YES];
    };
}

-(void)requestForOrganizers
{
    WEAKSELF
    QSOrganizerHomeService *service = serviceByType(QSServiceTypeOrganizerHome);
    CZHomeParam *param = [[CZHomeParam alloc] init];
    param.userId = [QSClient userId];
    param.pageNum = @(self.pageIndex);
    param.pageSize = @(10);
    [service requestForApiOrganGetOrganListByFilterByParam:param callBack:^(BOOL success, NSInteger code, id  _Nonnull data, NSString * _Nonnull errorMessage) {
        
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

