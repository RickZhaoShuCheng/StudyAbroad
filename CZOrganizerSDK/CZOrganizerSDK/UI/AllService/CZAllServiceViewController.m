//
//  CZAllServiceViewController.m
//  CZOrganizerSDK
//
//  Created by zsc on 2020/3/7.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZAllServiceViewController.h"
#import "CZAllServiceThirdViewController.h"
#import "CZPageScrollContentView.h"
#import "CZAllServiceDiaryViewController.h"
#import "CZAllServiceSchoolStarViewController.h"
#import "SPPageMenu.h"
#import "QSClient.h"
#import "CXSearchViewController.h"
#import "CZBadgeView.h"
#import "CZAdvisorDetailService.h"
#import "QSCommonService.h"

@interface CZAllServiceViewController ()<SPPageMenuDelegate>
@property (nonatomic , strong)CZPageScrollContentView *contentView;
@property (nonatomic , strong) SPPageMenu *pageMenu;
@property (nonatomic, strong) CZBadgeView *redDotBadgeView;
@property (nonatomic, strong) UIButton *shopButton;

@end

@implementation CZAllServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [self requestForApiShoppingCartGetShoppingCartCountCallBack];
}

-(void)initUI
{
    self.title = self.model.content1;
    NSMutableArray *vcs = [[NSMutableArray alloc] init];
    CZAllServiceThirdViewController *controller1 = [[CZAllServiceThirdViewController alloc] init];
    [vcs addObject:controller1];
    
    CZAllServiceSchoolStarViewController *controller2 = [[CZAllServiceSchoolStarViewController alloc] init];
//    controller2.model = self.model;
    [vcs addObject:controller2];
    
    CZAllServiceDiaryViewController *controller3 = [[CZAllServiceDiaryViewController alloc] init];
    controller3.model = self.model;
    [vcs addObject:controller3];
    
    self.pageMenu = [SPPageMenu pageMenuWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 50) trackerStyle:SPPageMenuTrackerStyleLine];
    self.pageMenu.permutationWay = SPPageMenuPermutationWayNotScrollAdaptContent;
    [self.pageMenu setItems:@[NSLocalizedString(@"中介服务", nil),NSLocalizedString(@"达人服务", nil),NSLocalizedString(@"日记", nil)] selectedItemIndex:0];
    self.pageMenu.itemTitleFont = [UIFont boldSystemFontOfSize:16];
    self.pageMenu.tracker.backgroundColor = self.pageMenu.unSelectedItemTitleColor = CZColorCreater(51, 172, 253, 1);
    self.pageMenu.selectedItemTitleColor = [UIColor blackColor];
    self.pageMenu.unSelectedItemTitleColor = CZColorCreater(167, 167, 185, 1);
    [self.view addSubview:self.pageMenu];
    
    self.contentView = [[CZPageScrollContentView alloc]initWithFrame:CGRectMake(0, self.pageMenu.bounds.size.height, self.view.bounds.size.width, self.view.bounds.size.height-self.pageMenu.bounds.size.height-(IPHONE_X?88:68)) contentControllers:vcs rootController:self];
    [self.view addSubview:self.contentView];
    
    self.pageMenu.bridgeScrollView = self.contentView.collectionView;
    self.pageMenu.delegate = self;

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
