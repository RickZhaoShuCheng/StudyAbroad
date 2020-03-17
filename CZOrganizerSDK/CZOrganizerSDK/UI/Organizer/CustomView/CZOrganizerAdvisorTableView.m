//
//  CZOrganizerAdvisorTableView.m
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/12.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZOrganizerAdvisorTableView.h"
#import "CZOrganizerAdvisorCell.h"

@interface CZOrganizerAdvisorTableView ()<UITableViewDelegate,UITableViewDataSource>

@end
@implementation CZOrganizerAdvisorTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.showsVerticalScrollIndicator = NO;
        [self registerClass:[CZOrganizerAdvisorCell class] forCellReuseIdentifier:NSStringFromClass([CZOrganizerAdvisorCell class])];
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CZOrganizerAdvisorCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CZOrganizerAdvisorCell class]) forIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ScreenScale(160);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return ScreenScale(20);
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, ScreenScale(20))];
    footerView.backgroundColor = CZColorCreater(245, 245, 249, 1);
    return footerView;
}
- (void)scrollViewDidScroll:(UIScrollView*)scrollView {

    CGFloat sectionFooterHeight = ScreenScale(20);

    CGFloat ButtomHeight = scrollView.contentSize.height -self.frame.size.height;
    if (ButtomHeight - sectionFooterHeight <= scrollView.contentOffset.y && scrollView.contentSize.height >0) {
        scrollView.contentInset = UIEdgeInsetsMake(0,0,0,0);
    }else{
        scrollView.contentInset = UIEdgeInsetsMake(0,0, -(sectionFooterHeight),0);
    }
}
@end
