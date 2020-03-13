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

@interface CZAllServiceSubViewController ()<SPPageMenuDelegate>
@property (nonatomic , strong)CZPageScrollContentView *contentView;
@property (nonatomic , strong)SPPageMenu *pageMenu;
@end

@implementation CZAllServiceSubViewController
@synthesize contentScrollView;
@synthesize canScroll;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
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
    
    self.contentView = [[CZPageScrollContentView alloc]initWithFrame:CGRectMake(0, self.pageMenu.bounds.size.height, self.view.bounds.size.width, self.view.bounds.size.height-self.pageMenu.bounds.size.height) contentControllers:vcs rootController:self];
    [self.view addSubview:self.contentView];
    self.pageMenu.bridgeScrollView = self.contentView.collectionView;

    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setImage:[CZImageProvider imageNamed:@"tong_yong_fan_hui"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(actionForBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = backButton;
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

@end
