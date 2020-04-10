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
    }
    return self;
}

- (void)setSportUserId:(NSString *)sportUserId{
    _sportUserId = sportUserId;
    if (sportUserId) {
        WEAKSELF
        if (!self.serviceVC) {
            self.serviceVC = [[SchoolStarShopServiceVC alloc]init];
            self.serviceVC.superVC = self.superVC;
            self.serviceVC.sportUserId = sportUserId;
            [self.scrollView addSubview:self.serviceVC.view];
            [self.serviceVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.leading.mas_equalTo(self.scrollView);
                make.top.bottom.mas_equalTo(self.contentView);
                make.width.mas_equalTo(kScreenWidth);
            }];
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
        }
        if (!self.commentVC) {
            self.commentVC = [[SchoolStarShopCommentVC alloc]init];
            self.commentVC.superVC = self.superVC;
            self.commentVC.sportUserId = sportUserId;
            [self.scrollView addSubview:self.commentVC.view];
            [self.commentVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.leading.mas_equalTo(self.scrollView.mas_leading).offset(kScreenWidth);
                make.top.bottom.mas_equalTo(self.contentView);
                make.width.mas_equalTo(kScreenWidth);
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
        }
        if (!self.caseVC) {
            self.caseVC = [[SchoolStarShopCaseVC alloc]init];
            self.caseVC.superVC = self.superVC;
            self.caseVC.sportUserId = sportUserId;
            [self.scrollView addSubview:self.caseVC.view];
            [self.caseVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.leading.mas_equalTo(self.scrollView.mas_leading).offset(kScreenWidth*2);
                make.top.bottom.mas_equalTo(self.contentView);
                make.width.mas_equalTo(kScreenWidth);
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
    }
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
    
}
@end
