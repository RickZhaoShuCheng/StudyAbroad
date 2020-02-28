//
//  CZCarefullyChooseCell.m
//  CZOrganizerSDK
//
//  Created by zsc on 2020/2/26.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZCarefullyChooseCell.h"

@interface CZCarefullyChooseCell ()
@property (nonatomic , strong) UIImageView *coverImageView;
@property (nonatomic , strong) UILabel *nameLabel;
@property (nonatomic , strong) UILabel *priceLabel;
@property (nonatomic , strong) UILabel *addressLabel;
@property (nonatomic , strong) UILabel *distanceLabel;
@end

@implementation CZCarefullyChooseCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initWithUI];
    }
    return self;
}

- (void)initWithUI{
    
    self.coverImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.coverImageView];
    [self.coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(160);
        make.height.mas_equalTo(94);
        make.top.mas_equalTo(0);
        make.centerX.mas_equalTo(0);
    }];
    self.coverImageView.backgroundColor = [UIColor redColor];

    
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.textColor = [UIColor blackColor];
    self.nameLabel.font = [UIFont boldSystemFontOfSize:14];
    self.nameLabel.numberOfLines = 1;
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.coverImageView.mas_bottom).offset(12);
        make.height.mas_greaterThanOrEqualTo(0);
        make.left.mas_equalTo(9);
        make.left.mas_equalTo(-9);
    }];
    
    self.priceLabel = [[UILabel alloc] init];
    self.priceLabel.font = [UIFont boldSystemFontOfSize:15];
    self.priceLabel.textColor = CZColorCreater(255, 68, 85, 1);
    [self.contentView addSubview:self.priceLabel];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_greaterThanOrEqualTo(0);
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(7);
        make.left.mas_equalTo(self.nameLabel);
    }];
    
    self.addressLabel = [[UILabel alloc] init];
    self.addressLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:11];
    self.addressLabel.textColor = CZColorCreater(129, 129, 146, 1);
    [self.contentView addSubview:self.addressLabel];
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_greaterThanOrEqualTo(0);
        make.left.mas_equalTo(self.nameLabel);
        make.bottom.mas_equalTo(-12.5);
    }];
    
    self.distanceLabel = [[UILabel alloc] init];
    self.distanceLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:11];
    self.distanceLabel.textColor = CZColorCreater(129, 129, 146, 1);
    [self.contentView addSubview:self.distanceLabel];
    [self.distanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_greaterThanOrEqualTo(0);
        make.right.mas_equalTo(self.nameLabel);
        make.bottom.mas_equalTo(-12.5);
    }];
    
}

@end