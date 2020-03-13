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

@interface CZAllServiceViewController ()<SPPageMenuDelegate>
@property (nonatomic , strong)CZPageScrollContentView *contentView;
@property (nonatomic , strong) SPPageMenu *pageMenu;
@end

@implementation CZAllServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
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
    
    self.contentView = [[CZPageScrollContentView alloc]initWithFrame:CGRectMake(0, self.pageMenu.bounds.size.height, self.view.bounds.size.width, self.view.bounds.size.height-self.pageMenu.bounds.size.height) contentControllers:vcs rootController:self];
    [self.view addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.pageMenu.mas_bottom);
        make.left.right.bottom.mas_equalTo(0);
    }];
    self.pageMenu.bridgeScrollView = self.contentView.collectionView;
    self.pageMenu.delegate = self;

    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setImage:[CZImageProvider imageNamed:@"tong_yong_fan_hui"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(actionForBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = backButton;
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