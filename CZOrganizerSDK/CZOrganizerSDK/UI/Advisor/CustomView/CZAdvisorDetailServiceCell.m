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
    }
    return self;
}

- (void)setModel:(CZProductVoListModel *)model{
    _model = model;
    [self.iconImg sd_setImageWithURL:[NSURL URLWithString:PIC_URL(model.logo)] placeholderImage:nil];
    self.countLab.text = [NSString stringWithFormat:@"%@人付款",[@([model.payCount integerValue]) stringValue]];
    self.addressLab.text = model.organName;
    self.titleLab.text = model.title;
    
    if ([model.priceType isEqualToString:@"RMB"]) {
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"¥%.2f",[model.price floatValue]/100]];
        [str addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:ScreenScale(22)]} range:NSMakeRange(0, 1)];
        [str addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:ScreenScale(31)]} range:NSMakeRange(1, str.length-1)];
        self.priceLab.attributedText = str;
    }else{
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"A$%.2f",[model.price floatValue]/100]];
        [str addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:ScreenScale(22)]} range:NSMakeRange(0, 2)];
        [str addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:ScreenScale(31)]} range:NSMakeRange(2, str.length-2)];
        self.priceLab.attributedText = str;
    }
    self.distanceLab.text =[NSString stringWithFormat:@"%.2fkm" , model.distance.floatValue/1000.0];
}

- (void)initWithUI{
    
    self.contentView.backgroundColor = CZColorCreater(245, 245, 249, 1);
    
    self.bgView = [[UIView alloc]init];
    self.bgView.backgroundColor = [UIColor whiteColor];
    self.bgView.layer.masksToBounds = YES;
    self.bgView.layer.cornerRadius = ScreenScale(5);
    [self.contentView addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.contentView.mas_leading).offset(ScreenScale(30));
        make.top.mas_equalTo(self.contentView.mas_top).offset(ScreenScale(20));
        make.width.mas_equalTo(ScreenScale(330));
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
    }];
    
    self.iconImg = [[UIImageView alloc]init];
    [self.bgView addSubview:self.iconImg];
    [self.iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(ScreenScale(330));
        make.top.leading.trailing.mas_equalTo(self.bgView);
    }];
    
    self.titleLab = [[UILabel alloc]init];
    self.titleLab.font = [UIFont boldSystemFontOfSize:ScreenScale(28)];
    self.titleLab.text = @"-";
    self.titleLab.numberOfLines = 2;
    self.titleLab.textColor = CZColorCreater(0, 0, 0, 1);
    [self.bgView addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.iconImg.mas_leading).offset(ScreenScale(20));
        make.trailing.mas_equalTo(self.iconImg.mas_trailing);
        make.top.mas_equalTo(self.iconImg.mas_bottom).offset(ScreenScale(24));
        make.height.mas_greaterThanOrEqualTo(0);
    }];
    
    self.distanceLab = [[UILabel alloc]init];
    self.distanceLab.font = [UIFont systemFontOfSize:ScreenScale(22)];
    self.distanceLab.text = @"-";
    self.distanceLab.textColor = CZColorCreater(129, 129, 146, 1);
    self.distanceLab.textAlignment = NSTextAlignmentRight;
    [self.bgView addSubview:self.distanceLab];
    [self.distanceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self.iconImg.mas_trailing).offset(-ScreenScale(20));
        make.bottom.mas_equalTo(self.bgView.mas_bottom).offset(-ScreenScale(20));
        make.width.height.mas_greaterThanOrEqualTo(0);
    }];
    
    
    self.addressLab = [[UILabel alloc]init];
    self.addressLab.font = [UIFont systemFontOfSize:ScreenScale(22)];
    self.addressLab.text = @"-";
    self.addressLab.textColor = CZColorCreater(129, 129, 146, 1);
    [self.bgView addSubview:self.addressLab];
    [self.addressLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.iconImg.mas_leading).offset(ScreenScale(20));
        make.trailing.mas_equalTo(self.distanceLab.mas_leading).offset(-ScreenScale(24));
        make.bottom.mas_equalTo(self.bgView.mas_bottom).offset(-ScreenScale(20));
        make.height.mas_greaterThanOrEqualTo(0);
    }];
    [self.distanceLab setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];

    self.priceLab = [[UILabel alloc]init];
    self.priceLab.textColor = CZColorCreater(255, 68, 85, 1);
    [self.bgView addSubview:self.priceLab];
    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.iconImg.mas_leading).offset(ScreenScale(20));
        make.bottom.mas_equalTo(self.addressLab.mas_top).offset(-ScreenScale(10));
        make.width.height.mas_greaterThanOrEqualTo(0);
    }];
    
    self.countLab = [[UILabel alloc]init];
    self.countLab.font = [UIFont systemFontOfSize:ScreenScale(22)];
    self.countLab.text = @"-人付款";
    self.countLab.textColor = CZColorCreater(183, 183, 196, 1);
    [self.bgView addSubview:self.countLab];
    [self.countLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.priceLab.mas_trailing).offset (ScreenScale(20));
        make.trailing.mas_equalTo(self.bgView.mas_trailing);
        make.bottom.mas_equalTo(self.priceLab);
        make.height.mas_greaterThanOrEqualTo(0);
    }];
}
@end
