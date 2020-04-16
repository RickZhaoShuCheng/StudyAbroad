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
#import "QSHudView.h"
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
        NSDictionary *productDic = [weakSelf dicFromObject:model];
        NSDictionary *starDic = [weakSelf dicFromObject:weakSelf.starModel];
        
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

   
    QSProgressHUD *hud = [QSHudView HUDForView:[UIApplication sharedApplication].keyWindow];
    CZAdvisorDetailService *service = serviceByType(QSServiceTypeAdvisorDetail);
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:model.productId forKey:@"productId"];
    [param setValue:model.organId forKey:@"organId"];
    [param setValue:@"1" forKey:@"buyCount"];
    [service requestForApiShoppingCartAddShoppingCart:param CallBack:^(BOOL success, NSInteger code, id  _Nonnull data, NSString * _Nonnull errorMessage) {
        if (success){
            dispatch_async(dispatch_get_main_queue(), ^{
                [hud hideAnimated:YES];
                [QSHudView showToastOnView:[UIApplication sharedApplication].keyWindow title:@"加入成功" customizationBlock:^(QSHudView *hudView) {
                    [hudView hideAnimated:YES afterDelay:1];
                }];
            });
        }else{
            [hud hideAnimated:YES];
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
//model转化为字典
- (NSDictionary *)dicFromObject:(NSObject *)object {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    unsigned int count;
    objc_property_t *propertyList = class_copyPropertyList([object class], &count);
    
    for (int i = 0; i < count; i++) {
        objc_property_t property = propertyList[i];
        const char *cName = property_getName(property);
        NSString *name = [NSString stringWithUTF8String:cName];
        NSObject *value = [object valueForKey:name];//valueForKey返回的数字和字符串都是对象
        
        if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]]) {
            //string , bool, int ,NSinteger
            [dic setObject:value forKey:name];
            
        } else if ([value isKindOfClass:[NSArray class]]) {
            //数组或字典
            [dic setObject:[self arrayWithObject:value] forKey:name];
        } else if ([value isKindOfClass:[NSDictionary class]]) {
            //数组或字典
            [dic setObject:[self dicWithObject:value] forKey:name];
        } else if (value == nil) {
            //null
            //[dic setObject:[NSNull null] forKey:name];//这行可以注释掉?????
        } else {
            //model
            [dic setObject:[self dicFromObject:value] forKey:name];
        }
    }
    
    return [dic copy];
}
- (NSArray *)arrayWithObject:(id)object {
    //数组
    NSMutableArray *array = [NSMutableArray array];
    NSArray *originArr = (NSArray *)object;
    if ([originArr isKindOfClass:[NSArray class]]) {
        for (NSObject *object in originArr) {
            if ([object isKindOfClass:[NSString class]]||[object isKindOfClass:[NSNumber class]]) {
                //string , bool, int ,NSinteger
                [array addObject:object];
            } else if ([object isKindOfClass:[NSArray class]]) {
                //数组或字典
                [array addObject:[self arrayWithObject:object]];
            } else if ([object isKindOfClass:[NSDictionary class]]) {
                //数组或字典
                [array addObject:[self dicWithObject:object]];
            } else {
                //model
                [array addObject:[self dicFromObject:object]];
            }
        }
        return [array copy];
    }
    return array.copy;
}

- (NSDictionary *)dicWithObject:(id)object {
    //字典
    NSDictionary *originDic = (NSDictionary *)object;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if ([object isKindOfClass:[NSDictionary class]]) {
        for (NSString *key in originDic.allKeys) {
            id object = [originDic objectForKey:key];
            if ([object isKindOfClass:[NSString class]]||[object isKindOfClass:[NSNumber class]]) {
                //string , bool, int ,NSinteger
                [dic setObject:object forKey:key];
            } else if ([object isKindOfClass:[NSArray class]]) {
                //数组或字典
                [dic setObject:[self arrayWithObject:object] forKey:key];
            } else if ([object isKindOfClass:[NSDictionary class]]) {
                //数组或字典
                [dic setObject:[self dicWithObject:object] forKey:key];
            } else {
                //model
                [dic setObject:[self dicFromObject:object] forKey:key];
            }
        }
        return [dic copy];
    }
    return dic.copy;
}
@end
