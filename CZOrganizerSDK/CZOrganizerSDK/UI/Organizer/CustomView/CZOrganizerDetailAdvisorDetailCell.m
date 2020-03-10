//
//  CZOrganizerDetailAdvisorDetailCell.m
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/9.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZOrganizerDetailAdvisorDetailCell.h"
#import "UIImageView+WebCache.h"
@interface CZOrganizerDetailAdvisorDetailCell()
@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) UIImageView *avatarImg;
@property (nonatomic,strong) UIImageView *VImg;
@property (nonatomic,strong) UILabel *nameLab;
@property (nonatomic,strong) UILabel *countLab;
@end
@implementation CZOrganizerDetailAdvisorDetailCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initWithUI];
    }
    return self;
}
/**
 * 初始化UI
 */
- (void)initWithUI{
    self.bgView = [[UIView alloc]init];
    self.bgView.backgroundColor = CZColorCreater(76, 182, 253, 0.05);
    self.bgView.layer.masksToBounds = YES;
    self.bgView.layer.cornerRadius = WidthRatio(5);
    [self.contentView addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.leading.bottom.mas_equalTo(self.contentView);
        make.height.mas_equalTo(self.bgView.mas_width);
    }];
    
    self.avatarImg = [[UIImageView alloc]init];
    self.avatarImg.layer.masksToBounds = YES;
    self.avatarImg.layer.cornerRadius = WidthRatio(108)/2;
    self.avatarImg.layer.borderColor = CZColorCreater(229, 239, 248, 1).CGColor;
    self.avatarImg.layer.borderWidth = WidthRatio(6);
    [self.avatarImg sd_setImageWithURL:[NSURL URLWithString:@"http://b-ssl.duitang.com/uploads/item/201812/10/20181210163023_xXazM.thumb.700_0.jpeg"] placeholderImage:nil];
    [self.contentView addSubview:self.avatarImg];
    [self.avatarImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.bgView.mas_top);
        make.size.mas_equalTo(WidthRatio(108));
        make.centerX.mas_equalTo(self.contentView);
    }];
    
    self.VImg = [[UIImageView alloc]init];
    self.VImg.image = [CZImageProvider imageNamed:@"shou_ye_ren_zheng_cell"];
    [self.contentView addSubview:self.VImg];
    [self.VImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.avatarImg.mas_bottom).offset(-HeightRatio(18));
        make.centerX.mas_equalTo(self.avatarImg);
        make.width.mas_equalTo(WidthRatio(85));
        make.height.mas_equalTo(HeightRatio(36));
    }];
    
    self.nameLab = [[UILabel alloc]init];
    self.nameLab.text = @"俞敏洪";
    self.nameLab.font = [UIFont systemFontOfSize:WidthRatio(28)];
    self.nameLab.textColor = CZColorCreater(53, 53, 53, 1);
    self.nameLab.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.nameLab];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.VImg.mas_bottom).offset(HeightRatio(10));
        make.leading.trailing.mas_equalTo(self.contentView);
    }];
    
    self.countLab = [[UILabel alloc]init];
    self.countLab.text = @"3980个案例";
    self.countLab.font = [UIFont systemFontOfSize:WidthRatio(24)];
    self.countLab.textColor = CZColorCreater(129, 129, 146, 1);
    self.countLab.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.countLab];
    [self.countLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.nameLab.mas_bottom).offset(HeightRatio(16));
        make.leading.trailing.mas_equalTo(self.contentView);
    }];
    
}
@end
