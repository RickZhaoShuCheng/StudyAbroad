//
//  CZOrganizerDetailViewController.m
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/8.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZOrganizerDetailViewController.h"
#import "CZCommentsListVC.h"
#import "CZOrganizerDynamicVC.h"
#import "QSCommonService.h"
#import "CZAdvisorDetailService.h"
#import "CZProductVoListModel.h"
#import "CZCommentsDetailVC.h"
#import "QSClient.h"
#import "CZOrganizerProjectVC.h"
#import "CZOrganizerAdvisorVC.h"
#import "CZOrganizerDiaryVC.h"
#import "CZAdvisorDetailViewController.h"

@interface CZOrganizerDetailViewController ()
@property (nonatomic ,strong)UIButton *chatBtn;//咨询按钮
@property (nonatomic ,assign) NSInteger commentIndex;
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
    self.commentIndex = 1;
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
            CZOrganizerProjectVC *projectVC = [[CZOrganizerProjectVC alloc]init];
            projectVC.caseType = @"1";
            projectVC.idStr = weakSelf.organId;
            [weakSelf.navigationController pushViewController:projectVC animated:YES];
        }else if (index == 2){
            //顾问团队
            CZOrganizerAdvisorVC *advisorVC = [[CZOrganizerAdvisorVC alloc]init];
            advisorVC.caseType = @"1";
            advisorVC.idStr = weakSelf.organId;
            [weakSelf.navigationController pushViewController:advisorVC animated:YES];
        }else if (index == 3){
            //精华日记
            CZOrganizerDiaryVC *diaryVC = [[CZOrganizerDiaryVC alloc]init];
            diaryVC.caseType = @"1";
            diaryVC.idStr = weakSelf.organId;
            [weakSelf.navigationController pushViewController:diaryVC animated:YES];
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
        CZOrganizerDynamicVC *dynamic = [[CZOrganizerDynamicVC alloc]init];
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
        weakSelf.commentIndex = index +1;
    }];
    //点击评价
    [self.collectionView setSelectCommentBlock:^(CZCommentModel * _Nonnull model) {
        CZCommentsDetailVC *detailVC = [[CZCommentsDetailVC alloc]init];
        detailVC.idStr = model.socId;
        [weakSelf.navigationController pushViewController:detailVC animated:YES];
    }];
    //点击项目
    [self.collectionView setSelectProductBlock:^(CZProductVoListModel * _Nonnull model) {
        UIViewController *prodDetailVC = [QSClient instanceProductDetailVCByOptions:@{@"productId":model.productId}];
        [weakSelf.navigationController pushViewController:prodDetailVC animated:YES];
    }];
    //点击顾问
    [self.collectionView setSelectAdvisorBlock:^(CZAdvisorModel * _Nonnull model) {
        CZAdvisorDetailViewController *detailVC = [[CZAdvisorDetailViewController alloc]init];
        detailVC.counselorId = model.counselorId;
        [weakSelf.navigationController pushViewController:detailVC animated:YES];
    }];
    
    //点击日记
    [self.collectionView setSelectDiaryBlock:^(CZDiaryModel * _Nonnull model) {
        UIViewController *controller = [QSClient instanceDiaryDetailTabVCByOptions:@{@"diaryId":model.smdId}];
        [weakSelf.navigationController pushViewController:controller animated:YES];
    }];
    
    //评价点赞
    [self.collectionView setCommentsPraiseBlock:^(CZCommentModel * _Nonnull model) {
        if ([model.isPraise boolValue]) {
            //已点赞，取消点赞
            [weakSelf requestForApiObjectCommentsPraiseCancelObjectCommentsPraise:model.socId];
        }else{
            //未点赞，进行点赞
            [weakSelf requestForApiObjectCommentsPraiseObjectCommentsPraise:model.socId];
        }
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
评价点赞
*/
- (void)requestForApiObjectCommentsPraiseObjectCommentsPraise:(NSString *)socId{
    WEAKSELF
    CZAdvisorDetailService *service = serviceByType(QSServiceTypeAdvisorDetail);
    [service requestForApiObjectCommentsPraiseObjectCommentsPraise:socId callBack:^(BOOL success, NSInteger code, id  _Nonnull data, NSString * _Nonnull errorMessage) {
        if (success){
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf requestForApiObjectCommentsFindComments:weakSelf.commentIndex];
            });
        }
    }];
}
/**
取消评价点赞
*/
- (void)requestForApiObjectCommentsPraiseCancelObjectCommentsPraise:(NSString *)socId{
    WEAKSELF
    CZAdvisorDetailService *service = serviceByType(QSServiceTypeAdvisorDetail);
    [service requestForApiObjectCommentsPraiseCancelObjectCommentsPraise:socId callBack:^(BOOL success, NSInteger code, id  _Nonnull data, NSString * _Nonnull errorMessage) {
        if (success){
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf requestForApiObjectCommentsFindComments:weakSelf.commentIndex];
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
