//
//  CZBoardProductListCell.m
//  CZOrganizerSDK
//
//  Created by zsc on 2020/3/11.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZBoardProductListCell.h"

#import "CZProductModel.h"
#import "UIImageView+WebCache.h"

@interface CZBoardProductListCell ()
@property (nonatomic , strong) UIImageView *coverImageView;
@property (nonatomic , strong) UILabel *nameLabel;
@property (nonatomic , strong) UILabel *priceLabel;
@end

@implementation CZBoardProductListCell

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
        make.size.mas_equalTo(90);
        make.top.mas_equalTo(0);
        make.centerX.mas_equalTo(0);
    }];
    
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.textColor = [UIColor blackColor];
    self.nameLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:14];
    self.nameLabel.numberOfLines = 2;
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.coverImageView.mas_bottom).offset(11);
        make.height.mas_greaterThanOrEqualTo(0);
        make.left.right.mas_equalTo(0);
    }];
    
    self.priceLabel = [[UILabel alloc] init];
    self.priceLabel.font = [UIFont boldSystemFontOfSize:11];
    self.priceLabel.textColor = CZColorCreater(255, 68, 85, 1);
    [self.contentView addSubview:self.priceLabel];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_greaterThanOrEqualTo(0);
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(10);
        make.left.right.mas_equalTo(0);
    }];
    
}

-(void)setModel:(CZProductModel *)model
{
    _model = model;
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:PIC_URL(model.organLogo)] placeholderImage:nil];
    self.nameLabel.text = model.title;
    self.priceLabel.text = [NSString stringWithFormat:@"￥ %.2f" ,  model.price.floatValue];
}

@end
