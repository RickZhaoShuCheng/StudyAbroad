//
//  CZBoardAdvisorNormalCell.m
//  CZOrganizerSDK
//
//  Created by zsc on 2020/3/13.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZBoardAdvisorNormalCell.h"
#import "CZRankView.h"
#import "JCTagListView.h"
#import "UIImageView+WebCache.h"
#import "UIView+cz_anyCorners.h"
#import "CZBoardProductListView.h"

@interface CZBoardAdvisorNormalCell()
@property (nonatomic , strong) UIImageView *bgView;
@property (nonatomic , strong) UIImageView *avatarImageView;
@property (nonatomic , strong) UILabel *nameLabel;
@property (nonatomic , strong) CZRankView *rankView;
@property (nonatomic , strong) UILabel *rankDetailLabel;
@property (nonatomic , strong) JCTagListView *tagList;
@property (nonatomic , strong) UILabel *weekDetailLabel;
@property (nonatomic , strong) UILabel *weekTitleLabel;
@property (nonatomic , strong) UIView *bottomView;
@property (nonatomic , strong) UILabel *workPlaceLabel;

@property (nonatomic , strong) UIImageView *addressIconView;
@property (nonatomic , strong) UILabel *addressLabel;
@property (nonatomic , strong) CZBoardProductListView *productListView;

@end

@implementation CZBoardAdvisorNormalCell

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
    
    self.avatarImageView = [[UIImageView alloc] init];
    self.avatarImageView.layer.cornerRadius = 32;
    self.avatarImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:self.avatarImageView];
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(68);
        make.top.mas_equalTo(15);
        make.left.mas_equalTo(15);
    }];
    
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.textColor = [UIColor blackColor];
    self.nameLabel.font = [UIFont boldSystemFontOfSize:18];
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.avatarImageView.mas_right).offset(15);
        make.width.height.mas_greaterThanOrEqualTo(0);
        make.top.mas_equalTo(self.avatarImageView).offset(4);
    }];
    
    self.rankView = [[CZRankView alloc] init];
    [self.contentView addSubview:self.rankView];
    [self.rankView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(70);
        make.left.mas_equalTo(self.nameLabel);
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(12);
        make.height.mas_equalTo(12);
    }];
    
    self.rankDetailLabel = [[UILabel alloc] init];
    self.rankDetailLabel.textColor = CZColorCreater(129, 129, 146, 1);
    self.rankDetailLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:11];
    [self.contentView addSubview:self.rankDetailLabel];
    [self.rankDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_greaterThanOrEqualTo(0);
        make.left.mas_equalTo(self.rankView.mas_right).offset(5);
        make.centerY.mas_equalTo(self.rankView);
    }];
    
    self.workPlaceLabel = [[UILabel alloc] init];
    self.workPlaceLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:11];
    self.workPlaceLabel.textColor = [UIColor whiteColor];
    [self.contentView addSubview:self.workPlaceLabel];
    [self.workPlaceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_greaterThanOrEqualTo(0);
        make.left.mas_equalTo(self.rankView);
        make.bottom.mas_equalTo(self.avatarImageView);
    }];
    
    self.tagList = [[JCTagListView alloc]initWithFrame:CGRectMake(11, CGRectGetMaxY(self.avatarImageView.frame)+5, self.contentView.bounds.size.width-22,0)];
    self.tagList.tagCornerRadius = ScreenScale(2.5);
    self.tagList.tagBorderWidth = 0.5;
    self.tagList.tagBorderColor = CZColorCreater(76, 182, 253, 1);
    self.tagList.tagBackgroundColor = [UIColor whiteColor];
    self.tagList.tagTextColor = CZColorCreater(76, 182, 253, 1);
    self.tagList.tagFont = [UIFont fontWithName:@"PingFang-SC-Medium" size:11];
    self.tagList.tagItemSpacing = 8;
    self.tagList.tagLineSpacing = 8;
    self.tagList.tagContentInset = UIEdgeInsetsMake(ScreenScale(5), ScreenScale(10), ScreenScale(5), ScreenScale(10));
    [self.contentView addSubview:self.tagList];
    
    self.weekTitleLabel = [[UILabel alloc] init];
    self.weekTitleLabel.font = [UIFont boldSystemFontOfSize:13];
    self.weekTitleLabel.textColor = CZColorCreater(51, 51, 51, 1);
    self.weekTitleLabel.text = NSLocalizedString(@"本周指数", nil);
    [self.contentView addSubview:self.weekTitleLabel];
    [self.weekTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_greaterThanOrEqualTo(0);
        make.top.mas_equalTo(self.tagList.mas_bottom).offset(15);
        make.left.mas_equalTo(15);
    }];
    
    self.weekDetailLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.weekDetailLabel];
    [self.weekDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_greaterThanOrEqualTo(0);
        make.left.mas_equalTo(self.weekTitleLabel.mas_right).offset(12);
        make.centerY.mas_equalTo(self.weekTitleLabel);
    }];
    
    
    self.bottomView = [[UIView alloc] init];
    self.bottomView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.weekTitleLabel.mas_bottom);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(52);
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
        make.centerY.mas_equalTo(0);
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
    
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 15;
    layout.itemSize = CGSizeMake(91, 91);
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    [layout setSectionInset:UIEdgeInsetsMake(0, 15, 0, 0)];
    self.productListView = [[CZBoardProductListView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    [self.bottomView addSubview:self.productListView];
    [self.productListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(180);
        make.top.mas_equalTo(15);
    }];
}

-(void)setModel:(CZAdvisorModel *)model
{
    _model = model;
    self.tagList.tags = @[@"123123",@"123",@"23",@"123",@"23",@"123",@"23",@"123",@"23",@"123",@"23",@"123",@"23"];
    
    [self.tagList mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.avatarImageView.mas_bottom).offset(5);
        make.left.mas_equalTo(11);
        make.right.mas_equalTo(-11);
        make.height.mas_equalTo(self.tagList.contentHeight);
    }];
    
    
    CGSize cellSize = [self.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    model.cellHeight = cellSize.height;

    [self.rankView setRankByRate:model.valStar.floatValue];
    self.nameLabel.text = model.counselorName;
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    self.bgView.frame = CGRectMake(0, 0, self.contentView.bounds.size.width, CGRectGetMaxY(self.bottomView.frame));
}

@end

