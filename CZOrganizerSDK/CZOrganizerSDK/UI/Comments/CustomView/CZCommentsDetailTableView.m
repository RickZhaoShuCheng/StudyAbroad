
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
@property (nonatomic ,strong) NSMutableArray *dataArr;
@end
@implementation CZCommentsDetailTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.dataArr = [NSMutableArray array];
        [self.dataArr addObject:@{@"level":@"0",@"name":@"最甜的芥末",@"content":@"沙发",@"img":@"http://pics2.baidu.com/feed/6f061d950a7b0208861260d9c2b4e9d5562cc8a7.png?token=a660efbc8f229953136baa823633d889&s=9F1405CE8E9000D4F395A8BA0300D011",@"photo":@"0"}];
        [self.dataArr addObject:@{@"level":@"1",@"name":@"百世可乐",@"content":@"手速够快",@"img":@"http://pics2.baidu.com/feed/6f061d950a7b0208861260d9c2b4e9d5562cc8a7.png?token=a660efbc8f229953136baa823633d889&s=9F1405CE8E9000D4F395A8BA0300D011",@"photo":@"0"}];
        [self.dataArr addObject:@{@"level":@"1",@"name":@"百世可乐",@"content":@"手速够快",@"img":@"http://pics2.baidu.com/feed/6f061d950a7b0208861260d9c2b4e9d5562cc8a7.png?token=a660efbc8f229953136baa823633d889&s=9F1405CE8E9000D4F395A8BA0300D011",@"photo":@"0"}];
        [self.dataArr addObject:@{@"level":@"1",@"name":@"百世可乐",@"content":@"手速够快",@"img":@"http://pics2.baidu.com/feed/6f061d950a7b0208861260d9c2b4e9d5562cc8a7.png?token=a660efbc8f229953136baa823633d889&s=9F1405CE8E9000D4F395A8BA0300D011",@"photo":@"0"}];
        [self.dataArr addObject:@{@"level":@"2",@"name":@"百世可乐",@"content":@"手速够快",@"img":@"http://pics2.baidu.com/feed/6f061d950a7b0208861260d9c2b4e9d5562cc8a7.png?token=a660efbc8f229953136baa823633d889&s=9F1405CE8E9000D4F395A8BA0300D011",@"photo":@"0"}];
         [self.dataArr addObject:@{@"level":@"0",@"name":@"最甜的芥末",@"content":@"沙发",@"img":@"http://pics2.baidu.com/feed/6f061d950a7b0208861260d9c2b4e9d5562cc8a7.png?token=a660efbc8f229953136baa823633d889&s=9F1405CE8E9000D4F395A8BA0300D011",@"photo":@"2"}];
        [self.dataArr addObject:@{@"level":@"0",@"name":@"最甜的芥末",@"content":@"沙发",@"img":@"http://pics2.baidu.com/feed/6f061d950a7b0208861260d9c2b4e9d5562cc8a7.png?token=a660efbc8f229953136baa823633d889&s=9F1405CE8E9000D4F395A8BA0300D011",@"photo":@"4"}];
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
    NSMutableDictionary *tempDic = self.dataArr[indexPath.row];
    if ([tempDic[@"level"] isEqualToString:@"0"]) {
        CZCommentsDetailOneCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CZCommentsDetailOneCell class]) forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if ([tempDic[@"level"] isEqualToString:@"1"]) {
        CZCommentsDetailTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CZCommentsDetailTwoCell class]) forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    CZCommentsDetailMoreCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CZCommentsDetailMoreCell class]) forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableDictionary *tempDic = self.dataArr[indexPath.row];
    if ([tempDic[@"level"] isEqualToString:@"0"]) {
        if ([tempDic[@"photo"] integerValue] == 0) {
            //无图片
            return ScreenScale(200);
        }else if ([tempDic[@"photo"] integerValue] <= 3) {
            //1-3张
            return ScreenScale(480);
        }else{
            //4-6张
            return ScreenScale(750);
        }
    }
    if ([tempDic[@"level"] isEqualToString:@"1"]) {
        return ScreenScale(160);
    }
    return ScreenScale(114);
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
        _headerView = [[CZCommentsDetailHeaderView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, ScreenScale(1380))];
    }
    return _headerView;
}
@end
