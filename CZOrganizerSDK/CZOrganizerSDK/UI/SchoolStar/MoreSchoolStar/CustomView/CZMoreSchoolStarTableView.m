
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
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        CZMoreSchoolStarCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CZMoreSchoolStarCell class]) forIndexPath:indexPath];
        
        return cell;
    }else{
        CZMoreSchoolStarGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CZMoreSchoolStarGoodsCell class]) forIndexPath:indexPath];
        
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
    
}
@end
