//
//  CZBoardProdcutTopCell.m
//  CZOrganizerSDK
//
//  Created by 赵曙诚 on 2020/3/22.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZBoardProductTopCell.h"
#import "UIImageView+WebCache.h"
#import "CZCommentModel.h"

@interface CZBoardProductTopCell()

@property (nonatomic , strong) UIImageView *goldImageView;
@property (nonatomic , strong) UIImageView *bgView;
@property (nonatomic , strong) UIImageView *coverImageView;
@property (nonatomic , strong) UILabel *mainTitleLabel;
@property (nonatomic , strong) UILabel *subTitleLabel;
@property (nonatomic , strong) UILabel *distanceLabel;
@property (nonatomic , strong) UILabel *popularityLabel;
@property (nonatomic , strong) UILabel *priceLabel;
@property (nonatomic , strong) UIView *bottomView;
@property (nonatomic , strong) UIImageView *avatarImageView;
@property (nonatomic , strong) UILabel *avatarDetailLabel;

@end

@implementation CZBoardProductTopCell

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
        make.height.mas_equalTo(177);
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
        make.height.mas_greaterThanOrEqualTo(0);
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
        make.centerY.mas_equalTo(self.coverImageView);
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
    
    self.bottomView = [[UIView alloc] init];
    self.bottomView.layer.cornerRadius = 16;
    self.bottomView.layer.masksToBounds = YES;
    self.bottomView.backgroundColor = CZColorCreater(245, 245, 249, 1);
    [self.bgView addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.bottom.mas_equalTo(-15);
        make.height.mas_equalTo(32);
    }];
    
    self.avatarImageView = [[UIImageView alloc] init];
    self.avatarImageView.layer.cornerRadius = 11;
    self.avatarImageView.layer.masksToBounds = YES;
    [self.bottomView addSubview:self.avatarImageView];
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(22);
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(7.5);
    }];
    
    self.avatarDetailLabel = [[UILabel alloc] init];
    self.avatarDetailLabel.textColor = CZColorCreater(129, 129, 146, 1);
    self.avatarDetailLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:12];
    [self.bottomView addSubview:self.avatarDetailLabel];
    [self.avatarDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_greaterThanOrEqualTo(0);
        make.centerY.mas_equalTo(self.avatarImageView);
        make.left.mas_equalTo(self.avatarImageView.mas_right).offset(5);
        make.right.mas_equalTo(-5);
    }];
}

-(void)setType:(CZBoardProductTopType)type
{
    _type = type;
    switch (type) {
        case CZBoardProductTopTypeGold:
            self.goldImageView.image = [CZImageProvider imageNamed:@"shou_ye_jin_pai"];
            break;
        case CZBoardProductTopTypeSilver:
            self.goldImageView.image = [CZImageProvider imageNamed:@"shou_ye_yin_pai"];
            break;
        case CZBoardProductTopTypeCopper:
            self.goldImageView.image = [CZImageProvider imageNamed:@"shou_ye_tong_pai"];
            break;
        default:
            break;
    }
    
    self.goldImageView.hidden = NO;
    if (type > 2) {
        self.goldImageView.hidden = YES;
    }
}

-(void)setModel:(CZProductModel *)model
{
    _model = model;
    NSArray *banners = [model.banners componentsSeparatedByString:@","];
    NSString *imageName = @"";
    if (banners) {
        imageName = banners[0];
    }
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:PIC_URL(imageName)] placeholderImage:[CZImageProvider imageNamed:@"fen_mian_mo_ren_tu"]];
    self.mainTitleLabel.text = model.title;
    self.subTitleLabel.text = model.organName.length > 0?model.organName:model.sportRealName;
    self.popularityLabel.text = @"近30天累计人气";
    self.priceLabel.text = [NSString stringWithFormat:@"¥%.2f",model.price.floatValue/100.0];
    
    self.avatarDetailLabel.text = @"";
    self.avatarImageView.image = [CZImageProvider imageNamed:@"default_avatar"];
    if (model.comments.count > 0) {
        CZCommentModel *comment = [model.comments firstObject];
        self.avatarDetailLabel.text = comment.comment;
        [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:PIC_URL(comment.userImg)] placeholderImage:nil];
        self.bottomView.hidden = NO;
        
        [self.bgView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.top.mas_equalTo(0);
            make.height.mas_equalTo(177);
        }];
    }
    else
    {
        self.bottomView.hidden = YES;
        
        [self.bgView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.top.mas_equalTo(0);
            make.height.mas_equalTo(135);
        }];
    }
    
    [self.contentView layoutIfNeeded];
    
    self.distanceLabel.text = [NSString stringWithFormat:@"%.2fkm" , model.distance.floatValue/1000.0];
    
}

@end
