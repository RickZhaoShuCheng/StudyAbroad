
//
//  CZAdvisorDynamicQATableView.m
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/4/28.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZAdvisorDynamicQATableView.h"

@interface CZAdvisorDynamicQATableView()<UITableViewDelegate,UITableViewDataSource>

@end
@implementation CZAdvisorDynamicQATableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.delegate = self;
        self.dataSource = self;
        self.scrollEnabled = NO;
        self.showsVerticalScrollIndicator = NO;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        [self registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
        
        UILabel *bgLab = [[UILabel alloc]init];
        bgLab.text = @"暂不开放";
        bgLab.font = [UIFont systemFontOfSize:ScreenScale(24)];
        bgLab.textAlignment = NSTextAlignmentCenter;
        bgLab.textColor = CZColorCreater(51, 51, 51, 1);
        bgLab.frame = CGRectMake(0, 0, kScreenWidth, kScreenWidth);
        [self addSubview:bgLab];
    }
    return self;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ScreenScale(80);
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.scrollContentSize) {
        self.scrollContentSize(scrollView.contentOffset.y);
    }
}
@end
