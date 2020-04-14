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

@interface CZAllServiceViewController ()<SPPageMenuDelegate>
@property (nonatomic , strong)CZPageScrollContentView *contentView;
@property (nonatomic , strong) SPPageMenu *pageMenu;
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
    
    self.contentView = [[CZPageScrollContentView alloc]initWithFrame:CGRectMake(0, self.pageMenu.bounds.size.height, self.view.bounds.size.width, self.view.bounds.size.height-self.pageMenu.bounds.size.height-70) contentControllers:vcs rootController:self];
    [self.view addSubview:self.contentView];
    
    self.pageMenu.bridgeScrollView = self.contentView.collectionView;
    self.pageMenu.delegate = self;

    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 44, 44);
    [leftButton setImage:[CZImageProvider imageNamed:@"tong_yong_fan_hui"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(actionForBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = backButton;
    
    UIButton *shopButton = [UIButton buttonWithType:UIButtonTypeCustom];
    shopButton.frame = CGRectMake(0, 0, 30, 30);
    [shopButton addTarget:self action:@selector(actionForShowCart) forControlEvents:UIControlEventTouchUpInside];
    [shopButton setImage:[CZImageProvider imageNamed:@"zhu_ye_dao_hang_gou_wu_che_an_niu"] forState:UIControlStateNormal];
    UIBarButtonItem *shopBarItem = [[UIBarButtonItem alloc] initWithCustomView:shopButton];
    
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

@end
