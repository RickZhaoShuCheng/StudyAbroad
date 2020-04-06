//
//  SchoolStarShopDetailCell.m
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/4/6.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "SchoolStarShopDetailCell.h"

@interface SchoolStarShopDetailCell()<UIScrollViewDelegate>

@end
@implementation SchoolStarShopDetailCell
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
    self.scrollView.contentSize = CGSizeMake(kScreenWidth*3, self.contentView.frame.size.height);
    
    self.serviceVC = [[SchoolStarShopServiceVC alloc]init];
    [self.scrollView addSubview:self.serviceVC.view];
    [self.serviceVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.scrollView);
        make.top.bottom.mas_equalTo(self.contentView);
        make.width.mas_equalTo(kScreenWidth);
    }];
    
    self.commentVC = [[SchoolStarShopCommentVC alloc]init];
    [self.scrollView addSubview:self.commentVC.view];
    [self.commentVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.scrollView.mas_leading).offset(kScreenWidth);
        make.top.bottom.mas_equalTo(self.contentView);
        make.width.mas_equalTo(kScreenWidth);
    }];
    
    self.caseVC = [[SchoolStarShopCaseVC alloc]init];
    [self.scrollView addSubview:self.caseVC.view];
    [self.caseVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.scrollView.mas_leading).offset(kScreenWidth*2);
        make.top.bottom.mas_equalTo(self.contentView);
        make.width.mas_equalTo(kScreenWidth);
    }];
}
- (void)actionMethod{
    WEAKSELF
    //滚动监听
    [self.serviceVC.tableView setScrollContentSize:^(CGFloat offsetY) {
        if (weakSelf.scrollContentSize) {
            weakSelf.scrollContentSize(offsetY);
        }
        if (offsetY <= 0) {
            weakSelf.serviceVC.tableView.scrollEnabled = NO;
        }else{
            weakSelf.serviceVC.tableView.scrollEnabled = YES;
        }
    }];
    
    [self.commentVC.tableView setScrollContentSize:^(CGFloat offsetY) {
        if (weakSelf.scrollContentSize) {
            weakSelf.scrollContentSize(offsetY);
        }
        if (offsetY <= 0) {
            weakSelf.commentVC.tableView.scrollEnabled = NO;
        }else{
            weakSelf.commentVC.tableView.scrollEnabled = YES;
        }
    }];
    
    [self.caseVC.collectionView setScrollContentSize:^(CGFloat offsetY) {
        if (weakSelf.scrollContentSize) {
            weakSelf.scrollContentSize(offsetY);
        }
        if (offsetY <= 0) {
            weakSelf.caseVC.collectionView.scrollEnabled = NO;
        }else{
            weakSelf.caseVC.collectionView.scrollEnabled = YES;
        }
    }];
}
@end
