//
//  CZHotActivityCell.m
//  CZOrganizerSDK
//
//  Created by zsc on 2020/2/25.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZHotActivityCell.h"
#import "CZActivityModel.h"
#import "UIImageView+WebCache.h"
#import "NSDate+Utils.h"

@interface CZHotActivityCell ()
@property (nonatomic , strong) UIImageView *coverImageView;
@property (nonatomic , strong) UILabel *nameLabel;
@property (nonatomic , strong) UILabel *addressPriceLabel;
@end

@implementation CZHotActivityCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initWithUI];
    }
    return self;
}

- (void)initWithUI{
    
    self.coverImageView = [[UIImageView alloc] init];
    self.coverImageView.layer.masksToBounds = YES;
    self.coverImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:self.coverImageView];
    [self.coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(160);
        make.height.mas_equalTo(94);
        make.top.mas_equalTo(0);
        make.centerX.mas_equalTo(0);
    }];

    
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.textColor = [UIColor blackColor];
    self.nameLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:13];
    self.nameLabel.numberOfLines = 2;
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.coverImageView.mas_bottom).offset(8);
        make.height.mas_greaterThanOrEqualTo(0);
        make.left.right.mas_equalTo(0);
    }];
    
    self.addressPriceLabel = [[UILabel alloc] init];
    self.addressPriceLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:11];
    self.addressPriceLabel.textColor = CZColorCreater(170, 170, 187, 1);
    [self.contentView addSubview:self.addressPriceLabel];
    [self.addressPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_greaterThanOrEqualTo(0);
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(7);
        make.left.right.mas_equalTo(0);
    }];
    
    
}

-(void)setModel:(CZActivityModel *)model
{
    _model = model;
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:PIC_URL(model.logo)] placeholderImage:[CZImageProvider imageNamed:@"fen_mian_mo_ren_tu"]];
    self.nameLabel.text = model.title;
    
    NSString *dateString = [[NSDate alloc] distanceTimeWithBeforeTime:[model.createTime doubleValue]/1000];

    if (model.activityType == 0) {
        self.addressPriceLabel.text = [dateString stringByAppendingString:@"线上直播"];
    }else{
        self.addressPriceLabel.text = [dateString stringByAppendingString:model.extAddress];
    }
}

@end
