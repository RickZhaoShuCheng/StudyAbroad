
//
//  AdvisorDynamicPostCell.m
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/22.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "AdvisorDynamicPostCell.h"

@interface AdvisorDynamicPostCell()
@property (nonatomic ,strong) UIImageView *avatarImg;
@property (nonatomic ,strong) UILabel *nameLab;
@property (nonatomic ,strong) UILabel *timeLab;
@end
@implementation AdvisorDynamicPostCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initWithUI];
    }
    return self;
}

/**
 * 初始化UI
 */
- (void)initWithUI{
    self.avatarImg = [[UIImageView alloc]init];
    self.avatarImg.backgroundColor = [UIColor redColor];
    self.avatarImg.layer.masksToBounds = YES;
    self.avatarImg.layer.cornerRadius = ScreenScale(60)/2;
    [self.contentView addSubview:self.avatarImg];
    [self.avatarImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.contentView.mas_leading).offset(ScreenScale(30));
        make.top.mas_equalTo(self.contentView.mas_top).offset(ScreenScale(30));
        make.size.mas_equalTo(ScreenScale(60));
    }];
    
    self.nameLab = [[UILabel alloc]init];
    self.nameLab.text = @"许一铭";
    self.nameLab.textColor = [UIColor blackColor];
    self.nameLab.font = [UIFont boldSystemFontOfSize:ScreenScale(26)];
    [self.contentView addSubview:self.nameLab];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.avatarImg.mas_trailing).offset(ScreenScale(10));
        make.top.mas_equalTo(self.avatarImg.mas_top);
        make.height.mas_greaterThanOrEqualTo(0);
        make.trailing.mas_equalTo(self.contentView.mas_trailing).offset(-ScreenScale(30));
    }];
    
    self.timeLab = [[UILabel alloc]init];
    self.timeLab.text = @"2小时前 ";
    self.timeLab.textColor = CZColorCreater(159, 159, 178, 1);
    self.timeLab.font = [UIFont boldSystemFontOfSize:ScreenScale(22)];
    [self.contentView addSubview:self.timeLab];
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.avatarImg.mas_trailing).offset(ScreenScale(10));
        make.bottom.mas_equalTo(self.avatarImg.mas_bottom);
        make.height.mas_greaterThanOrEqualTo(0);
        make.trailing.mas_equalTo(self.contentView.mas_trailing).offset(-ScreenScale(30));
    }];
    
}
@end
