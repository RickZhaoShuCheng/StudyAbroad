
//
//  CZMoreSchoolStarCell.m
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/4/1.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZMoreSchoolStarCell.h"
#import "CZRankView.h"
#import "UIImageView+WebCache.h"

@interface CZMoreSchoolStarCell ()
@property (nonatomic ,strong) UIImageView *avatarImg;
@property (nonatomic ,strong) UILabel *nameLab;
@property (nonatomic ,strong) UILabel *contentLab;
@property (nonatomic ,strong) CZRankView *rankView;
@property (nonatomic ,strong) UIImageView *VImg;
@property (nonatomic ,strong) UILabel *serviceLab;
@property (nonatomic ,strong) UILabel *schoolLab;
@property (nonatomic ,strong) UIButton *locationBtn;
@end
@implementation CZMoreSchoolStarCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initWithUI];
    }
    return self;
}

- (void)setModel:(CZSchoolStarModel *)model{
    _model = model;
    if ([model.status integerValue] == 1) {
        self.VImg.hidden = NO;
    }else{
        self.VImg.hidden = YES;
    }
    self.nameLab.text = model.realName;
    [self.avatarImg sd_setImageWithURL:[NSURL URLWithString:PIC_URL(model.userImg)] placeholderImage:nil];
    self.contentLab.text = model.keywords;
//    self.contentLab.text = [NSString stringWithFormat:@"%@年%@留学老油条",model.studyYears,model.countryName];
    [self.rankView setRankByRate:[model.valStar floatValue]];
    self.serviceLab.text = [NSString stringWithFormat:@"服务%@人",[@([model.servicePersonCount integerValue]) stringValue]];
    
    if ([model.isGraduation integerValue] == 1) {
        self.schoolLab.text = [NSString stringWithFormat:@"  %@ / 已毕业  ",model.schoolName];
    }else if ([model.isGraduation integerValue] == 2){
        self.schoolLab.text = [NSString stringWithFormat:@"  %@ / 留学中  ",model.schoolName];
    }else if ([model.isGraduation integerValue] == 3){
        self.schoolLab.text = [NSString stringWithFormat:@"  %@ / 准备留学  ",model.schoolName];
    }
    [self.locationBtn setTitle:model.countryName forState:UIControlStateNormal];
}

/**
 * 初始化UI
 */
- (void)initWithUI{
    
    self.avatarImg = [[UIImageView alloc]init];
    self.avatarImg.layer.masksToBounds = YES;
    self.avatarImg.layer.cornerRadius = ScreenScale(90)/2.0;
    [self.contentView addSubview:self.avatarImg];
    [self.avatarImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.contentView).offset(ScreenScale(30));
        make.top.mas_equalTo(self.contentView).offset(ScreenScale(30));
        make.size.mas_equalTo(ScreenScale(90));
    }];
    
    
    self.VImg = [[UIImageView alloc]init];
    self.VImg.image = [CZImageProvider imageNamed:@"shou_ye_ren_zheng_cell"];
    [self.contentView addSubview:self.VImg];
    [self.VImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.avatarImg.mas_bottom).offset(-ScreenScale(18));
        make.centerX.mas_equalTo(self.avatarImg);
        make.width.mas_equalTo(ScreenScale(80));
        make.height.mas_equalTo(ScreenScale(36));
    }];
    
    self.nameLab = [[UILabel alloc]init];
    self.nameLab.font = [UIFont boldSystemFontOfSize:ScreenScale(26)];
    self.nameLab.textColor = CZColorCreater(51, 51, 51, 1);
    self.nameLab.text = @"-";
    [self.contentView addSubview:self.nameLab];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.avatarImg.mas_trailing).offset(ScreenScale(16));
        make.top.mas_equalTo(self.avatarImg);
        make.height.mas_greaterThanOrEqualTo(0);
        make.trailing.mas_equalTo(self.contentView.mas_trailing).offset(-ScreenScale(30));
    }];
    
    self.contentLab = [[UILabel alloc]init];
    self.contentLab.font = [UIFont systemFontOfSize:ScreenScale(22)];
    self.contentLab.textColor = CZColorCreater(129, 129, 146, 1);
    self.contentLab.text = @"-";
    [self.contentView addSubview:self.contentLab];
    [self.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.avatarImg.mas_trailing).offset(ScreenScale(16));
        make.top.mas_equalTo(self.nameLab.mas_bottom).offset(ScreenScale(10));
        make.height.mas_greaterThanOrEqualTo(0);
        make.trailing.mas_equalTo(self.contentView.mas_trailing).offset(-ScreenScale(30));
    }];
    
    self.rankView = [CZRankView instanceRankViewByRate:0.0];
    [self.contentView addSubview:self.rankView];
    [self.rankView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(ScreenScale(150));
        make.leading.mas_equalTo(self.avatarImg.mas_trailing).offset(ScreenScale(16));
        make.top.mas_equalTo(self.contentLab.mas_bottom).offset(ScreenScale(12));
        make.height.mas_equalTo(ScreenScale(28));
    }];
    
    self.serviceLab = [[UILabel alloc] init];
    self.serviceLab.text = @"服务-人";
    self.serviceLab.textColor = CZColorCreater(170, 170, 187, 1);
    self.serviceLab.font = [UIFont systemFontOfSize:ScreenScale(22)];
    [self.contentView addSubview:self.serviceLab];
    [self.serviceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.rankView.mas_trailing);
        make.top.mas_equalTo(self.rankView.mas_top).offset(-ScreenScale(4));
        make.trailing.mas_equalTo(self.mas_trailing).offset(-ScreenScale(30));
        make.height.mas_greaterThanOrEqualTo(0);
    }];
    
    self.schoolLab = [[UILabel alloc]init];
    self.schoolLab.font = [UIFont systemFontOfSize:ScreenScale(18)];
    self.schoolLab.textColor = CZColorCreater(51, 172, 253, 1);
    self.schoolLab.textAlignment = NSTextAlignmentCenter;
    self.schoolLab.text = @"  - / -  ";
    self.schoolLab.layer.masksToBounds = YES;
    self.schoolLab.layer.cornerRadius = ScreenScale(3);
    self.schoolLab.layer.borderColor = CZColorCreater(51, 172, 253, 1).CGColor;
    self.schoolLab.layer.borderWidth = ScreenScale(1);
    [self.contentView addSubview:self.schoolLab];
    
    self.locationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.locationBtn setImage:[CZImageProvider imageNamed:@"guwen_dingwei"] forState:UIControlStateNormal];
    [self.locationBtn setTitle:@"-" forState:UIControlStateNormal];
    [self.locationBtn setTitleColor:CZColorCreater(129, 129, 146, 1) forState:UIControlStateNormal];
    [self.locationBtn.titleLabel setFont:[UIFont systemFontOfSize:ScreenScale(24)]];
    [self.locationBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -ScreenScale(10), 0, 0)];
    [self.contentView addSubview:self.locationBtn];
    [self.locationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self.contentView.mas_trailing).offset(-ScreenScale(30));
        make.width.height.mas_greaterThanOrEqualTo(0);
        make.centerY.mas_equalTo(self.schoolLab);
    }];
    
    [self.schoolLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.avatarImg.mas_trailing).offset(ScreenScale(16));
        make.top.mas_equalTo(self.rankView.mas_bottom).offset(ScreenScale(10));
        make.height.mas_equalTo(ScreenScale(30));
        make.width.mas_greaterThanOrEqualTo(0).priorityHigh();
        make.trailing.mas_equalTo(self.locationBtn.mas_leading).offset(-ScreenScale(20)).priorityLow();
    }];
    
    [self.locationBtn setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    [self.schoolLab setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
//    [self.locationBtn setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
//    [self.schoolLab setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
}
@end
