//
//  CZBoardAdvisorView.m
//  CZOrganizerSDK
//
//  Created by zsc on 2020/3/13.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZBoardAdvisorView.h"
#import "CZBoardAdvisorTopCell.h"
#import "CZBoardAdvisorNormalCell.h"
#import "CZAdvisorModel.h"
#import "CZProductVoListModel.h"

@interface CZBoardAdvisorView ()<UITableViewDelegate,UITableViewDataSource>

@end
@implementation CZBoardAdvisorView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self registerClass:[CZBoardAdvisorTopCell class] forCellReuseIdentifier:NSStringFromClass([CZBoardAdvisorTopCell class])];
        [self registerClass:[CZBoardAdvisorNormalCell class] forCellReuseIdentifier:NSStringFromClass([CZBoardAdvisorNormalCell class])];
        self.tableFooterView = [UIView new];
        self.dataSource = self;
        self.delegate = self;
        self.backgroundColor = [UIColor clearColor];
        if (@available(iOS 11.0, *)) {
            self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            /// 自动关闭估算高度，不想估算那个，就设置那个即可
            self.estimatedRowHeight = 0;
            self.estimatedSectionHeaderHeight = 0;
            self.estimatedSectionFooterHeight = 0;
        }
    }
    return self;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section <= 2) {
        CZBoardAdvisorTopCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CZBoardAdvisorTopCell class]) forIndexPath:indexPath];
        CZAdvisorModel *model = self.dataArr[indexPath.section];
        [cell setModel:model];
        cell.type = indexPath.section;
        WEAKSELF
        cell.productListView.selectedBlock = ^(NSString * _Nonnull productId) {
            if (weakSelf.selectedProductBlock) {
                weakSelf.selectedProductBlock(productId);
            }
        };
        return cell;
    }
    else
    {
        CZBoardAdvisorNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CZBoardAdvisorNormalCell class]) forIndexPath:indexPath];
        CZAdvisorModel *model = self.dataArr[indexPath.section];
        [cell setModel:model];
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CZAdvisorModel *model = self.dataArr[indexPath.section];
    return model.cellHeight;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CZAdvisorModel *model = self.dataArr[indexPath.section];
    if (self.selectedBlock) {
        self.selectedBlock(model.counselorId);
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 0.01)];
    return view;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 15)];
    return view;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.separatorInset = UIEdgeInsetsMake(0, 68, 0,0);
}

-(NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc] init];
    }
    return _dataArr;
}

@end

