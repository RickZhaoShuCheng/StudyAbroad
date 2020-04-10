//
//  CZDiaryCell.m
//  CZOrganizerSDK
//
//  Created by zsc on 2020/2/29.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZDiaryCell.h"
#import "UIImageView+WebCache.h"

@interface CZDiaryCell ()
@property (nonatomic , strong) UIImageView *coverImageView;
@property (nonatomic , strong) UILabel *tagLabel;
@property (nonatomic , strong) UILabel *nameLabel;

@property (nonatomic , strong) UIImageView *iconImageView;
@property (nonatomic , strong) UILabel *nickNameLabel;

@property (nonatomic , strong) UIImageView *goodImageView;
@property (nonatomic , strong) UILabel *goodCountLabel;

@property (nonatomic , strong) UIImageView *diaryBgView;
@property (nonatomic , strong) UILabel *diaryNameLabel;
@property (nonatomic , strong) UIImageView *diaryIconView;


@end

@implementation CZDiaryCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initWithUI];
    }
    return self;
}

- (void)initWithUI{
    
    self.coverImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.coverImageView];
    [self.coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(self.contentView.mas_width).multipliedBy(237/165.0);
    }];

    
    self.tagLabel = [[UILabel alloc] init];
    self.tagLabel.textColor = CZColorCreater(170, 170, 187, 1.0);
    self.tagLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:11];
    self.tagLabel.numberOfLines = 1;
    [self.contentView addSubview:self.tagLabel];
    [self.tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.coverImageView.mas_bottom).offset(7.5);
        make.height.mas_greaterThanOrEqualTo(1);
        make.left.right.mas_equalTo(0);
    }];
    
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.textColor = [UIColor blackColor];
    self.nameLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:14];
    self.nameLabel.numberOfLines = 2;
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.tagLabel.mas_bottom).offset(2);
        make.height.mas_greaterThanOrEqualTo(0);
        make.left.right.mas_equalTo(0);
    }];
 
    self.iconImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.iconImageView];
    self.iconImageView.layer.masksToBounds = YES;
    self.iconImageView.layer.cornerRadius = 8;
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.mas_equalTo(0);
        make.size.mas_equalTo(16);
    }];
    
    
    self.nickNameLabel = [[UILabel alloc] init];
    self.nickNameLabel.textColor = CZColorCreater(107, 107, 124, 1);
    self.nickNameLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:11];
    [self.contentView addSubview:self.nickNameLabel];
    [self.nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_greaterThanOrEqualTo(0);
        make.left.mas_equalTo(self.iconImageView.mas_right).offset(3);
        make.centerY.mas_equalTo(self.iconImageView);
    }];
    
    self.goodCountLabel = [[UILabel alloc] init];
    self.goodCountLabel.text = @"0";
    self.goodCountLabel.textColor = CZColorCreater(107, 107, 124, 1);
    self.goodCountLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:11];
    [self.contentView addSubview:self.goodCountLabel];
    [self.goodCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_greaterThanOrEqualTo(0);
        make.right.mas_equalTo(0);
        make.centerY.mas_equalTo(self.iconImageView);
    }];
 
    self.goodImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.goodImageView];
    [self.goodImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.goodCountLabel.mas_left).offset(-8);
        make.height.mas_equalTo(11);
        make.width.mas_equalTo(12.5);
        make.centerY.mas_equalTo(self.iconImageView);
    }];
    self.goodImageView.image = [CZImageProvider imageNamed:@"zhu_ye_zan"];
    
    self.diaryIconView = [[UIImageView alloc] init];
    [self.coverImageView addSubview:self.diaryIconView];
    [self.diaryIconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(14.5);
        make.height.mas_equalTo(8);
        make.width.mas_equalTo(8.5);
        make.bottom.mas_equalTo(-12);
    }];
    self.diaryIconView.image = [CZImageProvider imageNamed:@"zhu_ye_ri_ji"];
    
    self.diaryNameLabel = [[UILabel alloc] init];
    self.diaryNameLabel.text = @"-";
    [self.diaryNameLabel setContentHuggingPriority:UILayoutPriorityRequired
                                     forAxis:UILayoutConstraintAxisHorizontal];
    self.diaryNameLabel.textColor = [UIColor whiteColor];
    self.diaryNameLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:11];
    [self.coverImageView addSubview:self.diaryNameLabel];
    [self.diaryNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_greaterThanOrEqualTo(1);
        make.centerY.mas_equalTo(self.diaryIconView);
        make.left.mas_equalTo(self.diaryIconView.mas_right).offset(3);
    }];
    
    self.diaryBgView = [[UIImageView alloc] init];
    self.diaryBgView.layer.masksToBounds = YES;
    self.diaryBgView.layer.cornerRadius = 8.5;
    self.diaryBgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    [self.coverImageView addSubview:self.diaryBgView];
    [self.diaryBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(8);
        make.height.mas_equalTo(17);
        make.centerY.mas_equalTo(self.diaryIconView);
        make.right.mas_equalTo(self.diaryNameLabel.mas_right).offset(6.5).priorityMedium();
    }];
    [self.coverImageView sendSubviewToBack:self.diaryBgView];
}

-(void)setModel:(CZDiaryModel *)model
{
    _model = model;
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:PIC_URL(model.smdMainImg)] placeholderImage:[CZImageProvider imageNamed:@"fen_mian_mo_ren_tu"]];
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:PIC_URL(model.userImg)] placeholderImage:[CZImageProvider imageNamed:@"default_avatar"]];
    self.nickNameLabel.text = model.userNickName;
    self.nameLabel.text = model.smdContent;
    self.goodCountLabel.text = [@(model.praiseCount.integerValue) stringValue];
    self.diaryNameLabel.text = [NSString stringWithFormat:@"%@ | %@篇日记" , model.schoolName,[@(model.diaryCount.integerValue) stringValue]];
        self.tagLabel.text = model.topicTypeStr;
}

@end
