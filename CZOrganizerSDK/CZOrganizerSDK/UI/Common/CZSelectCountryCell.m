//
//  CZSelectCountryCell.m
//  CZOrganizerSDK
//
//  Created by zsc on 2020/3/2.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZSelectCountryCell.h"
#import "CZSCountryModel.h"

@interface CZSelectCountryCell ()
@property (nonatomic , strong) UILabel *nameLabel;
@property (nonatomic , strong) UIImageView *lineImageView;
@end

@implementation CZSelectCountryCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initWithUI];
    }
    return self;
}

-(void)initWithUI
{
    self.lineImageView = [[UIImageView alloc] init];
    self.lineImageView.backgroundColor = CZColorCreater(51, 172, 253, 1);
    [self.contentView addSubview:self.lineImageView];
    [self.lineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.centerY.mas_equalTo(0);
        make.width.mas_equalTo(2.5);
        make.height.mas_equalTo(18.5);
    }];
    
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.nameLabel];
    self.nameLabel.font = [UIFont boldSystemFontOfSize:13];
    self.nameLabel.textColor = CZColorCreater(13, 13, 13, 1);
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(5);
        make.right.mas_equalTo(-5);
        make.height.mas_greaterThanOrEqualTo(0);
        make.centerY.mas_equalTo(0);
    }];
}

-(void)setModel:(CZSCountryModel *)model
{
    _model = model;
    self.nameLabel.text = model.country.area_name;
}

-(void)setDidSelect:(BOOL)didSelect
{
    _didSelect = didSelect;
    self.lineImageView.hidden = !didSelect;
    self.contentView.backgroundColor = didSelect?[UIColor whiteColor]:CZColorCreater(245, 245, 249, 1);
}

@end
