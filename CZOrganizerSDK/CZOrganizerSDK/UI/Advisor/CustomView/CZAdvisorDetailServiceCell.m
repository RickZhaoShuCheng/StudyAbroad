//
//  CZAdvisorDetailServiceCell.m
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/5.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZAdvisorDetailServiceCell.h"
#import "UIImageView+WebCache.h"

@interface CZAdvisorDetailServiceCell ()
@property (nonatomic ,strong)UIImageView *iconImg;
@property (nonatomic ,strong)UILabel *titleLab;
@property (nonatomic ,strong)UILabel *addressLab;
@property (nonatomic ,strong)UILabel *distanceLab;
@property (nonatomic ,strong)UILabel *priceLab;
@property (nonatomic ,strong)UILabel *countLab;

@end

@implementation CZAdvisorDetailServiceCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initWithUI];
        [self.iconImg sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1583430496700&di=de4170c57a050cdb73902ad1c01ae3db&imgtype=0&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F20182%2F7%2F20182711467_GsuwC.jpeg"] placeholderImage:nil];
    }
    return self;
}
- (void)initWithUI{
    
    self.backgroundColor = CZColorCreater(245, 245, 249, 1);
    
    self.bgView = [[UIView alloc]init];
    self.bgView.backgroundColor = [UIColor whiteColor];
    self.bgView.layer.masksToBounds = YES;
    self.bgView.layer.cornerRadius = WidthRatio(5);
    [self.contentView addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.contentView.mas_leading).offset(WidthRatio(30));
        make.top.mas_equalTo(self.contentView.mas_top).offset(HeightRatio(20));
        make.width.mas_equalTo(WidthRatio(330));
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
    }];
    
    self.iconImg = [[UIImageView alloc]init];
    [self.bgView addSubview:self.iconImg];
    [self.iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(WidthRatio(330));
        make.top.leading.trailing.mas_equalTo(self.bgView);
    }];
    
    self.titleLab = [[UILabel alloc]init];
    self.titleLab.font = [UIFont boldSystemFontOfSize:WidthRatio(28)];
    self.titleLab.text = @"精品预告名师1V1定制咨询30分钟";
    self.titleLab.numberOfLines = 2;
    self.titleLab.textColor = CZColorCreater(0, 0, 0, 1);
    [self.bgView addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.iconImg.mas_leading).offset(WidthRatio(20));
        make.trailing.mas_equalTo(self.iconImg.mas_trailing);
        make.top.mas_equalTo(self.iconImg.mas_bottom).offset(HeightRatio(24));
        make.height.mas_greaterThanOrEqualTo(0);
    }];
    
    self.distanceLab = [[UILabel alloc]init];
    self.distanceLab.font = [UIFont systemFontOfSize:WidthRatio(22)];
    self.distanceLab.text = @"6.98km";
    self.distanceLab.textColor = CZColorCreater(129, 129, 146, 1);
    self.distanceLab.textAlignment = NSTextAlignmentRight;
    [self.bgView addSubview:self.distanceLab];
    [self.distanceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self.iconImg.mas_trailing).offset(-WidthRatio(20));
        make.bottom.mas_equalTo(self.bgView.mas_bottom).offset(-HeightRatio(20));
        make.width.height.mas_greaterThanOrEqualTo(0);
    }];
    
    
    self.addressLab = [[UILabel alloc]init];
    self.addressLab.font = [UIFont systemFontOfSize:WidthRatio(22)];
    self.addressLab.text = @"海牛留学工作室";
    self.addressLab.textColor = CZColorCreater(129, 129, 146, 1);
    [self.bgView addSubview:self.addressLab];
    [self.addressLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.iconImg.mas_leading).offset(WidthRatio(20));
        make.trailing.mas_equalTo(self.distanceLab.mas_leading).offset(-WidthRatio(24));
        make.bottom.mas_equalTo(self.bgView.mas_bottom).offset(-HeightRatio(20));
        make.height.mas_greaterThanOrEqualTo(0);
    }];
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:@"¥4555"];
    [str addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:WidthRatio(22)]} range:NSMakeRange(0, 1)];
    [str addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:WidthRatio(31)]} range:NSMakeRange(1, str.length-1)];
    
    self.priceLab = [[UILabel alloc]init];
    self.priceLab.attributedText = str;
    self.priceLab.textColor = CZColorCreater(255, 68, 85, 1);
    [self.bgView addSubview:self.priceLab];
    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.iconImg.mas_leading).offset(WidthRatio(20));
        make.bottom.mas_equalTo(self.addressLab.mas_top).offset(-HeightRatio(10));
        make.width.height.mas_greaterThanOrEqualTo(0);
    }];
    
    self.countLab = [[UILabel alloc]init];
    self.countLab.font = [UIFont systemFontOfSize:WidthRatio(22)];
    self.countLab.text = @"15人付款";
    self.countLab.textColor = CZColorCreater(183, 183, 196, 1);
    [self.bgView addSubview:self.countLab];
    [self.countLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.priceLab.mas_trailing).offset (WidthRatio(20));
        make.trailing.mas_equalTo(self.bgView.mas_trailing);
        make.bottom.mas_equalTo(self.priceLab);
        make.height.mas_greaterThanOrEqualTo(0);
    }];
}
@end