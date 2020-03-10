//
//  CZOrganizerDetailViewController.m
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/8.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZOrganizerDetailViewController.h"
#import "CZOrganizerDetailCollectionView.h"
#import "CZAdvisorDetailService.h"
#import "QSCommonService.h"

@interface CZOrganizerDetailViewController ()
@property (nonatomic ,strong)CZOrganizerDetailCollectionView *collectionView;
@property (nonatomic ,strong)UILabel *titleLab;//标题
@property (nonatomic ,strong)UIButton *backBtn;//返回按钮
@property (nonatomic ,strong)UIButton *shareBtn;//分享按钮
@property (nonatomic ,strong)UIButton *chatBtn;//咨询按钮
@end

@implementation CZOrganizerDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self actionMethod];
    [self requestAdvisorDetail];
}

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

- (void)actionMethod{
    WEAKSELF
    //滚动时设置导航条透明度
    [self.collectionView setScrollContentSize:^(CGFloat offsetY) {
        //设置渐变透明度
        CGFloat alpha = (offsetY / NaviH)>0.99?0.99:(offsetY / NaviH);
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
            rect.size.height = HeightRatio(540)+weakSelf.collectionView.tagListHeight - offsetY;
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
//测试筛选项
- (void)testDiaryFilter{
    NSMutableArray *arr = [NSMutableArray array];
    [arr addObject:@"全部"];
    [arr addObject:@"最新"];
    [arr addObject:@"好评 50"];
    [arr addObject:@"消费后评价 38"];
    [self.collectionView.diaryFilterArr removeAllObjects];
    [self.collectionView.diaryFilterArr addObjectsFromArray:arr];
    
    NSMutableArray *arr1 = [NSMutableArray array];
    [arr1 addObject:@"全部"];
    [arr1 addObject:@"最新"];
    [arr1 addObject:@"好评 80"];
    [arr1 addObject:@"消费后评价 128"];
    [self.collectionView.evaluateFilterArr removeAllObjects];
    [self.collectionView.evaluateFilterArr addObjectsFromArray:arr1];
    
}

/**
 获取顾问详情
 */
- (void)requestAdvisorDetail{
    WEAKSELF
    CZAdvisorDetailService *service = serviceByType(QSServiceTypeAdvisorDetail);
    [service requestForApiCounselorGetCounselorDetails:@"95c23cee471b41a69cb181e31e7dc561" callBack:^(BOOL success, NSInteger code, id  _Nonnull data, NSString * _Nonnull errorMessage) {
        //测试
        dispatch_sync(dispatch_get_main_queue(), ^{
            ///展示个人标签
            [weakSelf testTags];
            //测试筛选项
            [weakSelf testDiaryFilter];
            //测试评价图片
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            NSMutableArray *tempArr = [NSMutableArray array];
            [tempArr addObject:@"http://pic1.win4000.com/wallpaper/c/57ad6e8f410eb.jpg"];
            [tempArr addObject:@"http://up.enterdesk.com/edpic/c3/84/b0/c384b0e8f05432c78c72f8d0cd1ab9ac.jpg"];
            [dic setValue:tempArr forKey:@"pics"];
            
            NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
            NSMutableArray *tempArr1 = [NSMutableArray array];
            [tempArr1 addObject:@"http://uploadfile.bizhizu.cn/2015/0720/20150720033105173.jpg.source.jpg"];
            [tempArr1 addObject:@"http://pic1.win4000.com/wallpaper/2018-10-12/5bc00af5751a2.jpg"];
            [tempArr1 addObject:@"http://uploadfile.bizhizu.cn/2015/0720/20150720033105173.jpg.source.jpg"];
            [tempArr1 addObject:@"http://pic1.win4000.com/wallpaper/2018-10-12/5bc00af5751a2.jpg"];
            [dic1 setValue:tempArr1 forKey:@"pics"];
            
            NSMutableDictionary *dic2 = [NSMutableDictionary dictionary];
            NSMutableArray *tempArr2 = [NSMutableArray array];
            [dic2 setValue:tempArr2 forKey:@"pics"];
                       
            [weakSelf.collectionView.evaluateArr addObject:dic];
            [weakSelf.collectionView.evaluateArr addObject:dic1];
            [weakSelf.collectionView.evaluateArr addObject:dic2];
            [weakSelf.collectionView reloadData];
        });
        
         if (success){
             dispatch_async(dispatch_get_main_queue(), ^{
                 NSMutableArray *array = [[NSMutableArray alloc] init];
//                 for (NSDictionary *dic in data) {
//                     CZAdvisorModel *model = [CZAdvisorModel modelWithDict:dic];
//                     [array addObject:model];
//                 }
//
//                 [weakSelf.dataView.mj_header endRefreshing];
//
//                 if (weakSelf.pageIndex == 1) {
//                     [weakSelf.dataView.dataArr removeAllObjects];
//                     [weakSelf.dataView.dataArr addObjectsFromArray:array];
//                 }
//                 else
//                 {
//                     [weakSelf.dataView.dataArr addObjectsFromArray:array];
//                 }
//
//                 if (array.count < 10) {
//                     [weakSelf.dataView.mj_footer endRefreshingWithNoMoreData];
//                 }
//                 else
//                 {
//                     [weakSelf.dataView.mj_footer endRefreshing];
//                 }
//
//                 [weakSelf.dataView reloadData];
//
//                 if (self.dataView.dataArr.count > 0) {
// //                    [self.dataTableView hideNoData];
//                 }
//                 else
//                 {
// //                    [self.dataTableView showNodataView];
//                 }
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
    self.titleLab.text = @"机构详情";
    self.titleLab.textAlignment = NSTextAlignmentCenter;
    self.titleLab.textColor = [UIColor clearColor];
    [self.navigationItem setTitleView:self.titleLab];
    
    UIView *bottomView = [[UIView alloc]init];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(HeightRatio(140));
    }];
    
    self.chatBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.chatBtn.layer.masksToBounds = YES;
    self.chatBtn.layer.cornerRadius = HeightRatio(80)/2.0;
    [self.chatBtn setBackgroundColor:CZColorCreater(51, 172, 253, 1)];
    [self.chatBtn setTitle:@"咨询一下" forState:UIControlStateNormal];
    [self.chatBtn setTitleColor:CZColorCreater(255, 255, 255, 1) forState:UIControlStateNormal];
    [self.chatBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:WidthRatio(30)]];
    [self.chatBtn setImage:[CZImageProvider imageNamed:@"guwen_xiaoxi"] forState:UIControlStateNormal];
    [self.chatBtn setImage:[CZImageProvider imageNamed:@"guwen_xiaoxi"] forState:UIControlStateHighlighted];
    [self.chatBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, WidthRatio(14))];
    [bottomView addSubview:self.chatBtn];
    [self.chatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bottomView);
        make.height.mas_equalTo(HeightRatio(80));
        make.width.mas_equalTo(WidthRatio(690));
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

- (CZOrganizerDetailCollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.sectionHeadersPinToVisibleBounds = YES;
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;

        _collectionView = [[CZOrganizerDetailCollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    }
    return _collectionView;
}
- (void)rbackItemClick{
    [self testTags];
    [self testDiaryFilter];
}

//返回
-(void)actionForBack{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
