//
//  CZBoardOrganizerNormalCell.m
//  CZOrganizerSDK
//
//  Created by zsc on 2020/3/13.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZBoardOrganizerNormalCell.h"
#import "CZRankView.h"
#import "JCTagListView.h"
#import "UIImageView+WebCache.h"
#import "UIView+cz_anyCorners.h"

@interface CZBoardOrganizerNormalCell()
@property (nonatomic , strong) UIImageView *bgView;
@property (nonatomic , strong) UIImageView *coverImageView;
@property (nonatomic , strong) UILabel *nameLabel;
@property (nonatomic , strong) CZRankView *rankView;
@property (nonatomic , strong) UILabel *rankDetailLabel;
@property (nonatomic , strong) UILabel *weekDetailLabel;
@property (nonatomic , strong) UILabel *weekTitleLabel;
@property (nonatomic , strong) UILabel *commentDetailLabel;
@property (nonatomic , strong) UILabel *commentTitleLabel;

@property (nonatomic , strong) UIView *bottomView;

@property (nonatomic , strong) UIImageView *addressIconView;
@property (nonatomic , strong) UILabel *addressLabel;

@end

@implementation CZBoardOrganizerNormalCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initWithUI];
    }
    return self;
}

-(void)initWithUI
{
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    
    self.bgView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.bgView];
    self.bgView.backgroundColor = [UIColor whiteColor];
    self.bgView.layer.cornerRadius = 10;
    self.bgView.layer.masksToBounds = YES;

    self.coverImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.coverImageView];
    [self.coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.top.mas_equalTo(13);
        make.size.mas_equalTo(51);
    }];
    
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.textColor = [UIColor blackColor];
    self.nameLabel.font = [UIFont boldSystemFontOfSize:18];
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.coverImageView.mas_right).offset(8.5);
        make.width.height.mas_greaterThanOrEqualTo(0);
        make.top.mas_equalTo(self.coverImageView).offset(4);
    }];
    
    self.rankView = [[CZRankView alloc] init];
    [self.contentView addSubview:self.rankView];
    [self.rankView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(70);
        make.left.mas_equalTo(self.coverImageView.mas_right).offset(8.5);
        make.bottom.mas_equalTo(self.coverImageView).offset(-7.5);
        make.height.mas_equalTo(12);
    }];
    
    self.rankDetailLabel = [[UILabel alloc] init];
    self.rankDetailLabel.textColor = [UIColor whiteColor];
    self.rankDetailLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:11];
    [self.contentView addSubview:self.rankDetailLabel];
    [self.rankDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_greaterThanOrEqualTo(0);
        make.left.mas_equalTo(self.rankView.mas_right).offset(5);
        make.centerY.mas_equalTo(self.rankView);
    }];
    
    self.weekTitleLabel = [[UILabel alloc] init];
    self.weekTitleLabel.font = [UIFont boldSystemFontOfSize:13];
    self.weekTitleLabel.textColor = CZColorCreater(51, 51, 51, 1);
    self.weekTitleLabel.text = NSLocalizedString(@"本周指数", nil);
    [self.contentView addSubview:self.weekTitleLabel];
    [self.weekTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_greaterThanOrEqualTo(0);
        make.top.mas_equalTo(self.coverImageView.mas_bottom).offset(20);
        make.left.mas_equalTo(self.coverImageView);
    }];
    
    self.weekDetailLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.weekDetailLabel];
    [self.weekDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_greaterThanOrEqualTo(0);
        make.left.mas_equalTo(self.weekTitleLabel.mas_right).offset(12);
        make.centerY.mas_equalTo(self.weekTitleLabel);
    }];
    
    self.commentTitleLabel = [[UILabel alloc] init];
    self.commentTitleLabel.font = [UIFont boldSystemFontOfSize:13];
    self.commentTitleLabel.textColor = CZColorCreater(51, 51, 51, 1);
    self.commentTitleLabel.text = NSLocalizedString(@"用户评价", nil);
    [self.contentView addSubview:self.commentTitleLabel];
    [self.commentTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_greaterThanOrEqualTo(0);
        make.top.mas_equalTo(self.weekTitleLabel.mas_bottom).offset(10);
        make.left.mas_equalTo(self.coverImageView);
    }];
    
    self.commentDetailLabel = [[UILabel alloc] init];
    self.commentDetailLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:12];
    self.commentDetailLabel.textColor = CZColorCreater(129, 129, 146, 1);
    [self.contentView addSubview:self.commentDetailLabel];
    [self.commentDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_greaterThanOrEqualTo(0);
        make.left.mas_equalTo(self.commentTitleLabel.mas_right).offset(12);
        make.centerY.mas_equalTo(self.commentTitleLabel);
    }];
    
    self.bottomView = [[UIView alloc] init];
    [self.contentView addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.commentDetailLabel.mas_bottom);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(50);
        make.bottom.mas_equalTo(-15);
    }];
    
    self.addressIconView = [[UIImageView alloc] init];
    self.addressIconView.layer.masksToBounds = YES;
    self.addressIconView.layer.cornerRadius = 11;
    self.addressIconView.image = [CZImageProvider imageNamed:@"shou_ye_di_zhi_icon"];
    [self.bottomView addSubview:self.addressIconView];
    [self.addressIconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(22);
        make.left.mas_equalTo(15);
        make.bottom.mas_equalTo(-15);
    }];
    
    self.addressLabel = [[UILabel alloc] init];
    self.addressLabel.textColor = CZColorCreater(129, 129, 146, 1);
    self.addressLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:12];
    [self.bottomView addSubview:self.addressLabel];
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_greaterThanOrEqualTo(0);
        make.left.mas_equalTo(self.addressIconView.mas_right).offset(5);
        make.centerY.mas_equalTo(self.addressIconView);
        make.right.mas_equalTo(-10);
    }];

}

-(void)setModel:(CZOrganizerModel *)model
{
    _model = model;
    
    CGSize cellSize = [self.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    model.cellHeight = cellSize.height;

    [self.rankView setRankByRate:model.valStar.floatValue];
    
    NSString *rankDetail = [NSString stringWithFormat:@"%@ 条评价 | %@ 案例 | %@ 顾问" , [@(model.valResponse.integerValue) stringValue], [@(model.valSatisfaction.integerValue) stringValue], [@(model.valProfessional.integerValue) stringValue]];
    self.rankDetailLabel.text = rankDetail;
    self.nameLabel.text = model.name;
    self.addressLabel.text = model.address;
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    self.bgView.frame = CGRectMake(0, 0, self.contentView.bounds.size.width, CGRectGetMaxY(self.bottomView.frame));
}

@end
