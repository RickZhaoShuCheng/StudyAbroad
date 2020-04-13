
//
//  SchoolStarShopCommentTableView.m
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/4/6.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZSchoolStarShopCommentTableView.h"
#import "CZSchoolStarShopCommentCell.h"

@interface CZSchoolStarShopCommentTableView()<UITableViewDelegate,UITableViewDataSource>

@end
@implementation CZSchoolStarShopCommentTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.dataArr = [NSMutableArray array];
        self.backgroundColor = [UIColor whiteColor];
        self.delegate = self;
        self.dataSource = self;
        self.scrollEnabled = NO;
        self.showsVerticalScrollIndicator = NO;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        [self registerClass:[CZSchoolStarShopCommentCell class] forCellReuseIdentifier:NSStringFromClass([CZSchoolStarShopCommentCell class])];
        self.tableHeaderView = self.headerView;
    }
    return self;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CZSchoolStarShopCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CZSchoolStarShopCommentCell class]) forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.dataArr[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CZCommentModel *model = self.dataArr[indexPath.row];
    return ScreenScale(160) + model.commentHeight;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.selectCommentBlock) {
        self.selectCommentBlock(self.dataArr[indexPath.row]);
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.scrollContentSize) {
        self.scrollContentSize(scrollView.contentOffset.y);
    }
}

- (CZSchoolStarShopCommentHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[CZSchoolStarShopCommentHeaderView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, ScreenScale(100))];
    }
    return _headerView;
}
@end
