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
#import "CZCommentModel.h"

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
@property (nonatomic , strong) UIView *tagView;

@property (nonatomic , strong) UIImageView *addressIconView;
@property (nonatomic , strong) UILabel *addressLabel;

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
        make.left.mas_equalTo(27);
        make.top.mas_equalTo(28);
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
        make.left.mas_equalTo(self.goldImageView);
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
    self.weekDetailLabel.textColor = [UIColor whiteColor];
    self.weekDetailLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:11];
    [self.contentView addSubview:self.weekDetailLabel];
    [self.weekDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_greaterThanOrEqualTo(0);
        make.height.mas_equalTo(12);
        make.left.mas_equalTo(self.goldImageView);
        make.top.mas_equalTo(self.rankView.mas_bottom).offset(12);
    }];
    
    self.tagView = [[UIView alloc] init];
    [self.contentView addSubview:self.tagView];
    [self.tagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.weekDetailLabel.mas_bottom).offset(11);
        make.left.mas_equalTo(26);
        make.right.mas_equalTo(-26);
        make.height.mas_equalTo(self.tagList.contentHeight);
    }];
    
    self.tagList = [[JCTagListView alloc]initWithFrame:CGRectMake(26, CGRectGetMaxY(self.weekDetailLabel.frame)+12, self.contentView.bounds.size.width-53,0)];
    self.tagList.tagCornerRadius = ScreenScale(2.5);
    self.tagList.tagBorderWidth = 0;
    self.tagList.tagBackgroundColor = [UIColor whiteColor];
    self.tagList.tagTextColor = CZColorCreater(43, 120, 217, 1);
    self.tagList.tagFont = [UIFont fontWithName:@"PingFang-SC-Medium" size:11];
    self.tagList.tagItemSpacing = 8;
    self.tagList.tagLineSpacing = 8;
    self.tagList.tagContentInset = UIEdgeInsetsMake(ScreenScale(5), ScreenScale(10), ScreenScale(5), ScreenScale(10));
    [self.tagView addSubview:self.tagList];
    [self.tagList mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    
    self.middileView = [[UIView alloc] init];
    [self.contentView addSubview:self.middileView];
    [self.middileView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.tagList.mas_bottom).offset(20);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
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
    self.iconDetailLabel.textColor = [UIColor whiteColor];
    self.iconDetailLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:12];
    [self.middileView addSubview:self.iconDetailLabel];
    [self.iconDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.iconImageView.mas_right).offset(5);
        make.centerY.mas_equalTo(self.iconImageView);
        make.right.mas_equalTo(-22);
        make.height.mas_greaterThanOrEqualTo(0);
    }];
    
    self.bottomView = [[UIView alloc] init];
    self.bottomView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.bottomView];
    [self.contentView sendSubviewToBack:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.middileView.mas_bottom).offset(-10);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(223);
        make.bottom.mas_equalTo(0);
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
    layout.itemSize = CGSizeMake(91, 180);
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
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.bottom.mas_equalTo(self.middileView.mas_bottom);
    }];
    
    self.bottomView.backgroundColor = [UIColor whiteColor];
    self.bottomView.layer.cornerRadius = 10;
    self.bottomView.layer.masksToBounds = YES;
}

-(void)setModel:(CZOrganizerModel *)model
{
    _model = model;
    if (!model.keywords.length) {
        self.tagList.tags = @[];
    }
    else
    {
        NSArray *keywords = [model.keywords componentsSeparatedByString:@","];
        self.tagList.tags = keywords;
    }
    
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
    
    NSString *rankDetail = [NSString stringWithFormat:@"%@ 条评价 | %@ 案例 | %@ 顾问" , [@(model.commentsCount.integerValue) stringValue], [@(model.caseCount.integerValue) stringValue], [@(model.counselorCount.integerValue) stringValue]];
    self.rankDetailLabel.text = rankDetail;
    self.nameLabel.text = model.name;
    self.addressLabel.text = model.address;
    
    self.iconDetailLabel.text = @"";
    self.iconImageView.image = [CZImageProvider imageNamed:@"default_avatar"];
    if (![model.comments isKindOfClass:[NSString class]] && model.comments.count > 0) {
        CZCommentModel *comment = [model.comments firstObject];
        self.iconDetailLabel.text = comment.comment;
        [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:PIC_URL(comment.userImg)] placeholderImage:nil];
    }
    
    self.weekDetailLabel.text = [NSString stringWithFormat:@"本周指数  销量 %@ | 人气 %@ | 口碑 %@",[@(model.sales.integerValue) stringValue] , [@(model.popularity.integerValue) stringValue] , [@(model.reputation.integerValue) stringValue]];
    
    self.productListView.dataArr = self.model.productVoList;
    [self.productListView reloadData];
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
