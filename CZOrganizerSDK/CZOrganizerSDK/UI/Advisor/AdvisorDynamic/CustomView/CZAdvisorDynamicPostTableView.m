

//
//  AdvisorDynamicPostTableView.m
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/22.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZAdvisorDynamicPostTableView.h"
#import "CZAdvisorDynamicPostCell.h"
#import "CZAdvisorDynamicPostCommentCell.h"

@interface CZAdvisorDynamicPostTableView()<UITableViewDelegate ,UITableViewDataSource>

@end
@implementation CZAdvisorDynamicPostTableView

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
        [self registerClass:[CZAdvisorDynamicPostCell class] forCellReuseIdentifier:NSStringFromClass([CZAdvisorDynamicPostCell class])];
        [self registerClass:[CZAdvisorDynamicPostCommentCell class] forCellReuseIdentifier:NSStringFromClass([CZAdvisorDynamicPostCommentCell class])];
    }
    return self;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row %2) {
        CZAdvisorDynamicPostCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CZAdvisorDynamicPostCommentCell class]) forIndexPath:indexPath];
        return cell;
    }
    CZAdvisorDynamicPostCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CZAdvisorDynamicPostCell class]) forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row %2) {
        return ScreenScale(80);
    }
    return ScreenScale(900);
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.scrollContentSize) {
        self.scrollContentSize(scrollView.contentOffset.y);
    }
}
@end
