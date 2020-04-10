//
//  CZPersonInfoView.m
//  CZOrganizerSDK
//
//  Created by zsc on 2020/2/29.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZPersonInfoView.h"

@interface CZPersonInfoView ()
@property (nonatomic , strong) UIImageView *avatarImageView;
@property (nonatomic , strong) UILabel *infoLabel;
@property (nonatomic , strong) UILabel *subTitleLabel;
@property (nonatomic , strong) UILabel *organizeNameLabel;
@property (nonatomic , strong) CZRankView *rankView;
@property (nonatomic , strong) UIImageView *confirmImageView;
@end


@implementation CZPersonInfoView

- (instancetype)initWithFrame:(CGRect)frame container:(UIView *)container
{
    self = [super initWithFrame:frame];
    if (self) {
        [container addSubview:self];
        [self initUI];
    }
    return self;
}

-(void)initUI
{
    self.avatarImageView = [[UIImageView alloc] init];
    [self addSubview:self.avatarImageView];
    self.avatarImageView.layer.cornerRadius = 22.5;
    self.avatarImageView.layer.masksToBounds = YES;
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(45);
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(0);
    }];
    
    self.confirmImageView = [[UIImageView alloc] init];
    [self addSubview:self.confirmImageView];
    self.confirmImageView.image = [CZImageProvider imageNamed:@"ji_gou_ren_zheng"];
    [self.confirmImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(39);
        make.height.mas_equalTo(18.5);
        make.centerY.mas_equalTo(self.avatarImageView.mas_bottom);
        make.centerX.mas_equalTo(self.avatarImageView);
    }];
    
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(45);
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(0);
    }];

    self.infoLabel = [[UILabel alloc] init];
    self.infoLabel.textColor = CZColorCreater(51, 51, 51, 1);
    self.infoLabel.font = [UIFont boldSystemFontOfSize:13];
    [self addSubview:self.infoLabel];
    [self.infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_greaterThanOrEqualTo(1);
        make.right.mas_equalTo(-8);
        make.top.mas_equalTo(self.avatarImageView);
        make.left.mas_equalTo(self.avatarImageView.mas_right).offset(8);
    }];
    
    self.organizeNameLabel = [[UILabel alloc] init];
    self.organizeNameLabel.textColor = CZColorCreater(129, 129, 146, 1);
    self.organizeNameLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:11];
    [self addSubview:self.organizeNameLabel];
    [self.organizeNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_greaterThanOrEqualTo(1);
        make.right.mas_equalTo(-8);
        make.centerY.mas_equalTo(self.avatarImageView);
        make.left.mas_equalTo(self.avatarImageView.mas_right).offset(8);
    }];
    
    self.rankView = [CZRankView instanceRankViewByRate:3.1];
    [self addSubview:self.rankView];
    [self.rankView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(70);
        make.left.mas_equalTo(self.avatarImageView.mas_right).offset(8);
        make.bottom.mas_equalTo(self.avatarImageView);
        make.height.mas_equalTo(10);
    }];
    
    self.subTitleLabel = [[UILabel alloc] init];
    self.subTitleLabel.textColor = CZColorCreater(170, 170, 187, 1);
    self.subTitleLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:11];
    [self addSubview:self.subTitleLabel];
    [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_greaterThanOrEqualTo(1);
        make.right.mas_equalTo(-8);
        make.centerY.mas_equalTo(self.rankView);
        make.left.mas_equalTo(self.rankView.mas_right).offset(3);
    }];
}

@end
