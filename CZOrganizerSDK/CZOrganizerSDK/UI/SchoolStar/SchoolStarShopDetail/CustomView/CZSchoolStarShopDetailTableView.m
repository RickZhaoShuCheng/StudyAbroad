//
//  SchoolStarShopDetailTableView.m
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/4/6.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZSchoolStarShopDetailTableView.h"
#import "CZSchoolStarShopDetailSectionHeaderView.h"

@interface CZSchoolStarShopDetailTableView()<UITableViewDelegate,UITableViewDataSource,SPPageMenuDelegate>

@end
@implementation CZSchoolStarShopDetailTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.showsVerticalScrollIndicator = NO;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
//        self.bounces = NO;
        self.backgroundColor = [UIColor whiteColor];
        [self registerClass:[CZSchoolStarShopDetailCell class] forCellReuseIdentifier:NSStringFromClass([CZSchoolStarShopDetailCell class])];
        [self registerClass:[CZSchoolStarShopDetailSectionHeaderView class] forHeaderFooterViewReuseIdentifier:NSStringFromClass([CZSchoolStarShopDetailSectionHeaderView class])];
        self.tableHeaderView = self.headerView;
    }
    return self;
}
- (void)setModel:(CZSchoolStarModel *)model{
    _model = model;
    self.headerView.model = _model;
    CGRect frame = self.headerView.bgImg.frame;
    CGFloat maxY = self.headerView.tagList.frame.origin.y + self.headerView.tagList.frame.size.height;
    if (maxY >= self.headerView.bgImg.frame.size.height) {
        frame.size.height = frame.size.height + self.headerView.tagList.contentHeight + ScreenScale(20);
        self.headerView.frame = frame;
        self.headerView.bgImg.frame = frame;
    }
    [self reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    self.cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CZSchoolStarShopDetailCell class]) forIndexPath:indexPath];
    self.cell.superVC = self.superVC;
    self.cell.sportUserId = self.model.sportUserId;
    WEAKSELF
    self.cell.scrollContentSize = ^(CGFloat offsetY) {
        if (offsetY > 0) {
            weakSelf.scrollEnabled = NO;
//            NSLog(@"2222++++++++");
        }else{
            weakSelf.scrollEnabled = YES;
//            NSLog(@"2222................");
        }
    };
    return self.cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = 0.0;
    // 如果是刘海屏
    if (IPHONE_X) {
        height = kScreenHeight - ScreenScale(90) - NaviH - kBottomSafeHeight - ScreenScale(100);
    }else{
        height = kScreenHeight - ScreenScale(90) - NaviH - ScreenScale(100);
    }
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return ScreenScale(90);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    CZSchoolStarShopDetailSectionHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([CZSchoolStarShopDetailSectionHeaderView class]) ];
    if (!headerView.pageMenu.bridgeScrollView) {
        headerView.pageMenu.bridgeScrollView = self.cell.scrollView;
    }
    if (!headerView.pageMenu.delegate) {
        headerView.pageMenu.delegate = self;
    }
    return headerView;
}
#pragma mark - SPPageMenu的代理方法
- (void)pageMenu:(SPPageMenu *)pageMenu itemSelectedFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    //悬浮
    CGFloat header = self.headerView.frame.size.height;//这个header其实是section1 的header到顶部的距离（一般为: tableHeaderView的高度）
    CGFloat offsetY = self.contentOffset.y;
    if (offsetY < (header - NaviH) && offsetY >= 0) {
        //当视图滑动的距离小于header时
        self.cell.serviceVC.tableView.scrollEnabled = NO;
        self.cell.commentVC.tableView.scrollEnabled = NO;
        self.cell.caseVC.collectionView.scrollEnabled = NO;
        self.scrollEnabled = YES;
    }else if(offsetY >= (header - NaviH)){
        //当视图滑动的距离大于header时，这里就可以设置section1的header的位置啦，设置的时候要考虑到导航栏的透明对滚动视图的影响
        self.cell.serviceVC.tableView.scrollEnabled = YES;
        self.cell.commentVC.tableView.scrollEnabled = YES;
        self.cell.caseVC.collectionView.scrollEnabled = YES;
        self.scrollEnabled = NO;
    }
    if (fromIndex == toIndex) {
        return;
    }
    
    // 如果fromIndex与toIndex之差大于等于2,说明跨界面移动了,此时不动画.
    if (labs(toIndex - fromIndex) >= 2) {
        [self.cell.scrollView setContentOffset:CGPointMake(kScreenWidth * toIndex, 0) animated:NO];
    } else {
        [self.cell.scrollView setContentOffset:CGPointMake(kScreenWidth * toIndex, 0) animated:YES];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.scrollContentSize) {
        self.scrollContentSize(scrollView.contentOffset.y);
    }
}

- (CZSchoolStarShopDetailTableHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[CZSchoolStarShopDetailTableHeaderView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, ScreenScale(540))];
        WEAKSELF
        [_headerView setClickAvatarBlock:^{
            if (weakSelf.clickAvatarBlock) {
                weakSelf.clickAvatarBlock();
            }
        }];
    }
    return _headerView;
}
@end
