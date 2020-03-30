
//
//  CZCommentsDetailTableView.m
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/15.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZCommentsDetailTableView.h"
#import "CZCommentsDetailOneCell.h"
#import "CZCommentsDetailTwoCell.h"
#import "CZCommentsDetailMoreCell.h"

@interface CZCommentsDetailTableView()<UITableViewDelegate,UITableViewDataSource>

@end
@implementation CZCommentsDetailTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.dataArr = [NSMutableArray array];
        self.delegate = self;
        self.dataSource = self;
        [self registerClass:[CZCommentsDetailOneCell class] forCellReuseIdentifier:NSStringFromClass([CZCommentsDetailOneCell class])];
        [self registerClass:[CZCommentsDetailTwoCell class] forCellReuseIdentifier:NSStringFromClass([CZCommentsDetailTwoCell class])];
        [self registerClass:[CZCommentsDetailMoreCell class] forCellReuseIdentifier:NSStringFromClass([CZCommentsDetailMoreCell class])];
        self.showsVerticalScrollIndicator = NO;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableHeaderView = self.headerView;
    }
    return self;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CZCommentModel *model = self.dataArr[indexPath.row];
    if (model.level == 1) {
        CZCommentsDetailOneCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CZCommentsDetailOneCell class]) forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = model;
        return cell;
    }
    if (model.level == 2) {
        CZCommentsDetailTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CZCommentsDetailTwoCell class]) forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    CZCommentsDetailMoreCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CZCommentsDetailMoreCell class]) forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CZCommentModel *model = self.dataArr[indexPath.row];
    if (model.level == 1) {
        NSMutableArray *imgsArr = [NSMutableArray array];
        if (model.imgs.length) {
            [imgsArr addObjectsFromArray:[model.imgs componentsSeparatedByString:@","]];
        }
        
        if ([imgsArr count] == 0) {
            //无图片
            return ScreenScale(150) + model.commentHeight;
        }else if ([imgsArr count] <= 3) {
            //1-3张
            return ScreenScale(370) + model.commentHeight;
        }else{
            //4-6张
            return ScreenScale(570) + model.commentHeight;
        }
    }
    if (model.level == 2) {
        return ScreenScale(160) + model.commentHeight;
    }
    if (model.level == 3) {
        return ScreenScale(114);
    }
    return 0;
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
        _headerView = [[CZCommentsDetailHeaderView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, ScreenScale(1340))];
    }
    return _headerView;
}
@end
