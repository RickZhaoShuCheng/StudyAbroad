//
//  CZAdvisorDetailDiaryCell.m
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/5.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZAdvisorDetailDiaryCell.h"
#import "UIImageView+WebCache.h"
@interface CZAdvisorDetailDiaryCell ()
@property (nonatomic ,strong)UILabel *tipsLab;
@property (nonatomic ,strong)UILabel *titleLab;
@property (nonatomic ,strong)UIImageView *avatarImg;
@property (nonatomic ,strong)UIImageView *likeImg;
@property (nonatomic ,strong)UILabel *nameLab;
@property (nonatomic ,strong)UILabel *countLab;
@property (nonatomic ,strong)UILabel *schoolLab;
@end
@implementation CZAdvisorDetailDiaryCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initWithUI];
        [self.iconImg sd_setImageWithURL:[NSURL URLWithString:@"http://pic1.win4000.com/pic/1/9f/509593ca21.jpg"] placeholderImage:nil];
        [self.avatarImg sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1583430496699&di=2e9ba8fdb67aefd9577448dd47b6171e&imgtype=0&src=http%3A%2F%2Fp3.ssl.cdn.btime.com%2Ft01d5003ec96206de54.jpg%3Fsize%3D539x537"] placeholderImage:nil];
    }
    return self;
}
- (void)initWithUI{
    self.backgroundColor = [UIColor whiteColor];
    
    self.iconImg = [[UIImageView alloc]init];
    self.iconImg.layer.masksToBounds = YES;
    self.iconImg.layer.cornerRadius = ScreenScale(10);
    [self.contentView addSubview:self.iconImg];
    [self.iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.contentView.mas_leading).offset(ScreenScale(30));
        make.width.mas_equalTo(ScreenScale(330));
        make.top.mas_equalTo(self.contentView.mas_top).offset(ScreenScale(20));
        make.height.mas_equalTo(ScreenScale(474));
    }];
    
    self.tipsLab = [[UILabel alloc]init];
    self.tipsLab.font = [UIFont systemFontOfSize:ScreenScale(22)];
    self.tipsLab.text = @"#Seoul穿搭";
    self.tipsLab.textColor = CZColorCreater(170, 170, 187, 1);
    self.tipsLab.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.tipsLab];
    [self.tipsLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.iconImg.mas_leading);
        make.top.mas_equalTo(self.iconImg.mas_bottom).offset(ScreenScale(10));
        make.height.mas_greaterThanOrEqualTo(0);
        make.trailing.mas_equalTo(self.contentView.mas_trailing).offset(-ScreenScale(16));
    }];
    
    self.titleLab = [[UILabel alloc]init];
    self.titleLab.font = [UIFont systemFontOfSize:ScreenScale(28)];
    self.titleLab.text = @"晚餐就在位于公共市场的食在加拿大餐厅";
    self.titleLab.numberOfLines = 2;
    self.titleLab.textColor = CZColorCreater(0, 0, 0, 1);
    [self.contentView addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.iconImg.mas_leading);
        make.trailing.mas_equalTo(self.contentView.mas_trailing).offset(-ScreenScale(16));
        make.top.mas_equalTo(self.tipsLab.mas_bottom).offset(ScreenScale(10));
        make.height.mas_greaterThanOrEqualTo(0);
    }];
    
    self.avatarImg = [[UIImageView alloc]init];
    self.avatarImg.backgroundColor = [UIColor redColor];
    self.avatarImg.layer.masksToBounds = YES;
    self.avatarImg.layer.cornerRadius = ScreenScale(35)/2;
    [self.contentView addSubview:self.avatarImg];
    [self.avatarImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.iconImg.mas_leading);
        make.size.mas_equalTo(ScreenScale(35));
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-ScreenScale(18));
    }];
    
    self.countLab = [[UILabel alloc]init];
    self.countLab.font = [UIFont systemFontOfSize:ScreenScale(24)];
    self.countLab.text = @"8";
    self.countLab.textColor = CZColorCreater(107, 107, 124, 1);
    self.countLab.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.countLab];
    [self.countLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self.iconImg.mas_trailing).offset(-ScreenScale(16));
        make.centerY.mas_equalTo(self.avatarImg);
        make.height.width.mas_greaterThanOrEqualTo(0);
    }];
    
    self.likeImg = [[UIImageView alloc]init];
    self.likeImg.image = [CZImageProvider imageNamed:@"zhu_ye_zan"];
    [self.contentView addSubview:self.likeImg];
    [self.likeImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self.countLab.mas_leading).offset(-ScreenScale(10)).priorityHigh();
        make.width.mas_equalTo(ScreenScale(25));
        make.height.mas_equalTo(ScreenScale(20));
        make.centerY.mas_equalTo(self.countLab);
    }];
    
    
    self.nameLab = [[UILabel alloc]init];
    self.nameLab.font = [UIFont systemFontOfSize:ScreenScale(22)];
    self.nameLab.text = @"许一铭";
    self.nameLab.textColor = CZColorCreater(107, 107, 124, 1);
    [self.contentView addSubview:self.nameLab];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.avatarImg.mas_trailing).offset(ScreenScale(10));
        make.centerY.mas_equalTo(self.avatarImg);
        make.height.width.mas_greaterThanOrEqualTo(0);
//        make.trailing.mas_equalTo(self.likeImg.mas_trailing).offset(-ScreenScale(10)).priorityLow();
    }];
    
    UIImageView *logoImg = [[UIImageView alloc]init];
    logoImg.image = [CZImageProvider imageNamed:@"zhu_ye_ri_ji"];
    [self.iconImg addSubview:logoImg];
    [logoImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.iconImg.mas_leading).offset(ScreenScale(28));
        make.bottom.mas_equalTo(self.iconImg.mas_bottom).offset(-ScreenScale(25));
        make.size.mas_equalTo(logoImg.image.size);
    }];
    
    self.schoolLab = [[UILabel alloc] init];
    self.schoolLab.font  =[UIFont systemFontOfSize:ScreenScale(18)];
    self.schoolLab.textColor = CZColorCreater(255, 255, 255, 1);
    self.schoolLab.text = @"莫那什大学留学 | 1篇日记";
    [self.iconImg addSubview:self.schoolLab];
    [self.schoolLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(logoImg.mas_trailing).offset(ScreenScale(12));
        make.centerY.mas_equalTo(logoImg);
        make.height.mas_greaterThanOrEqualTo(0);
        make.trailing.mas_lessThanOrEqualTo(self.iconImg.mas_trailing).offset(-ScreenScale(16));
    }];
    
    UIView *bgView = [[UIView alloc]init];
    bgView.backgroundColor = CZColorCreater(0, 0, 0, 0.4);
    bgView.layer.masksToBounds = YES;
    bgView.layer.cornerRadius = ScreenScale(34)/2.0;
    [self.iconImg addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.iconImg.mas_leading).offset(ScreenScale(16));
        make.bottom.mas_equalTo(self.iconImg.mas_bottom).offset(-ScreenScale(14));
        make.trailing.mas_equalTo(self.schoolLab.mas_trailing).offset(ScreenScale(12));
        make.height.mas_equalTo(ScreenScale(34));
    }];
    [self.iconImg sendSubviewToBack:bgView];
}
@end
