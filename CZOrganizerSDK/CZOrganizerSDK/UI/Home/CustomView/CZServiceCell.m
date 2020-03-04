//
//  CZServiceCell.m
//  CZOrganizerSDK
//
//  Created by zsc on 2020/2/21.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZServiceCell.h"
#import "CZHomeModel.h"
#import "UIImageView+WebCache.h"

@interface CZServiceCell ()

@property (nonatomic , strong) UIImageView *iconImageView;

@property (nonatomic , strong) UILabel *mainTitleLabel;

@end

@implementation CZServiceCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initWithUI];
    }
    return self;
}

- (void)initWithUI{
    self.iconImageView = [[UIImageView alloc] init];
    self.iconImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:self.iconImageView];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(25);
        make.centerY.mas_equalTo(-20);
        make.centerX.mas_equalTo(0);
    }];
    
    self.mainTitleLabel = [[UILabel alloc] init];
    self.mainTitleLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:13];
    self.mainTitleLabel.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
    [self.contentView addSubview:self.mainTitleLabel];
    [self.mainTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_greaterThanOrEqualTo(0);
        make.centerX.mas_equalTo(0);
        make.centerY.mas_equalTo(20);
    }];
}

-(void)setModel:(CZHomeModel *)model
{
    _model = model;
    if (model.sort) {
        self.mainTitleLabel.text = model.content1;
        [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:PIC_URL(model.spImg)] placeholderImage:nil];
    }
    else
    {
        self.mainTitleLabel.text = @"";
        self.iconImageView.image = nil;
    }

}
@end
