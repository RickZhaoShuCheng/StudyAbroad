//
//  SchoolStarShopServiceTableView.m
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/4/6.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "SchoolStarShopServiceTableView.h"
#import "SchoolStarShopServiceCell.h"
@interface SchoolStarShopServiceTableView()<UITableViewDelegate,UITableViewDataSource>

@end
@implementation SchoolStarShopServiceTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.delegate = self;
        self.dataSource = self;
        self.scrollEnabled = NO;
        self.showsVerticalScrollIndicator = NO;
//        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        [self registerClass:[SchoolStarShopServiceCell class] forCellReuseIdentifier:NSStringFromClass([SchoolStarShopServiceCell class])];
    }
    return self;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SchoolStarShopServiceCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SchoolStarShopServiceCell class]) forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ScreenScale(256);
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.scrollContentSize) {
        self.scrollContentSize(scrollView.contentOffset.y);
    }
}
@end
