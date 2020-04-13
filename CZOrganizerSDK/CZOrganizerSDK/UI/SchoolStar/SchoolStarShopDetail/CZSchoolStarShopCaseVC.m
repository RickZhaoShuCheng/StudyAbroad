//
//  SchoolStarShopCaseVC.m
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/4/6.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZSchoolStarShopCaseVC.h"
#import "CZCaseModel.h"
#import "QSCommonService.h"
#import "CZAdvisorDetailService.h"
#import "CZMJRefreshHelper.h"
#import "QSClient.h"
@interface CZSchoolStarShopCaseVC ()
@property (nonatomic ,assign) NSInteger pageNum;
@end

@implementation CZSchoolStarShopCaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageNum = 1;
    [self initWithUI];
    [self actionMethod];
    [self requestForApiDiarySelectCaseList];
}

- (void)actionMethod{
    WEAKSELF
    self.collectionView.mj_footer = [CZMJRefreshHelper  lb_footerWithAction:^{
        weakSelf.pageNum ++;
        [weakSelf requestForApiDiarySelectCaseList];
    }];
    //点击案例
    [self.collectionView setSelectCaseBlock:^(CZCaseModel * _Nonnull model) {
        UIViewController *controller = [QSClient instanceDiaryDetailTabVCByOptions:@{@"diaryId":model.smdId}];
        [weakSelf.superVC.navigationController pushViewController:controller animated:YES];
    }];
}

- (void)requestForApiDiarySelectCaseList{
    WEAKSELF
    CZAdvisorDetailService *service = [QSCommonService service:QSServiceTypeAdvisorDetail];
    [service requestForApiDiarySelectCaseList:@"" counselorId:@"" sportUserId:self.sportUserId pageNum:self.pageNum pageSize:20 callBack:^(BOOL success, NSInteger code, id  _Nonnull data, NSString * _Nonnull errorMessage) {
        if (success) {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSMutableArray *tempArr = [NSMutableArray array];
                for (NSDictionary *dic in data) {
                    CZCaseModel *model = [CZCaseModel modelWithDict:dic];
                    [tempArr addObject:model];
                }
                
                if (weakSelf.pageNum == 1) {
                    [weakSelf.collectionView.dataArr removeAllObjects];
                    [weakSelf.collectionView.dataArr addObjectsFromArray:tempArr];
                }else{
                    [weakSelf.collectionView.dataArr addObjectsFromArray:tempArr];
                }
                [weakSelf.collectionView reloadData];
//                if (weakSelf.pageNum == 1) {
//                    [weakSelf.tableView.mj_header endRefreshing];
//                }
                if (tempArr.count < 20) {
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
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}
- (CZSchoolStarShopCaseCollectionView *)collectionView{
       if (!_collectionView) {
           UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
           layout.sectionHeadersPinToVisibleBounds = YES;
           layout.scrollDirection = UICollectionViewScrollDirectionVertical;
           _collectionView = [[CZSchoolStarShopCaseCollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
       }
       return _collectionView;
   }
@end
