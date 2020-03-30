//
//  CZOrganizerDetailViewController.m
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/8.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZOrganizerDetailViewController.h"
#import "CZCommentsListVC.h"
#import "OrganizerDynamicVC.h"
#import "QSCommonService.h"
#import "CZAdvisorDetailService.h"
#import "CZProductVoListModel.h"
#import "CZCommentsDetailVC.h"

@interface CZOrganizerDetailViewController ()
@property (nonatomic ,strong)UIButton *chatBtn;//咨询按钮
@end

@implementation CZOrganizerDetailViewController
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.collectionView.headerView.scrollDynamic stopTimer];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.collectionView.headerView.scrollDynamic startTimer];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.collectionView.headerView.scrollDynamic adjustWhenControllerViewWillAppera];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    WEAKSELF
    //将collectionView滚动值传至主控制器
    [self.collectionView setScrollContentSize:^(CGFloat offsetY) {
        if (weakSelf.scrollContentSize) {
            weakSelf.scrollContentSize(offsetY);
        }
    }];
    
    //点击全部事件处理
    [self.collectionView setClickAllBlock:^(NSInteger index) {
        if (index == 1) {
            //为您推荐
        }else if (index == 2){
            //顾问团队
        }else if (index == 3){
            //精华日记
        }else if (index == 4){
            //优秀评价
            CZCommentsListVC *commentsList = [[CZCommentsListVC alloc]init];
            commentsList.idStr = weakSelf.organId;
            commentsList.commentsType = @"1";
            [weakSelf.navigationController pushViewController:commentsList animated:YES];
        }
    }];
    //点击动态
    [self.collectionView setClickDynamicBlock:^{
        OrganizerDynamicVC *dynamic = [[OrganizerDynamicVC alloc]init];
        dynamic.model = weakSelf.collectionView.model;
        [weakSelf.navigationController pushViewController:dynamic animated:YES];
    }];
    
    //日记筛选
    [self.collectionView setSelectDiaryIndex:^(NSInteger index) {
        [weakSelf requestForApiDiaryFindCaseListByFilter:index+1];
    }];
    
    //评价筛选
    [self.collectionView setSelectCommentIndex:^(NSInteger index) {
        [weakSelf requestForApiObjectCommentsFindComments:index+1];
    }];
    //点击评价
    [self.collectionView setSelectCommentBlock:^(CZCommentModel * _Nonnull model) {
        CZCommentsDetailVC *detailVC = [[CZCommentsDetailVC alloc]init];
        detailVC.idStr = model.socId;
        [weakSelf.navigationController pushViewController:detailVC animated:YES];
    }];
}

- (void)setOrganId:(NSString *)organId{
    _organId = organId;
    [self requestForApiCounselorGetCounselorListByOrganId];
    [self requestForApiProductGetOrganRecommendProduct];
    [self requestForApiDiaryFindCaseListByFilter:1];
    [self requestForApiObjectCommentsFindComments:1];
}
/**
 获取服务项目
 */
- (void)requestForApiProductGetOrganRecommendProduct{
    WEAKSELF
    CZAdvisorDetailService *service = serviceByType(QSServiceTypeAdvisorDetail);
    [service requestForApiProductGetOrganRecommendProduct:self.organId pageNum:1 pageSize:20 callBack:^(BOOL success, NSInteger code, id  _Nonnull data, NSString * _Nonnull errorMessage) {
        if (success){
            dispatch_async(dispatch_get_main_queue(), ^{
                NSMutableArray *array = [[NSMutableArray alloc] init];
                for (NSDictionary *dic in data) {
                    CZProductVoListModel *model = [CZProductVoListModel modelWithDict:dic];
                    [array addObject:model];
                }
                weakSelf.collectionView.model.productVoList = array;
                [weakSelf.collectionView reloadData];
            });
        }
    }];
}
/**
获取顾问
*/
- (void)requestForApiCounselorGetCounselorListByOrganId{
    WEAKSELF
    CZAdvisorDetailService *service = serviceByType(QSServiceTypeAdvisorDetail);
    [service requestForApiCounselorGetCounselorListByOrganId:self.organId callBack:^(BOOL success, NSInteger code, id  _Nonnull data, NSString * _Nonnull errorMessage) {
        if (success){
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.collectionView.model.advisorArray = data;
                [weakSelf.collectionView reloadData];
            });
        }
    }];
}

/**
 获取日记
 */
- (void)requestForApiDiaryFindCaseListByFilter:(NSInteger)index{
    WEAKSELF
    CZAdvisorDetailService *service = serviceByType(QSServiceTypeAdvisorDetail);
    [service requestForApiDiaryFindCaseListByFilter:@"1" idStr:self.organId filterSum:index pageNum:1 pageSize:20 callBack:^(BOOL success, NSInteger code, id  _Nonnull data, NSString * _Nonnull errorMessage) {
        if (success){
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.collectionView.model.filterDiary = data[@"filterDiary"];
                weakSelf.collectionView.model.diaryVoList = data[@"data"];
                weakSelf.collectionView.model.diaryCount = data[@"totalSize"];
                [weakSelf.collectionView setDiaryFilter:weakSelf.collectionView.model.filterDiary];
                [weakSelf.collectionView reloadData];
            });
        }
    }];
}
/**
 获取评价
 */
- (void)requestForApiObjectCommentsFindComments:(NSInteger)index{
    WEAKSELF
    CZAdvisorDetailService *service = serviceByType(QSServiceTypeAdvisorDetail);
    [service requestForApiObjectCommentsFindComments:@"1" idStr:self.organId filterSum:index pageNum:1 pageSize:20 callBack:^(BOOL success, NSInteger code, id  _Nonnull data, NSString * _Nonnull errorMessage) {
       if (success){
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.collectionView.model.filterComment = data[@"filterComment"];
                weakSelf.collectionView.model.commentList = data[@"list"];
                weakSelf.collectionView.model.commentsCount = data[@"totalSize"];
                [weakSelf.collectionView setCommentFilter:weakSelf.collectionView.model.filterComment];
                [weakSelf.collectionView reloadData];
            });
        }
    }];
}
/**
 加载UI
 */
-(void)initUI{
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view.mas_top);
        make.bottom.mas_equalTo(self.view);
    }];
}

- (CZOrganizerDetailCollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.sectionHeadersPinToVisibleBounds = YES;
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;

        _collectionView = [[CZOrganizerDetailCollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    }
    return _collectionView;
}
@end
