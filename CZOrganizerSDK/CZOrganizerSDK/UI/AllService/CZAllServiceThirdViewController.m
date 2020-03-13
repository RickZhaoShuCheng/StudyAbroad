//
//  CZAllServiceThirdViewController.m
//  CZOrganizerSDK
//
//  Created by zsc on 2020/3/7.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZAllServiceThirdViewController.h"
#import "CZCarefullyChooseView.h"
#import "QSCommonService.h"
#import "QSOrganizerHomeService.h"
#import "QSClient.h"
#import "CZMJRefreshHelper.h"
#import "CZProductModel.h"
#import "DropMenuBar.h"
#import "CZCommonFilterManager.h"

@interface CZAllServiceThirdViewController ()

@property (nonatomic ,strong) CZCarefullyChooseView *dataCollectionView;
@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, strong) DropMenuBar *menuScreeningView;

@property (nonatomic, strong)CZCommonFilterManager *manager;

@end

@implementation CZAllServiceThirdViewController
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
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat coverWidth = (screenWidth - 15*3)/2.0;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(coverWidth, coverWidth/165.0*220);
    [layout setSectionInset:UIEdgeInsetsMake(0, 15, 0, 15)];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    self.dataCollectionView = [[CZCarefullyChooseView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.menuScreeningView.frame), self.view.bounds.size.width, self.view.bounds.size.height-CGRectGetMaxY(self.menuScreeningView.frame)) collectionViewLayout:layout];
    self.dataCollectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.dataCollectionView];
    self.dataCollectionView.alwaysBounceVertical = YES;
    [self.dataCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.menuScreeningView.mas_bottom);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-100);
    }];
    
    WEAKSELF
    self.dataCollectionView.mj_header = [CZMJRefreshHelper lb_headerWithAction:^{
        weakSelf.pageIndex = 1;
        [weakSelf requestForProductList];
    }];
    
    self.dataCollectionView.mj_footer = [CZMJRefreshHelper lb_footerWithAction:^{
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
    param.serviceSource = @(1);
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


-(void)createDefaultFilterMenu
{
    self.manager = [[CZCommonFilterManager alloc] init];
    self.menuScreeningView = [self.manager actionsForType:CZCommonFilterTypeCarefulyChoose];
    [self.view addSubview:self.menuScreeningView];
}

@end
