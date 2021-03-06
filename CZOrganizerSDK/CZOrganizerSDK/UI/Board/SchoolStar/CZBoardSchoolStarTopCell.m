//
//  CZBoardSchoolStarTopCell.m
//  CZOrganizerSDK
//
//  Created by 赵曙诚 on 2020/3/20.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZBoardSchoolStarTopCell.h"
#import "CZRankView.h"
#import "JCTagListView.h"
#import "UIImageView+WebCache.h"
#import "UIView+cz_anyCorners.h"
#import "CZBoardProductListView.h"
#import "CZCommentModel.h"

@interface CZBoardSchoolStarTopCell()
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
@property (nonatomic , strong) UIView *tagView;
@property (nonatomic , strong) UIImageView *iconImageView;
@property (nonatomic , strong) UILabel *iconDetailLabel;

@property (nonatomic , strong) UIImageView *addressIconView;
@property (nonatomic , strong) UILabel *addressLabel;
@property (nonatomic , strong) UIImageView *confirmImageView;

@end

@implementation CZBoardSchoolStarTopCell

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
        make.left.mas_equalTo(25);
        make.top.mas_equalTo(7);
        make.width.mas_equalTo(28);
        make.height.mas_equalTo(31);
    }];
    
    self.avatarImageView = [[UIImageView alloc] init];
    self.avatarImageView.layer.cornerRadius = 32;
    self.avatarImageView.layer.masksToBounds = YES;
    [self.contentView insertSubview:self.avatarImageView belowSubview:self.goldImageView];
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(68);
        make.top.mas_equalTo(self.goldImageView).offset(8);
        make.left.mas_equalTo(self.goldImageView).offset(5);
    }];
    
    self.confirmImageView = [[UIImageView alloc] init];
    [self addSubview:self.confirmImageView];
    self.confirmImageView.image = [CZImageProvider imageNamed:@"ji_gou_ren_zheng_da"];
    [self.confirmImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(52);
        make.height.mas_equalTo(24);
        make.centerY.mas_equalTo(self.avatarImageView.mas_bottom);
        make.centerX.mas_equalTo(self.avatarImageView);
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
    
    self.tagView = [[UIView alloc] init];
    [self.contentView addSubview:self.tagView];
    [self.tagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.avatarImageView.mas_bottom).offset(5);
        make.left.mas_equalTo(self.workPlaceLabel.mas_left);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(40);
    }];
    
    self.tagList = [[JCTagListView alloc]initWithFrame:CGRectMake(11, 0, [UIScreen mainScreen].bounds.size.width-30, 300)];
    self.tagList.tagCornerRadius = ScreenScale(2.5);
    self.tagList.tagBorderWidth = 0;
    self.tagList.tagBackgroundColor = [UIColor whiteColor];
    self.tagList.tagTextColor = CZColorCreater(77, 54, 229, 1);
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
        make.top.mas_equalTo(self.tagList.mas_bottom).offset(10);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(54);
    }];
    
    self.weekDetailLabel = [[UILabel alloc] init];
    self.weekDetailLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:14];
    self.weekDetailLabel.textColor = [UIColor whiteColor];
    [self.middileView addSubview:self.weekDetailLabel];
    [self.weekDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.height.mas_equalTo(12);
        make.right.mas_equalTo(-11);
        make.centerY.mas_equalTo(0);
    }];
    
//    self.iconImageView = [[UIImageView alloc] init];
//    self.iconImageView.layer.masksToBounds = YES;
//    self.iconImageView.layer.cornerRadius = 10.5;
//    [self.middileView addSubview:self.iconImageView];
//    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(21);
//        make.left.top.mas_equalTo(9);
//    }];
//
//    self.iconDetailLabel = [[UILabel alloc] init];
//    [self.middileView addSubview:self.iconDetailLabel];
//    [self.iconDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.iconDetailLabel.mas_right).offset(5);
//        make.top.mas_equalTo(5);
//        make.right.mas_equalTo(-22);
//        make.height.mas_greaterThanOrEqualTo(0);
//    }];
    
    self.bottomView = [[UIView alloc] init];
    self.bottomView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.bottomView];
    [self.contentView sendSubviewToBack:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.middileView.mas_bottom);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(50);
        make.bottom.mas_equalTo(0);
    }];
    
    self.addressIconView = [[UIImageView alloc] init];
    self.addressIconView.layer.masksToBounds = YES;
    self.addressIconView.layer.cornerRadius = 11;
    self.addressIconView.image = [CZImageProvider imageNamed:@"shou_ye_di_zhi_icon"];
    self.addressIconView.backgroundColor = [UIColor redColor];
    [self.bottomView addSubview:self.addressIconView];
    [self.addressIconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(22);
        make.left.mas_equalTo(15);
        make.bottom.mas_equalTo(-25);
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
    
    
    self.productListView = [[CZBoardSchoolStarProductView alloc] init];
    self.productListView.layer.cornerRadius = 10;
    self.productListView.scrollEnabled = NO;
    self.productListView.layer.masksToBounds = YES;
    [self.bottomView addSubview:self.productListView];
    [self.productListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(-10);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-30, 10)];
    header.backgroundColor = [UIColor whiteColor];
    self.productListView.tableHeaderView = header;
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(-15);
        make.left.mas_equalTo(15);
        make.bottom.mas_equalTo(self.middileView.mas_bottom);
    }];
    
    [self.bottomView sendSubviewToBack:self.productListView];
}

-(void)setModel:(CZSchoolStarModel *)model
{
    _model = model;
    if (!model.sportUserEduVos.length) {
        self.tagList.tags = @[];
    }
    else
    {
        NSArray *sportUserEduVos = [model.sportUserEduVos componentsSeparatedByString:@","];
        self.tagList.tags = sportUserEduVos;
    }
    
    [self.tagView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(self.tagList.contentHeight);
    }];
    
    CGFloat bottomHeight = 15+40*(self.model.productVoList.count < 3?self.model.productVoList.count:2);
    
    if (self.model.comments.count == 0) {
        self.addressIconView.hidden = YES;
        self.addressLabel.hidden = YES;
    }
    else
    {
        bottomHeight += 40;
        self.addressIconView.hidden = NO;
        self.addressLabel.hidden = NO;
        CZCommentModel *comment = self.model.comments[0];
        self.addressLabel.text = comment.comment;
        [self.addressIconView sd_setImageWithURL:[NSURL URLWithString:PIC_URL(comment.userImg)] placeholderImage:[CZImageProvider imageNamed:@"default_avatar"]];
    }
    
    [self.bottomView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(bottomHeight);
    }];

    [self.rankView setRankByRate:model.valStar.floatValue];
    
    self.rankDetailLabel.text = [NSString stringWithFormat:@"%@ 次服务" , [@(model.serviceCount.integerValue) stringValue]];

    self.nameLabel.text = model.realName;
    self.workPlaceLabel.text = model.keywords;
    
    self.iconDetailLabel.text = @"";
    self.iconImageView.image = [CZImageProvider imageNamed:@"default_avatar"];
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:PIC_URL(model.userImg)] placeholderImage:[CZImageProvider imageNamed:@"default_avatar"]];

    self.weekDetailLabel.text = [NSString stringWithFormat:@"本周指数  销量 %@ | 人气 %@ | 口碑 %@",[@(model.sales.integerValue) stringValue] , [@(model.popularity.integerValue) stringValue] , [@(model.reputation.integerValue) stringValue]];
    
    [self.productListView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(-10);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(bottomHeight);
    }];
    
    self.productListView.dataArr = self.model.productVoList.count > 2?[self.model.productVoList subarrayWithRange:NSMakeRange(0, 2)]:self.model.productVoList;
    [self.productListView reloadData];
    
    [self.contentView layoutIfNeeded];
    
    CGSize cellSize = [self.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    model.cellHeight = cellSize.height;
}

-(void)setType:(CZBoardSchoolStarTopType)type
{
    _type = type;
    switch (type) {
        case CZBoardSchoolStarTopTypeGold:
            self.goldImageView.image = [CZImageProvider imageNamed:@"shou_ye_jin_pai"];
            self.bgView.image = [CZImageProvider imageNamed:@"shou_ye_jin_pai_bei_jing"];
            self.middileView.backgroundColor = CZColorCreater(43, 120, 217, 1);
            break;
        case CZBoardSchoolStarTopTypeSilver:
            self.goldImageView.image = [CZImageProvider imageNamed:@"shou_ye_yin_pai"];
            self.middileView.backgroundColor = CZColorCreater(200, 145, 78, 1);
            self.bgView.image = [CZImageProvider imageNamed:@"shou_ye_tong_pai_bei_jing"];
            break;
        case CZBoardSchoolStarTopTypeCopper:
            self.goldImageView.image = [CZImageProvider imageNamed:@"shou_ye_tong_pai"];
            self.middileView.backgroundColor = CZColorCreater(102, 129, 162, 1);
            self.bgView.image = [CZImageProvider imageNamed:@"shou_ye_yin_pai_bei_jing"];
            break;
        default:
            break;
    }
}

@end

