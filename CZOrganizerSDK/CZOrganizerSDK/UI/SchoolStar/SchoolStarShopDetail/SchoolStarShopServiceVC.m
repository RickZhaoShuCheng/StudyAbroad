//
//  SchoolStarShopServiceVC.m
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/4/6.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "SchoolStarShopServiceVC.h"
#import "CZAdvisorDetailService.h"
#import "QSCommonService.h"
#import "CZProductVoListModel.h"
#import "CZMJRefreshHelper.h"
#import "QSClient.h"
@interface SchoolStarShopServiceVC ()
@property (nonatomic ,assign) NSInteger pageNum;
@end

@implementation SchoolStarShopServiceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageNum = 1;
    [self initWithUI];
//    [self actionMethod];
    WEAKSELF
//    self.tableView.mj_header = [CZMJRefreshHelper lb_headerWithAction:^{
//        weakSelf.pageNum = 1;
//        [weakSelf requestForApiProductGetProductList];
//    }];
    self.tableView.mj_footer = [CZMJRefreshHelper lb_footerWithAction:^{
        weakSelf.pageNum ++;
        [weakSelf requestForApiProductGetProductList];
    }];
    [self requestForApiProductGetProductList];
    [self.tableView setSelectProductBlock:^(CZProductVoListModel * _Nonnull model) {
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
    [service requestForApiProductGetProductList:@"3" idStr:self.sportUserId pageNum:self.pageNum pageSize:20 callBack:^(BOOL success, NSInteger code, id  _Nonnull data, NSString * _Nonnull errorMessage) {
        if (success){
            dispatch_async(dispatch_get_main_queue(), ^{
                NSMutableArray *array = [[NSMutableArray alloc] init];
                for (NSDictionary *dic in data) {
                    CZProductVoListModel *model = [CZProductVoListModel modelWithDict:dic];
                    [array addObject:model];
                }
                
                if (weakSelf.pageNum == 1) {
                    [weakSelf.tableView.dataArr removeAllObjects];
                    [weakSelf.tableView.dataArr addObjectsFromArray:array];
                }else{
                    [weakSelf.tableView.dataArr addObjectsFromArray:array];
                }
                [weakSelf.tableView reloadData];
                
//                if (weakSelf.pageNum == 1) {
//                    [weakSelf.tableView.mj_header endRefreshing];
//                }
                if (array.count < 20) {
                    [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
                }else{
                    [weakSelf.tableView.mj_footer endRefreshing];
                }
            });
        }
    }];
}

/**
 * 初始化UI
 */
- (void)initWithUI{
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

- (SchoolStarShopServiceTableView *)tableView{
    if (!_tableView) {
        _tableView = [[SchoolStarShopServiceTableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    }
    return _tableView;
}
@end
