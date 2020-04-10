//
//  CZBoardSchoolStarView.m
//  CZOrganizerSDK
//
//  Created by 赵曙诚 on 2020/3/20.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZBoardSchoolStarView.h"
#import "CZBoardSchoolStarTopCell.h"
#import "CZBoardSchoolStarNormalCell.h"
#import "CZSchoolStarModel.h"

@interface CZBoardSchoolStarView ()<UITableViewDelegate,UITableViewDataSource>

@end
@implementation CZBoardSchoolStarView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self registerClass:[CZBoardSchoolStarTopCell class] forCellReuseIdentifier:NSStringFromClass([CZBoardSchoolStarTopCell class])];
        [self registerClass:[CZBoardSchoolStarNormalCell class] forCellReuseIdentifier:NSStringFromClass([CZBoardSchoolStarNormalCell class])];
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
        CZBoardSchoolStarTopCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CZBoardSchoolStarTopCell class]) forIndexPath:indexPath];
        CZSchoolStarModel *model = self.dataArr[indexPath.section];
        [cell setModel:model];
        cell.type = indexPath.section;
        WEAKSELF
        cell.productListView.selectedProductCell = ^(CZProductVoListModel * _Nonnull model) {
            if (weakSelf.selectedProductCell) {
                weakSelf.selectedProductCell(model);
            }
        };
        return cell;
    }
    else
    {
        CZBoardSchoolStarNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CZBoardSchoolStarNormalCell class]) forIndexPath:indexPath];
        CZSchoolStarModel *model = self.dataArr[indexPath.section];
        [cell setModel:model];
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CZSchoolStarModel *model = self.dataArr[indexPath.section];
    return model.cellHeight;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.selectedSchoolStarCell) {
        self.selectedSchoolStarCell(self.dataArr[indexPath.section]);
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

