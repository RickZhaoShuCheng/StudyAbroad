
//
//  SchoolStarShopCommentTableView.m
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/4/6.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "SchoolStarShopCommentTableView.h"
#import "SchoolStarShopCommentCell.h"

@interface SchoolStarShopCommentTableView()<UITableViewDelegate,UITableViewDataSource>

@end
@implementation SchoolStarShopCommentTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.delegate = self;
        self.dataSource = self;
        self.scrollEnabled = NO;
        self.showsVerticalScrollIndicator = NO;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        [self registerClass:[SchoolStarShopCommentCell class] forCellReuseIdentifier:NSStringFromClass([SchoolStarShopCommentCell class])];
        self.tableHeaderView = self.headerView;
    }
    return self;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SchoolStarShopCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SchoolStarShopCommentCell class]) forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ScreenScale(230);
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.scrollContentSize) {
        self.scrollContentSize(scrollView.contentOffset.y);
    }
}

- (SchoolStarShopCommentHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[SchoolStarShopCommentHeaderView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, ScreenScale(100))];
    }
    return _headerView;
}
@end
