//
//  CZBoardOrganizerTopCell.m
//  CZOrganizerSDK
//
//  Created by zsc on 2020/3/9.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZBoardOrganizerTopCell.h"
#import "CZRankView.h"
#import "JCTagListView.h"
#import "UIImageView+WebCache.h"
#import "UIView+cz_anyCorners.h"
#import "CZBoardProductListView.h"

@interface CZBoardOrganizerTopCell()
@property (nonatomic , strong) UIImageView *bgView;
@property (nonatomic , strong) UIImageView *goldImageView;
@property (nonatomic , strong) UILabel *nameLabel;
@property (nonatomic , strong) CZRankView *rankView;
@property (nonatomic , strong) UILabel *rankDetailLabel;
@property (nonatomic , strong) UILabel *weekDetailLabel;
@property (nonatomic , strong) JCTagListView *tagList;
@property (nonatomic , strong) UIView *middileView;
@property (nonatomic , strong) UIImageView *iconImageView;
@property (nonatomic , strong) UILabel *iconDetailLabel;
@property (nonatomic , strong) UIView *bottomView;

@property (nonatomic , strong) UIImageView *addressIconView;
@property (nonatomic , strong) UILabel *addressLabel;
@property (nonatomic , strong) CZBoardProductListView *productListView;

@end

@implementation CZBoardOrganizerTopCell

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
        make.left.mas_equalTo(12);
        make.top.mas_equalTo(13);
        make.width.mas_equalTo(28);
        make.height.mas_equalTo(31);
    }];
    
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.textColor = [UIColor whiteColor];
    self.nameLabel.font = [UIFont boldSystemFontOfSize:18];
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.goldImageView.mas_right).offset(5.5);
        make.width.height.mas_greaterThanOrEqualTo(0);
        make.centerY.mas_equalTo(self.goldImageView);
    }];
    
    self.rankView = [[CZRankView alloc] init];
    [self.contentView addSubview:self.rankView];
    [self.rankView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(70);
        make.left.mas_equalTo(self.nameLabel);
        make.top.mas_equalTo(self.goldImageView.mas_bottom).offset(10);
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
    
    self.weekDetailLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.weekDetailLabel];
    [self.weekDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_greaterThanOrEqualTo(0);
        make.left.mas_equalTo(self.goldImageView);
        make.top.mas_equalTo(self.rankView.mas_bottom).offset(12);
    }];
    
    self.tagList = [[JCTagListView alloc]initWithFrame:CGRectMake(11, CGRectGetMaxY(self.weekDetailLabel.frame)+12, self.contentView.bounds.size.width-22,0)];
    self.tagList.tagCornerRadius = WidthRatio(2.5);
    self.tagList.tagBorderWidth = 0;
    self.tagList.tagBackgroundColor = [UIColor whiteColor];
    self.tagList.tagTextColor = CZColorCreater(43, 120, 217, 1);
    self.tagList.tagFont = [UIFont fontWithName:@"PingFang-SC-Medium" size:11];
    self.tagList.tagItemSpacing = 8;
    self.tagList.tagLineSpacing = 8;
    self.tagList.tagContentInset = UIEdgeInsetsMake(HeightRatio(5), WidthRatio(10), HeightRatio(5), WidthRatio(10));
    [self.contentView addSubview:self.tagList];
    
    self.middileView = [[UIView alloc] init];
    [self.contentView addSubview:self.middileView];
    [self.middileView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.tagList.mas_bottom).offset(20);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(54);
    }];
    
    self.iconImageView = [[UIImageView alloc] init];
    self.iconImageView.layer.masksToBounds = YES;
    self.iconImageView.layer.cornerRadius = 10.5;
    [self.middileView addSubview:self.iconImageView];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(21);
        make.left.top.mas_equalTo(9);
    }];
    
    self.iconDetailLabel = [[UILabel alloc] init];
    [self.middileView addSubview:self.iconDetailLabel];
    [self.iconDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.iconDetailLabel.mas_right).offset(5);
        make.top.mas_equalTo(5);
        make.right.mas_equalTo(-22);
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

-(void)setModel:(CZOrganizerModel *)model
{
    _model = model;
    self.tagList.tags = @[@"123123",@"123",@"23",@"123",@"23",@"123",@"23",@"123",@"23",@"123",@"23",@"123",@"23"];
    
    [self.tagList mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.weekDetailLabel.mas_bottom).offset(11);
        make.left.mas_equalTo(11);
        make.right.mas_equalTo(-11);
        make.height.mas_equalTo(self.tagList.contentHeight);
    }];
    
    
    CGSize cellSize = [self.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    model.cellHeight = cellSize.height;
    
//    self.goldImageView.image = [CZImageProvider imageNamed:@"shou_ye_jin_pai"];
//    self.bgView.image = [CZImageProvider imageNamed:@"shou_ye_jin_pai_bei_jing"];
    [self.rankView setRankByRate:model.valStar.floatValue];
    
    NSString *rankDetail = [NSString stringWithFormat:@"%@ 条评价 | %@ 案例 | %@ 顾问" , [@(model.valResponse.integerValue) stringValue], [@(model.valSatisfaction.integerValue) stringValue], [@(model.valProfessional.integerValue) stringValue]];
    self.rankDetailLabel.text = rankDetail;
    self.nameLabel.text = model.name;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:PIC_URL(model.logo)] placeholderImage:nil];
    self.addressLabel.text = model.address;
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    self.bgView.frame = CGRectMake(0, 0, self.contentView.bounds.size.width, CGRectGetMaxY(self.middileView.frame));
    [self.bottomView setBorderWithCornerRadius:10 borderWidth:1 borderColor:[UIColor clearColor] type:UIRectCornerBottomRight | UIRectCornerBottomLeft];
}

-(void)setType:(CZBoardOrganizerTopType)type
{
    _type = type;
    switch (type) {
        case CZBoardOrganizerTopTypeGold:
            self.goldImageView.image = [CZImageProvider imageNamed:@"shou_ye_jin_pai"];
            self.bgView.image = [CZImageProvider imageNamed:@"shou_ye_jin_pai_bei_jing"];
            self.middileView.backgroundColor = CZColorCreater(43, 120, 217, 1);
            break;
        case CZBoardOrganizerTopTypeSilver:
            self.goldImageView.image = [CZImageProvider imageNamed:@"shou_ye_yin_pai"];
            self.bgView.image = [CZImageProvider imageNamed:@"shou_ye_yin_pai_bei_jing"];
            self.middileView.backgroundColor = CZColorCreater(102, 129, 162, 1);
            break;
        case CZBoardOrganizerTopTypeCopper:
            self.goldImageView.image = [CZImageProvider imageNamed:@"shou_ye_tong_pai"];
            self.bgView.image = [CZImageProvider imageNamed:@"shou_ye_tong_pai_bei_jing"];
            self.middileView.backgroundColor = CZColorCreater(200, 145, 78, 1);
            break;
        default:
            break;
    }
}

@end
