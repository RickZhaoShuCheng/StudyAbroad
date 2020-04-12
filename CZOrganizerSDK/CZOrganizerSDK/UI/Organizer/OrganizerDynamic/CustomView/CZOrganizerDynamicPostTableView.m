


//
//  OrganizerDynamicPostTableView.m
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/23.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZOrganizerDynamicPostTableView.h"
#import "CZOrganizerDynamicPostCell.h"

@interface CZOrganizerDynamicPostTableView()<UITableViewDelegate ,UITableViewDataSource>

@end
@implementation CZOrganizerDynamicPostTableView

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
        [self registerClass:[CZOrganizerDynamicPostCell class] forCellReuseIdentifier:NSStringFromClass([CZOrganizerDynamicPostCell class])];
    }
    return self;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CZOrganizerDynamicPostCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CZOrganizerDynamicPostCell class]) forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ScreenScale(770);
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.scrollContentSize) {
        self.scrollContentSize(scrollView.contentOffset.y);
    }
}
@end
