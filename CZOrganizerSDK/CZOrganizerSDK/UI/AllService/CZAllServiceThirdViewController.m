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
#import "CollectionWaterfallLayout.h"

@interface CZAllServiceThirdViewController ()<CollectionWaterfallLayoutProtocol>

@property (nonatomic ,strong) CZCarefullyChooseView *dataCollectionView;
@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, strong) DropMenuBar *menuScreeningView;

@property (nonatomic, strong)CZCommonFilterManager *manager;
@property (nonatomic, strong) CollectionWaterfallLayout *waterfallLayout;

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
    
//    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
//    CGFloat coverWidth = (screenWidth - 15*3)/2.0;
//
//    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
//    layout.itemSize = CGSizeMake(coverWidth, coverWidth/165.0*220+15);
//    [layout setSectionInset:UIEdgeInsetsMake(0, 15, 0, 15)];
//    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    _waterfallLayout = [[CollectionWaterfallLayout alloc] init];
    _waterfallLayout.delegate = self;
    _waterfallLayout.columns = 2;
//    _waterfallLayout.columnSpacing = 15;
    _waterfallLayout.insets = UIEdgeInsetsMake(15, 15, 15, 15);
    
    self.dataCollectionView = [[CZCarefullyChooseView alloc] initWithFrame:CGRectZero collectionViewLayout:_waterfallLayout];
    self.dataCollectionView.currentVC = self;
    [self.view addSubview:self.dataCollectionView];
    self.dataCollectionView.alwaysBounceVertical = YES;
    [self.dataCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.menuScreeningView.mas_bottom);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    self.pageIndex = 1;
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
    self.menuScreeningView = [self.manager actionsForType:CZCommonFilterTypeServiceThird];
    [self.view addSubview:self.menuScreeningView];
}

#pragma mark - CollectionWaterfallLayoutProtocol
- (CGFloat)collectionViewLayout:(CollectionWaterfallLayout *)layout heightForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CZProductModel *model = self.dataCollectionView.dataArr[indexPath.row];
    CGFloat height = (self.view.bounds.size.width-15*3)/2.0;
    
    CGFloat nameHeight = [model.title boundingRectWithSize:CGSizeMake(height-18, 50) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:14]} context:nil].size.height;
    height += nameHeight+65;
    return height;
}

- (CGFloat)collectionViewLayout:(CollectionWaterfallLayout *)layout heightForSupplementaryViewAtIndexPath:(NSIndexPath *)indexPath
{
    return 0;
}

@end
