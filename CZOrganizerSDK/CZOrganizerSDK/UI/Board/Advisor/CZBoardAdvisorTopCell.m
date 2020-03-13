//
//  CZBoardAdvisorTopCell.m
//  CZOrganizerSDK
//
//  Created by zsc on 2020/3/13.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZBoardAdvisorTopCell.h"
#import "CZRankView.h"
#import "JCTagListView.h"
#import "UIImageView+WebCache.h"
#import "UIView+cz_anyCorners.h"
#import "CZBoardProductListView.h"

@interface CZBoardAdvisorTopCell()
@property (nonatomic , strong) UIImageView *bgView;
@property (nonatomic , strong) UIImageView *goldImageView;
@property (nonatomic , strong) UIImageView *avatarImageView;
@property (nonatomic , strong) UILabel *nameLabel;
@property (nonatomic , strong) CZRankView *rankView;
@property (nonatomic , strong) UILabel *rankDetailLabel;
@property (nonatomic , strong) JCTagListView *tagList;
@property (nonatomic , strong) UIView *middileView;
@property (nonatomic , strong) UILabel *weekDetailLabel;
@property (nonatomic , strong) UIView *bottomView;
@property (nonatomic , strong) UILabel *workPlaceLabel;

@property (nonatomic , strong) UIImageView *addressIconView;
@property (nonatomic , strong) UILabel *addressLabel;
@property (nonatomic , strong) CZBoardProductListView *productListView;

@end

@implementation CZBoardAdvisorTopCell

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
    
    self.goldImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.goldImageView];
    [self.goldImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(7);
        make.width.mas_equalTo(28);
        make.height.mas_equalTo(31);
    }];
    
    self.avatarImageView = [[UIImageView alloc] init];
    self.avatarImageView.layer.cornerRadius = 32;
    self.avatarImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:self.avatarImageView];
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(68);
        make.top.mas_equalTo(self.goldImageView).offset(8);
        make.left.mas_equalTo(self.goldImageView).offset(5);
    }];
    
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.textColor = [UIColor whiteColor];
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
    self.rankDetailLabel.textColor = [UIColor whiteColor];
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
    self.tagList.tagCornerRadius = WidthRatio(2.5);
    self.tagList.tagBorderWidth = 0;
    self.tagList.tagBackgroundColor = [UIColor whiteColor];
    self.tagList.tagTextColor = CZColorCreater(77, 54, 229, 1);
    self.tagList.tagFont = [UIFont fontWithName:@"PingFang-SC-Medium" size:11];
    self.tagList.tagItemSpacing = 8;
    self.tagList.tagLineSpacing = 8;
    self.tagList.tagContentInset = UIEdgeInsetsMake(HeightRatio(5), WidthRatio(10), HeightRatio(5), WidthRatio(10));
    [self.contentView addSubview:self.tagList];
    
    self.middileView = [[UIView alloc] init];
    self.middileView.backgroundColor = CZColorCreater(43, 120, 217, 1);
    [self.contentView addSubview:self.middileView];
    [self.middileView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.tagList.mas_bottom).offset(20);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(40);
    }];
    
    self.weekDetailLabel = [[UILabel alloc] init];
    [self.middileView addSubview:self.weekDetailLabel];
    [self.weekDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(11);
        make.centerY.mas_equalTo(0);
        make.right.mas_equalTo(-11);
        make.height.mas_greaterThanOrEqualTo(0);
    }];
    
    self.bottomView = [[UIView alloc] init];
    self.bottomView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.middileView.mas_bottom);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(223);
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
    
//    self.goldImageView.image = [CZImageProvider imageNamed:@"shou_ye_jin_pai"];
//    self.bgView.image = [CZImageProvider imageNamed:@"shou_ye_jin_pai_bei_jing"];
    [self.rankView setRankByRate:model.valStar.floatValue];
    
//    NSString *rankDetail = [NSString stringWithFormat:@"%@ 条评价 | %@ 案例 | %@ 顾问" , [@(model.valResponse.integerValue) stringValue], [@(model.valSatisfaction.integerValue) stringValue], [@(model.valProfessional.integerValue) stringValue]];
//    self.rankDetailLabel.text = rankDetail;
    self.nameLabel.text = model.counselorName;
//    self.addressLabel.text = model.address;
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    self.bgView.frame = CGRectMake(0, 0, self.contentView.bounds.size.width, CGRectGetMaxY(self.middileView.frame));
    [self.bottomView setBorderWithCornerRadius:10 borderWidth:1 borderColor:[UIColor clearColor] type:UIRectCornerBottomRight | UIRectCornerBottomLeft];
}

-(void)setType:(CZBoardAdvisorTopType)type
{
    _type = type;
    switch (type) {
        case CZBoardAdvisorTopTypeGold:
            self.goldImageView.image = [CZImageProvider imageNamed:@"shou_ye_jin_pai"];
            self.bgView.image = [CZImageProvider imageNamed:@"shou_ye_jin_pai_bei_jing"];
            break;
        case CZBoardAdvisorTopTypeSilver:
            self.goldImageView.image = [CZImageProvider imageNamed:@"shou_ye_yin_pai"];
            self.bgView.image = [CZImageProvider imageNamed:@"shou_ye_yin_pai_bei_jing"];
            break;
        case CZBoardAdvisorTopTypeCopper:
            self.goldImageView.image = [CZImageProvider imageNamed:@"shou_ye_tong_pai"];
            self.bgView.image = [CZImageProvider imageNamed:@"shou_ye_tong_pai_bei_jing"];
            break;
        default:
            break;
    }
}

@end
