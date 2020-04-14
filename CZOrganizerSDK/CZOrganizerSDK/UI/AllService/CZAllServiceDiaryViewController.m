//
//  CZAllServiceDiaryViewController.m
//  CZOrganizerSDK
//
//  Created by zsc on 2020/3/8.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZAllServiceDiaryViewController.h"
#import "CZDiaryView.h"
#import "QSCommonService.h"
#import "QSOrganizerHomeService.h"
#import "QSClient.h"
#import "CZMJRefreshHelper.h"
#import "CZDiaryModel.h"
#import "CZCommonFilterManager.h"
#import "CollectionWaterfallLayout.h"

@interface CZAllServiceDiaryViewController ()<CollectionWaterfallLayoutProtocol>

@property (nonatomic ,strong) CZDiaryView *dataCollectionView;
@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, strong)CZCommonFilterManager *manager;
@property (nonatomic, strong) DropMenuBar *menuScreeningView;
@property (nonatomic, strong) CollectionWaterfallLayout *waterfallLayout;

@end

@implementation CZAllServiceDiaryViewController
@synthesize contentScrollView;
@synthesize canScroll;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self requestForDiaryList];
}

-(void)initUI
{
    self.view.backgroundColor = CZColorCreater(245, 245, 249, 1.0);

    [self createDefaultFilterMenu];
    
//    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
//    CGFloat coverWidth = (screenWidth - 15*3)/2.0;
//
//    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
//    layout.itemSize = CGSizeMake(coverWidth, coverWidth/165.0*294);
//    [layout setSectionInset:UIEdgeInsetsMake(0, 15, 0, 15)];
//    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    _waterfallLayout = [[CollectionWaterfallLayout alloc] init];
    _waterfallLayout.delegate = self;
    _waterfallLayout.columns = 2;
//    _waterfallLayout.columnSpacing = 5;
    _waterfallLayout.insets = UIEdgeInsetsMake(15, 15, 15, 15);
    
    self.dataCollectionView = [[CZDiaryView alloc] initWithFrame:CGRectZero collectionViewLayout:_waterfallLayout];
    self.dataCollectionView.superVC = self;
    [self.view addSubview:self.dataCollectionView];
    self.dataCollectionView.alwaysBounceVertical = YES;
    [self.dataCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(CGRectGetMaxY(self.menuScreeningView.frame));
        make.bottom.mas_equalTo(0);
    }];
    
    self.pageIndex = 1;
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

-(void)requestForDiaryList
{
    WEAKSELF
    QSOrganizerHomeService *service = serviceByType(QSServiceTypeOrganizerHome);
    CZHomeParam *param = [[CZHomeParam alloc] init];
    param.userId = [QSClient userId];
//    param.productCategory = self.model.spId;
    param.pageNum = @(self.pageIndex);
    param.pageSize = @(10);
    [service requestForApiDiaryFindAllCaseListByParam:param callBack:^(BOOL success, NSInteger code, id  _Nonnull data, NSString * _Nonnull errorMessage) {
        
        if (success) {
        
            dispatch_async(dispatch_get_main_queue(), ^{
                
                NSMutableArray *array = [[NSMutableArray alloc] init];
                
//                for (NSDictionary *dic in data) {
//                    CZDiaryModel *model = [CZDiaryModel modelWithDict:dic];
//                    [array addObject:model];
//                }
                
                for (NSInteger index = 0; index < [data count]; index++) {
                    CZDiaryModel *model = [CZDiaryModel modelWithDict:[data objectAtIndex:index]];
                    if (index%4==0||index==3){
                        model.coverHeight = 200;
                    }else{
                        model.coverHeight = 300;
                    }
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

#pragma mark - CollectionWaterfallLayoutProtocol
- (CGFloat)collectionViewLayout:(CollectionWaterfallLayout *)layout heightForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CZDiaryModel *model = self.dataCollectionView.dataArr[indexPath.row];
    CGFloat height = model.coverHeight;
    
    CGFloat nameHeight = [model.smdContent boundingRectWithSize:CGSizeMake(height-18, 50) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:14]} context:nil].size.height;
    height += nameHeight+50;
    return height;
}

- (CGFloat)collectionViewLayout:(CollectionWaterfallLayout *)layout heightForSupplementaryViewAtIndexPath:(NSIndexPath *)indexPath
{
    return 0;
}

-(void)createDefaultFilterMenu
{
    self.manager = [[CZCommonFilterManager alloc] init];
    self.menuScreeningView = [self.manager actionsForType:CZCommonFilterTypeServiceDiary];
    [self.view addSubview:self.menuScreeningView];
}

@end
