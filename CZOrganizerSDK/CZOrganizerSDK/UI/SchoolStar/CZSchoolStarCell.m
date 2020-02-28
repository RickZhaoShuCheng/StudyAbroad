//
//  CZSchoolStarCell.m
//  CZOrganizerSDK
//
//  Created by zsc on 2020/2/25.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZSchoolStarCell.h"
#import "CZSchoolStarModel.h"
#import "UIImageView+WebCache.h"

@interface CZSchoolStarCell ()
@property (nonatomic , strong) UIImageView *avatarImageView;
@property (nonatomic , strong) UILabel *nameLabel;
@property (nonatomic , strong) UILabel *servicePriceLabel;
@property (nonatomic , strong) UILabel *introduceLabel;
@property (nonatomic , strong) UILabel *schoolNameLabel;
@property (nonatomic , strong) UIImageView *vipImageView;
@property (nonatomic , strong) UIImageView *bgView;

@end

@implementation CZSchoolStarCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initWithUI];
    }
    return self;
}

- (void)initWithUI{

    self.bgView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    self.bgView.layer.masksToBounds = YES;
    self.bgView.layer.cornerRadius = 1;
    self.bgView.layer.borderWidth = 0.5;
    self.bgView.layer.borderColor = CZColorCreater(241, 241, 245, 1).CGColor;
    
    self.avatarImageView = [[UIImageView alloc] init];
    self.avatarImageView.layer.masksToBounds = YES;
    self.avatarImageView.layer.cornerRadius = 25;
    [self.contentView addSubview:self.avatarImageView];
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(50);
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(13);
    }];
    
    self.vipImageView = [[UIImageView alloc] init];
    self.vipImageView.image = [CZImageProvider imageNamed:@"zhu_ye_lao_shi_da_v"];
    [self.contentView addSubview:self.vipImageView];
    [self.vipImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.mas_equalTo(self.avatarImageView);
        make.width.mas_equalTo(18.5);
        make.height.mas_equalTo(20.5);
    }];
    
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.textColor = [UIColor blackColor];
    self.nameLabel.font = [UIFont boldSystemFontOfSize:12];
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.avatarImageView.mas_bottom).offset(5);
        make.height.mas_greaterThanOrEqualTo(0);
        make.left.mas_equalTo(5);
        make.right.mas_equalTo(-5);
    }];
    
    self.servicePriceLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.servicePriceLabel];
    self.servicePriceLabel.textAlignment = NSTextAlignmentCenter;
    [self.servicePriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(14);
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(5);
        make.left.mas_equalTo(5);
        make.right.mas_equalTo(-5);
    }];

    
    self.introduceLabel = [[UILabel alloc] init];
    self.introduceLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:10];
    self.introduceLabel.textAlignment = NSTextAlignmentCenter;
    self.introduceLabel.textColor = CZColorCreater(170, 170, 187, 1);
    [self.contentView addSubview:self.introduceLabel];
    [self.introduceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_greaterThanOrEqualTo(0);
        make.top.mas_equalTo(self.servicePriceLabel.mas_bottom).offset(10);
        make.left.mas_equalTo(5);
        make.right.mas_equalTo(-5);
    }];
    
    self.schoolNameLabel = [[UILabel alloc] init];
    self.schoolNameLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:10];
    self.schoolNameLabel.textAlignment = NSTextAlignmentCenter;
    self.schoolNameLabel.textColor = CZColorCreater(103, 103, 121, 1);
    [self.contentView addSubview:self.schoolNameLabel];
    [self.schoolNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_greaterThanOrEqualTo(0);
        make.top.mas_equalTo(self.introduceLabel.mas_bottom).offset(5);
        make.left.mas_equalTo(5);
        make.right.mas_equalTo(-5);
    }];
    
}

-(void)setModel:(CZSchoolStarModel *)model
{
    _model = model;
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:PIC_URL(model.userImg)] placeholderImage:nil];
    self.nameLabel.text = model.realName;
    self.schoolNameLabel.text = model.schoolName;
    self.introduceLabel.text = model.sportIntroduction;
    
    NSDictionary *attribtDic1 = @{NSForegroundColorAttributeName:CZColorCreater(51, 172, 253, 1),
                                  NSFontAttributeName:[UIFont fontWithName:@"PingFang-SC-Medium" size:10]
    };
    NSMutableAttributedString *attribtStr1 = [[NSMutableAttributedString alloc]initWithString:model.reserveCount.stringValue attributes:attribtDic1];
    
    NSDictionary *attribtDic2 = @{NSForegroundColorAttributeName:CZColorCreater(170, 170, 187, 1),
                                  NSFontAttributeName:[UIFont fontWithName:@"PingFang-SC-Medium" size:10]
    };
    NSMutableAttributedString *attribtStr2 = [[NSMutableAttributedString alloc]initWithString:@" 服务 | " attributes:attribtDic2];
    [attribtStr1 appendAttributedString:attribtStr2];
    
    NSDictionary *attribtDic3 = @{NSForegroundColorAttributeName:CZColorCreater(255, 68, 85, 1),
                                  NSFontAttributeName:[UIFont fontWithName:@"PingFang-SC-Medium" size:10]
    };
    NSMutableAttributedString *attribtStr3 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@元",model.lowPrice] attributes:attribtDic3];
    [attribtStr1 appendAttributedString:attribtStr3];
    
    NSDictionary *attribtDic4 = @{NSForegroundColorAttributeName:CZColorCreater(170, 170, 187, 1),
                                  NSFontAttributeName:[UIFont fontWithName:@"PingFang-SC-Medium" size:10]
    };
    NSMutableAttributedString *attribtStr4 = [[NSMutableAttributedString alloc]initWithString:@" 起" attributes:attribtDic4];
    [attribtStr1 appendAttributedString:attribtStr4];
    self.servicePriceLabel.attributedText = attribtStr1;
}

@end
