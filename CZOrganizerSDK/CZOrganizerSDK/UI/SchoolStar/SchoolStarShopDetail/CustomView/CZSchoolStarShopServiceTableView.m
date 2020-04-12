//
//  SchoolStarShopServiceTableView.m
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/4/6.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZSchoolStarShopServiceTableView.h"
#import "CZSchoolStarShopServiceCell.h"
@interface CZSchoolStarShopServiceTableView()<UITableViewDelegate,UITableViewDataSource>

@end
@implementation CZSchoolStarShopServiceTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.dataArr = [NSMutableArray array];
        self.backgroundColor = [UIColor whiteColor];
        self.delegate = self;
        self.dataSource = self;
        self.scrollEnabled = NO;
        self.showsVerticalScrollIndicator = NO;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        [self registerClass:[CZSchoolStarShopServiceCell class] forCellReuseIdentifier:NSStringFromClass([CZSchoolStarShopServiceCell class])];
    }
    return self;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CZSchoolStarShopServiceCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CZSchoolStarShopServiceCell class]) forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.dataArr[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CZProductVoListModel *model = self.dataArr[indexPath.row];
    return ScreenScale(200) + model.descHeight;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.selectProductBlock) {
        self.selectProductBlock(self.dataArr[indexPath.row]);
    }
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.scrollContentSize) {
        self.scrollContentSize(scrollView.contentOffset.y);
    }
}
@end
