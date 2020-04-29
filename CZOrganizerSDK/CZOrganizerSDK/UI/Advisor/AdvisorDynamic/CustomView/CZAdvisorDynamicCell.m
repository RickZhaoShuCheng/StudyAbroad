//
//  AdvisorDynamicCell.m
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/22.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZAdvisorDynamicCell.h"

@interface CZAdvisorDynamicCell()<UIScrollViewDelegate>

@end
@implementation CZAdvisorDynamicCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initWithUI];
        [self actionMethod];
    }
    return self;
}
/**
 * 初始化UI
 */
- (void)initWithUI{
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.scrollView = [[UIScrollView alloc]init];
    self.scrollView.delegate = self;
    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.scrollView.alwaysBounceHorizontal = YES;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self.contentView addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
    [self.contentView layoutIfNeeded];
    self.scrollView.contentSize = CGSizeMake(kScreenWidth*2, self.contentView.frame.size.height);
    
    self.postVC = [[CZAdvisorDynamicPostVC alloc]init];
    [self.scrollView addSubview:self.postVC.view];
    [self.postVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.scrollView);
        make.top.bottom.mas_equalTo(self.contentView);
        make.width.mas_equalTo(kScreenWidth);
    }];
    
    self.QAVC = [[CZAdvisorDynamicQAVC alloc]init];
    [self.scrollView addSubview:self.QAVC.view];
    [self.QAVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.scrollView.mas_leading).offset(kScreenWidth);
        make.top.bottom.mas_equalTo(self.contentView);
        make.width.mas_equalTo(kScreenWidth);
    }];
}
- (void)actionMethod{
    WEAKSELF
    //滚动监听
    [self.postVC.tableView setScrollContentSize:^(CGFloat offsetY) {
        if (weakSelf.scrollContentSize) {
            weakSelf.scrollContentSize(offsetY);
        }
        if (offsetY <= 0) {
            weakSelf.postVC.tableView.scrollEnabled = NO;
        }else{
            weakSelf.postVC.tableView.scrollEnabled = YES;
        }
    }];
    [self.QAVC.tableView setScrollContentSize:^(CGFloat offsetY) {
        if (weakSelf.scrollContentSize) {
            weakSelf.scrollContentSize(offsetY);
        }
        if (offsetY <= 0) {
            weakSelf.QAVC.tableView.scrollEnabled = NO;
        }else{
            weakSelf.QAVC.tableView.scrollEnabled = YES;
        }
    }];
}
@end
