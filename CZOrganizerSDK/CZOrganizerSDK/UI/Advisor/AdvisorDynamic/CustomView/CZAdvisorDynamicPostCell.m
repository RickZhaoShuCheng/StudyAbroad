
//
//  AdvisorDynamicPostCell.m
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/22.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZAdvisorDynamicPostCell.h"
#import "UIImageView+WebCache.h"

@interface CZAdvisorDynamicPostCell()
@property (nonatomic ,strong) UIImageView *avatarImg;
@property (nonatomic ,strong) UILabel *nameLab;
@property (nonatomic ,strong) UILabel *timeLab;
@property (nonatomic ,strong) UIImageView *contentImg;
@property (nonatomic ,strong) UILabel *contentLab;
@property (nonatomic ,strong) UIButton *shareBtn;
@property (nonatomic ,strong) UIButton *collectionBtn;
@property (nonatomic ,strong) UILabel *collectionLab;
@property (nonatomic ,strong) UIButton *commentBtn;
@property (nonatomic ,strong) UILabel *commentLab;
@property (nonatomic ,strong) UIButton *likeBtn;
@property (nonatomic ,strong) UILabel *likeLab;
@end
@implementation CZAdvisorDynamicPostCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initWithUI];
        [self.avatarImg sd_setImageWithURL:[NSURL URLWithString:@"http://uploadfile.bizhizu.cn/2015/0720/20150720033105173.jpg.source.jpg"] placeholderImage:nil];
    }
    return self;
}

/**
 * 初始化UI
 */
- (void)initWithUI{
    self.avatarImg = [[UIImageView alloc]init];
    self.avatarImg.layer.masksToBounds = YES;
    self.avatarImg.layer.cornerRadius = ScreenScale(70)/2;
    [self.contentView addSubview:self.avatarImg];
    [self.avatarImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.contentView.mas_leading).offset(ScreenScale(30));
        make.top.mas_equalTo(self.contentView.mas_top).offset(ScreenScale(30));
        make.size.mas_equalTo(ScreenScale(70));
    }];
    
    self.nameLab = [[UILabel alloc]init];
    self.nameLab.text = @"许一铭";
    self.nameLab.textColor = CZColorCreater(51, 51, 51, 1);
    self.nameLab.font = [UIFont boldSystemFontOfSize:ScreenScale(28)];
    [self.contentView addSubview:self.nameLab];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.avatarImg.mas_trailing).offset(ScreenScale(18));
        make.top.mas_equalTo(self.avatarImg.mas_top);
        make.height.mas_greaterThanOrEqualTo(0);
        make.trailing.mas_equalTo(self.contentView.mas_trailing).offset(-ScreenScale(30));
    }];
    
    self.timeLab = [[UILabel alloc]init];
    self.timeLab.text = @"2小时前 ";
    self.timeLab.textColor = CZColorCreater(153, 153, 153, 1);
    self.timeLab.font = [UIFont boldSystemFontOfSize:ScreenScale(22)];
    [self.contentView addSubview:self.timeLab];
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.avatarImg.mas_trailing).offset(ScreenScale(18));
        make.bottom.mas_equalTo(self.avatarImg.mas_bottom);
        make.height.mas_greaterThanOrEqualTo(0);
        make.trailing.mas_equalTo(self.contentView.mas_trailing).offset(-ScreenScale(30));
    }];
    
    self.contentImg = [[UIImageView alloc]init];
    [self.contentImg sd_setImageWithURL:[NSURL URLWithString:@"http://uploadfile.bizhizu.cn/2015/0720/20150720033105173.jpg.source.jpg"] placeholderImage:nil];
    self.contentImg.layer.masksToBounds = YES;
    self.contentImg.layer.cornerRadius = ScreenScale(20);
    [self.contentView addSubview:self.contentImg];
    [self.contentImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.contentView).offset(ScreenScale(14));
        make.top.mas_equalTo(self.avatarImg.mas_bottom).offset(ScreenScale(22));
        make.trailing.mas_equalTo(self.contentView).offset(-ScreenScale(14));
        make.height.mas_equalTo(ScreenScale(524));
    }];
    
    self.contentLab = [[UILabel alloc]init];
    self.contentLab.numberOfLines = 0;
    self.contentLab.font = [UIFont systemFontOfSize:ScreenScale(28)];
    self.contentLab.textColor = CZColorCreater(51, 51, 51, 1);
    self.contentLab.text = @"晚餐就在位于公共市场的食在加拿大餐厅用餐这也是一个类似厂房改造的餐厅，超高的空间四面采光坐在这里很舒服，看着吧台忙碌的厨师...";
    [self.contentView addSubview:self.contentLab];
    [self.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.avatarImg.mas_bottom).offset(ScreenScale(22) + ScreenScale(524) + ScreenScale(24));
        make.leading.mas_equalTo(self.contentView.mas_leading).offset(ScreenScale(30));
        make.trailing.mas_equalTo(self.contentView.mas_trailing).offset(-ScreenScale(30));
        make.height.mas_greaterThanOrEqualTo(0);
    }];
    
    self.shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.shareBtn setImage:[CZImageProvider imageNamed:@"dongtai_fenxiang"] forState:UIControlStateNormal];
    [self.contentView addSubview:self.shareBtn];
    [self.shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.contentView.mas_leading).offset(ScreenScale(18));
        make.size.mas_equalTo(ScreenScale(60));
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-ScreenScale(20));
    }];
    
    self.collectionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.collectionBtn setImage:[CZImageProvider imageNamed:@"dongtai_shoucang"] forState:UIControlStateNormal];
    [self.contentView addSubview:self.collectionBtn];
    [self.collectionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self.contentView.mas_trailing).offset(-ScreenScale(40));
        make.size.mas_equalTo(ScreenScale(60));
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-ScreenScale(20));
    }];
    
    self.collectionLab = [[UILabel alloc]init];
    self.collectionLab.font = [UIFont systemFontOfSize:ScreenScale(16)];
    self.collectionLab.textColor = CZColorCreater(51, 51, 51, 1);
    self.collectionLab.text = @"-";
    [self.contentView addSubview:self.collectionLab];
    [self.collectionLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.collectionBtn.mas_trailing).offset(-ScreenScale(10));
        make.top.mas_equalTo(self.collectionBtn.mas_top).offset(ScreenScale(10));
        make.trailing.mas_equalTo(self.contentView.mas_trailing);
        make.height.mas_greaterThanOrEqualTo(0);
    }];
    
    self.commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.commentBtn setImage:[CZImageProvider imageNamed:@"dongtai_pinglun"] forState:UIControlStateNormal];
    [self.contentView addSubview:self.commentBtn];
    [self.commentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self.collectionBtn.mas_leading).offset(-ScreenScale(56));
        make.size.mas_equalTo(ScreenScale(60));
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-ScreenScale(20));
    }];
    
    self.commentLab = [[UILabel alloc]init];
    self.commentLab.font = [UIFont systemFontOfSize:ScreenScale(16)];
    self.commentLab.textColor = CZColorCreater(51, 51, 51, 1);
    self.commentLab.text = @"-";
    [self.contentView addSubview:self.commentLab];
    [self.commentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.commentBtn.mas_trailing).offset(-ScreenScale(10));
        make.top.mas_equalTo(self.commentBtn.mas_top).offset(ScreenScale(10));
        make.trailing.mas_equalTo(self.collectionBtn.mas_leading).offset(ScreenScale(10));
        make.height.mas_greaterThanOrEqualTo(0);
    }];
    
    self.likeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.likeBtn setImage:[CZImageProvider imageNamed:@"dongtai_xihuan"] forState:UIControlStateNormal];
    [self.contentView addSubview:self.likeBtn];
    [self.likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self.commentBtn.mas_leading).offset(-ScreenScale(56));
        make.size.mas_equalTo(ScreenScale(60));
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-ScreenScale(20));
    }];
    
    self.likeLab = [[UILabel alloc]init];
    self.likeLab.font = [UIFont systemFontOfSize:ScreenScale(16)];
    self.likeLab.textColor = CZColorCreater(51, 51, 51, 1);
    self.likeLab.text = @"-";
    [self.contentView addSubview:self.likeLab];
    [self.likeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.likeBtn.mas_trailing).offset(-ScreenScale(10));
        make.top.mas_equalTo(self.likeBtn.mas_top).offset(ScreenScale(10));
        make.trailing.mas_equalTo(self.commentBtn.mas_leading).offset(ScreenScale(10));
        make.height.mas_greaterThanOrEqualTo(0);
    }];
}
@end
