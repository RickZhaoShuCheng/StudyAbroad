//
//  CZOrganizerDiaryVC.m
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/11.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZOrganizerDiaryVC.h"
#import "CZOrganizerDiaryCollectionView.h"
#import "CZMJRefreshHelper.h"
#import "CZAdvisorDetailService.h"
#import "QSCommonService.h"
#import "CZDiaryModel.h"

@interface CZOrganizerDiaryVC ()
@property (nonatomic ,strong) CZOrganizerDiaryCollectionView *collectionView;
@property (nonatomic ,assign) NSInteger pageNum;
@end

@implementation CZOrganizerDiaryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageNum = 1;
    [self initWithUI];
    WEAKSELF
    self.collectionView.mj_header = [CZMJRefreshHelper lb_headerWithAction:^{
        weakSelf.pageNum = 1;
        [weakSelf requestForApiDiaryFindCaseListByFilter:1];
    }];
    self.collectionView.mj_footer = [CZMJRefreshHelper lb_footerWithAction:^{
        weakSelf.pageNum ++;
        [weakSelf requestForApiDiaryFindCaseListByFilter:1];
    }];
    [self requestForApiDiaryFindCaseListByFilter:1];
}

/**
 获取日记
 */
- (void)requestForApiDiaryFindCaseListByFilter:(NSInteger)index{
    WEAKSELF
    CZAdvisorDetailService *service = serviceByType(QSServiceTypeAdvisorDetail);
    [service requestForApiDiaryFindCaseListByFilter:@"1" idStr:self.title filterSum:index pageNum:self.pageNum pageSize:20 callBack:^(BOOL success, NSInteger code, id  _Nonnull data, NSString * _Nonnull errorMessage) {
        if (success){
            dispatch_async(dispatch_get_main_queue(), ^{
                NSMutableArray *array = [[NSMutableArray alloc] init];
                
                for (NSDictionary *dic in data[@"data"]) {
                    CZDiaryModel *model = [CZDiaryModel modelWithDict:dic];
                    [array addObject:model];
                }
                
                if (weakSelf.pageNum == 1) {
                    [weakSelf.collectionView.dataArr removeAllObjects];
                    [weakSelf.collectionView.dataArr addObjectsFromArray:array];
                }else{
                    [weakSelf.collectionView.dataArr addObjectsFromArray:array];
                }
                
                NSMutableArray *keyArr = [NSMutableArray array];
                if ([data[@"filterDiary"] length]) {
                    [keyArr addObjectsFromArray:[data[@"filterDiary"] componentsSeparatedByString:@","]];
                }
                
                [weakSelf.collectionView setTagListTags:keyArr];
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
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}
- (CZOrganizerDiaryCollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.sectionHeadersPinToVisibleBounds = YES;
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectionView = [[CZOrganizerDiaryCollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    }
    return _collectionView;
}

@end
