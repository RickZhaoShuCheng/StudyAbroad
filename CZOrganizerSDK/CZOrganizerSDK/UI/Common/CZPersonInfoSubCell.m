//
//  CZPersonInfoSubCell.m
//  CZOrganizerSDK
//
//  Created by zsc on 2020/2/29.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZPersonInfoSubCell.h"
#import "CZProductVoListModel.h"
#import "CZOrganizerModel.h"
@interface CZPersonInfoSubCell ()

@property (nonatomic , strong) UIImageView *iconImageView;
@property (nonatomic , strong) UILabel *mainTitleLabel;
@property (nonatomic , strong) UILabel *subTitleLabel;
@end

@implementation CZPersonInfoSubCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initWithUI];
    }
    return self;
}
/**
 * 赋值信息
 */

/**
 * 初始化UI
 */
- (void)initWithUI{

    self.iconImageView = [[UIImageView alloc] init];
    self.iconImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:self.iconImageView];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(15);
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(68);
    }];
    
    self.subTitleLabel = [[UILabel alloc] init];
    self.subTitleLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.subTitleLabel];
    [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_greaterThanOrEqualTo(0);
        make.centerY.mas_equalTo(0);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-10);
    }];
    
    self.mainTitleLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.mainTitleLabel];
    [self.mainTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_greaterThanOrEqualTo(0);
        make.right.mas_equalTo(self.subTitleLabel.mas_left).offset(-8);
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(self.iconImageView.mas_right).offset(7);
    }];
}

-(void)setCellType:(CZPersonInfoSubCellType)cellType
{
    switch (cellType) {
        case CZPersonInfoSubCellTypeSchool:
        case CZPersonInfoSubCellTypeAsk:
            self.mainTitleLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:13];
            self.mainTitleLabel.textColor = CZColorCreater(61, 67, 83, 1);
            self.iconImageView.image = [CZImageProvider imageNamed:@"zhu_ye_gou_cell"];
            self.subTitleLabel.textColor = CZColorCreater(255, 68, 85, 1);
            self.subTitleLabel.font = [UIFont boldSystemFontOfSize:14];
            break;
        case CZPersonInfoSubCellTypeOrganizer:
            self.mainTitleLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:12];
            self.mainTitleLabel.textColor = CZColorCreater(129, 129, 146, 1);
            self.iconImageView.image = [CZImageProvider imageNamed:@"shou_ye_ding_wei_cell"];
            self.subTitleLabel.textColor = CZColorCreater(255, 68, 85, 1);
            self.subTitleLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:13];

        default:
            break;
    }
}

-(void)setModel:(CZProductVoListModel *)model
{
    _model = model;
    self.mainTitleLabel.text = model.title;
    self.subTitleLabel.text = [NSString stringWithFormat:@"%@ %.2f" , model.priceType,model.price.floatValue/100];
}

-(void)setOmodel:(CZOrganizerModel *)omodel
{
    _omodel = omodel;
    self.mainTitleLabel.text = omodel.address;
    self.subTitleLabel.text = [NSString stringWithFormat:@"%.2fkm" , _omodel.distance];
}

@end
