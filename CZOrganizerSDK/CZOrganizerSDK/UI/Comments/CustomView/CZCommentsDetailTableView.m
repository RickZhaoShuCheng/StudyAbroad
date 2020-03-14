
//
//  CZCommentsDetailTableView.m
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/15.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZCommentsDetailTableView.h"


@interface CZCommentsDetailTableView()<UITableViewDelegate,UITableViewDataSource>

@end
@implementation CZCommentsDetailTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        [self registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
        self.showsVerticalScrollIndicator = NO;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableHeaderView = self.headerView;
    }
    return self;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    #warning 图片高度没算，最多支持6张图片，有机会再优化，缺少内容高度，需动态计算
//    if ([[self.commentsArr[indexPath.row] objectForKey:@"pics"] count] == 0) {
//        //无图片
//        return HeightRatio(300);
//    }else if ([[self.commentsArr[indexPath.row] objectForKey:@"pics"] count] <= 3) {
////        1-3张
//        return HeightRatio(480);
//    }else{
////        4-6张
        return HeightRatio(170);
//    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.scrollContentSize) {
        self.scrollContentSize(scrollView.contentOffset.y);
    }
}

- (CZCommentsDetailHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[CZCommentsDetailHeaderView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, HeightRatio(1220))];
    }
    return _headerView;
}
@end
