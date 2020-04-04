//
//  ActivityDetailTableView.m
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/25.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "ActivityDetailTableView.h"
#import "CZActivityListCell.h"

@interface ActivityDetailTableView()<UITableViewDelegate ,UITableViewDataSource>

@end
@implementation ActivityDetailTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.dataArr = [NSMutableArray array];
        self.delegate = self;
        self.dataSource = self;
        self.tableHeaderView = self.headerView;
        self.showsVerticalScrollIndicator = NO;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self registerClass:[CZActivityListCell class] forCellReuseIdentifier:NSStringFromClass([CZActivityListCell class])];
    }
    return self;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CZActivityListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CZActivityListCell class]) forIndexPath:indexPath];
    cell.model = self.dataArr[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ScreenScale(230);
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return ScreenScale(100);
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, ScreenScale(100))];
    headerView.backgroundColor = [UIColor whiteColor];
    
    UILabel *line = [[UILabel alloc]init];
    line.backgroundColor = CZColorCreater(76, 182, 253, 1);
    line.text = @"";
    [headerView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(headerView);
        make.width.mas_equalTo(ScreenScale(8));
        make.height.mas_equalTo(ScreenScale(26));
        make.centerY.mas_equalTo(headerView);
    }];
    
    UILabel *title = [[UILabel alloc]init];
    title.font = [UIFont boldSystemFontOfSize:ScreenScale(30)];
    title.textColor = CZColorCreater(0, 0, 0, 1);
    title.text = @"更多活动";
    [headerView addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(headerView.mas_leading).offset(ScreenScale(30));
        make.width.height.mas_greaterThanOrEqualTo(0);
        make.centerY.mas_equalTo(line);
    }];
    return headerView;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CZActivityModel *model = self.dataArr[indexPath.row];
    if (self.didSelectCell) {
        self.didSelectCell(model.productId);
    }
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.scrollContentSize) {
        self.scrollContentSize(scrollView.contentOffset.y);
    }
}
- (ActivityDetailHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[ActivityDetailHeaderView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, ScreenScale(1000))];
    }
    return _headerView;
}
@end
