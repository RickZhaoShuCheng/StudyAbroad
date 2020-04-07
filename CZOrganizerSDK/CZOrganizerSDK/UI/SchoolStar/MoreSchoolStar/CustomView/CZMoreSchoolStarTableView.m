
//
//  CZMoreSchoolStarTableView.m
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/4/1.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZMoreSchoolStarTableView.h"
#import "CZMoreSchoolStarCell.h"
#import "CZMoreSchoolStarGoodsCell.h"

@interface CZMoreSchoolStarTableView ()<UITableViewDelegate,UITableViewDataSource>

@end
@implementation CZMoreSchoolStarTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.dataArr = [NSMutableArray array];
        self.delegate = self;
        self.dataSource = self;
        self.showsVerticalScrollIndicator = NO;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        [self registerClass:[CZMoreSchoolStarCell class] forCellReuseIdentifier:NSStringFromClass([CZMoreSchoolStarCell class])];
        [self registerClass:[CZMoreSchoolStarGoodsCell class] forCellReuseIdentifier:NSStringFromClass([CZMoreSchoolStarGoodsCell class])];
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    CZSchoolStarModel *model = self.dataArr[section];
    return model.productVoList.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        CZMoreSchoolStarCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CZMoreSchoolStarCell class]) forIndexPath:indexPath];
        cell.model = self.dataArr[indexPath.section];
        return cell;
    }else{
        CZMoreSchoolStarGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CZMoreSchoolStarGoodsCell class]) forIndexPath:indexPath];
        CZSchoolStarModel *model = self.dataArr[indexPath.section];
        cell.model = model.productVoList[indexPath.row - 1];
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return ScreenScale(220);
    }else{
        return ScreenScale(80);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return ScreenScale(20);
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, ScreenScale(20))];
    footer.backgroundColor = CZColorCreater(245, 245, 249, 1);
    return footer;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
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
@end
