//
//  CZAdvisorDetailViewController.m
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/4.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZAdvisorDetailViewController.h"
#import "CZAdvisorDetailCollectionView.h"
#import "CZAdvisorDetailService.h"
#import "QSCommonService.h"
#import "CZAdvisorInfoModel.h"
#import "CZCommentsListVC.h"
#import "CZOrganizerVC.h"
#import "AdvisorDynamicVC.h"

@interface CZAdvisorDetailViewController ()
@property (nonatomic ,strong)CZAdvisorDetailCollectionView *collectionView;
@property (nonatomic ,strong)UILabel *titleLab;//标题
@property (nonatomic ,strong)UIButton *backBtn;//返回按钮
@property (nonatomic ,strong)UIButton *shareBtn;//分享按钮
@property (nonatomic ,strong)UIButton *chatBtn;//咨询按钮
@property (nonatomic ,assign) NSInteger pageNo;
@property (nonatomic ,assign) NSInteger pageSize;
@property (nonatomic ,assign) CGFloat alpha;

@end

@implementation CZAdvisorDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.alpha = 0;
    self.pageNo = 1;
    self.pageSize = 20;
    [self initUI];
    [self actionMethod];
    [self requestAdvisorDetail];
    [self requestForApiDiaryFindCaseListByFilter:1];
    [self requestForApiObjectCommentsFindComments:1];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar.subviews.firstObject setAlpha:self.alpha];
    [self.titleLab setAlpha:self.alpha];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.titleLab setAlpha:self.alpha];
}

- (void)actionMethod{
    WEAKSELF
    //点击全部事件处理
    [self.collectionView setClickAllBlock:^(NSInteger index) {
        if (index == 1) {
            //服务项目
        }else if (index == 2){
            //精华日记
        }else if (index == 3){
            //优秀评价
            CZCommentsListVC *commentsList = [[CZCommentsListVC alloc]init];
            [weakSelf.navigationController pushViewController:commentsList animated:YES];
        }
    }];
    
    //点击定位事件处理
    [self.collectionView setLocationClick:^{
        CZOrganizerVC *organizerVC = [[CZOrganizerVC alloc]init];
        organizerVC.organId = weakSelf.collectionView.model.organId;
        organizerVC.hidesBottomBarWhenPushed = YES;
        [weakSelf.navigationController pushViewController:organizerVC animated:YES];
    }];
    
    //点击动态事件处理
    [self.collectionView setDynamicClick:^{
        AdvisorDynamicVC *dynamicVC = [[AdvisorDynamicVC alloc]init];
        dynamicVC.model = weakSelf.collectionView.model;
        [weakSelf.navigationController pushViewController:dynamicVC animated:YES];
    }];
    
    //日记筛选
    [self.collectionView setSelectDiaryIndex:^(NSInteger index) {
        [weakSelf requestForApiDiaryFindCaseListByFilter:index+1];
    }];
    
    //滚动时设置导航条透明度
    [self.collectionView setScrollContentSize:^(CGFloat offsetY) {
        //设置渐变透明度
        CGFloat alpha = (offsetY / NaviH)>0.99?0.99:(offsetY / NaviH);
        weakSelf.alpha = alpha;
        [weakSelf.navigationController.navigationBar.subviews.firstObject setAlpha:alpha];
        weakSelf.titleLab.alpha = alpha;
        weakSelf.titleLab.textColor = [UIColor blackColor];
        if (alpha >0.5) {
            [weakSelf.backBtn setImage:[CZImageProvider imageNamed:@"tong_yong_fan_hui"] forState:UIControlStateNormal];
            [weakSelf.shareBtn setImage:[CZImageProvider imageNamed:@"heise_fenxiang"] forState:UIControlStateNormal];
        }else{
            [weakSelf.backBtn setImage:[CZImageProvider imageNamed:@"baise_fanhui"] forState:UIControlStateNormal];
            [weakSelf.shareBtn setImage:[CZImageProvider imageNamed:@"guwen_fenxiang"] forState:UIControlStateNormal];
        }
        //判断是否改变
        if (offsetY < 0) {
            CGRect rect = weakSelf.collectionView.headerView.bgImg.frame;
            //改变图片的y值和高度即可
            rect.origin.y = offsetY;
            rect.size.height = ScreenScale(540)+weakSelf.collectionView.tagListHeight - offsetY;
            weakSelf.collectionView.headerView.bgImg.frame = rect;
        }
        
        //悬浮
        CGFloat header = weakSelf.collectionView.headerView.frame.size.height;//这个header其实是section1 的header到顶部的距离（一般为: tableHeaderView的高度）
        if (offsetY < (header - (NaviH+StatusBarHeight+5)) && offsetY >= 0) {
            //当视图滑动的距离小于header时
            weakSelf.collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        }else if(weakSelf.collectionView.contentOffset.y >= (header - (NaviH+StatusBarHeight+5))){
            //当视图滑动的距离大于header时，这里就可以设置section1的header的位置啦，设置的时候要考虑到导航栏的透明对滚动视图的影响
        weakSelf.collectionView.contentInset = UIEdgeInsetsMake(NaviH+StatusBarHeight+5, 0, 0, 0);
        }
    }];
}
//测试标签
-(void)testTags{
    NSMutableArray *arr = [NSMutableArray array];
    [arr addObject:@"留学5年"];
    [arr addObject:@"擅长澳洲留学问答"];
    [arr addObject:@"留学之家2019年问答排名第一"];
    [arr addObject:@"留学之家2019年问答排名第一"];

    [self.collectionView.headerView setTags:arr];
    CGRect frame = self.collectionView.headerView.bgImg.frame;
    CGFloat maxY = self.collectionView.headerView.tagList.frame.origin.y + self.collectionView.headerView.tagList.frame.size.height;
    if (maxY >= self.collectionView.headerView.bgImg.frame.size.height) {
        frame.size.height = frame.size.height + self.collectionView.headerView.tagList.contentHeight;
        self.collectionView.tagListHeight = self.collectionView.headerView.tagList.contentHeight;
        self.collectionView.headerView.bgImg.frame = frame;
        [self.collectionView reloadData];
    }
}

/**
 获取顾问详情
 */
- (void)requestAdvisorDetail{
    WEAKSELF
    CZAdvisorDetailService *service = serviceByType(QSServiceTypeAdvisorDetail);
    [service requestForApiCounselorGetCounselorDetails:self.counselorId callBack:^(BOOL success, NSInteger code, id  _Nonnull data, NSString * _Nonnull errorMessage) {
         if (success){
             dispatch_async(dispatch_get_main_queue(), ^{
                 
                 CZAdvisorInfoModel *model = [CZAdvisorInfoModel modelWithDict:data];
//                 model.keywords = @"哈哈哈,askdh,卡对接开发,按时肯定会焚枯食淡,askdh,卡对接开发,按时肯定会焚枯食淡";
                 weakSelf.collectionView.model = model;
                 weakSelf.titleLab.text = model.counselorName;
                 [weakSelf requestAdvisorProduct];
             });
         }
    }];
}

/**
 获取服务项目
 */
- (void)requestAdvisorProduct{
    WEAKSELF
    CZAdvisorDetailService *service = serviceByType(QSServiceTypeAdvisorDetail);
    [service requestForApiProductGetCounselorRecommendProduct:self.counselorId pageNum:self.pageNo pageSize:self.pageSize callBack:^(BOOL success, NSInteger code, id  _Nonnull data, NSString * _Nonnull errorMessage) {
        if (success){
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.collectionView.model.productVoList = data;
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
    [service requestForApiDiaryFindCaseListByFilter:@"2" idStr:self.counselorId filterSum:index pageNum:self.pageNo pageSize:self.pageSize callBack:^(BOOL success, NSInteger code, id  _Nonnull data, NSString * _Nonnull errorMessage) {
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
    [service requestForApiObjectCommentsFindComments:@"2" idStr:self.counselorId filterSum:index pageNum:self.pageNo pageSize:self.pageSize callBack:^(BOOL success, NSInteger code, id  _Nonnull data, NSString * _Nonnull errorMessage) {
       if (success){
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.collectionView.model.filterComment = data[@"filterComment"];
                weakSelf.collectionView.model.commentList = data[@"list"];
                weakSelf.collectionView.model.commentsCount = data[@"totalSize"];
                [weakSelf.collectionView setDiaryFilter:weakSelf.collectionView.model.filterComment];
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
    //返回按钮
    self.backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];//baise_fanhui@2x  tong_yong_fan_hui
    [self.backBtn setImage:[CZImageProvider imageNamed:@"baise_fanhui"] forState:UIControlStateNormal];
    [self.backBtn addTarget:self action:@selector(actionForBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:self.backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    
    //右边按钮
    self.shareBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];//heise_fenxiang@2x   guwen_fenxiang
    [self.shareBtn setImage:[CZImageProvider imageNamed:@"guwen_fenxiang"] forState:UIControlStateNormal];
    [self.shareBtn addTarget:self action:@selector(rbackItemClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rbackItem = [[UIBarButtonItem alloc]initWithCustomView:self.shareBtn];
    self.navigationItem.rightBarButtonItem = rbackItem;
    //导航透明
    self.edgesForExtendedLayout = UIRectEdgeTop;
//    self.navigationController.navigationBar.translucent = YES;
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar.subviews.firstObject setAlpha:0.0];
    
    self.titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    self.titleLab.textAlignment = NSTextAlignmentCenter;
    self.titleLab.textColor = [UIColor clearColor];
    [self.navigationItem setTitleView:self.titleLab];
    
    UIView *bottomView = [[UIView alloc]init];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(ScreenScale(140));
    }];
    
    self.chatBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.chatBtn.layer.masksToBounds = YES;
    self.chatBtn.layer.cornerRadius = ScreenScale(80)/2.0;
    [self.chatBtn setBackgroundColor:CZColorCreater(51, 172, 253, 1)];
    [self.chatBtn setTitle:@"咨询一下" forState:UIControlStateNormal];
    [self.chatBtn setTitleColor:CZColorCreater(255, 255, 255, 1) forState:UIControlStateNormal];
    [self.chatBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:ScreenScale(30)]];
    [self.chatBtn setImage:[CZImageProvider imageNamed:@"guwen_xiaoxi"] forState:UIControlStateNormal];
    [self.chatBtn setImage:[CZImageProvider imageNamed:@"guwen_xiaoxi"] forState:UIControlStateHighlighted];
    [self.chatBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, ScreenScale(14))];
    [bottomView addSubview:self.chatBtn];
    [self.chatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bottomView);
        make.height.mas_equalTo(ScreenScale(80));
        make.width.mas_equalTo(ScreenScale(690));
        make.top.mas_equalTo(bottomView.mas_top);
    }];
    
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.mas_equalTo(self.view);
        make.leading.trailing.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view.mas_top).offset(-(NaviH+StatusBarHeight+5));
        make.bottom.mas_equalTo(bottomView.mas_top);
    }];

}

- (CZAdvisorDetailCollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.sectionHeadersPinToVisibleBounds = YES;
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;

        _collectionView = [[CZAdvisorDetailCollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    }
    return _collectionView;
}
- (void)rbackItemClick{
    [self testTags];
}

//返回
-(void)actionForBack{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
