//
//  SchoolStarDetailTableView.m
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/4/6.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "SchoolStarDetailTableView.h"
#import "SchoolStarDetailSectionHeaderView.h"
@interface SchoolStarDetailTableView ()<UITableViewDelegate,UITableViewDataSource,SPPageMenuDelegate>

@end
@implementation SchoolStarDetailTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.showsVerticalScrollIndicator = NO;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
//        self.bounces = NO;
        self.backgroundColor = [UIColor whiteColor];
        [self registerClass:[SchoolStarDetailCell class] forCellReuseIdentifier:NSStringFromClass([SchoolStarDetailCell class])];
        [self registerClass:[SchoolStarDetailSectionHeaderView class] forHeaderFooterViewReuseIdentifier:NSStringFromClass([SchoolStarDetailSectionHeaderView class])];
        self.tableHeaderView = self.headerView;
    }
    return self;
}
- (void)setModel:(CZUserInfoModel *)model{
    model.introduceOpen = NO;
    _model = model;
    self.headerView.model = _model;

    CGRect rect = CGRectMake(0, 0, kScreenWidth, ScreenScale(780));
    NSInteger count = model.sportUserEduVos.count;
    if (model.sportUserEduVos.count > 3) {
        count = 3;
    }
    if (model.sportUserEduVos.count <= 3) {
        rect.size.height = rect.size.height + ScreenScale(140)* count;
    }else{
        rect.size.height = rect.size.height + ScreenScale(60) + ScreenScale(140)* count;
    }
    [self.headerView setFrame:rect];
    [self reloadData];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    self.cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SchoolStarDetailCell class]) forIndexPath:indexPath];
    WEAKSELF
    self.cell.superVC = self.superVC;
    self.cell.userId = self.model.userId;
    self.cell.scrollContentSize = ^(CGFloat offsetY) {
        if (offsetY > 0) {
            weakSelf.scrollEnabled = NO;
        }else{
            weakSelf.scrollEnabled = YES;
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
    SchoolStarDetailSectionHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([SchoolStarDetailSectionHeaderView class]) ];
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
        self.cell.postVC.tableView.scrollEnabled = NO;
        self.cell.piiicVC.tableView.scrollEnabled = NO;
        self.cell.diaryVC.tableView.scrollEnabled = NO;
        self.scrollEnabled = YES;
    }else if(offsetY >= (header - NaviH)){
        //当视图滑动的距离大于header时，这里就可以设置section1的header的位置啦，设置的时候要考虑到导航栏的透明对滚动视图的影响
        self.cell.postVC.tableView.scrollEnabled = YES;
        self.cell.piiicVC.tableView.scrollEnabled = YES;
        self.cell.diaryVC.tableView.scrollEnabled = YES;
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

- (SchoolStarDetailTableHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[SchoolStarDetailTableHeaderView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, ScreenScale(780))];
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
        _headerView.moreBtnClick = ^(UIButton * _Nonnull button) {
            CGRect headerFrame = weakSelf.headerView.frame;
            if (!weakSelf.model.experienceOpen) {
                [button setTitle:@"收起" forState:UIControlStateNormal];
                //逆时针 旋转180度
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
                [UIView setAnimationDuration:0.2]; //动画时长
                weakSelf.headerView.arrowImg.transform = CGAffineTransformMakeRotation(180 *M_PI / 180.0);
                CGAffineTransform transform = weakSelf.headerView.arrowImg.transform;
                //第二个值表示横向放大的倍数，第三个值表示纵向缩小的程度
                transform = CGAffineTransformScale(transform, 1,1);
                weakSelf.headerView.arrowImg.transform = transform;
                [UIView commitAnimations];
                NSArray *tempArr = @[@"",@"",@"",@""];
                NSInteger count = tempArr.count;
                if (tempArr.count > 3) {
                    count = 3;
                }
                headerFrame.size.height = headerFrame.size.height + ScreenScale(140) * (tempArr.count - count);
                weakSelf.headerView.frame = headerFrame;
                [weakSelf.headerView.experienceContainerView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.leading.trailing.mas_equalTo(weakSelf.headerView);
                    make.top.mas_equalTo(weakSelf.headerView.bgImg.mas_bottom).offset(ScreenScale(120));
                    make.height.mas_equalTo(ScreenScale(140) * tempArr.count);
                }];
            }else{
                [button setTitle:@"展开" forState:UIControlStateNormal];
                //顺时针 旋转180度
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
                [UIView setAnimationDuration:0.2]; //动画时长
                weakSelf.headerView.arrowImg.transform = CGAffineTransformMakeRotation(0*M_PI/180);
                CGAffineTransform transform = weakSelf.headerView.arrowImg.transform;
                transform = CGAffineTransformScale(transform, 1,1);
                weakSelf.headerView.arrowImg.transform = transform;
                [UIView commitAnimations];
                NSArray *tempArr = @[@"",@"",@"",@""];
                NSInteger count = tempArr.count;
                if (tempArr.count > 3) {
                    count = 3;
                }
                headerFrame.size.height = headerFrame.size.height - ScreenScale(140) * (tempArr.count - count);
                weakSelf.headerView.frame = headerFrame;
                [weakSelf.headerView.experienceContainerView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.leading.trailing.mas_equalTo(weakSelf.headerView);
                    make.top.mas_equalTo(weakSelf.headerView.bgImg.mas_bottom).offset(ScreenScale(120));
                    make.height.mas_equalTo(ScreenScale(140) * count);
                }];
            }
            weakSelf.model.experienceOpen = !weakSelf.model.experienceOpen;
            [weakSelf reloadData];
        };
    }
    return _headerView;
}

@end
