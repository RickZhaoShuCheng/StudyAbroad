//
//  CZDiaryViewController.m
//  CZOrganizerSDK
//
//  Created by zsc on 2020/2/29.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZDiaryViewController.h"
#import "CZDiaryView.h"
#import "QSCommonService.h"
#import "QSOrganizerHomeService.h"
#import "QSClient.h"
#import "CZMJRefreshHelper.h"
#import "CZDiaryModel.h"

@interface CZDiaryViewController ()

@property (nonatomic ,strong) CZDiaryView *dataCollectionView;
@property (nonatomic, assign) NSInteger pageIndex;

@end

@implementation CZDiaryViewController
@synthesize contentScrollView;
@synthesize canScroll;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self requestForDiaryList];
}

-(void)initUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat coverWidth = (screenWidth - 15*3)/2.0;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(coverWidth, coverWidth/165.0*294);
    [layout setSectionInset:UIEdgeInsetsMake(0, 15, 0, 15)];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    self.dataCollectionView = [[CZDiaryView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    self.dataCollectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.dataCollectionView];
    if (!self.model) {
        self.contentScrollView = self.dataCollectionView;
    }
    self.dataCollectionView.alwaysBounceVertical = YES;
    [self.dataCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    WEAKSELF
    self.dataCollectionView.mj_header = [CZMJRefreshHelper lb_headerWithAction:^{
        weakSelf.pageIndex = 1;
        [weakSelf requestForDiaryList];
    }];
    
    self.dataCollectionView.mj_footer = [CZMJRefreshHelper lb_footerWithAction:^{
        weakSelf.pageIndex += 1;
        [weakSelf requestForDiaryList];
    }];
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.dataCollectionView.frame = self.view.bounds;
}

-(void)requestForDiaryList
{
    WEAKSELF
    QSOrganizerHomeService *service = serviceByType(QSServiceTypeOrganizerHome);
    CZHomeParam *param = [[CZHomeParam alloc] init];
    param.userId = [QSClient userId];
//    param.productCategory = @"1";
    param.pageNum = @(self.pageIndex);
    param.pageSize = @(10);
    [service requestForApiDiaryFindAllCaseListByParam:param callBack:^(BOOL success, NSInteger code, id  _Nonnull data, NSString * _Nonnull errorMessage) {
        
        if (success) {
        
            dispatch_async(dispatch_get_main_queue(), ^{
                
                NSMutableArray *array = [[NSMutableArray alloc] init];
                
                for (NSDictionary *dic in data) {
                    CZDiaryModel *model = [CZDiaryModel modelWithDict:dic];
                    [array addObject:model];
                }
                
                [weakSelf.dataCollectionView.mj_header endRefreshing];
                
                if (weakSelf.pageIndex == 1) {
                    [weakSelf.dataCollectionView.dataArr removeAllObjects];
                    [weakSelf.dataCollectionView.dataArr addObjectsFromArray:array];
                }
                else
                {
                    [weakSelf.dataCollectionView.dataArr addObjectsFromArray:array];
                }
                
                if (array.count < 10) {
                    [weakSelf.dataCollectionView.mj_footer endRefreshingWithNoMoreData];
                }
                else
                {
                    [weakSelf.dataCollectionView.mj_footer endRefreshing];
                }
                
                [weakSelf.dataCollectionView reloadData];
                
                if (self.dataCollectionView.dataArr.count > 0) {
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
