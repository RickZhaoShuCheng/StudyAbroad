

//
//  OrganizerDynamicTableView.m
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/23.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "OrganizerDynamicTableView.h"
#import "OrganizerDynamicSectionHeaderView.h"


@interface OrganizerDynamicTableView()<UITableViewDelegate,UITableViewDataSource,SPPageMenuDelegate>

@end
@implementation OrganizerDynamicTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.showsVerticalScrollIndicator = NO;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
//        self.bounces = NO;
        self.backgroundColor = [UIColor whiteColor];
        [self registerClass:[OrganizerDynamicCell class] forCellReuseIdentifier:NSStringFromClass([OrganizerDynamicCell class])];
        [self registerClass:[OrganizerDynamicSectionHeaderView class] forHeaderFooterViewReuseIdentifier:NSStringFromClass([OrganizerDynamicSectionHeaderView class])];
        self.tableHeaderView = self.headerView;
    }
    return self;
}
- (void)setModel:(CZOrganizerModel *)model{
    model.introduceOpen = NO;
    _model = model;
    self.headerView.model = _model;
    [self reloadData];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    self.cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([OrganizerDynamicCell class]) forIndexPath:indexPath];
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
        height = kScreenHeight - ScreenScale(90) - NaviH - kBottomSafeHeight;
    }else{
        height = kScreenHeight - ScreenScale(90) - NaviH;
    }
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return ScreenScale(90);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    OrganizerDynamicSectionHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([OrganizerDynamicSectionHeaderView class]) ];
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
    NSLog(@"11111----->>%2.f",scrollView.contentOffset.y);
    if (self.scrollContentSize) {
        self.scrollContentSize(scrollView.contentOffset.y);
    }
}
//
//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
//    //悬浮
//    CGFloat header = self.headerView.frame.size.height;//这个header其实是section1 的header到顶部的距离（一般为: tableHeaderView的高度）
//    if (scrollView.contentOffset.y < (header - NaviH) && scrollView.contentOffset.y >= 0) {
//        //当视图滑动的距离小于header时
//        self.cell.postVC.tableView.scrollEnabled = NO;
//        self.scrollEnabled = YES;
//    }else if(scrollView.contentOffset.y >= (header - NaviH)){
//        //当视图滑动的距离大于header时，这里就可以设置section1的header的位置啦，设置的时候要考虑到导航栏的透明对滚动视图的影响
//        self.cell.postVC.tableView.scrollEnabled = YES;
//        self.scrollEnabled = NO;
//    }
//}

- (OrganizerDynamicTableHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[OrganizerDynamicTableHeaderView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth-NaviH)];
        WEAKSELF
        _headerView.arrowBtnClick = ^(UIButton * _Nonnull button) {
            CGRect headerFrame = weakSelf.headerView.frame;
            CGRect frame = weakSelf.headerView.bgImg.frame;
            CGFloat height = weakSelf.model.introduceHeight-weakSelf.model.singleHeight*2;
            if (!weakSelf.model.introduceOpen) {
                //逆时针 旋转180度
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
                [UIView setAnimationDuration:0.2]; //动画时长
                button.transform = CGAffineTransformMakeRotation(180 *M_PI / 180.0);
                CGAffineTransform transform = button.transform;
                //第二个值表示横向放大的倍数，第三个值表示纵向缩小的程度
                transform = CGAffineTransformScale(transform, 1,1);
                button.transform = transform;
                [UIView commitAnimations];
                weakSelf.headerView.contentLab.numberOfLines = 0;
                weakSelf.headerView.bgImg.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height + height);
                weakSelf.headerView.frame = CGRectMake(headerFrame.origin.x, headerFrame.origin.y, headerFrame.size.width, headerFrame.size.height + height);
            }else{
                //顺时针 旋转180度
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
                [UIView setAnimationDuration:0.2]; //动画时长
                button.transform = CGAffineTransformMakeRotation(0*M_PI/180);
                CGAffineTransform transform = button.transform;
                transform = CGAffineTransformScale(transform, 1,1);
                button.transform = transform;
                [UIView commitAnimations];
                weakSelf.headerView.contentLab.numberOfLines = 2;
                weakSelf.headerView.bgImg.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height - height);
                weakSelf.headerView.frame = CGRectMake(headerFrame.origin.x, headerFrame.origin.y, headerFrame.size.width, headerFrame.size.height - height);
            }
            weakSelf.model.introduceOpen = !weakSelf.model.introduceOpen;
            [weakSelf reloadData];
        };
    }
    return _headerView;
}
@end
