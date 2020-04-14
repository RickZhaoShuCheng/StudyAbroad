//
//  CZAllBoardViewController.m
//  CZOrganizerSDK
//
//  Created by zsc on 2020/3/11.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZAllBoardViewController.h"
#import "CZBoardOrganizerViewController.h"
#import "CZBoardAdvisorViewController.h"
#import "CZBoardSchoolStarViewController.h"
#import "CZPageScrollContentView.h"
#import "CZBoardProductViewController.h"
#import "SPPageMenu.h"

@interface CZAllBoardViewController () <SPPageMenuDelegate>
@property (nonatomic , strong)CZPageScrollContentView *contentView;
@property (nonatomic , strong) SPPageMenu *pageMenu;
@property (nonatomic , assign) NSInteger selectIndex;
@end

@implementation CZAllBoardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

-(void)initUI
{
    for (NSInteger i = 0; i < self.models.count; i++) {
        CZHomeModel *iModel = self.models[i];
        if (iModel.sort.integerValue == self.model.sort.integerValue) {
            self.selectIndex = i;
            break;
        }
    }
    
    self.title = NSLocalizedString(@"榜单", nil);
    NSMutableArray *vcs = [[NSMutableArray alloc] init];
    CZBoardOrganizerViewController *controller1 = [[CZBoardOrganizerViewController alloc] init];
    controller1.model = self.models[0];
    [vcs addObject:controller1];
    CZBoardAdvisorViewController *controller2 = [[CZBoardAdvisorViewController alloc] init];
    controller2.model = self.models[1];
    [vcs addObject:controller2];
    CZBoardSchoolStarViewController *controller3 = [[CZBoardSchoolStarViewController alloc] init];
    controller3.model = self.models[2];
    [vcs addObject:controller3];
    
    CZBoardProductViewController *controller4 = [[CZBoardProductViewController alloc] init];
    controller4.model = self.models[3];
    [vcs addObject:controller4];
    controller4.type = CZBoardProductTypePopular;
    
    CZBoardProductViewController *controller5 = [[CZBoardProductViewController alloc] init];
    controller5.model = self.models[4];
    [vcs addObject:controller5];
    controller5.type = CZBoardProductTypeHot;
    
    CZBoardProductViewController *controller6 = [[CZBoardProductViewController alloc] init];
    controller6.model = self.models[5];
    [vcs addObject:controller6];
    controller6.type = CZBoardProductTypeGood;
    
    CZBoardProductViewController *controller7 = [[CZBoardProductViewController alloc] init];
    controller7.model = self.models[6];
    [vcs addObject:controller7];
    controller7.type = CZBoardProductTypeGood;
    
    self.pageMenu = [SPPageMenu pageMenuWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 50) trackerStyle:SPPageMenuTrackerStyleLine];
    self.pageMenu.permutationWay = SPPageMenuPermutationWayScrollAdaptContent;
    [self.pageMenu setItems:@[controller1.model.content1,controller2.model.content1,controller3.model.content1,controller4.model.content1,controller5.model.content1,controller6.model.content1,controller7.model.content1] selectedItemIndex:0];
    self.pageMenu.itemTitleFont = [UIFont boldSystemFontOfSize:16];
    self.pageMenu.tracker.backgroundColor = self.pageMenu.unSelectedItemTitleColor = CZColorCreater(51, 172, 253, 1);
    self.pageMenu.selectedItemTitleColor = [UIColor blackColor];
    self.pageMenu.unSelectedItemTitleColor = CZColorCreater(167, 167, 185, 1);    self.pageMenu.delegate = self;
    [self.view addSubview:self.pageMenu];
    
    self.contentView = [[CZPageScrollContentView alloc]initWithFrame:CGRectMake(0, self.pageMenu.bounds.size.height, self.view.bounds.size.width, self.view.bounds.size.height-self.pageMenu.bounds.size.height-(IPHONE_X?88:68)) contentControllers:vcs rootController:self];
    [self.view addSubview:self.contentView];
    self.pageMenu.bridgeScrollView = self.contentView.collectionView;
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 44, 44);
    [leftButton setImage:[CZImageProvider imageNamed:@"tong_yong_fan_hui"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(actionForBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = backButton;
    
    if (self.selectIndex < self.models.count - 1) {
        [self.pageMenu setSelectedItemIndex:self.selectIndex];
    }
    
    [self.contentView.collectionView setContentOffset:CGPointMake(self.selectIndex*self.view.bounds.size.width, 0) animated:YES];
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
