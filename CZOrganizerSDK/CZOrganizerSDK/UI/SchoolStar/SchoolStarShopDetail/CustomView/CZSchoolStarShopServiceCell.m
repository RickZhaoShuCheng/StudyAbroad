
//
//  SchoolStarShopServiceCell.m
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/4/6.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZSchoolStarShopServiceCell.h"

@interface CZSchoolStarShopServiceCell ()
@property (nonatomic ,strong) UILabel *titleLab;
@property (nonatomic ,strong) UILabel *contentLab;
@property (nonatomic ,strong) UILabel *priceLab;
@property (nonatomic ,strong) UILabel *countLab;
@property (nonatomic ,strong) UIButton *buyBtn;
@property (nonatomic ,strong) UIButton *cartBtn;
@end
@implementation CZSchoolStarShopServiceCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initWithUI];
    }
    return self;
}

- (void)setModel:(CZProductVoListModel *)model{
    _model = model;
    self.titleLab.text = model.title;
    self.contentLab.text = model.desc;
    NSMutableAttributedString *str;
    if ([model.priceType isEqualToString:@"RMB"]) {
        NSString *price = [NSString stringWithFormat:@"¥%.2f",[model.price floatValue]/100];
        str = [[NSMutableAttributedString alloc]initWithString:price];
        [str addAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:ScreenScale(24)]} range:NSMakeRange(0, 1)];
        [str addAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:ScreenScale(30)]} range:NSMakeRange(1, str.length - 1)];
    }else{
        NSString *price = [NSString stringWithFormat:@"A$%.2f",[model.price floatValue]/100];
        str = [[NSMutableAttributedString alloc]initWithString:price];
        [str addAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:ScreenScale(24)]} range:NSMakeRange(0, 2)];
        [str addAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:ScreenScale(30)]} range:NSMakeRange(2, str.length - 2)];
    }
    self.priceLab.attributedText = str;
    
    NSInteger hour = model.serviceTime.integerValue/3600;
    
    NSString *string = @"";
    if (hour) {
        string = [string stringByAppendingFormat:@"%lu小时" , hour];
        NSInteger min = model.serviceTime.integerValue/60;
        if (min%60) {
            string = [string stringByAppendingFormat:@"%lu分钟" , model.serviceTime.integerValue%3600/60];
        }
    }
    else
    {
        NSInteger min = model.serviceTime.integerValue/60;
        string = [string stringByAppendingFormat:@"%lu分钟" , min];
    }
    string = [string stringByAppendingString:@"/次"];
    self.countLab.text = string;
}
- (void)clickBuyBtn{
    if (self.clickBuyBlock) {
        self.clickBuyBlock(self.model);
    }
}
- (void)clickCartBtnBtn{
    if (self.clickCartBlock) {
        self.clickCartBlock(self.model);
    }
}
/**
 * 初始化UI
 */
- (void)initWithUI{
    self.titleLab = [[UILabel alloc]init];
    self.titleLab.font = [UIFont boldSystemFontOfSize:ScreenScale(30)];
    self.titleLab.textColor = [UIColor blackColor];
    self.titleLab.text = @"-";
    [self.contentView addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.contentView.mas_leading).offset(ScreenScale(30));
        make.trailing.mas_equalTo(self.contentView.mas_trailing).offset(-ScreenScale(30));
        make.top.mas_equalTo(self.contentView.mas_top).offset(ScreenScale(30));
        make.height.mas_greaterThanOrEqualTo(0);
    }];
    
    self.contentLab = [[UILabel alloc]init];
    self.contentLab.font = [UIFont systemFontOfSize:ScreenScale(26)];
    self.contentLab.textColor = CZColorCreater(170, 170, 187, 1);
    self.contentLab.text = @"-";
    self.contentLab.numberOfLines = 0;
    [self.contentView addSubview:self.contentLab];
    [self.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.contentView.mas_leading).offset(ScreenScale(30));
        make.trailing.mas_equalTo(self.contentView.mas_trailing).offset(-ScreenScale(30));
        make.top.mas_equalTo(self.titleLab.mas_bottom).offset(ScreenScale(16));
        make.height.mas_greaterThanOrEqualTo(0);
    }];
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:@"¥0.00"];
    [str addAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:ScreenScale(24)]} range:NSMakeRange(0, 1)];
    [str addAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:ScreenScale(30)]} range:NSMakeRange(1, str.length - 1)];
    
    self.priceLab = [[UILabel alloc]init];
    self.priceLab.font = [UIFont systemFontOfSize:ScreenScale(24)];
    self.priceLab.textColor = CZColorCreater(255, 68, 85, 1);
    self.priceLab.attributedText = str;
    [self.contentView addSubview:self.priceLab];
    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.contentView.mas_leading).offset(ScreenScale(30));
        make.width.mas_greaterThanOrEqualTo(0);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-ScreenScale(40));
        make.height.mas_greaterThanOrEqualTo(0);
    }];
    
    self.countLab = [[UILabel alloc]init];
    self.countLab.font = [UIFont systemFontOfSize:ScreenScale(22)];
    self.countLab.textColor = CZColorCreater(183, 183, 196, 1);
    self.countLab.text = @"-/次";
    [self.contentView addSubview:self.countLab];
    [self.countLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.priceLab.mas_trailing).offset(ScreenScale(16));
        make.width.mas_greaterThanOrEqualTo(0);
        make.centerY.mas_equalTo(self.priceLab);
        make.height.mas_greaterThanOrEqualTo(0);
    }];
    
    self.buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.buyBtn setTitle:@"立即购买" forState:UIControlStateNormal];
    [self.buyBtn setTitleColor:CZColorCreater(255, 255, 255, 1) forState:UIControlStateNormal];
    [self.buyBtn.titleLabel setFont:[UIFont systemFontOfSize:ScreenScale(20)]];
    [self.buyBtn setBackgroundColor:CZColorCreater(96, 159, 250, 1)];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, ScreenScale(120), ScreenScale(48)) byRoundingCorners:(UIRectCornerTopRight | UIRectCornerBottomRight) cornerRadii:CGSizeMake(ScreenScale(48)/2.0, ScreenScale(48)/2.0)];//圆角大小
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = CGRectMake(0, 0, ScreenScale(120), ScreenScale(48));
    maskLayer.path = maskPath.CGPath;
    self.buyBtn.layer.mask = maskLayer;
    [self.buyBtn addTarget:self action:@selector(clickBuyBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.buyBtn];
    [self.buyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self.contentView.mas_trailing).offset(-ScreenScale(30));
        make.height.mas_equalTo(ScreenScale(48));
        make.width.mas_equalTo(ScreenScale(120));
        make.centerY.mas_equalTo(self.priceLab);
    }];
    
    self.cartBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.cartBtn setTitle:@"加购物车" forState:UIControlStateNormal];
    [self.cartBtn setTitleColor:CZColorCreater(255, 255, 255, 1) forState:UIControlStateNormal];
    [self.cartBtn.titleLabel setFont:[UIFont systemFontOfSize:ScreenScale(20)]];
    [self.cartBtn setBackgroundColor:CZColorCreater(124, 204, 255, 1)];
    UIBezierPath *maskPath1 = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, ScreenScale(120), ScreenScale(48)) byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerBottomLeft) cornerRadii:CGSizeMake(ScreenScale(48)/2.0, ScreenScale(48)/2.0)];//圆角大小
    CAShapeLayer *maskLayer1 = [[CAShapeLayer alloc] init];
    maskLayer1.frame = CGRectMake(0, 0, ScreenScale(120), ScreenScale(48));
    maskLayer1.path = maskPath1.CGPath;
    self.cartBtn.layer.mask = maskLayer1;
    [self.cartBtn addTarget:self action:@selector(clickCartBtnBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.cartBtn];
    [self.cartBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self.buyBtn.mas_leading);
        make.height.mas_equalTo(ScreenScale(48));
        make.width.mas_equalTo(ScreenScale(120));
        make.centerY.mas_equalTo(self.buyBtn);
    }];
    
    UILabel *line = [[UILabel alloc]init];
    line.backgroundColor = CZColorCreater(243, 243, 243, 1);
    line.text = @"";
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.contentView.mas_leading).offset(ScreenScale(30));
        make.trailing.mas_equalTo(self.contentView.mas_trailing).offset(-ScreenScale(30));
        make.height.mas_equalTo(ScreenScale(1));
        make.bottom.mas_equalTo(self.contentView);
    }];
}
@end
