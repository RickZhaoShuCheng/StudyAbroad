//
//  CZPageScrollViewController.m
//  CZPageScrollController
//
//  Created by zsc on 2020/2/20.
//  Copyright © 2020年 zsc. All rights reserved.
//

#import "CZPageScrollViewController.h"
#import "CZRecognizeGesTableView.h"
#import "CZPageScrollContentView.h"

@interface CZPageScrollViewController ()<UITableViewDataSource, UITableViewDelegate, SSPageScrollContentDelegate>
// 是否允许滑动
@property(nonatomic) BOOL viewCanScroll;

// 承载主视图的table
@property(nonatomic, weak) UITableView *scrollMainTableView;

@end

@implementation CZPageScrollViewController
@synthesize scrollContentView = _scrollContentView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // 视图初始化
    [self setupViews];
    // 配置加载
    [self setupPreferences];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 改变尺寸
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    _scrollMainTableView.frame = self.view.bounds;
}


#pragma mark -
// 初始化视图
- (void)setupViews
{
    self.stopSectionIndex = -1;
    CZRecognizeGesTableView *tableView = [[CZRecognizeGesTableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.showsVerticalScrollIndicator = NO;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    if (@available(iOS 11.0, *)) {
        tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    _scrollMainTableView = tableView;
    
    // headerView
    tableView.tableHeaderView = [self tableHeaderView];
    // footerView
    tableView.tableFooterView = [UIView new];
}

// 初始化配置
- (void)setupPreferences
{
    // 允许滑动
    _viewCanScroll = YES;
}


#pragma mark - UITableViewDataSource, UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.stopSectionIndex+1;
}

//
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return 1;
    
    if (section == self.stopSectionIndex) {
        return 1;
    }
    return [self tableViewSectionCountForSection:section];
}

//
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == self.stopSectionIndex) {
        static NSString *cellider = @"switchPageCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellider];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellider];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            // 内部视图加载
            CGFloat headersection = [self tableView:tableView heightForHeaderInSection:self.stopSectionIndex];
            CGRect frame = CGRectMake(0, 0, tableView.frame.size.width, self.view.frame.size.height-headersection);
            CZPageScrollContentView *contentView = [[CZPageScrollContentView alloc]initWithFrame:frame contentControllers:[self contentScrollers] rootController:self];
            contentView.delegate = self;
            WEAKSELF
            contentView.layoutSuccess = weakSelf.layoutSuccess;
            [cell.contentView addSubview:contentView];
            _scrollContentView = contentView;
            // 手势优先级 collectView的优先级 > tableView的优先级
            [tableView.panGestureRecognizer requireGestureRecognizerToFail:contentView.collectionView.panGestureRecognizer];
        }
        
        return cell;
    }
    
    UITableViewCell *cell = [self tableViewCellForRowAtIndexPath:indexPath tableView:tableView];
    
    if (cell == nil) {
        static NSString *cellider = @"customCell";
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellider];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;

}

#pragma mark -
// row高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == self.stopSectionIndex) {
        CGFloat height = [self tableView:tableView heightForHeaderInSection:indexPath.section];
        return self.view.frame.size.height-height+1;
    }
    
    return [self tableViewCellHeightForAtIndexPath:indexPath];
}


#pragma mark - 子类覆盖
// section
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return [self tableViewForHeaderInSection:section].frame.size.height;
}

// section header
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //
    return [self tableViewForHeaderInSection:section];
}


//#pragma mark UIScrollView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //-1时会崩溃，不知道是不是因为这个？
    if (self.stopSectionIndex == -1) {
        return;
    }
    CGFloat bottomCellOffset = [_scrollMainTableView rectForSection:self.stopSectionIndex].origin.y;
    if (scrollView.contentOffset.y >= bottomCellOffset) {
        scrollView.contentOffset = CGPointMake(0, bottomCellOffset);
        if (_viewCanScroll) {
            _viewCanScroll = NO;
            _scrollContentView.canScroll = YES;
        }
    }else{
        if (!_viewCanScroll) {//子视图没到顶部
            scrollView.contentOffset = CGPointMake(0, bottomCellOffset);
        }
    }
    
    [self didScrolling:_viewCanScroll];
}

//滚到视图最下面
-(void)scrollToBottom
{
    CGFloat bottomCellOffset = [_scrollMainTableView rectForSection:self.stopSectionIndex].origin.y;
    [self.scrollMainTableView setContentOffset:CGPointMake(0, bottomCellOffset) animated:YES];
    if (_viewCanScroll) {
        _viewCanScroll = NO;
        _scrollContentView.canScroll = YES;
    }
    [self didScrolling:_viewCanScroll];
}

//滚到视图最上面面
-(void)scrollToTop
{
    [self.scrollMainTableView setContentOffset:CGPointZero animated:YES];
    _viewCanScroll = YES;
    _scrollContentView.canScroll = YES;
    [self didScrolling:_viewCanScroll];
}


#pragma mark - SSPageScrollContentDelegate
// 开始滑动的时候
- (void)scrollViewWillBeginDragging:(CZPageScrollContentView *)scrollView
{
//    NSLog(@" scrollViewWillBeginDragging ");
}

// view 停止滑动的时候
- (void)scrollViewDidEndDragging:(CZPageScrollContentView *)scrollView
                      scrollView:(UIScrollView *)sender
{
//    NSLog(@" scrollViewDidEndDragging ");
}

// 滚动到某一页的时候
- (void)scrollView:(CZPageScrollContentView *)scrollView atIndex:(NSInteger)index
{
//    NSLog(@" scrollView:atIndex: ");
}

// 内部子视图已经滑到顶部
- (void)scrollView:(CZPageScrollContentView *)scrollView subViewsScrollToTop:(BOOL)top
{
    _viewCanScroll = YES;
    _scrollContentView.canScroll = NO;
}


#pragma mark - Override
// 子类化实现
- (NSArray<UIViewController<CZScrollContentControllerDeleagte> *> *)contentScrollers
{
    // override
    return nil;
}

- (UIView *)tableHeaderView
{
    // override
    return nil;
}

- (UIView *)tableViewForHeaderInSection:(NSInteger)section
{
    // override
    return nil;
}

- (UITableViewCell *)tableViewCellForRowAtIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView
{
    // override
    return nil;
}

- (CGFloat)tableViewCellHeightForAtIndexPath:(NSIndexPath *)indexPath
{
    // override
    return 0;
}

- (NSInteger)tableViewSectionCountForSection:(NSInteger)section
{
    // override
    return 0;
}

-(void)reloadData
{
    [self.scrollMainTableView reloadData];
}

@end













