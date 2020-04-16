//
//  SchoolStarShopServiceVC.m
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/4/6.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZSchoolStarShopServiceVC.h"
#import "CZAdvisorDetailService.h"
#import "QSCommonService.h"
#import "CZProductVoListModel.h"
#import "CZMJRefreshHelper.h"
#import "QSClient.h"
@interface CZSchoolStarShopServiceVC ()
@property (nonatomic ,assign) NSInteger pageNum;
@end

@implementation CZSchoolStarShopServiceVC

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
        [weakSelf.superVC.navigationController pushViewController:prodDetailVC animated:YES];
    }];
    [self.tableView setClickCartBlock:^(CZProductVoListModel * _Nonnull model) {
        [weakSelf requestForApiShoppingCartAddShoppingCart:model];
    }];
    [self.tableView setClickBuyBlock:^(CZProductVoListModel * _Nonnull model) {
        
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
                    CGFloat height = [self getStringHeightWithText:model.desc font:[UIFont systemFontOfSize:ScreenScale(26)] viewWidth:kScreenWidth - ScreenScale(60)];
                    model.descHeight = height;
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
 加入购物车
 */
- (void)requestForApiShoppingCartAddShoppingCart:(CZProductVoListModel *)model{

   __block UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth/2.0-ScreenScale(100), kScreenHeight/2.0-ScreenScale(200), ScreenScale(200), ScreenScale(200))];
    bgView.layer.masksToBounds = YES;
    bgView.layer.cornerRadius = ScreenScale(10);
    bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    [[UIApplication sharedApplication].keyWindow addSubview:bgView];

    __block UIActivityIndicatorView * activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(ScreenScale(200)/2.0-16, ScreenScale(200)/2.0-16, 32.0f, 32.0f)];
    [activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [bgView addSubview:activityIndicator];
    [activityIndicator startAnimating];

    CZAdvisorDetailService *service = serviceByType(QSServiceTypeAdvisorDetail);
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:model.productId forKey:@"productId"];
    [param setValue:model.organId forKey:@"organId"];
    [param setValue:@"1" forKey:@"buyCount"];
    [service requestForApiShoppingCartAddShoppingCart:param CallBack:^(BOOL success, NSInteger code, id  _Nonnull data, NSString * _Nonnull errorMessage) {
        if (success){
            dispatch_async(dispatch_get_main_queue(), ^{
                [activityIndicator stopAnimating];
                [bgView removeFromSuperview];
            });
        }else{
            [activityIndicator stopAnimating];
            [bgView removeFromSuperview];
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

- (CZSchoolStarShopServiceTableView *)tableView{
    if (!_tableView) {
        _tableView = [[CZSchoolStarShopServiceTableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    }
    return _tableView;
}

- (CGFloat)getStringHeightWithText:(NSString *)text font:(UIFont *)font viewWidth:(CGFloat)width {
    // 设置文字属性 要和label的一致
    NSDictionary *attrs = @{NSFontAttributeName :font};
    CGSize maxSize = CGSizeMake(width, MAXFLOAT);

    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;

    // 计算文字占据的宽高
    CGSize size = [text boundingRectWithSize:maxSize options:options attributes:attrs context:nil].size;

   // 当你是把获得的高度来布局控件的View的高度的时候.size转化为ceilf(size.height)。
    return  ceilf(size.height);
}
@end
