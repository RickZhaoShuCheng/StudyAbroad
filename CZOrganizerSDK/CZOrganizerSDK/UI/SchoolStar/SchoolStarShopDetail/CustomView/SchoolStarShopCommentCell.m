//
//  SchoolStarShopCommentCell.m
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/4/6.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "SchoolStarShopCommentCell.h"
#import "UIImageView+WebCache.h"

@interface SchoolStarShopCommentCell ()
@property (nonatomic ,strong) UIImageView *avatarImg;
@property (nonatomic ,strong) UILabel *nameLab;
@property (nonatomic ,strong) UILabel *timeLab;
@property (nonatomic ,strong) UILabel *serviceLab;
@property (nonatomic ,strong) UILabel *contentLab;
@end
@implementation SchoolStarShopCommentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initWithUI];
        [self.avatarImg sd_setImageWithURL:[NSURL URLWithString:@"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=2662493301,1276913271&fm=26&gp=0.jpg"] placeholderImage:nil];
    }
    return self;
}

/**
 * 初始化UI
 */
- (void)initWithUI{
    self.avatarImg = [[UIImageView alloc]init];
    self.avatarImg.layer.masksToBounds = YES;
    self.avatarImg.layer.cornerRadius = ScreenScale(70)/2.0;
    [self.contentView addSubview:self.avatarImg];
    [self.avatarImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.contentView.mas_leading).offset(ScreenScale(30));
        make.top.mas_equalTo(self.contentView);
        make.size.mas_equalTo(ScreenScale(70));
    }];
    
    self.timeLab = [[UILabel alloc]init];
    self.timeLab.text = @"6小时前";
    self.timeLab.font = [UIFont systemFontOfSize:ScreenScale(22)];
    self.timeLab.textColor = CZColorCreater(159, 159, 178, 1);
    [self.contentView addSubview:self.timeLab];
    
    self.nameLab = [[UILabel alloc]init];
    self.nameLab.font = [UIFont systemFontOfSize:ScreenScale(24)];
    self.nameLab.textColor = CZColorCreater(32, 32, 32, 1);
    self.nameLab.text = @"百事可乐";
    [self.contentView addSubview:self.nameLab];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.avatarImg.mas_trailing).offset(ScreenScale(16));
        make.height.mas_greaterThanOrEqualTo(0);
        make.top.mas_equalTo(self.avatarImg);
        make.trailing.mas_equalTo(self.timeLab.mas_leading).offset(-ScreenScale(20));
    }];
    
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self.contentView.mas_trailing).offset(-ScreenScale(30));
        make.centerY.mas_equalTo(self.nameLab);
        make.width.height.mas_greaterThanOrEqualTo(0);
    }];
    [self.timeLab setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    [self.nameLab setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    
    self.serviceLab = [[UILabel alloc]init];
    self.serviceLab.font = [UIFont systemFontOfSize:ScreenScale(24)];
    self.serviceLab.textColor = CZColorCreater(129, 129, 146, 1);
    self.serviceLab.text = @"购买服务：新南威尔士咨询服务";
    [self.contentView addSubview:self.serviceLab];
    [self.serviceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.avatarImg.mas_trailing).offset(ScreenScale(16));
        make.height.mas_greaterThanOrEqualTo(0);
        make.top.mas_equalTo(self.nameLab.mas_bottom).offset(ScreenScale(12));
        make.trailing.mas_equalTo(self.contentView.mas_trailing).offset(-ScreenScale(30));
    }];
    
    self.contentLab = [[UILabel alloc]init];
    self.contentLab.font = [UIFont systemFontOfSize:ScreenScale(24)];
    self.contentLab.textColor = CZColorCreater(129, 129, 146, 1);
    self.contentLab.text = @"小黄老师真的非常的棒 很耐心、细心为我解疑答惑非常的感谢！赞一个";
    self.contentLab.numberOfLines = 0;
    [self.contentView addSubview:self.contentLab];
    [self.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.avatarImg.mas_trailing).offset(ScreenScale(16));
        make.height.mas_greaterThanOrEqualTo(0);
        make.top.mas_equalTo(self.serviceLab.mas_bottom).offset(ScreenScale(30));
        make.trailing.mas_equalTo(self.contentView.mas_trailing).offset(-ScreenScale(30));
    }];
    
    UILabel *line = [[UILabel alloc]init];
    line.text = @"";
    line.backgroundColor = CZColorCreater(243, 243, 247, 1);
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self.contentView);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-ScreenScale(34));
        make.leading.mas_equalTo(self.avatarImg.mas_trailing).offset(ScreenScale(16));
        make.height.mas_equalTo(ScreenScale(1));
    }];
}
@end
