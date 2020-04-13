//
//  CZCarefullyChooseCell.m
//  CZOrganizerSDK
//
//  Created by zsc on 2020/2/26.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZCarefullyChooseCell.h"
#import "UIImageView+WebCache.h"

@interface CZCarefullyChooseCell ()
@property (nonatomic , strong) UIImageView *coverImageView;
@property (nonatomic , strong) UILabel *nameLabel;
@property (nonatomic , strong) UILabel *priceLabel;
@property (nonatomic , strong) UILabel *addressLabel;
@property (nonatomic , strong) UILabel *distanceLabel;
@property (nonatomic , strong) UILabel *orgPriceLabel;

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
    
    self.contentView.layer.masksToBounds = YES;
    self.contentView.layer.cornerRadius = 2.5;
    
    self.coverImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.coverImageView];
    [self.coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(self.contentView.mas_width).multipliedBy(132/165.0);
    }];
    
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.textColor = [UIColor blackColor];
    self.nameLabel.font = [UIFont boldSystemFontOfSize:14];
    self.nameLabel.numberOfLines = 2;
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.coverImageView.mas_bottom).offset(7);
        make.height.mas_greaterThanOrEqualTo(0);
        make.left.mas_equalTo(9);
        make.right.mas_equalTo(-9);
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

    self.distanceLabel = [[UILabel alloc] init];
    self.distanceLabel.textAlignment = NSTextAlignmentRight;
    self.distanceLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:11];
    self.distanceLabel.textColor = CZColorCreater(129, 129, 146, 1);
    [self.contentView addSubview:self.distanceLabel];
    [self.distanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_greaterThanOrEqualTo(0);
        make.right.mas_equalTo(self.nameLabel);
        make.bottom.mas_equalTo(self.addressLabel);
    }];
    
    self.orgPriceLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.orgPriceLabel];
    [self.orgPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_greaterThanOrEqualTo(0);
        make.left.mas_equalTo(self.priceLabel.mas_right).offset(5);
        make.centerY.mas_equalTo(self.priceLabel);
    }];
    
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_greaterThanOrEqualTo(0);
        make.left.mas_equalTo(self.nameLabel);
        make.bottom.mas_equalTo(-12.5);
        make.right.mas_equalTo(self.distanceLabel.mas_left).offset(-5);
    }];
    
    [self.distanceLabel setContentHuggingPriority:UILayoutPriorityRequired
    forAxis:UILayoutConstraintAxisHorizontal];
    
}

-(void)setModel:(CZProductModel *)model
{
    _model = model;
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:PIC_URL(model.logo)] placeholderImage:[CZImageProvider imageNamed:@"fen_mian_mo_ren_tu"]];
    self.nameLabel.text = model.title;
    self.priceLabel.text = [NSString stringWithFormat:@"￥%.2f" , model.price.floatValue/100.0];
    self.addressLabel.text = model.organName;
    self.distanceLabel.text =[NSString stringWithFormat:@"%.2fkm" , model.distance.floatValue/1000.0];
    
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle],NSForegroundColorAttributeName:CZColorCreater(129, 129, 146, 1),NSFontAttributeName:[UIFont fontWithName:@"PingFang-SC-Medium" size:11]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"￥%.2f" , model.oldPrice.floatValue/100.0] attributes:attribtDic];
    self.orgPriceLabel.attributedText = attribtStr;
}

@end
