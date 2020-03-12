
//
//  CZOrganizerAdvisorCell.m
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/12.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZOrganizerAdvisorCell.h"
#import "UIImageView+WebCache.h"
#import "CZRankView.h"

@interface CZOrganizerAdvisorCell()
@property (nonatomic ,strong) UIImageView *avatarImg;
@property (nonatomic ,strong) UIImageView *VImg;
@property (nonatomic ,strong) UILabel *nameLab;
@property (nonatomic ,strong) UILabel *advisorLab;
@property (nonatomic ,strong) CZRankView *rankView;
@property (nonatomic ,strong) UILabel *countLab;
@end
@implementation CZOrganizerAdvisorCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self initWithUI];
        [self.avatarImg sd_setImageWithURL:[NSURL URLWithString:@"http://ztd00.photos.bdimg.com/ztd/w=700;q=50/sign=dc636c57845494ee87220d191dce91c3/8718367adab44aed01ce530cbb1c8701a08bfb52.jpg"] placeholderImage:nil];
    }
    return self;
}

/**
 * 初始化UI
 */
- (void)initWithUI{
    self.avatarImg = [[UIImageView alloc] init];
    self.avatarImg.backgroundColor = [UIColor redColor];
    self.avatarImg.layer.masksToBounds = YES;
    self.avatarImg.layer.cornerRadius = WidthRatio(90)/2.0;
    [self.contentView addSubview:self.avatarImg];
    [self.avatarImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.contentView.mas_leading).offset(WidthRatio(30));
        make.centerY.mas_equalTo(self.contentView);
        make.size.mas_equalTo(WidthRatio(90));
    }];
    
    self.VImg = [[UIImageView alloc]init];
    self.VImg.image = [CZImageProvider imageNamed:@"shou_ye_ren_zheng_cell"];
    [self addSubview:self.VImg];
    [self.VImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.avatarImg.mas_bottom).offset(-HeightRatio(18));
        make.centerX.mas_equalTo(self.avatarImg);
        make.width.mas_equalTo(WidthRatio(78));
        make.height.mas_equalTo(HeightRatio(36));
    }];
    
    self.nameLab = [[UILabel alloc]init];
    self.nameLab.font = [UIFont boldSystemFontOfSize:WidthRatio(26)];
    self.nameLab.textColor = CZColorCreater(51, 51, 51, 1);
    self.nameLab.text = @"郭静";
    [self.contentView addSubview:self.nameLab];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.avatarImg.mas_trailing).offset(WidthRatio(16));
        make.top.mas_equalTo(self.avatarImg.mas_top).offset(HeightRatio(2));
        make.height.mas_greaterThanOrEqualTo(0);
        make.trailing.mas_equalTo(self.contentView.mas_trailing).offset(-WidthRatio(30));
    }];
    
    self.advisorLab = [[UILabel alloc]init];
    self.advisorLab.font = [UIFont systemFontOfSize:WidthRatio(22)];
    self.advisorLab.textColor = CZColorCreater(129, 129, 146, 1);
    self.advisorLab.text = @"南京市海牛工作室";
    [self.contentView addSubview:self.advisorLab];
    [self.advisorLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.avatarImg.mas_trailing).offset(WidthRatio(16));
        make.top.mas_equalTo(self.nameLab.mas_bottom).offset(HeightRatio(8));
        make.height.mas_greaterThanOrEqualTo(0);
        make.trailing.mas_equalTo(self.contentView.mas_trailing).offset(-WidthRatio(30));
    }];
    
    self.rankView = [CZRankView instanceRankViewByRate:3.1];
    self.rankView.frame = CGRectMake(0, 0, WidthRatio(150), HeightRatio(28));
    [self.contentView addSubview:self.rankView];
    [self.rankView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.avatarImg.mas_trailing).offset(WidthRatio(16));
        make.top.mas_equalTo(self.advisorLab.mas_bottom).offset(HeightRatio(10));
        make.size.mas_equalTo(self.rankView.frame.size);
    }];
    
    self.countLab = [[UILabel alloc]init];
    self.countLab.font = [UIFont systemFontOfSize:WidthRatio(22)];
    self.countLab.textColor = CZColorCreater(170, 170, 187, 1);
    self.countLab.text = @"服务3637人";
    [self.contentView addSubview:self.countLab];
    [self.countLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.rankView.mas_trailing);
        make.top.mas_equalTo(self.rankView.mas_top).offset(-HeightRatio(2));
        make.height.mas_greaterThanOrEqualTo(0);
        make.trailing.mas_equalTo(self.contentView.mas_trailing).offset(-WidthRatio(30));
    }];
}
@end
