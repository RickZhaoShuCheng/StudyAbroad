
//
//  CZCommentsDetailTwoCell.m
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/18.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZCommentsDetailTwoCell.h"
#import "UIImageView+WebCache.h"
#import "NSDate+Utils.h"
@interface CZCommentsDetailTwoCell()
@property (nonatomic ,strong) UIImageView *avatarImg;
@property (nonatomic ,strong) UILabel *nameLab;
@property (nonatomic ,strong) UILabel *contentLab;
@property (nonatomic ,strong) UILabel *timeLab;
@property (nonatomic ,strong) UILabel *countLab;
@property (nonatomic ,strong) UIImageView *likeImg;
@end
@implementation CZCommentsDetailTwoCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initWithUI];
    }
    return self;
}
- (void)setModel:(CZCommentModel *)model{
    _model = model;
    [self.avatarImg sd_setImageWithURL:[NSURL URLWithString:PIC_URL(model.userImg)] placeholderImage:nil];
    self.nameLab.text = model.userNickName;
    
    NSMutableAttributedString *tempStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"回复%@ %@",model.toUserNickName,model.comment]];
    [tempStr addAttributes:@{NSForegroundColorAttributeName:CZColorCreater(29, 112, 193, 1)} range:NSMakeRange(2, model.toUserNickName.length)];
    
    self.contentLab.attributedText = tempStr;
    self.countLab.text = [NSString stringWithFormat:@"%@",[@([model.praiseCount integerValue]) stringValue]];
    self.timeLab.text = [[NSDate alloc] distanceTimeWithBeforeTime:[model.createTime doubleValue]/1000];
}

/**
 * 初始化UI
 */
- (void)initWithUI{
    self.avatarImg = [[UIImageView alloc]init];
    self.avatarImg.layer.masksToBounds = YES;
    self.avatarImg.layer.cornerRadius = ScreenScale(60)/2.0;
    [self.contentView addSubview:self.avatarImg];
    [self.avatarImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.contentView.mas_leading).offset(ScreenScale(120));
        make.top.mas_equalTo(self.contentView.mas_top).offset(ScreenScale(20));
        make.size.mas_equalTo(ScreenScale(60));
    }];
    
    self.nameLab = [[UILabel alloc]init];
    self.nameLab.font = [UIFont systemFontOfSize:ScreenScale(24)];
    self.nameLab.textColor = CZColorCreater(32, 32, 32, 1);
    self.nameLab.text = @"-";
    [self.contentView addSubview:self.nameLab];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self.contentView.mas_trailing).offset(-ScreenScale(30));
        make.leading.mas_equalTo(self.avatarImg.mas_trailing).offset(ScreenScale(20));
        make.top.mas_equalTo(self.avatarImg);
        make.height.mas_greaterThanOrEqualTo(0);
    }];
    
    self.contentLab = [[UILabel alloc]init];
    self.contentLab.font = [UIFont systemFontOfSize:ScreenScale(26)];
    self.contentLab.textColor = CZColorCreater(0, 0, 0, 1);
    self.contentLab.text = @"-";
    [self.contentView addSubview:self.contentLab];
    [self.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self.contentView.mas_trailing).offset(-ScreenScale(30));
        make.leading.mas_equalTo(self.avatarImg.mas_trailing).offset(ScreenScale(20));
        make.top.mas_equalTo(self.nameLab.mas_bottom).offset(ScreenScale(10));
        make.height.mas_greaterThanOrEqualTo(0);
    }];
    
    self.timeLab = [[UILabel alloc]init];
    self.timeLab.font = [UIFont systemFontOfSize:ScreenScale(22)];
    self.timeLab.textColor = CZColorCreater(159, 159, 178, 1);
    self.timeLab.text = @"-";
    [self.contentView addSubview:self.timeLab];
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.avatarImg.mas_trailing).offset(ScreenScale(20));
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-ScreenScale(24));
        make.height.width.mas_greaterThanOrEqualTo(0);
    }];
    
    self.countLab = [[UILabel alloc]init];
    self.countLab.font = [UIFont systemFontOfSize:ScreenScale(24)];
    self.countLab.text = @"-";
    self.countLab.textColor = CZColorCreater(150, 150, 171, 1);
    self.countLab.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.countLab];
    [self.countLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self.contentView.mas_trailing).offset(-ScreenScale(30));
        make.centerY.mas_equalTo(self.timeLab);
        make.height.width.mas_greaterThanOrEqualTo(0);
    }];
    
    self.likeImg = [[UIImageView alloc]init];
    self.likeImg.image = [CZImageProvider imageNamed:@"zhu_ye_zan"];
    [self.contentView addSubview:self.likeImg];
    [self.likeImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self.countLab.mas_leading).offset(-ScreenScale(10)).priorityHigh();
        make.width.mas_equalTo(ScreenScale(25));
        make.height.mas_equalTo(ScreenScale(20));
        make.centerY.mas_equalTo(self.countLab);
    }];
}
@end
