//
//  CZBoardProductView.m
//  CZOrganizerSDK
//
//  Created by 赵曙诚 on 2020/3/22.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZBoardProductView.h"
#import "CZBoardProductTopCell.h"
//#import "CZBoardProductNormalCell.h"
#import "CZProductModel.h"

@interface CZBoardProductView ()<UITableViewDelegate,UITableViewDataSource>

@end
@implementation CZBoardProductView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self registerClass:[CZBoardProductTopCell class] forCellReuseIdentifier:NSStringFromClass([CZBoardProductTopCell class])];
//        [self registerClass:[CZBoardProductNormalCell class] forCellReuseIdentifier:NSStringFromClass([CZBoardProductNormalCell class])];
        self.tableFooterView = [UIView new];
        self.dataSource = self;
        self.delegate = self;
        self.backgroundColor = [UIColor clearColor];
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
    CZBoardProductTopCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CZBoardProductTopCell class]) forIndexPath:indexPath];
    CZProductModel *model = self.dataArr[indexPath.section];
    [cell setModel:model];
    cell.type = indexPath.section;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CZProductModel *model = self.dataArr[indexPath.section];
    if (model.comments.count > 0) {
        return 177;
    }
    return 135;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CZProductModel *model = self.dataArr[indexPath.section];
    if (self.selectedBlock) {
        self.selectedBlock(model.productId);
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
