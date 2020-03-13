//
//  CZAdvisorDetailEvaluateCell.m
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/6.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZAdvisorDetailEvaluateCell.h"
#import "CZRankView.h"
#import "UIImageView+WebCache.h"

@interface CZAdvisorDetailEvaluateCell()
@property (nonatomic, strong)UIImageView *avatarImg;
@property (nonatomic, strong)UILabel *nameLab;
@property (nonatomic, strong)UILabel *timeLab;
@property (nonatomic ,strong)CZRankView *rankView;
@property (nonatomic, strong)UILabel *tipsLab;
@property (nonatomic, strong)UILabel *evaluateLab;
@property (nonatomic ,strong)UILabel *contentLab;
@property (nonatomic ,strong)UILabel *lookLab;
@property (nonatomic ,strong)UILabel *likeLab;
@property (nonatomic, strong)UIImageView *likeImg;
@property (nonatomic ,strong)UILabel *commentLab;
@property (nonatomic, strong)UIImageView *commentImg;
@end

@implementation CZAdvisorDetailEvaluateCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.picsArr = [NSMutableArray array];
        [self initWithUI];
    }
    return self;
}
- (void)setPicsArr:(NSMutableArray *)picsArr{
    _picsArr = picsArr;
    [self loadPicsImg];
}

//加载图片
- (void)loadPicsImg{
    if (self.picsArr.count>0) {
        WEAKSELF
        [self.picsArr enumerateObjectsUsingBlock:^(NSString *  _Nonnull url, NSUInteger idx, BOOL * _Nonnull stop) {
            UIImageView *pic = [[UIImageView alloc]init];
            [pic sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil];
            [weakSelf.contentView addSubview:pic];
            [pic mas_makeConstraints:^(MASConstraintMaker *make) {
                make.leading.mas_equalTo(weakSelf.contentLab.mas_leading).offset(idx%3 * (WidthRatio(193.5)+WidthRatio(10)));
                make.top.mas_equalTo(weakSelf.contentLab.mas_bottom).offset(HeightRatio(20)+idx/3 *(WidthRatio(193.5)+WidthRatio(10)));
                make.size.mas_equalTo(WidthRatio(193.5));
            }];
        }];
        
    }
}

- (void)initWithUI{
    self.backgroundColor = CZColorCreater(255, 255, 255, 1);
    
    self.avatarImg = [[UIImageView alloc]init];
    [self.avatarImg sd_setImageWithURL:[NSURL URLWithString:@"http://img.tupianzj.com/uploads/allimg/160411/9-1604110SJ0.jpg"] placeholderImage:nil];
    self.avatarImg.layer.masksToBounds = YES;
    self.avatarImg.layer.cornerRadius = WidthRatio(70)/2.0;
    [self.contentView addSubview:self.avatarImg];
    [self.avatarImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.contentView.mas_leading).offset(WidthRatio(30));
        make.top.mas_equalTo(self.contentView.mas_top).offset(HeightRatio(40));
        make.size.mas_equalTo(WidthRatio(70));
    }];
    
    self.timeLab = [[UILabel alloc]init];
    self.timeLab.font = [UIFont systemFontOfSize:WidthRatio(22)];
    self.timeLab.textColor = CZColorCreater(159, 159, 178, 1);
    self.timeLab.text = @"6小时前";
    [self.contentView addSubview:self.timeLab];
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self.contentView.mas_trailing).offset(-WidthRatio(30));
        make.height.mas_greaterThanOrEqualTo(0);
        make.top.mas_equalTo(self.avatarImg.mas_top).offset(HeightRatio(5));
        make.width.mas_greaterThanOrEqualTo(0).priorityHigh();
    }];
    
    self.nameLab = [[UILabel alloc]init];
    self.nameLab.font = [UIFont systemFontOfSize:WidthRatio(24)];
    self.nameLab.textColor = CZColorCreater(32, 32, 32, 1);
    self.nameLab.text = @"百事可乐";
    [self.contentView addSubview:self.nameLab];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.avatarImg.mas_trailing).offset(WidthRatio(18));
        make.top.mas_equalTo(self.avatarImg.mas_top).offset(HeightRatio(5));
        make.height.mas_greaterThanOrEqualTo(0);
        make.trailing.mas_equalTo (self.timeLab.mas_leading).offset(WidthRatio(20)).priorityLow();
    }];
    
    self.rankView = [CZRankView instanceRankViewByRate:3.1];
    [self.contentView addSubview:self.rankView];
    [self.rankView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(WidthRatio(150));
        make.leading.mas_equalTo(self.avatarImg.mas_trailing).offset(WidthRatio(20));
        make.top.mas_equalTo(self.nameLab.mas_bottom).offset(HeightRatio(10));
        make.height.mas_equalTo(HeightRatio(28));
    }];
    
    self.tipsLab = [[UILabel alloc]init];
    self.tipsLab.font = [UIFont systemFontOfSize:WidthRatio(18)];
    self.tipsLab.textColor = CZColorCreater(51, 172, 253, 1);
    self.tipsLab.text = @"  消费后评价  ";
    self.tipsLab.layer.masksToBounds = YES;
    self.tipsLab.layer.cornerRadius = WidthRatio(3);
    self.tipsLab.layer.borderWidth = WidthRatio(1);
    self.tipsLab.layer.borderColor = CZColorCreater(51, 172, 253, 1).CGColor;
    [self.contentView addSubview:self.tipsLab];
    [self.tipsLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.rankView.mas_trailing);
        make.top.mas_equalTo(self.rankView.mas_top).offset(-HeightRatio(5));
        make.width.mas_greaterThanOrEqualTo(0);
        make.height.mas_equalTo(HeightRatio(24));
    }];
    
    self.evaluateLab = [[UILabel alloc]init];
    self.evaluateLab.font = [UIFont systemFontOfSize:WidthRatio(24)];
    self.evaluateLab.textColor = CZColorCreater(129, 129, 146, 1);
    self.evaluateLab.text = @"专业度: 4.9  服务: 4.9  价格: 4.9";
    [self.contentView addSubview:self.evaluateLab];
    [self.evaluateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.nameLab.mas_leading);
        make.top.mas_equalTo(self.rankView.mas_bottom).offset(HeightRatio(10));
        make.height.mas_greaterThanOrEqualTo(0);
        make.trailing.mas_equalTo (self.contentView.mas_trailing).offset(-WidthRatio(24));
    }];
    
    self.contentLab = [[UILabel alloc]init];
    self.contentLab.font = [UIFont systemFontOfSize:WidthRatio(26)];
    self.contentLab.textColor = CZColorCreater(51, 51, 51, 1);
    self.contentLab.text = @"力学课内全部内容及相关自招考试内容。掌握热学电学的基础内容，培养完整的抽象思维方式";
    self.contentLab.numberOfLines = 0;
    [self.contentView addSubview:self.contentLab];
    [self.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.nameLab.mas_leading);
        make.top.mas_equalTo(self.evaluateLab.mas_bottom).offset(HeightRatio(25));
        make.height.mas_greaterThanOrEqualTo(0);
        make.trailing.mas_equalTo (self.contentView.mas_trailing).offset(-WidthRatio(24));
    }];
    
    self.lookLab = [[UILabel alloc]init];
    self.lookLab.font = [UIFont systemFontOfSize:WidthRatio(22)];
    self.lookLab.textColor = CZColorCreater(159, 159, 178, 1);
    self.lookLab.text = @"1522人已看";
    [self.contentView addSubview:self.lookLab];
    [self.lookLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.nameLab.mas_leading);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-HeightRatio(32));
        make.height.width.mas_greaterThanOrEqualTo(0);
    }];
    
    self.likeLab = [[UILabel alloc]init];
    self.likeLab.font = [UIFont systemFontOfSize:WidthRatio(24)];
    self.likeLab.textColor = CZColorCreater(150, 150, 171, 1);
    self.likeLab.text = @"1522";
    [self.contentView addSubview:self.likeLab];
    [self.likeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self.contentView.mas_trailing).offset(-WidthRatio(24));
        make.centerY.mas_equalTo(self.lookLab);
        make.height.width.mas_greaterThanOrEqualTo(0);
    }];
    
    self.likeImg = [[UIImageView alloc]init];
    self.likeImg.image = [CZImageProvider imageNamed:@"zhu_ye_zan"];
    [self.contentView addSubview:self.likeImg];
    [self.likeImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self.likeLab.mas_leading).offset(-WidthRatio(10));
        make.width.mas_equalTo(WidthRatio(25));
        make.height.mas_equalTo(HeightRatio(20));
        make.centerY.mas_equalTo(self.likeLab);
    }];
    
    self.commentLab = [[UILabel alloc]init];
    self.commentLab.font = [UIFont systemFontOfSize:WidthRatio(24)];
    self.commentLab.textColor = CZColorCreater(150, 150, 171, 1);
    self.commentLab.text = @"1522";
    [self.contentView addSubview:self.commentLab];
    [self.commentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self.likeImg.mas_leading).offset(-WidthRatio(70));
        make.centerY.mas_equalTo(self.lookLab);
        make.height.width.mas_greaterThanOrEqualTo(0);
    }];
    
    self.commentImg = [[UIImageView alloc]init];
    self.commentImg.image = [CZImageProvider imageNamed:@"guwen_pinglun"];
    [self.contentView addSubview:self.commentImg];
    [self.commentImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self.commentLab.mas_leading).offset(-WidthRatio(10));
        make.width.mas_equalTo(WidthRatio(25));
        make.height.mas_equalTo(HeightRatio(20));
        make.centerY.mas_equalTo(self.commentLab);
    }];
    
    UILabel *line = [[UILabel alloc]init];
    line.backgroundColor = CZColorCreater(243, 243, 247, 1);
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.mas_equalTo(self.contentView);
        make.height.mas_equalTo(HeightRatio(1));
    }];
}
@end