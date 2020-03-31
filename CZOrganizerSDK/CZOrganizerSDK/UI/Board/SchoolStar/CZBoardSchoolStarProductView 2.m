//
//  CZBoardSchoolStarProductView.m
//  CZOrganizerSDK
//
//  Created by 赵曙诚 on 2020/3/20.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZBoardSchoolStarProductView.h"
#import "CZPersonInfoSubCell.h"
#import "CZSchoolStarModel.h"
#import "CZProductVoListModel.h"
@interface CZBoardSchoolStarProductView ()<UITableViewDelegate,UITableViewDataSource>

@end
@implementation CZBoardSchoolStarProductView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self registerClass:[CZPersonInfoSubCell class] forCellReuseIdentifier:NSStringFromClass([CZPersonInfoSubCell class])];
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
    
    CZPersonInfoSubCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CZPersonInfoSubCell class]) forIndexPath:indexPath];
    CZSchoolStarModel *model = self.dataArr[indexPath.section];
    [cell setCellType:CZPersonInfoSubCellTypeAsk];
    [cell setModel:model.productVoList[indexPath.row]];
    return cell;

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}


-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.separatorInset = UIEdgeInsetsMake(0, 15, 0,0);
}

-(NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc] init];
    }
    return _dataArr;
}

@end

