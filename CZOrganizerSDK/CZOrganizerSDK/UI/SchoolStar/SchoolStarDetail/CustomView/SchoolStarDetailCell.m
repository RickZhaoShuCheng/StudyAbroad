//
//  SchoolStarDetailCell.m
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/4/6.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "SchoolStarDetailCell.h"

@interface SchoolStarDetailCell ()<UIScrollViewDelegate>

@end
@implementation SchoolStarDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initWithUI];
    }
    return self;
}

-(void)setUserId:(NSString *)userId{
    _userId = userId;
    if (userId) {
        WEAKSELF
        if (!self.postVC) {
            self.postVC = [[SchoolStarDetailPostVC alloc]init];
            self.postVC.userId = self.userId;
            self.postVC.superVC = self.superVC;
            [self.scrollView addSubview:self.postVC.view];
            [self.postVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.leading.mas_equalTo(self.scrollView);
                make.top.bottom.mas_equalTo(self.contentView);
                make.width.mas_equalTo(kScreenWidth);
            }];
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
        }
        if (!self.piiicVC) {
            self.piiicVC = [[SchoolStarDetailPiiicVC alloc]init];
            [self.scrollView addSubview:self.piiicVC.view];
            [self.piiicVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.leading.mas_equalTo(self.scrollView.mas_leading).offset(kScreenWidth);
                make.top.bottom.mas_equalTo(self.contentView);
                make.width.mas_equalTo(kScreenWidth);
            }];
            [self.piiicVC.tableView setScrollContentSize:^(CGFloat offsetY) {
                if (weakSelf.scrollContentSize) {
                    weakSelf.scrollContentSize(offsetY);
                }
                if (offsetY <= 0) {
                    weakSelf.piiicVC.tableView.scrollEnabled = NO;
                }else{
                    weakSelf.piiicVC.tableView.scrollEnabled = YES;
                }
            }];
        }
        if (!self.diaryVC) {
            self.diaryVC = [[SchoolStarDetailDiaryVC alloc]init];
            [self.scrollView addSubview:self.diaryVC.view];
            [self.diaryVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.leading.mas_equalTo(self.scrollView.mas_leading).offset(kScreenWidth*2);
                make.top.bottom.mas_equalTo(self.contentView);
                make.width.mas_equalTo(kScreenWidth);
            }];
            [self.diaryVC.tableView setScrollContentSize:^(CGFloat offsetY) {
                if (weakSelf.scrollContentSize) {
                    weakSelf.scrollContentSize(offsetY);
                }
                if (offsetY <= 0) {
                    weakSelf.diaryVC.tableView.scrollEnabled = NO;
                }else{
                    weakSelf.diaryVC.tableView.scrollEnabled = YES;
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
