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
#import "CZAdvisorModel.h"

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
            [weakSelf.navigationController pushViewController:commentsList animated:YES];
        }
    }];
    
    [self.collectionView setClickDynamicBlock:^{
        OrganizerDynamicVC *dynamic = [[OrganizerDynamicVC alloc]init];
        dynamic.model = weakSelf.collectionView.model;
        [weakSelf.navigationController pushViewController:dynamic animated:YES];
    }];
    
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
}

- (void)setOrganId:(NSString *)organId{
    _organId = organId;
    [self requestForApiProductGetOrganRecommendProduct];
    [self requestForApiCounselorGetCounselorListByOrganId];
    [self requestForApiCounselorGetCounselorListByOrganId];
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
                CZOrganizerModel *model = [CZOrganizerModel modelWithDict:data];
                
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
                [weakSelf.collectionView reloadSections:[NSIndexSet indexSetWithIndex:2]];
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
