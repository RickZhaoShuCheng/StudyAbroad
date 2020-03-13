//
//  CZOrganizerDetailViewController.m
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/8.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZOrganizerDetailViewController.h"
#import "CZAdvisorDetailService.h"
#import "QSCommonService.h"

@interface CZOrganizerDetailViewController ()
@property (nonatomic ,strong)UIButton *chatBtn;//咨询按钮
@end

@implementation CZOrganizerDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self requestAdvisorDetail];
    WEAKSELF
    //将collectionView滚动值传至主控制器
    [self.collectionView setScrollContentSize:^(CGFloat offsetY) {
        if (weakSelf.scrollContentSize) {
            weakSelf.scrollContentSize(offsetY);
        }
    }];
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

//测试标签
-(void)testTags{
    NSMutableArray *arr = [NSMutableArray array];
    [arr addObject:@"留学5年"];
    [arr addObject:@"擅长澳洲留学问答"];
    [arr addObject:@"留学之家2019年问答排名第一"];
    [arr addObject:@"留学之家2019年问答排名第一"];
    [arr addObject:@"留学5年"];
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
//            [weakSelf testTags];
            //测试筛选项
//            [weakSelf testDiaryFilter];
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
