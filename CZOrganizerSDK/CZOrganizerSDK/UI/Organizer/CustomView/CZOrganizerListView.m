//
//  CZOrganizerListView.m
//  CZOrganizerSDK
//
//  Created by zsc on 2020/3/1.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZOrganizerListView.h"

#import "CZPersonInfoCell.h"
#import "CZPersonInfoSubCell.h"
#import "CZSchoolStarModel.h"
@interface CZOrganizerListView ()<UITableViewDelegate,UITableViewDataSource>

@end
@implementation CZOrganizerListView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self registerClass:[CZPersonInfoCell class] forCellReuseIdentifier:NSStringFromClass([CZPersonInfoCell class])];
        [self registerClass:[CZPersonInfoSubCell class] forCellReuseIdentifier:NSStringFromClass([CZPersonInfoSubCell class])];
        self.tableFooterView = [UIView new];
        self.dataSource = self;
        self.delegate = self;
    }
    return self;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (!indexPath.row) {
        CZPersonInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CZPersonInfoCell class]) forIndexPath:indexPath];
        CZOrganizerModel *model = self.dataArr[indexPath.section];
        [cell setOmodel:model];
        return cell;
    }
    else
    {
        CZPersonInfoSubCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CZPersonInfoSubCell class]) forIndexPath:indexPath];
        CZOrganizerModel *model = self.dataArr[indexPath.section];
        [cell setCellType:CZPersonInfoSubCellTypeOrganizer];
        [cell setOmodel:model];
        return cell;
    }

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (!indexPath.row) {
        return 75;
    }
    else
    {
        return 40;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.selectBlock) {
        self.selectBlock();
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
