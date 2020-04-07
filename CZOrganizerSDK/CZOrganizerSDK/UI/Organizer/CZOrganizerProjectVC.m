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
#import "QSClient.h"

@interface CZOrganizerProjectVC ()
@property (nonatomic ,strong) UIButton *backBtn;//返回按钮
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
        [weakSelf requestForApiProductGetProductList];
    }];
    self.collectionView.mj_footer = [CZMJRefreshHelper lb_footerWithAction:^{
        weakSelf.pageNum ++;
        [weakSelf requestForApiProductGetProductList];
    }];
    if ([self.caseType isEqualToString:@"1"]) {
        self.title = @"全部商品";
    }else{
        self.title = @"全部项目";
    };
    [self requestForApiProductGetProductList];
    [self.collectionView setSelectProductBlock:^(CZProductVoListModel * _Nonnull model) {
        UIViewController *prodDetailVC = [QSClient instanceProductDetailVCByOptions:@{@"productId":model.productId}];
        [weakSelf.navigationController pushViewController:prodDetailVC animated:YES];
    }];
    
}
/**
 获取服务项目
 */
- (void)requestForApiProductGetProductList{
    WEAKSELF
    CZAdvisorDetailService *service = serviceByType(QSServiceTypeAdvisorDetail);
    
    [service requestForApiProductGetProductList:self.caseType idStr:self.idStr pageNum:self.pageNum pageSize:20 callBack:^(BOOL success, NSInteger code, id  _Nonnull data, NSString * _Nonnull errorMessage) {
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
    
    //返回按钮
    self.backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];//baise_fanhui@2x  tong_yong_fan_hui
    [self.backBtn setImage:[CZImageProvider imageNamed:@"tong_yong_fan_hui"] forState:UIControlStateNormal];
    [self.backBtn addTarget:self action:@selector(actionForBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:self.backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    
    
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

//返回
-(void)actionForBack{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
