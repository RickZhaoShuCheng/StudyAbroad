//
//  CZSelectCityCell.m
//  CZOrganizerSDK
//
//  Created by zsc on 2020/3/2.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZSelectProvinceCell.h"
#import "CZSCountryModel.h"

@interface CZSelectProvinceCell ()
@property (nonatomic , strong) UILabel *nameLabel;
@end

@implementation CZSelectProvinceCell

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
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.nameLabel];
    self.nameLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:13];
    self.nameLabel.textColor = CZColorCreater(13, 13, 13, 1);
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(5);
        make.right.mas_equalTo(-5);
        make.height.mas_greaterThanOrEqualTo(0);
        make.centerY.mas_equalTo(0);
    }];
    self.backgroundColor = CZColorCreater(244, 244, 248, 1);
}

-(void)setModel:(CZSCountryModel *)model
{
    _model = model;
    self.nameLabel.text = model.country.area_name;
}

-(void)setDidSelect:(BOOL)didSelect
{
    _didSelect = didSelect;
    self.nameLabel.textColor = didSelect?CZColorCreater(51, 172, 253, 1):CZColorCreater(13, 13, 13, 1);
}

@end
