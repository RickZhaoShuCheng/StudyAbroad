//
//  CZActivityListCell.m
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/24.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZActivityListCell.h"
#import "UIImageView+WebCache.h"
@interface CZActivityListCell()
@property (nonatomic ,strong) UIImageView *iconImg;
@property (nonatomic ,strong) UILabel *nameLab;
@property (nonatomic ,strong) UILabel *priceLab;
@property (nonatomic ,strong) UILabel *locationLab;
@property (nonatomic ,strong) UILabel *timeLab;
@end
@implementation CZActivityListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initWithUI];
        [self.iconImg sd_setImageWithURL:[NSURL URLWithString:@"http://pics2.baidu.com/feed/6f061d950a7b0208861260d9c2b4e9d5562cc8a7.png?token=a660efbc8f229953136baa823633d889&s=9F1405CE8E9000D4F395A8BA0300D011"] placeholderImage:nil];
    }
    return self;
}

/**
 * 初始化UI
 */
- (void)initWithUI{
    self.iconImg = [[UIImageView alloc]init];
    [self.contentView addSubview:self.iconImg];
    [self.iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.contentView.mas_leading).offset(ScreenScale(30));
        make.size.mas_equalTo(ScreenScale(200));
        make.top.mas_equalTo(self.contentView.mas_top).offset(ScreenScale(10));
    }];
    
    self.nameLab = [[UILabel alloc]init];
    self.nameLab.font = [UIFont boldSystemFontOfSize:ScreenScale(32)];
    self.nameLab.textColor = CZColorCreater(51, 51, 51, 1);
    self.nameLab.text = @"精品预告名师1V1定咨询";
    [self.contentView addSubview:self.nameLab];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.iconImg.mas_trailing).offset(ScreenScale(24));
        make.top.mas_equalTo(self.iconImg.mas_top).offset(ScreenScale(2));
        make.trailing.mas_equalTo(self.contentView.mas_trailing).offset(-ScreenScale(24));
        make.height.mas_greaterThanOrEqualTo(0);
    }];
    
    self.priceLab = [[UILabel alloc]init];
    self.priceLab.font = [UIFont boldSystemFontOfSize:ScreenScale(32)];
    self.priceLab.textColor = CZColorCreater(255, 68, 85, 1);//钱255, 68, 85, 1)   免费255，142，0，1    已结束155，158，162，1
    self.priceLab.text = @"¥2837";
    [self.contentView addSubview:self.priceLab];
    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.iconImg.mas_trailing).offset(ScreenScale(24));
        make.top.mas_equalTo(self.nameLab.mas_bottom).offset(ScreenScale(30));
        make.trailing.mas_equalTo(self.contentView.mas_trailing).offset(-ScreenScale(24));
        make.height.mas_greaterThanOrEqualTo(0);
    }];
    
    self.locationLab = [[UILabel alloc]init];
    self.locationLab.font = [UIFont systemFontOfSize:ScreenScale(24)];
    self.locationLab.textColor = CZColorCreater(183, 183, 196, 1);
    self.locationLab.text = @"南京航空航天大学（将军路...";
    [self.contentView addSubview:self.locationLab];
    [self.locationLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.iconImg.mas_trailing).offset(ScreenScale(24));
        make.top.mas_equalTo(self.priceLab.mas_bottom).offset(ScreenScale(20));
        make.trailing.mas_equalTo(self.contentView.mas_trailing).offset(-ScreenScale(24));
        make.height.mas_greaterThanOrEqualTo(0);
    }];
    
    self.timeLab = [[UILabel alloc]init];
    self.timeLab.font = [UIFont systemFontOfSize:ScreenScale(24)];
    self.timeLab.textColor = CZColorCreater(129, 129, 146, 1);
    self.timeLab.text = @"进行中";
    [self.contentView addSubview:self.timeLab];
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.iconImg.mas_trailing).offset(ScreenScale(24));
        make.bottom.mas_equalTo(self.iconImg.mas_bottom).offset(-ScreenScale(2));
        make.trailing.mas_equalTo(self.contentView.mas_trailing).offset(-ScreenScale(24));
        make.height.mas_greaterThanOrEqualTo(0);
    }];
}
@end
