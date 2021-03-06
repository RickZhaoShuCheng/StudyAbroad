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

- (void)setModel:(CZAdvisorModel *)model{
    _model = model;
    [self.avatarImg sd_setImageWithURL:[NSURL URLWithString:PIC_URL(model.counselorImg)] placeholderImage:nil];
    self.nameLab.text = model.counselorName;
    self.countLab.text = [NSString stringWithFormat:@"%@个案例",[@([model.caseCount integerValue]) stringValue]];
    if ([model.status integerValue] == 1) {
        self.VImg.hidden = NO;
    }else{
        self.VImg.hidden = YES;
    }
}
/**
 * 初始化UI
 */
- (void)initWithUI{
    self.bgView = [[UIView alloc]init];
    self.bgView.backgroundColor = CZColorCreater(76, 182, 253, 0.05);
    self.bgView.layer.masksToBounds = YES;
    self.bgView.layer.cornerRadius = ScreenScale(5);
    [self.contentView addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.leading.bottom.mas_equalTo(self.contentView);
        make.height.mas_equalTo(self.bgView.mas_width);
    }];
    
    self.avatarImg = [[UIImageView alloc]init];
    self.avatarImg.layer.masksToBounds = YES;
    self.avatarImg.layer.cornerRadius = ScreenScale(108)/2;
    self.avatarImg.layer.borderColor = CZColorCreater(229, 239, 248, 1).CGColor;
    self.avatarImg.layer.borderWidth = ScreenScale(6);
    [self.contentView addSubview:self.avatarImg];
    [self.avatarImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.bgView.mas_top);
        make.size.mas_equalTo(ScreenScale(108));
        make.centerX.mas_equalTo(self.contentView);
    }];
    
    self.VImg = [[UIImageView alloc]init];
    self.VImg.image = [CZImageProvider imageNamed:@"shou_ye_ren_zheng_cell"];
    [self.contentView addSubview:self.VImg];
    [self.VImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.avatarImg.mas_bottom).offset(-ScreenScale(18));
        make.centerX.mas_equalTo(self.avatarImg);
        make.width.mas_equalTo(ScreenScale(85));
        make.height.mas_equalTo(ScreenScale(36));
    }];
    
    self.nameLab = [[UILabel alloc]init];
    self.nameLab.text = @"-";
    self.nameLab.font = [UIFont systemFontOfSize:ScreenScale(28)];
    self.nameLab.textColor = CZColorCreater(53, 53, 53, 1);
    self.nameLab.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.nameLab];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.VImg.mas_bottom).offset(ScreenScale(10));
        make.leading.trailing.mas_equalTo(self.contentView);
    }];
    
    self.countLab = [[UILabel alloc]init];
    self.countLab.text = @"-个案例";
    self.countLab.font = [UIFont systemFontOfSize:ScreenScale(24)];
    self.countLab.textColor = CZColorCreater(129, 129, 146, 1);
    self.countLab.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.countLab];
    [self.countLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.nameLab.mas_bottom).offset(ScreenScale(16));
        make.leading.trailing.mas_equalTo(self.contentView);
    }];
    
}
@end
