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
#import "DropMenuBar.h"
#import "CZCommonFilterManager.h"
#import "CollectionWaterfallLayout.h"

@interface CZDiaryViewController ()<CollectionWaterfallLayoutProtocol>

@property (nonatomic ,strong) CZDiaryView *dataCollectionView;
@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, strong) CZHomeParam *param;
@property (nonatomic, strong) DropMenuBar *menuScreeningView;
@property (nonatomic, strong)CZCommonFilterManager *manager;
@property (nonatomic, strong) CollectionWaterfallLayout *waterfallLayout;

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
    self.view.backgroundColor = CZColorCreater(245, 245, 249, 1.0);
    
    if (!self.param) {
        self.param = [[CZHomeParam alloc] init];
    }
    self.param.userId = [QSClient userId];
    if (self.model) {
        NSData *data = [self.model.jsonParams dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        self.param.productCategory = dic[@"productCategory"];
    }
    
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
    
    self.dataCollectionView = [[CZDiaryView alloc] initWithFrame:self.view.bounds collectionViewLayout:_waterfallLayout];
    self.dataCollectionView.superVC = self;
    [self.view addSubview:self.dataCollectionView];
    if (!self.model) {
        self.contentScrollView = self.dataCollectionView;
    }
    self.dataCollectionView.alwaysBounceVertical = YES;
    [self.dataCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.menuScreeningView.mas_bottom);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(!self.model?0:-100);
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
//    param.productCategory = @"1";
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

-(void)createDefaultFilterMenu
{
    WEAKSELF
    self.manager = [[CZCommonFilterManager alloc] init];
    self.manager.param = self.param;
    self.menuScreeningView = [self.manager actionsForType:self.model?CZCommonFilterTypeDiary:CZCommonFilterTypeHomeDiary];
    [self.view addSubview:self.menuScreeningView];
    self.manager.selectBlock = ^(CZHomeParam * _Nonnull param) {
        weakSelf.pageIndex = 1;
        [weakSelf requestForDiaryList];
    };
    self.manager.filterViewShow = self.filterViewShow;
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

@end
