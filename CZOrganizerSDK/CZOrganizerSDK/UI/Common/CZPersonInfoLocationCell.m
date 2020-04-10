//
//  CZPersionInfoLocationCell.m
//  CZOrganizerSDK
//
//  Created by zsc on 2020/2/29.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZPersonInfoLocationCell.h"
#import "CZPersonInfoView.h"
#import "CZPaddingLabel.h"
#import "CZSchoolStarModel.h"
#import "UIImageView+WebCache.h"

@interface CZPersonInfoLocationCell ()

@property (nonatomic , strong) CZPersonInfoView *infoView;

@property (nonatomic , strong) CZPaddingLabel *fromLabel;

@property (nonatomic , strong) UILabel *countyLabel;

@property (nonatomic , strong) UIImageView *iconImageView;

@end

@implementation CZPersonInfoLocationCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initWithUI];
    }
    return self;
}
/**
 * 赋值信息
 */

/**
 * 初始化UI
 */
- (void)initWithUI{
    self.infoView = [[CZPersonInfoView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 70) container:self.contentView];
    self.fromLabel = [[CZPaddingLabel alloc] init];
    self.fromLabel.edgeInsets = UIEdgeInsetsMake(3, 3, 3, 3);
    [self.contentView addSubview:self.fromLabel];
    [self.fromLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(68);
        make.top.mas_equalTo(self.infoView.mas_bottom).offset(0);
        make.width.height.mas_greaterThanOrEqualTo(0);
    }];
    self.fromLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:9];
    self.fromLabel.textColor = CZColorCreater(51, 172, 253, 1);
    self.fromLabel.layer.borderWidth = 0.5;
    self.fromLabel.layer.masksToBounds = YES;
    self.fromLabel.layer.cornerRadius = 1.5;
    self.fromLabel.layer.borderColor = CZColorCreater(51, 172, 253, 1).CGColor;
    
    self.countyLabel = [[UILabel alloc] init];
    self.countyLabel.textColor = CZColorCreater(129, 129, 146, 1);
    self.countyLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:12];
    [self.contentView addSubview:self.countyLabel];
    [self.countyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_greaterThanOrEqualTo(1);
        make.centerY.mas_equalTo(self.fromLabel);
        make.right.mas_equalTo(-15);
    }];
    
    self.iconImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.iconImageView];
    self.iconImageView.image = [CZImageProvider imageNamed:@"shou_ye_ding_wei_cell"];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(10.5);
        make.height.mas_equalTo(12);
        make.centerY.mas_equalTo(self.countyLabel);
        make.right.mas_equalTo(self.countyLabel.mas_left).offset(-6);
    }];
}

-(void)setModel:(CZSchoolStarModel *)model
{
    _model = model;
    
    [self.infoView.avatarImageView sd_setImageWithURL:[NSURL URLWithString:PIC_URL(model.userImg)] placeholderImage:[CZImageProvider imageNamed:@"default_avatar"]];
    self.infoView.infoLabel.text = model.realName;
    NSString *formatterString = NSLocalizedString(@"服务%@人", nil);
    self.infoView.subTitleLabel.text = [NSString stringWithFormat:formatterString,[@(model.servicePersonCount.integerValue) stringValue]];
    self.fromLabel.text = [NSString stringWithFormat:@"%@/%@",model.schoolName,NSLocalizedString(@"留学中", nil)];
    self.countyLabel.text = model.countryName;
}
@end
