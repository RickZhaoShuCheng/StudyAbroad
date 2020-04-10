//
//  CZAllServiceSchoolStarView.m
//  CZOrganizerSDK
//
//  Created by zsc on 2020/3/13.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZAllServiceSchoolStarView.h"
#import "CZAllServiceShoolStarCell.h"
#import "CZProductModel.h"
@interface CZAllServiceSchoolStarView ()<UITableViewDelegate,UITableViewDataSource>

@end
@implementation CZAllServiceSchoolStarView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self registerClass:[CZAllServiceShoolStarCell class] forCellReuseIdentifier:NSStringFromClass([CZAllServiceShoolStarCell class])];
        self.tableFooterView = [UIView new];
        self.dataSource = self;
        self.delegate = self;
    }
    return self;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CZAllServiceShoolStarCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CZAllServiceShoolStarCell class]) forIndexPath:indexPath];
    CZProductModel *model = self.dataArr[indexPath.row];
    [cell setModel:model];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 140;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}

-(NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc] init];
    }
    return _dataArr;
}

@end
