//
//  CZOrganizerProjectVC.m
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/11.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZOrganizerProjectVC.h"
#import "CZOrganizerProjectCollectionView.h"
#import "CZMJRefreshHelper.h"
#import "CZAdvisorDetailService.h"
#import "QSCommonService.h"
#import "CZProductVoListModel.h"

@interface CZOrganizerProjectVC ()
@property (nonatomic ,strong) CZOrganizerProjectCollectionView *collectionView;
@property (nonatomic ,assign) NSInteger pageNum;
@end

@implementation CZOrganizerProjectVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initWithUI];
    self.pageNum = 1;
    WEAKSELF
    self.collectionView.mj_header = [CZMJRefreshHelper lb_headerWithAction:^{
        weakSelf.pageNum = 1;
        [weakSelf requestForApiProductGetOrganRecommendProduct];
    }];
    self.collectionView.mj_footer = [CZMJRefreshHelper lb_footerWithAction:^{
        weakSelf.pageNum ++;
        [weakSelf requestForApiProductGetOrganRecommendProduct];
    }];
    [self requestForApiProductGetOrganRecommendProduct];
}
/**
 获取服务项目
 */
- (void)requestForApiProductGetOrganRecommendProduct{
    WEAKSELF
    CZAdvisorDetailService *service = serviceByType(QSServiceTypeAdvisorDetail);
    [service requestForApiProductGetOrganRecommendProduct:self.title pageNum:self.pageNum pageSize:20 callBack:^(BOOL success, NSInteger code, id  _Nonnull data, NSString * _Nonnull errorMessage) {
        if (success){
            dispatch_async(dispatch_get_main_queue(), ^{
                NSMutableArray *array = [[NSMutableArray alloc] init];
                for (NSDictionary *dic in data) {
                    CZProductVoListModel *model = [CZProductVoListModel modelWithDict:dic];
                    [array addObject:model];
                }
                
                if (weakSelf.pageNum == 1) {
                    [weakSelf.collectionView.dataArr removeAllObjects];
                    [weakSelf.collectionView.dataArr addObjectsFromArray:array];
                }else{
                    [weakSelf.collectionView.dataArr addObjectsFromArray:array];
                }
                [weakSelf.collectionView reloadData];
                
                if (weakSelf.pageNum == 1) {
                    [weakSelf.collectionView.mj_header endRefreshing];
                }
                if (array.count < 20) {
                    [weakSelf.collectionView.mj_footer endRefreshingWithNoMoreData];
                }else{
                    [weakSelf.collectionView.mj_footer endRefreshing];
                }
            });
        }
    }];
}


/**
 * 初始化UI
 */
- (void)initWithUI{
    self.view.backgroundColor = CZColorCreater(245, 245, 249, 1);
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}
- (CZOrganizerProjectCollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.sectionHeadersPinToVisibleBounds = YES;
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;

        _collectionView = [[CZOrganizerProjectCollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    }
    return _collectionView;
}
@end
