//
//  CZBoardProdcutNormalCell.m
//  CZOrganizerSDK
//
//  Created by 赵曙诚 on 2020/3/22.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZBoardProductNormalCell.h"
#import "UIImageView+WebCache.h"
#import "CZCommentModel.h"

@interface CZBoardProductNormalCell()

@property (nonatomic , strong) UIImageView *goldImageView;
@property (nonatomic , strong) UIImageView *bgView;
@property (nonatomic , strong) UIImageView *coverImageView;
@property (nonatomic , strong) UILabel *mainTitleLabel;
@property (nonatomic , strong) UILabel *subTitleLabel;
@property (nonatomic , strong) UILabel *distanceLabel;
@property (nonatomic , strong) UILabel *popularityLabel;
@property (nonatomic , strong) UILabel *priceLabel;

@end

@implementation CZBoardProductNormalCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initWithUI];
    }
    return self;
}

-(void)initWithUI
{
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    
    self.bgView = [[UIImageView alloc] init];
    self.bgView.backgroundColor = [UIColor whiteColor];
    self.bgView.layer.cornerRadius = 10;
    self.bgView.layer.masksToBounds = YES;
    [self.contentView addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(135);
    }];
    
    self.goldImageView = [[UIImageView alloc] init];
    [self.bgView addSubview:self.goldImageView];
    [self.goldImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(7);
        make.width.mas_equalTo(28);
        make.height.mas_equalTo(31);
    }];
    
    self.coverImageView = [[UIImageView alloc] init];
    [self.bgView addSubview:self.coverImageView];
    [self.coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(100);
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(15);
    }];
    [self.bgView sendSubviewToBack:self.coverImageView];
    
    self.mainTitleLabel = [[UILabel alloc] init];
    self.mainTitleLabel.numberOfLines = 2;
    self.mainTitleLabel.font = [UIFont boldSystemFontOfSize:13];
    self.mainTitleLabel.textColor = [UIColor blackColor];
    [self.bgView addSubview:self.mainTitleLabel];
    [self.mainTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.coverImageView.mas_right).offset(11);
        make.top.mas_equalTo(self.coverImageView.mas_top).offset(2);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(31);
    }];
    
    self.subTitleLabel = [[UILabel alloc] init];
    self.subTitleLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
    self.subTitleLabel.textColor = CZColorCreater(129, 129, 146, 1.0);
    [self.bgView addSubview:self.subTitleLabel];
    [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mainTitleLabel);
        make.top.mas_equalTo(self.mainTitleLabel.mas_bottom).offset(8);
        make.width.mas_greaterThanOrEqualTo(0);
        make.height.mas_equalTo(12);
    }];
    
    self.distanceLabel = [[UILabel alloc] init];
    self.distanceLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
    self.distanceLabel.textColor = CZColorCreater(129, 129, 146, 1.0);
    [self.bgView addSubview:self.distanceLabel];
    [self.distanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(self.mainTitleLabel.mas_bottom).offset(8);
        make.height.width.mas_greaterThanOrEqualTo(0);
    }];
    
    {
        UIImageView *circle = [[UIImageView alloc] init];
        circle.backgroundColor = CZColorCreater(251, 104, 83, 1);
        circle.layer.masksToBounds = YES;
        circle.layer.cornerRadius = 10;
        circle.layer.borderWidth = 1;
        circle.layer.borderColor = UIColor.whiteColor.CGColor;
        [self.bgView addSubview:circle];
        [circle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(20);
            make.left.mas_equalTo(self.coverImageView.mas_right).offset(11);
            make.bottom.mas_equalTo(self.coverImageView).offset(-18);
        }];
        
        UIImageView *fire = [[UIImageView alloc] init];
        fire.image = [CZImageProvider imageNamed:@"fire"];
        [circle addSubview:fire];
        [fire mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(10);
            make.height.mas_equalTo(19.5);
            make.center.mas_equalTo(circle);
        }];
        
        UIImageView *wordBgView = [[UIImageView alloc] init];
        wordBgView.backgroundColor = CZColorCreater(251, 104, 83, 1);
        wordBgView.layer.masksToBounds = YES;
        wordBgView.layer.cornerRadius = 10;
        [self.bgView addSubview:wordBgView];
        [self.bgView sendSubviewToBack:wordBgView];

        self.popularityLabel = [[UILabel alloc] init];
        self.popularityLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:11];
        self.popularityLabel.textColor = [UIColor whiteColor];
        [self.bgView addSubview:self.popularityLabel];
        [self.popularityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(circle.mas_right).offset(4);
            make.centerY.mas_equalTo(circle);
            make.width.height.mas_greaterThanOrEqualTo(0);
        }];
        
        [wordBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(circle.mas_centerX).offset(-10);
            make.top.bottom.mas_equalTo(circle);
            make.right.mas_equalTo(self.popularityLabel.mas_right).offset(7);
        }];
    }
    
    self.priceLabel = [[UILabel alloc] init];
    self.priceLabel.textColor = CZColorCreater(255, 68, 85, 1);
    self.priceLabel.font = [UIFont boldSystemFontOfSize:12];
    [self.bgView addSubview:self.priceLabel];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_greaterThanOrEqualTo(0);
        make.centerY.mas_equalTo(self.coverImageView.mas_bottom);
        make.left.mas_equalTo(self.coverImageView.mas_right).offset(11);
    }];
}

-(void)setModel:(CZProductModel *)model
{
    _model = model;
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:PIC_URL(model.banners)] placeholderImage:[CZImageProvider imageNamed:@"fen_mian_mo_ren_tu"]];
    self.mainTitleLabel.text = model.title;
    self.subTitleLabel.text = model.organName;
    self.popularityLabel.text = @"近30天累计人气";
    self.priceLabel.text = [NSString stringWithFormat:@"¥%.2f",model.price.floatValue/100.0];
    
    self.distanceLabel.text = [NSString stringWithFormat:@"%.2fkm" , model.distance.floatValue/1000.0];
}

@end
