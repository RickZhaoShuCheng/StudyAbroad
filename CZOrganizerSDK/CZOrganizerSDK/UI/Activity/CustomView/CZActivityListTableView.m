
//
//  CZActivityListTableView.m
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/24.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZActivityListTableView.h"
#import "CZActivityListCell.h"


@interface CZActivityListTableView()<UITableViewDelegate,UITableViewDataSource>

@end
@implementation CZActivityListTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.dataArr = [NSMutableArray array];
        self.delegate = self;
        self.dataSource = self;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [super deselectRowAtIndexPath:indexPath animated:YES];
    CZActivityModel *model = self.dataArr[indexPath.row];
    if (self.didSelectCell) {
        self.didSelectCell(model.productId);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ScreenScale(230);
}
@end
