//
//  CZCarefullyChooseViewController.m
//  CZOrganizerSDK
//
//  Created by zsc on 2020/2/21.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZCarefullyChooseViewController.h"
#import "CZCarefullyChooseView.h"
#import "QSCommonService.h"
#import "QSOrganizerHomeService.h"
#import "QSClient.h"
#import "CZMJRefreshHelper.h"
#import "CZProductModel.h"

@interface CZCarefullyChooseViewController ()

@property (nonatomic ,strong) CZCarefullyChooseView *dataCollectionView;
@property (nonatomic, assign) NSInteger pageIndex;

@end

@implementation CZCarefullyChooseViewController
@synthesize contentScrollView;
@synthesize canScroll;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self requestForCarefullyChoose];
}

-(void)initUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat coverWidth = (screenWidth - 15*3)/2.0;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(coverWidth, coverWidth/165.0*233);
    [layout setSectionInset:UIEdgeInsetsMake(0, 15, 0, 15)];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    self.dataCollectionView = [[CZCarefullyChooseView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    self.dataCollectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.dataCollectionView];
    self.contentScrollView = self.dataCollectionView;
    self.dataCollectionView.alwaysBounceVertical = YES;
    
    WEAKSELF
    self.dataCollectionView.mj_header = [CZMJRefreshHelper lb_headerWithAction:^{
        weakSelf.pageIndex = 0;
        [weakSelf requestForCarefullyChoose];
    }];
    
    self.dataCollectionView.mj_footer = [CZMJRefreshHelper lb_footerWithAction:^{
        weakSelf.pageIndex += 1;
        [weakSelf requestForCarefullyChoose];
    }];
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.dataCollectionView.frame = self.view.bounds;
}

-(void)requestForCarefullyChoose
{
    WEAKSELF
    QSOrganizerHomeService *service = serviceByType(QSServiceTypeOrganizerHome);
    CZHomeParam *param = [[CZHomeParam alloc] init];
    param.userId = [QSClient userId];
    param.serviceSource = @(1);
    param.pageNum = @(0);
    param.pageSize = @(10);
    [service requestForApiProductGetDefaultProductListByParam:param callBack:^(BOOL success, NSInteger code, id  _Nonnull data, NSString * _Nonnull errorMessage) {
        
        if (success) {
        
            dispatch_async(dispatch_get_main_queue(), ^{
                
                NSMutableArray *array = [[NSMutableArray alloc] init];
                
                for (NSDictionary dic in data) {
                    CZProductModel *model = [CZProductModel modelWithDict:dic];
                    [array addObject:data];
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