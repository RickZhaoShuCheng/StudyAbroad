//
//  CZSchoolStarListView.m
//  CZOrganizerSDK
//
//  Created by zsc on 2020/2/29.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZSchoolStarListView.h"
#import "CZPersonInfoLocationCell.h"
#import "CZPersonInfoSubCell.h"
@interface CZSchoolStarListView ()<UITableViewDelegate,UITableViewDataSource>

@end
@implementation CZSchoolStarListView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self registerClass:[CZPersonInfoLocationCell class] forCellReuseIdentifier:NSStringFromClass([CZPersonInfoLocationCell class])];
        [self registerClass:[CZPersonInfoSubCell class] forCellReuseIdentifier:NSStringFromClass([CZPersonInfoSubCell class])];
        self.dataSource = self;
        self.delegate = self;
        self.backgroundColor = [UIColor clearColor];
        self.tableFooterView = [UIView new];
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return self;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    CZSchoolStarModel *model = self.dataArr[section];
    return model.productVoList.count+1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (!indexPath.row) {
        CZPersonInfoLocationCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CZPersonInfoLocationCell class]) forIndexPath:indexPath];
        CZSchoolStarModel *model = self.dataArr[indexPath.section];
        [cell setModel:model];
        return cell;
    }
    else
    {
        CZPersonInfoSubCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CZPersonInfoSubCell class]) forIndexPath:indexPath];
        CZSchoolStarModel *model = self.dataArr[indexPath.section];
        [cell setCellType:CZPersonInfoSubCellTypeSchool];
        [cell setModel:model.productVoList[indexPath.row-1]];
        return cell;
    }

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (!indexPath.row) {
        return 100;
    }
    else
    {
        return 40;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (!indexPath.row) {
        if (self.selectedSchoolStarCell) {
            self.selectedSchoolStarCell(self.dataArr[indexPath.section]);
        }
    }else{
        if (self.selectedProductCell) {
            CZSchoolStarModel *model = self.dataArr[indexPath.section];
            self.selectedProductCell(model.productVoList[indexPath.row - 1]);
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 10)];
    view.backgroundColor = CZColorCreater(245, 245, 249, 1.0);
    return view;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 0.01)];
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

