//
//  CZMoreSchoolStarGoodsCell.m
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/4/1.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZMoreSchoolStarGoodsCell.h"
@interface CZMoreSchoolStarGoodsCell()
@property (nonatomic ,strong) UIImageView *buyImg;
@property (nonatomic ,strong) UILabel *nameLab;
@property (nonatomic ,strong) UILabel *priceLab;
@end

@implementation CZMoreSchoolStarGoodsCell

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
    UILabel *line = [[UILabel alloc]init];
    line.text = @"";
    line.backgroundColor = CZColorCreater(243, 243, 247, 1);
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.top.mas_equalTo(self.contentView);
        make.height.mas_equalTo(ScreenScale(1));
        make.leading.mas_equalTo(self.contentView.mas_leading).offset(ScreenScale(136));
    }];
    
    self.buyImg = [[UIImageView alloc]init];
    self.buyImg.image = [CZImageProvider imageNamed:@"zhu_ye_gou_cell"];
    [self.contentView addSubview:self.buyImg];
    [self.buyImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.contentView.mas_leading).offset(ScreenScale(136));
        make.size.mas_equalTo(self.buyImg.image.size);
        make.centerY.mas_equalTo(self.contentView);
    }];
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:@"¥ 4580.00"];
    [str addAttributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:ScreenScale(22)]} range:NSMakeRange(0, 2)];
    [str addAttributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:ScreenScale(28)]} range:NSMakeRange(2, str.length -2)];
    
    self.priceLab = [[UILabel alloc]init];
    self.priceLab.textColor = CZColorCreater(255, 68, 85, 1);
    self.priceLab.attributedText = str;
    [self.contentView addSubview:self.priceLab];
    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self.contentView.mas_trailing).offset(-ScreenScale(30));
        make.centerY.mas_equalTo(self.contentView);
        make.width.height.mas_greaterThanOrEqualTo(0);
    }];
    
    
    self.nameLab = [[UILabel alloc]init];
    self.nameLab.font = [UIFont systemFontOfSize:ScreenScale(26)];
    self.nameLab.textColor = CZColorCreater(61, 67, 83, 1);
    self.nameLab.text = @"ACT名师一对一 短时间迅速提升";
    [self.contentView addSubview:self.nameLab];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.buyImg.mas_trailing).offset(ScreenScale(14));
        make.centerY.mas_equalTo(self.contentView);
        make.height.mas_greaterThanOrEqualTo(0);
        make.trailing.mas_equalTo(self.priceLab.mas_leading).offset(-ScreenScale(20));
    }];
    
    [self.priceLab setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self.nameLab setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
}
@end
