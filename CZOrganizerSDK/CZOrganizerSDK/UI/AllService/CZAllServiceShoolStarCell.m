//
//  CZAllServiceShoolStarCell.m
//  CZOrganizerSDK
//
//  Created by zsc on 2020/3/13.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZAllServiceShoolStarCell.h"
#import "UIImageView+WebCache.h"

@interface CZAllServiceShoolStarCell ()
@property (nonatomic , strong) UILabel *nameLabel;
@property (nonatomic , strong) UILabel *infoLabel;

@property (nonatomic , strong) UIImageView *avatarImageView;
@property (nonatomic , strong) UILabel *userNameLabel;
@property (nonatomic , strong) UIImageView *topImageView;

@property (nonatomic , strong) UILabel *serviceCountLabel;
@property (nonatomic , strong) UILabel *priceLabel;

@property (nonatomic , strong) UIImageView *confirmImageView;

@end

@implementation CZAllServiceShoolStarCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initWithUI];
    }
    return self;
}

-(void)initWithUI
{
    self.nameLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.nameLabel];
    self.nameLabel.font = [UIFont boldSystemFontOfSize:15];
    self.nameLabel.textColor = [UIColor blackColor];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(20);
    }];
    
    self.infoLabel = [[UILabel alloc] init];
    self.infoLabel.numberOfLines = 2;
    [self.contentView addSubview:self.infoLabel];
    self.infoLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:13];
    self.infoLabel.textColor = CZColorCreater(170, 170, 187, 1);
    [self.infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(10);
    }];
    
    self.avatarImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.avatarImageView];
    self.avatarImageView.layer.cornerRadius = 18;
    self.avatarImageView.layer.masksToBounds = YES;
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(36);
        make.left.mas_equalTo(12);
        make.bottom.mas_equalTo(-10);
    }];
    
    self.confirmImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.confirmImageView];
    self.confirmImageView.image = [CZImageProvider imageNamed:@"da_ren_ren_zheng"];
    [self.confirmImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(39);
        make.height.mas_equalTo(18);
        make.bottom.mas_equalTo(self.avatarImageView);
        make.left.mas_equalTo(self.avatarImageView.mas_right).offset(4.5);
    }];
    
    self.userNameLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.userNameLabel];
    self.userNameLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:12];
    self.userNameLabel.textColor = CZColorCreater(51, 51, 51, 1);
    [self.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_greaterThanOrEqualTo(0);
        make.top.mas_equalTo(self.avatarImageView).offset(2);
        make.left.mas_equalTo(self.avatarImageView.mas_right).offset(6);
    }];
    
    self.topImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.topImageView];
    [self.topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(38.5);
        make.height.mas_equalTo(18);
        make.left.mas_equalTo(self.avatarImageView.mas_right).offset(6);
        make.bottom.mas_equalTo(self.avatarImageView);
    }];
    
    self.priceLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.priceLabel];
    self.priceLabel.font = [UIFont boldSystemFontOfSize:12];
    self.priceLabel.textColor = CZColorCreater(255, 68, 85, 1);
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_greaterThanOrEqualTo(0);
        make.bottom.mas_equalTo(self.avatarImageView);
        make.right.mas_equalTo(-15);
    }];
    
    self.serviceCountLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.serviceCountLabel];
    self.serviceCountLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:10];
    self.serviceCountLabel.textColor = CZColorCreater(183, 183, 196, 1);
    [self.serviceCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_greaterThanOrEqualTo(0);
        make.top.mas_equalTo(self.avatarImageView);
        make.right.mas_equalTo(-15);
    }];
}

-(void)setModel:(CZProductModel *)model
{
    _model = model;
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:PIC_URL(model.sportUserImg)] placeholderImage:[CZImageProvider imageNamed:@"default_avatar"]];
    self.nameLabel.text = model.title;
    self.infoLabel.text = model.desc;
    self.userNameLabel.text = model.sportRealName;
    self.priceLabel.text = [NSString stringWithFormat:@"¥%.2f" , model.price.floatValue/100];
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:PIC_URL(model.sportUserImg)] placeholderImage:[CZImageProvider imageNamed:@"default_avatar"]];
    NSInteger hour = model.serviceTime.integerValue/3600;
    
    NSString *string = @"";
    if (hour) {
        string = [string stringByAppendingFormat:@"%lu小时" , hour];
        NSInteger min = model.serviceTime.integerValue%60;
        if (min) {
            string = [string stringByAppendingFormat:@"%lu分钟" , min];
        }
    }
    else
    {
        NSInteger min = model.serviceTime.integerValue/60;
        string = [string stringByAppendingFormat:@"%lu分钟" , min];
    }
    
    string = [string stringByAppendingString:@"/次"];

    self.serviceCountLabel.text = string;
}


@end
