//
//  CZCommonFilterManager.m
//  CZOrganizerSDK
//
//  Created by zsc on 2020/3/7.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZCommonFilterManager.h"
#import "MenuAction.h"
#import "CZSCountryModel.h"
#import "CZCountryUtil.h"
#import "CZCommonInstance.h"
#import "CZSelectCityViewController.h"
#import "CZCustomFilterView.h"

@interface CZCommonFilterManager ()<DropMenuBarDelegate,CZSelectCityViewControllerDelegate>
@property (nonatomic , strong)DropMenuBar *menuScreeningView;
@end

@implementation CZCommonFilterManager

-(DropMenuBar *)actionsForType:(CZCommonFilterType)filterType
{
    NSArray *actions = nil;

    switch (filterType) {
        case CZCommonFilterTypeServiceThird:
            actions = [self createServiceThirdActions];
            break;
        case CZCommonFilterTypeServiceSchoolStar:
            actions = [self createServiceSchoolStarActions];
            break;
        case CZCommonFilterTypeServiceDiary:
            actions = [self createServiceDiaryActions];
            break;
        case CZCommonFilterTypeCarefulyChoose:
            actions = [self createCarefulyChooseActions];
            break;
        case CZCommonFilterTypeHomeCarefulyChoose:
            actions = [self createHomeCarefulyChooseActions];
            break;
        case CZCommonFilterTypeMoreSchoolStar:
            actions = [self createMoreSchoolStarActions];
            break;
        case CZCommonFilterTypeMoreActivity:
            actions = [self createMoreActivityActions];
            break;
        case CZCommonFilterTypeHomeDiary:
            actions = [self createHomeDiaryActions];
            break;
        case CZCommonFilterTypeDiary:
            actions = [self createDiaryActions];
            break;
        case CZCommonFilterTypeHomeSchoolStar:
            actions = [self createHomeSchoolStarActions];
            break;
        case CZCommonFilterTypeSchoolStar:
            actions = [self createSchoolStarActions];
            break;
        case CZCommonFilterTypeHomeOrganizer:
            actions = [self createHomeAdvisorAndOrganizerActions];
            break;
        case CZCommonFilterTypeOrganizer:
            actions = [self createAdvisorAndOrganizerActions];
            break;
        case CZCommonFilterTypeHomeAdvisor:
            actions = [self createHomeAdvisorAndOrganizerActions];
            break;
        case CZCommonFilterTypeAdvisor:
            actions = [self createAdvisorAndOrganizerActions];
            break;
        default:
            break;
    }
    
    DropMenuBar *menuScreeningView = [[DropMenuBar alloc] initWithAction:actions];
    menuScreeningView.delegate = self;
    menuScreeningView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 45);
    menuScreeningView.backgroundColor = [UIColor whiteColor];
    self.menuScreeningView = menuScreeningView;
    return menuScreeningView;
}

-(NSArray *)createHomeAdvisorAndOrganizerActions
{
    MenuAction *locationSort = [self addCountryFilterAction];
    
    NSMutableArray *datas = [[NSMutableArray alloc] init];
    NSArray *titles = @[NSLocalizedString(@"销量最多", nil),NSLocalizedString(@"案例最多", nil),NSLocalizedString(@"评分最高", nil),NSLocalizedString(@"离我最近", nil),NSLocalizedString(@"价格最高", nil),NSLocalizedString(@"价格最低", nil)];
    for (NSInteger i = 0; i < titles.count; i++) {
        ItemModel *model = [ItemModel modelWithText:titles[i] currentID:[@(i) stringValue] isSelect:NO];
        [datas addObject:model];
    }
    
    MenuAction *smartSort = [self addSmartActionByData:datas];
    
    MenuAction *servicesSort = [self addServiceAction];
    
    MenuAction *customSort = [self addCustomFilterAction:NO];
    
    return @[locationSort , smartSort , servicesSort , customSort];
}

-(NSArray *)createAdvisorAndOrganizerActions
{
    MenuAction *locationSort = [self addCountryFilterAction];
    
    NSMutableArray *datas = [[NSMutableArray alloc] init];
    NSArray *titles = @[NSLocalizedString(@"销量最多", nil),NSLocalizedString(@"案例最多", nil),NSLocalizedString(@"评分最高", nil),NSLocalizedString(@"离我最近", nil),NSLocalizedString(@"价格最高", nil),NSLocalizedString(@"价格最低", nil)];
    for (NSInteger i = 0; i < titles.count; i++) {
        ItemModel *model = [ItemModel modelWithText:titles[i] currentID:[@(i) stringValue] isSelect:NO];
        [datas addObject:model];
    }
    
    MenuAction *smartSort = [self addSmartActionByData:datas];
        
    MenuAction *customSort = [self addCustomFilterAction:NO];
    
    return @[locationSort , smartSort , customSort];
}

-(NSArray *)createHomeSchoolStarActions
{
       
    MenuAction *countrySort = [self addCountryFilterAction];

    NSMutableArray *datas = [[NSMutableArray alloc] init];
    NSArray *titles = @[NSLocalizedString(@"销量最多", nil),NSLocalizedString(@"案例最多", nil),NSLocalizedString(@"评分最高", nil),NSLocalizedString(@"离我最近", nil),NSLocalizedString(@"价格最高", nil),NSLocalizedString(@"价格最低", nil)];
    for (NSInteger i = 0; i < titles.count; i++) {
        ItemModel *model = [ItemModel modelWithText:titles[i] currentID:[@(i) stringValue] isSelect:NO];
        [datas addObject:model];
    }
    
    MenuAction *smartSort = [self addSmartActionByData:datas];
    
    MenuAction *servicesSort = [self addServiceAction];
    
    MenuAction *customSort = [self addCustomFilterAction:YES];

    return @[countrySort,smartSort,servicesSort,customSort];
}

-(NSArray *)createSchoolStarActions
{
      
    MenuAction *countrySort = [self addCountryFilterAction];

    NSMutableArray *datas = [[NSMutableArray alloc] init];
    NSArray *titles = @[NSLocalizedString(@"销量最多", nil),NSLocalizedString(@"案例最多", nil),NSLocalizedString(@"评分最高", nil),NSLocalizedString(@"离我最近", nil),NSLocalizedString(@"价格最高", nil),NSLocalizedString(@"价格最低", nil)];
    for (NSInteger i = 0; i < titles.count; i++) {
        ItemModel *model = [ItemModel modelWithText:titles[i] currentID:[@(i) stringValue] isSelect:NO];
        [datas addObject:model];
    }
    
    MenuAction *smartSort = [self addSmartActionByData:datas];
    
    MenuAction *customSort = [self addCustomFilterAction:YES];

    return @[countrySort,smartSort,customSort];

}

-(NSArray *)createHomeDiaryActions
{
       
    MenuAction *countrySort = [self addCountryFilterAction];

    NSMutableArray *datas = [[NSMutableArray alloc] init];
    NSArray *titles = @[NSLocalizedString(@"最新日记", nil),NSLocalizedString(@"最新回复", nil),NSLocalizedString(@"最热日记", nil)];
    for (NSInteger i = 0; i < titles.count; i++) {
        ItemModel *model = [ItemModel modelWithText:titles[i] currentID:[@(i) stringValue] isSelect:NO];
        [datas addObject:model];
    }
    
    MenuAction *smartSort = [self addSmartActionByData:datas];
    
    return @[countrySort,smartSort];
}

-(NSArray *)createDiaryActions
{
      
    MenuAction *countrySort = [self addCountryFilterAction];

    NSMutableArray *datas = [[NSMutableArray alloc] init];
    NSArray *titles = @[NSLocalizedString(@"最新日记", nil),NSLocalizedString(@"最新回复", nil),NSLocalizedString(@"最热日记", nil)];
    for (NSInteger i = 0; i < titles.count; i++) {
        ItemModel *model = [ItemModel modelWithText:titles[i] currentID:[@(i) stringValue] isSelect:NO];
        [datas addObject:model];
    }
    
    MenuAction *smartSort = [self addSmartActionByData:datas];
    
    return @[countrySort,smartSort];

}


-(NSArray *)createMoreSchoolStarActions
{
    MenuAction *locationSort = [self addSelectCityAction];
    
    NSMutableArray *datas = [[NSMutableArray alloc] init];
    NSArray *titles = @[NSLocalizedString(@"销量最多", nil),NSLocalizedString(@"案例最多", nil),NSLocalizedString(@"评分最高", nil),NSLocalizedString(@"离我最近", nil),NSLocalizedString(@"价格最高", nil),NSLocalizedString(@"价格最低", nil)];
    for (NSInteger i = 0; i < titles.count; i++) {
        ItemModel *model = [ItemModel modelWithText:titles[i] currentID:[@(i) stringValue] isSelect:NO];
        [datas addObject:model];
    }
    
    MenuAction *smartSort = [self addSmartActionByData:datas];

    MenuAction *customSort = [self addCustomFilterAction:NO];

    return @[locationSort,smartSort,customSort];
}

-(NSArray *)createMoreActivityActions
{
    return [self createServiceThirdActions];
}

-(NSArray *)createServiceThirdActions
{
    MenuAction *locationSort = [self addSelectCityAction];

    NSMutableArray *datas = [[NSMutableArray alloc] init];
    NSArray *titles = @[NSLocalizedString(@"销量最多", nil),NSLocalizedString(@"案例最多", nil),NSLocalizedString(@"评分最高", nil),NSLocalizedString(@"离我最近", nil),NSLocalizedString(@"价格最高", nil),NSLocalizedString(@"价格最低", nil)];
    for (NSInteger i = 0; i < titles.count; i++) {
        ItemModel *model = [ItemModel modelWithText:titles[i] currentID:[@(i) stringValue] isSelect:NO];
        [datas addObject:model];
    }
    
    MenuAction *smartSort = [self addSmartActionByData:datas];
    
    MenuAction *servicesSort = [self addServiceAction];
    
    MenuAction *customSort = [self addCustomFilterAction:NO];

    return @[locationSort,smartSort,servicesSort,customSort];
}

-(NSArray *)createServiceSchoolStarActions
{
    MenuAction *countrySort = [self addCountryFilterAction];

    NSMutableArray *datas = [[NSMutableArray alloc] init];
    NSArray *titles = @[NSLocalizedString(@"销量最多", nil),NSLocalizedString(@"案例最多", nil),NSLocalizedString(@"评分最高", nil),NSLocalizedString(@"离我最近", nil),NSLocalizedString(@"价格最高", nil),NSLocalizedString(@"价格最低", nil)];
    for (NSInteger i = 0; i < titles.count; i++) {
        ItemModel *model = [ItemModel modelWithText:titles[i] currentID:[@(i) stringValue] isSelect:NO];
        [datas addObject:model];
    }
    
    MenuAction *smartSort = [self addSmartActionByData:datas];
    
    MenuAction *servicesSort = [self addServiceAction];
    
    MenuAction *customSort = [self addCustomFilterAction:YES];

    return @[countrySort,smartSort,servicesSort,customSort];
}

-(NSArray *)createServiceDiaryActions
{
    MenuAction *countrySort = [self addCountryFilterAction];

    NSMutableArray *datas = [[NSMutableArray alloc] init];
    NSArray *titles = @[NSLocalizedString(@"最新日记", nil),NSLocalizedString(@"最新回复", nil),NSLocalizedString(@"最热日记", nil)];
    for (NSInteger i = 0; i < titles.count; i++) {
        ItemModel *model = [ItemModel modelWithText:titles[i] currentID:[@(i) stringValue] isSelect:NO];
        [datas addObject:model];
    }
    
    MenuAction *smartSort = [self addSmartActionByData:datas];
    
    MenuAction *schoolSort = [self addServiceAction];
    
    return @[countrySort,smartSort,schoolSort];
}

- (NSArray *)createHomeCarefulyChooseActions
{
    return [self createServiceThirdActions];
}

- (NSArray *)createCarefulyChooseActions
{
    MenuAction *locationSort = [self addSelectCityAction];

    NSMutableArray *datas = [[NSMutableArray alloc] init];
    NSArray *titles = @[NSLocalizedString(@"销量最多", nil),NSLocalizedString(@"案例最多", nil),NSLocalizedString(@"评分最高", nil),NSLocalizedString(@"离我最近", nil),NSLocalizedString(@"价格最高", nil),NSLocalizedString(@"价格最低", nil)];
    for (NSInteger i = 0; i < titles.count; i++) {
        ItemModel *model = [ItemModel modelWithText:titles[i] currentID:[@(i) stringValue] isSelect:NO];
        [datas addObject:model];
    }
    
    MenuAction *smartSort = [self addSmartActionByData:datas];
        
    MenuAction *customSort = [self addCustomFilterAction:NO];

    return @[locationSort,smartSort,customSort];
}


//增加地点筛选
-(MenuAction *)addSelectCityAction
{
    MenuAction *locationSort = [MenuAction actionWithTitle:NSLocalizedString(@"地点", nil) style:MenuActionTypeCustom];
    locationSort.tag = 1;
    CZSelectCityViewController *vc = [[CZSelectCityViewController alloc] init];
    vc.delegate = self;
    vc.fromFilter = YES;
    locationSort.displayCustomWithMenu = ^UIView *{
        return vc.view;
    };
    return locationSort;
}

//增加智能排序筛选
-(MenuAction *)addSmartActionByData:(NSArray *)data
{
    WEAKSELF
    MenuAction *smartSort = [MenuAction actionWithTitle:NSLocalizedString(@"智能排序", nil) style:MenuActionTypeList];
    smartSort.ListDataSource = data;
    smartSort.didSelectedMenuResult = ^(NSInteger index, ItemModel *selecModel) {
        weakSelf.param.smartSort = @(index);
        if (weakSelf.selectBlock) {
            weakSelf.selectBlock(weakSelf.param);
        }
    };
    return smartSort;
}

//增加服务类型
-(MenuAction *)addServiceAction
{
    MenuAction *servicesSort = [MenuAction actionWithTitle:NSLocalizedString(@"服务类型", nil) style:MenuActionTypeList];
    NSArray *services = [CZCommonInstance sharedInstance].servies;
    NSMutableArray *datas2 = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < services.count; i++) {
        NSString *name = [[services objectAtIndex:i] content1];
        NSString *jsonParam = [[services objectAtIndex:i] jsonParams];
        ItemModel *model = [ItemModel modelWithText:name currentID:[@(i) stringValue] isSelect:NO];
        model.jsonParam = jsonParam;
        [datas2 addObject:model];
    }
    
    if (datas2.count >0) {
        servicesSort.ListDataSource = datas2;
    }
    WEAKSELF
    servicesSort.didSelectedMenuResult = ^(NSInteger index, ItemModel *selecModel) {
        NSData *data = [selecModel.jsonParam dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        weakSelf.param.productCategory = dic[@"productCategory"];
        if (weakSelf.selectBlock) {
            weakSelf.selectBlock(weakSelf.param);
        }
    };
    return servicesSort;
}

//增加自定义筛选
-(MenuAction *)addCustomFilterAction:(BOOL)withoutService
{
    MenuAction *customFilterSort = [MenuAction actionWithTitle:NSLocalizedString(@"筛选", nil) style:MenuActionTypeCustom];
    WEAKSELF
    CZCustomFilterView *view = [[CZCustomFilterView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, !withoutService?304:200)];
    if (!withoutService) {
        [view layoutViews];
    }
    else
    {
        [view layoutPriceView:nil];
    }
    __block MenuAction *sort = customFilterSort;
    customFilterSort.displayCustomWithMenu = ^UIView *{
        view.select = ^(CZCustomFilterModel * _Nonnull model) {
            [weakSelf.menuScreeningView actionDidClick:sort];
            weakSelf.param.maxPrice = model.highPrice;
            weakSelf.param.minPrice = model.lowPrice;
            weakSelf.param.superviseType = model.type;
            if (weakSelf.selectBlock) {
                weakSelf.selectBlock(weakSelf.param);
            }
        };
        return view;
    };
    return customFilterSort;
}

//增加国家筛选
-(MenuAction *)addCountryFilterAction
{
    WEAKSELF
    NSArray *countries = [CZCountryUtil sharedInstance].datas;
    NSMutableArray *datas2 = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < countries.count; i++) {
        NSString *name = [[countries objectAtIndex:i] country].area_name;
        ItemModel *model = [ItemModel modelWithText:name currentID:[[countries objectAtIndex:i] country].ID isSelect:NO];
        [datas2 addObject:model];
    }
    
    
    MenuAction *countrySort = [MenuAction actionWithTitle:NSLocalizedString(@"国家", nil) style:MenuActionTypeList];
    countrySort.ListDataSource = datas2;
    countrySort.didSelectedMenuResult = ^(NSInteger index, ItemModel *selecModel) {
        weakSelf.param.countryId = selecModel.currentID;
        if (weakSelf.selectBlock) {
            weakSelf.selectBlock(weakSelf.param);
        }
    };
    return countrySort;
}

//增加学校筛选
-(MenuAction *)addSchoolFilterAction
{
    WEAKSELF
//    NSArray *countries = [CZCountryUtil sharedInstance].datas;
//    NSMutableArray *datas2 = [[NSMutableArray alloc] init];
//    for (NSInteger i = 0; i < countries.count; i++) {
//        NSString *name = [[countries objectAtIndex:i] country].area_name;
//        ItemModel *model = [ItemModel modelWithText:name currentID:[[countries objectAtIndex:i] country].ID isSelect:NO];
//        [datas2 addObject:model];
//    }
    
    
    MenuAction *schoolSort = [MenuAction actionWithTitle:NSLocalizedString(@"学校", nil) style:MenuActionTypeList];
//    countrySort.ListDataSource = datas2;
//    countrySort.didSelectedMenuResult = ^(NSInteger index, ItemModel *selecModel) {
//        weakSelf.param.countryId = selecModel.currentID;
//    };
    return schoolSort;
}

-(void)selectCity:(CZSCountryModel *)model viewController:(UIViewController *)vc
{
    __block MenuAction *action = nil;
    [self.menuScreeningView.actions enumerateObjectsUsingBlock:^(MenuAction * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.tag == 1) {
            action = obj;
        }
    }];
    self.param.cityId = model.country.ID;
    self.param.countryId = model.upLevelCountry.upLevelCountry.country.ID;
    [action adjustTitle:model.country.area_name textColor:CZColorCreater(51, 172, 253, 1)];
    if (self.selectBlock) {
        self.selectBlock(self.param);
    }
}

- (void)dropMenuViewWillAppear:(DropMenuBar *)view selectAction:(MenuAction *)action
{
    if (self.filterViewShow) {
        self.filterViewShow();
    }
}

- (void)dropMenuViewWillDisAppear:(DropMenuBar *)view selectAction:(MenuAction *)action
{
    
}

-(CZHomeParam *)param
{
    if (!_param) {
        _param = [[CZHomeParam alloc] init];
    }
    return _param;
}

@end
