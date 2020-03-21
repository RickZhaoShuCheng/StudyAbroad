
//
//  AdvisorDynamicTableView.m
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/21.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "AdvisorDynamicTableView.h"

@interface AdvisorDynamicTableView()<UITableViewDelegate,UITableViewDataSource>

@end
@implementation AdvisorDynamicTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
//        self.showsVerticalScrollIndicator = NO;
        self.backgroundColor = [UIColor whiteColor];
        [self registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
        self.tableHeaderView = self.headerView;
    }
    return self;
}
- (void)setModel:(CZAdvisorInfoModel *)model{
    model.introduceOpen = NO;
    _model = model;
    self.headerView.model = _model;
    [self reloadData];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ScreenScale(200);
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.scrollContentSize) {
        self.scrollContentSize(scrollView.contentOffset.y);
    }
}

- (AdvisorDynamicTableHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[AdvisorDynamicTableHeaderView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, ScreenScale(810))];
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
        };
    }
    return _headerView;
}
@end
