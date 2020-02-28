//
//  CZHomeFilterView.m
//  CZOrganizerSDK
//
//  Created by zsc on 2020/2/22.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZHomeFilterView.h"
#import "SPPageMenu.h"
#import "DropMenuBar.h"
#import "MenuAction.h"

@interface CZHomeFilterView () <SPPageMenuDelegate>

@property (nonatomic , strong) SPPageMenu *pageMenu;
@property (nonatomic , strong) SPPageMenu *pageMenuOt;
@property (nonatomic, strong) DropMenuBar *menuScreeningView;

@end

@implementation CZHomeFilterView

- (instancetype)initWithSuperView:(UIView *)superView
{
    self = [super init];
    if (self) {
        self.pageMenu = [SPPageMenu pageMenuWithFrame:CGRectMake(0, 0, superView.bounds.size.width, 25) trackerStyle:SPPageMenuTrackerStyleLine];
        [self.pageMenu setItems:@[NSLocalizedString(@"精选", nil),NSLocalizedString(@"口碑", nil),NSLocalizedString(@"达人", nil),NSLocalizedString(@"顾问", nil),NSLocalizedString(@"机构", nil)] selectedItemIndex:0];
        self.pageMenu.itemTitleFont = [UIFont boldSystemFontOfSize:16];
        self.pageMenu.tracker.hidden = YES;
        self.pageMenu.selectedItemTitleColor = self.pageMenu.unSelectedItemTitleColor = [UIColor colorWithRed:47/255.0 green:47/255.0 blue:47/255.0 alpha:1.0];
        self.pageMenu.permutationWay = SPPageMenuPermutationWayNotScrollEqualWidths;
        [self addSubview:self.pageMenu];
        self.frame = superView.bounds;
        self.pageMenu.tracker.hidden = YES;
        self.pageMenu.delegate = self;
        [superView addSubview:self];
        
        self.pageMenuOt = [SPPageMenu pageMenuWithFrame:CGRectMake(0, 25, superView.bounds.size.width, 25) trackerStyle:SPPageMenuTrackerStyleRoundedRect];
        self.pageMenuOt.backgroundColor = [UIColor clearColor];
        [self.pageMenuOt setItems:@[NSLocalizedString(@"猜你喜欢", nil),NSLocalizedString(@"消费点评", nil),NSLocalizedString(@"师哥师姐", nil),NSLocalizedString(@"名师大咖", nil),NSLocalizedString(@"精选好校", nil)] selectedItemIndex:0];
        self.pageMenuOt.itemTitleFont = [UIFont fontWithName:@"PingFang-SC-Medium" size:11];
        self.pageMenuOt.selectedItemTitleColor = [UIColor whiteColor];
        self.pageMenuOt.unSelectedItemTitleColor = CZColorCreater(170, 170, 187, 1.0);
        self.pageMenuOt.permutationWay = SPPageMenuPermutationWayNotScrollEqualWidths;
        self.pageMenuOt.delegate = self;
        [self addSubview:self.pageMenuOt];
        self.frame = superView.bounds;
        [superView addSubview:self];
        [self createDefaultFilterMenu];
    }
    return self;
}

-(void)pageMenu:(SPPageMenu *)pageMenu itemSelectedAtIndex:(NSInteger)index
{
    if (pageMenu.selectedItemIndex != self.pageMenuOt.selectedItemIndex) {
        [self.pageMenuOt setSelectedItemIndex:index];
    }
    
    if (pageMenu.selectedItemIndex != self.pageMenu.selectedItemIndex) {
        [self.pageMenu setSelectedItemIndex:index];
    }
}

-(void)createDefaultFilterMenu
{
    self.menuScreeningView = [[DropMenuBar alloc] initWithAction:@[]];
    self.menuScreeningView.frame = CGRectMake(0, CGRectGetMaxY(self.pageMenuOt.frame), self.frame.size.width, 45);
    self.menuScreeningView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.menuScreeningView];
    self.menuScreeningView.hideTable = YES;
}

-(void)setRelateScrollView:(UIScrollView *)scrollView
{
    [self.pageMenu setBridgeScrollView:scrollView];
}

@end
