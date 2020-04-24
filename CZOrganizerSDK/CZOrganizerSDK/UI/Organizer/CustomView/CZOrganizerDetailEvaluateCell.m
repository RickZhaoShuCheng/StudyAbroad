//
//  CZOrganizerDetailEvaluateCell.m
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/8.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZOrganizerDetailEvaluateCell.h"
#import "CZRankView.h"
#import "UIImageView+WebCache.h"
#import "NSDate+Utils.h"

@interface CZOrganizerDetailEvaluateCell()
@property (nonatomic, strong)UIImageView *avatarImg;
@property (nonatomic, strong)UILabel *nameLab;
@property (nonatomic, strong)UILabel *timeLab;
@property (nonatomic ,strong)CZRankView *rankView;
@property (nonatomic, strong)UILabel *tipsLab;
@property (nonatomic, strong)UILabel *evaluateLab;
@property (nonatomic ,strong)UILabel *contentLab;
@property (nonatomic ,strong)UILabel *lookLab;
@property (nonatomic ,strong)UILabel *likeLab;
@property (nonatomic, strong)UIButton *likeBtn;
@property (nonatomic ,strong)UILabel *commentLab;
@property (nonatomic, strong)UIImageView *commentImg;
@end
@implementation CZOrganizerDetailEvaluateCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.picsArr = [NSMutableArray array];
        [self initWithUI];
    }
    return self;
}
- (void)setModel:(CZCommentModel *)model{
    _model = model;
    [self.avatarImg sd_setImageWithURL:[NSURL URLWithString:PIC_URL(model.userImg)] placeholderImage:nil];
    self.nameLab.text = model.userNickName;
    [self.rankView setRankByRate:[model.valStar floatValue]];
    self.evaluateLab.text = [NSString stringWithFormat:@"专业度: %.1f  服务: %.1f  价格: %.1f",[model.valMajor floatValue],[model.valService floatValue],[model.valPrice floatValue]];
    self.contentLab.text = model.comment;
    self.lookLab.text = [NSString stringWithFormat:@"%@人已看",[@([model.visitCount integerValue]) stringValue]];
    self.commentLab.text = [NSString stringWithFormat:@"%@",[@([model.replyCount integerValue]) stringValue]];
    self.likeLab.text = [NSString stringWithFormat:@"%@",[@([model.praiseCount integerValue]) stringValue]];
    self.timeLab.text = [[NSDate alloc] distanceTimeWithBeforeTime:[model.createTime doubleValue]/1000];
    if ([model.isPraise boolValue]) {
        [self.likeBtn setImage:[CZImageProvider imageNamed:@"zhu_ye_yi_zan"] forState:UIControlStateNormal];
        [self.likeBtn setImage:[CZImageProvider imageNamed:@"zhu_ye_yi_zan"] forState:UIControlStateDisabled];
    }else{
        [self.likeBtn setImage:[CZImageProvider imageNamed:@"zhu_ye_zan"] forState:UIControlStateNormal];
        [self.likeBtn setImage:[CZImageProvider imageNamed:@"zhu_ye_zan"] forState:UIControlStateDisabled];
    }
    NSMutableArray *imgsArr = [NSMutableArray array];
    if (model.imgs.length) {
        [imgsArr addObjectsFromArray:[model.imgs componentsSeparatedByString:@","]];
    }
    [self.picsArr removeAllObjects];
    self.picsArr = imgsArr;
}

- (void)setPicsArr:(NSMutableArray *)picsArr{
    _picsArr = picsArr;
    [self loadPicsImg];
}

//加载图片
- (void)loadPicsImg{
    NSMutableArray *imgArr = [NSMutableArray array];
    [self.contentView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UIImageView class]] && obj.tag >= 700) {
            [imgArr addObject:obj];
        }
    }];
    [imgArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    if (self.picsArr.count>0) {
        WEAKSELF
        [self.picsArr enumerateObjectsUsingBlock:^(NSString *  _Nonnull url, NSUInteger idx, BOOL * _Nonnull stop) {
            UIImageView *pic = [[UIImageView alloc]init];
            [pic sd_setImageWithURL:[NSURL URLWithString:PIC_URL(url)] placeholderImage:nil];
            pic.tag = 700 + idx;
            [weakSelf.contentView addSubview:pic];
            [pic mas_makeConstraints:^(MASConstraintMaker *make) {
                make.leading.mas_equalTo(weakSelf.contentLab.mas_leading).offset(idx%3 * (ScreenScale(193.5)+ScreenScale(10)));
                make.top.mas_equalTo(weakSelf.contentLab.mas_bottom).offset(ScreenScale(20)+idx/3 *(ScreenScale(193.5)+ScreenScale(10)));
                make.size.mas_equalTo(ScreenScale(193.5));
            }];
        }];
        
    }
}

- (void)clickLike:(UIButton *)likeBtn{
    if (self.clickLikeAction) {
        self.clickLikeAction(likeBtn);
    }
}

- (void)initWithUI{
    self.backgroundColor = CZColorCreater(255, 255, 255, 1);
    
    self.avatarImg = [[UIImageView alloc]init];
    [self.avatarImg sd_setImageWithURL:[NSURL URLWithString:@"http://img.tupianzj.com/uploads/allimg/160411/9-1604110SJ0.jpg"] placeholderImage:nil];
    self.avatarImg.layer.masksToBounds = YES;
    self.avatarImg.layer.cornerRadius = ScreenScale(70)/2.0;
    [self.contentView addSubview:self.avatarImg];
    [self.avatarImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.contentView.mas_leading).offset(ScreenScale(30));
        make.top.mas_equalTo(self.contentView.mas_top).offset(ScreenScale(40));
        make.size.mas_equalTo(ScreenScale(70));
    }];
    
    self.timeLab = [[UILabel alloc]init];
    self.timeLab.font = [UIFont systemFontOfSize:ScreenScale(22)];
    self.timeLab.textColor = CZColorCreater(159, 159, 178, 1);
    self.timeLab.text = @"-";
    [self.contentView addSubview:self.timeLab];
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self.contentView.mas_trailing).offset(-ScreenScale(30));
        make.height.mas_greaterThanOrEqualTo(0);
        make.top.mas_equalTo(self.avatarImg.mas_top).offset(ScreenScale(5));
        make.width.mas_greaterThanOrEqualTo(0).priorityHigh();
    }];
    
    self.nameLab = [[UILabel alloc]init];
    self.nameLab.font = [UIFont systemFontOfSize:ScreenScale(24)];
    self.nameLab.textColor = CZColorCreater(32, 32, 32, 1);
    self.nameLab.text = @"-";
    [self.contentView addSubview:self.nameLab];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.avatarImg.mas_trailing).offset(ScreenScale(18));
        make.top.mas_equalTo(self.avatarImg.mas_top).offset(ScreenScale(5));
        make.height.mas_greaterThanOrEqualTo(0);
        make.trailing.mas_equalTo (self.timeLab.mas_leading).offset(ScreenScale(20)).priorityLow();
    }];
    
    self.rankView = [CZRankView instanceRankViewByRate:0.0];
    [self.contentView addSubview:self.rankView];
    [self.rankView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(ScreenScale(150));
        make.leading.mas_equalTo(self.avatarImg.mas_trailing).offset(ScreenScale(20));
        make.top.mas_equalTo(self.nameLab.mas_bottom).offset(ScreenScale(10));
        make.height.mas_equalTo(ScreenScale(28));
    }];
    
    self.tipsLab = [[UILabel alloc]init];
    self.tipsLab.font = [UIFont systemFontOfSize:ScreenScale(18)];
    self.tipsLab.textColor = CZColorCreater(51, 172, 253, 1);
    self.tipsLab.text = @"  消费后评价  ";
    self.tipsLab.layer.masksToBounds = YES;
    self.tipsLab.layer.cornerRadius = ScreenScale(3);
    self.tipsLab.layer.borderWidth = ScreenScale(1);
    self.tipsLab.layer.borderColor = CZColorCreater(51, 172, 253, 1).CGColor;
    [self.contentView addSubview:self.tipsLab];
    [self.tipsLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.rankView.mas_trailing);
        make.top.mas_equalTo(self.rankView.mas_top).offset(-ScreenScale(5));
        make.width.mas_greaterThanOrEqualTo(0);
        make.height.mas_equalTo(ScreenScale(24));
    }];
    
    self.evaluateLab = [[UILabel alloc]init];
    self.evaluateLab.font = [UIFont systemFontOfSize:ScreenScale(24)];
    self.evaluateLab.textColor = CZColorCreater(129, 129, 146, 1);
    self.evaluateLab.text = @"专业度: -  服务: -  价格: -";
    [self.contentView addSubview:self.evaluateLab];
    [self.evaluateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.nameLab.mas_leading);
        make.top.mas_equalTo(self.rankView.mas_bottom).offset(ScreenScale(10));
        make.height.mas_greaterThanOrEqualTo(0);
        make.trailing.mas_equalTo (self.contentView.mas_trailing).offset(-ScreenScale(24));
    }];
    
    self.contentLab = [[UILabel alloc]init];
    self.contentLab.font = [UIFont systemFontOfSize:ScreenScale(26)];
    self.contentLab.textColor = CZColorCreater(51, 51, 51, 1);
    self.contentLab.text = @"-";
    self.contentLab.numberOfLines = 0;
    [self.contentView addSubview:self.contentLab];
    [self.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.nameLab.mas_leading);
        make.top.mas_equalTo(self.evaluateLab.mas_bottom).offset(ScreenScale(25));
        make.height.mas_greaterThanOrEqualTo(0);
        make.trailing.mas_equalTo (self.contentView.mas_trailing).offset(-ScreenScale(24));
    }];
    
    self.lookLab = [[UILabel alloc]init];
    self.lookLab.font = [UIFont systemFontOfSize:ScreenScale(22)];
    self.lookLab.textColor = CZColorCreater(159, 159, 178, 1);
    self.lookLab.text = @"-人已看";
    [self.contentView addSubview:self.lookLab];
    [self.lookLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.nameLab.mas_leading);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-ScreenScale(32));
        make.height.width.mas_greaterThanOrEqualTo(0);
    }];
    
    self.likeLab = [[UILabel alloc]init];
    self.likeLab.font = [UIFont systemFontOfSize:ScreenScale(24)];
    self.likeLab.textColor = CZColorCreater(150, 150, 171, 1);
    self.likeLab.text = @"-";
    [self.contentView addSubview:self.likeLab];
    [self.likeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self.contentView.mas_trailing).offset(-ScreenScale(24));
        make.centerY.mas_equalTo(self.lookLab);
        make.height.width.mas_greaterThanOrEqualTo(0);
    }];
    
    self.likeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.likeBtn setImage:[CZImageProvider imageNamed:@"zhu_ye_zan"] forState:UIControlStateNormal];
    [self.likeBtn setImage:[CZImageProvider imageNamed:@"zhu_ye_zan"] forState:UIControlStateDisabled];
    [self.likeBtn addTarget:self action:@selector(clickLike:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.likeBtn];
    [self.likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self.likeLab.mas_leading).offset(-ScreenScale(10));
        make.width.mas_equalTo(ScreenScale(60));
        make.height.mas_equalTo(ScreenScale(60));
        make.centerY.mas_equalTo(self.likeLab);
    }];
    
    self.commentLab = [[UILabel alloc]init];
    self.commentLab.font = [UIFont systemFontOfSize:ScreenScale(24)];
    self.commentLab.textColor = CZColorCreater(150, 150, 171, 1);
    self.commentLab.text = @"-";
    [self.contentView addSubview:self.commentLab];
    [self.commentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self.likeBtn.mas_leading).offset(-ScreenScale(70));
        make.centerY.mas_equalTo(self.lookLab);
        make.height.width.mas_greaterThanOrEqualTo(0);
    }];
    
    self.commentImg = [[UIImageView alloc]init];
    self.commentImg.image = [CZImageProvider imageNamed:@"guwen_pinglun"];
    [self.contentView addSubview:self.commentImg];
    [self.commentImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self.commentLab.mas_leading).offset(-ScreenScale(10));
        make.width.mas_equalTo(ScreenScale(25));
        make.height.mas_equalTo(ScreenScale(20));
        make.centerY.mas_equalTo(self.commentLab);
    }];
    
    UILabel *line = [[UILabel alloc]init];
    line.backgroundColor = CZColorCreater(243, 243, 247, 1);
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.mas_equalTo(self.contentView);
        make.height.mas_equalTo(ScreenScale(1));
    }];
}
@end
