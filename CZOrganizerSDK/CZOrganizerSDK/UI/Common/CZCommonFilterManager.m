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

@interface CZCommonFilterManager ()<DropMenuBarDelegate,CZSelectCityViewControllerDelegate>
@property (nonatomic , strong)DropMenuBar *menuScreeningView;
@end

@implementation CZCommonFilterManager

-(DropMenuBar *)actionsForType:(CZCommonFilterType)filterType
{
    NSArray *actions = [self createServiceThirdActions];

    DropMenuBar *menuScreeningView = [[DropMenuBar alloc] initWithAction:actions];
    menuScreeningView.delegate = self;
    menuScreeningView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 45);
    menuScreeningView.backgroundColor = [UIColor whiteColor];
    self.menuScreeningView = menuScreeningView;
    return menuScreeningView;
    
//    MenuAction *smartSort = [MenuAction actionWithTitle:NSLocalizedString(@"智能排序", nil) style:MenuActionTypeList];
//    smartSort.didSelectedMenuResult = ^(NSInteger index, ItemModel *selecModel) {
//        NSLog(@"1111 === %@", selecModel.displayText);
//    };
//
//    NSMutableArray *countrys = [[NSMutableArray alloc] init];
//    NSMutableArray *countryDatas = [CZCountryUtil sharedInstance].datas;
//    for (int i = 0; i < countryDatas.count; i++) {
//        CZSCountryModel *country = countryDatas[i];
//        BOOL select = i == 0;
//        ItemModel *model = [ItemModel modelWithText:country.country.area_name currentID:country.country.ID isSelect:select];
//        [countrys addObject:model];
//    }
//
//    MenuAction *countrySort = [MenuAction actionWithTitle:NSLocalizedString(@"国家", nil) style:MenuActionTypeList];
//    countrySort.ListDataSource = countrys;
//    countrySort.didSelectedMenuResult = ^(NSInteger index, ItemModel *selecModel) {
//        NSLog(@"1111 === %@", selecModel.displayText);
//    };
//
//    MenuAction *profassionnalSort = [MenuAction actionWithTitle:NSLocalizedString(@"专业", nil) style:MenuActionTypeList];
//    profassionnalSort.didSelectedMenuResult = ^(NSInteger index, ItemModel *selecModel) {
//        NSLog(@"1111 === %@", selecModel.displayText);
//    };
//
//    MenuAction *citySort = [MenuAction actionWithTitle:NSLocalizedString(@"城市", nil) style:MenuActionTypeList];
//    citySort.didSelectedMenuResult = ^(NSInteger index, ItemModel *selecModel) {
//        NSLog(@"1111 === %@", selecModel.displayText);
//    };
//
//    MenuAction *filterSort = [MenuAction actionWithTitle:NSLocalizedString(@"筛选", nil) style:MenuActionTypeList];
//    filterSort.didSelectedMenuResult = ^(NSInteger index, ItemModel *selecModel) {
//        NSLog(@"1111 === %@", selecModel.displayText);
//    };
//
//    return @[smartSort,citySort,countrySort,profassionnalSort,filterSort];
}

-(NSArray *)createServiceThirdActions
{
    NSMutableArray *datas = [[NSMutableArray alloc] init];
    NSArray *titles = @[NSLocalizedString(@"销量最多", nil),NSLocalizedString(@"案例最多", nil),NSLocalizedString(@"评分最高", nil),NSLocalizedString(@"离我最近", nil),NSLocalizedString(@"价格最高", nil),NSLocalizedString(@"价格最低", nil)];
    for (NSInteger i = 0; i < titles.count; i++) {
        ItemModel *model = [ItemModel modelWithText:titles[i] currentID:[@(i) stringValue] isSelect:NO];
        [datas addObject:model];
    }
    
    MenuAction *smartSort = [MenuAction actionWithTitle:NSLocalizedString(@"智能排序", nil) style:MenuActionTypeList];
    smartSort.ListDataSource = datas;
    
    MenuAction *servicesSort = [MenuAction actionWithTitle:NSLocalizedString(@"服务类型", nil) style:MenuActionTypeList];
    NSArray *services = [CZCommonInstance sharedInstance].servies;
    NSMutableArray *datas2 = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < services.count; i++) {
        NSString *name = [[services objectAtIndex:i] content1];
        ItemModel *model = [ItemModel modelWithText:name  currentID:[@(i) stringValue] isSelect:NO];
        [datas2 addObject:model];
    }
    
    if (datas2.count >0) {
        servicesSort.ListDataSource = datas2;
    }
        
    MenuAction *locationSort = [MenuAction actionWithTitle:NSLocalizedString(@"地点", nil) style:MenuActionTypeCustom];
    locationSort.tag = 1;
    CZSelectCityViewController *vc = [[CZSelectCityViewController alloc] init];
    vc.delegate = self;
    locationSort.displayCustomWithMenu = ^UIView *{
        return vc.view;
    };
    
    return @[smartSort,servicesSort,locationSort];
}



-(void)selectCity:(CZSCountryModel *)model viewController:(UIViewController *)vc
{
    __block MenuAction *action = nil;
    [self.menuScreeningView.actions enumerateObjectsUsingBlock:^(MenuAction * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.tag == 1) {
            action = obj;
        }
    }];
    [action adjustTitle:model.country.area_name textColor:[UIColor redColor]];;
}

- (void)dropMenuViewWillAppear:(DropMenuBar *)view selectAction:(MenuAction *)action
{
    
}

- (void)dropMenuViewWillDisAppear:(DropMenuBar *)view selectAction:(MenuAction *)action
{
    
}

@end
