//
//  CZAllServiceSubViewController.m
//  CZOrganizerSDK
//
//  Created by zsc on 2020/3/8.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZAllServiceSubViewController.h"
#import "CZPageScrollContentView.h"
#import "CZCarefullyChooseViewController.h"
#import "CZDiaryViewController.h"
#import "CZSchoolStarViewController.h"
#import "CZAdvisorViewController.h"
#import "CZOrganizerListViewController.h"
#import "SPPageMenu.h"
#import "QSClient.h"
#import "CXSearchViewController.h"
#import "CZAdvisorDetailService.h"
#import "QSCommonService.h"
#import "CZBadgeView.h"

@interface CZAllServiceSubViewController ()<SPPageMenuDelegate>
@property (nonatomic , strong)CZPageScrollContentView *contentView;
@property (nonatomic , strong)SPPageMenu *pageMenu;
@property (nonatomic, strong) UIButton *shopButton;
@property (nonatomic, strong) CZBadgeView *redDotBadgeView;

@end

@implementation CZAllServiceSubViewController
@synthesize contentScrollView;
@synthesize canScroll;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

-(void)initUI
{
    self.title = self.model.content1;
    NSArray *vcs = [self contentScrollers];
    
    self.pageMenu = [SPPageMenu pageMenuWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 50) trackerStyle:SPPageMenuTrackerStyleLine];
    self.pageMenu.permutationWay = SPPageMenuPermutationWayNotScrollAdaptContent;
    [self.pageMenu setItems:@[NSLocalizedString(@"精选", nil),NSLocalizedString(@"口碑", nil),NSLocalizedString(@"达人", nil),NSLocalizedString(@"顾问", nil),NSLocalizedString(@"机构", nil)] selectedItemIndex:0];
    self.pageMenu.itemTitleFont = [UIFont boldSystemFontOfSize:16];
    self.pageMenu.tracker.backgroundColor = self.pageMenu.unSelectedItemTitleColor = CZColorCreater(51, 172, 253, 1);
    self.pageMenu.delegate = self;
    self.pageMenu.selectedItemTitleColor = [UIColor blackColor];
    self.pageMenu.unSelectedItemTitleColor = CZColorCreater(167, 167, 185, 1);
    [self.view addSubview:self.pageMenu];
    
    self.contentView = [[CZPageScrollContentView alloc]initWithFrame:CGRectMake(0, self.pageMenu.bounds.size.height, self.view.bounds.size.width, self.view.bounds.size.height-self.pageMenu.bounds.size.height-(IPHONE_X?88:68)) contentControllers:vcs rootController:self];
    [self.view addSubview:self.contentView];
    self.pageMenu.bridgeScrollView = self.contentView.collectionView;

    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 44, 44);
    leftButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [leftButton setImage:[CZImageProvider imageNamed:@"tong_yong_fan_hui"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(actionForBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = backButton;
    
    self.shopButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.shopButton.frame = CGRectMake(0, 0, 30, 30);
    [self.shopButton addTarget:self action:@selector(actionForShowCart) forControlEvents:UIControlEventTouchUpInside];
    [self.shopButton setImage:[CZImageProvider imageNamed:@"zhu_ye_dao_hang_gou_wu_che_an_niu"] forState:UIControlStateNormal];
    UIBarButtonItem *shopBarItem = [[UIBarButtonItem alloc] initWithCustomView:self.shopButton];
    
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    searchButton.frame = CGRectMake(0, 0, 30, 30);
    [searchButton addTarget:self action:@selector(actionForSearch) forControlEvents:UIControlEventTouchUpInside];
    [searchButton setImage:[CZImageProvider imageNamed:@"sousuo_heise"] forState:UIControlStateNormal];
    UIBarButtonItem *searchBarItem = [[UIBarButtonItem alloc] initWithCustomView:searchButton];
    
    self.navigationItem.rightBarButtonItems = @[searchBarItem , shopBarItem];
}

-(void)actionForShowCart
{
    [QSClient showCartInNavi:self.navigationController];
}

-(void)actionForSearch
{
    CXSearchViewController *searchViewController = [[CXSearchViewController alloc] initWithNibName:@"CXSearchViewController" bundle:[NSBundle bundleForClass:[self class]]];
    [self.navigationController pushViewController:searchViewController animated:YES];
}



// 子类化实现
- (NSArray<UIViewController<CZScrollContentControllerDeleagte> *> *)contentScrollers
{
    NSMutableArray *arry = [[NSMutableArray alloc]init];
    CZCarefullyChooseViewController *controller1 = [[CZCarefullyChooseViewController alloc]init];
    [arry addObject:controller1];
    CZDiaryViewController *controller2 = [[CZDiaryViewController alloc]init];
    [arry addObject:controller2];
    CZSchoolStarViewController *controller3 = [[CZSchoolStarViewController alloc]init];
    [arry addObject:controller3];
    CZAdvisorViewController *controller4 = [[CZAdvisorViewController alloc]init];
    [arry addObject:controller4];
    CZOrganizerListViewController *controller5 = [[CZOrganizerListViewController alloc]init];
    [arry addObject:controller5];
    controller1.model = self.model;
    controller2.model = self.model;
    controller3.model = self.model;
    controller4.model = self.model;
    controller5.model = self.model;
    return arry;
}

-(void)actionForBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)pageMenu:(SPPageMenu *)pageMenu itemSelectedFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex
{
    [self.contentView.collectionView setContentOffset:CGPointMake(toIndex*self.view.bounds.size.width, 0) animated:YES];
}

//获取购物车数量
- (void)requestForApiShoppingCartGetShoppingCartCountCallBack{
    WEAKSELF
    CZAdvisorDetailService *service = serviceByType(QSServiceTypeAdvisorDetail);
    [service requestForApiShoppingCartGetShoppingCartCountCallBack:^(BOOL success, NSInteger code, id  _Nonnull data, NSString * _Nonnull errorMessage) {
        if (success){
            dispatch_async(dispatch_get_main_queue(), ^{
                NSInteger count = [data integerValue];
                if (count) {
                    [weakSelf showRedDotOnTabBar:count];
                }
                else
                {
                    [weakSelf hideRedDotFromTabBar];
                }
            });
        }else{
        }
    }];
}

-(void)showRedDotOnTabBar:(NSInteger)unreadCount
{
    if(!self.redDotBadgeView){
        CZBadgeView *redDotBadgeView = [[CZBadgeView alloc] init];
        self.redDotBadgeView = redDotBadgeView;
    }
    
    self.redDotBadgeView.style = unreadCount > 0?CZBadgeViewStyleDefault:CZBadgeViewStyleDot;
    if (self.redDotBadgeView.style == CZBadgeViewStyleDefault) {
        if (unreadCount <= 99) {
            self.redDotBadgeView.badgeValue = @(unreadCount).stringValue;
        }
        else
        {
            self.redDotBadgeView.badgeValue = @"99+";
        }
    }
    
    self.redDotBadgeView.frame = CGRectMake(CGRectGetWidth(self.shopButton.frame)-10, -CGRectGetMinY(self.shopButton.frame)-2, self.redDotBadgeView.frame.size.width, self.redDotBadgeView.frame.size.height);
    
    [self.shopButton addSubview:self.redDotBadgeView];
    
    self.redDotBadgeView.hidden = NO;
}

-(void)hideRedDotFromTabBar
{
    self.redDotBadgeView.hidden = YES;
}


@end
