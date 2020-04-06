

//
//  SchoolStarShopDetailTableHeaderView.m
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/4/6.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "SchoolStarShopDetailTableHeaderView.h"
#import "CZRankView.h"
#import "CZAdvisorDetailBtnView.h"
#import "UIImageView+WebCache.h"

@interface SchoolStarShopDetailTableHeaderView ()
@property (nonatomic ,strong)UIImageView *avatarImg;
@property (nonatomic ,strong)UIImageView *VImg;
@property (nonatomic ,strong)UILabel *nameLab;
@property (nonatomic ,strong)UILabel *contentLab;
@property (nonatomic ,strong)CZRankView *rankView;
@property (nonatomic ,strong)UILabel *serviceLab;
@property (nonatomic ,strong)CZAdvisorDetailBtnView *caseView;
@property (nonatomic ,strong)CZAdvisorDetailBtnView *fansView;
@property (nonatomic ,strong)CZAdvisorDetailBtnView *serviceView;
@property (nonatomic ,strong)CZAdvisorDetailBtnView *consultView;
@property (nonatomic ,strong)CZAdvisorDetailBtnView *praiseView;
@property (nonatomic ,strong)CZAdvisorDetailBtnView *complainView;
@property (nonatomic ,strong)CZAdvisorDetailBtnView *refundView;
@property (nonatomic ,strong)CZAdvisorDetailBtnView *evaluationView;
@end
@implementation SchoolStarShopDetailTableHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = CZColorCreater(245, 245, 249, 1);
        [self initWithUI];
    }
    return self;
}
- (void)setModel:(CZSchoolStarModel *)model{
    _model = model;
    if (!model) {
        return;
    }
    if ([model.status integerValue] == 1) {
        self.VImg.hidden = NO;
    }else{
        self.VImg.hidden = YES;
    }
    self.nameLab.text = model.realName;
    [self.avatarImg sd_setImageWithURL:[NSURL URLWithString:PIC_URL(model.userImg)] placeholderImage:nil];
    [self.bgImg sd_setImageWithURL:[NSURL URLWithString:PIC_URL(model.userImg)] placeholderImage:nil];
    [self.rankView setRankByRate:[model.valStar floatValue]];
    self.serviceLab.text = [NSString stringWithFormat:@"服务%@人",[@([model.servicePersonCount integerValue]) stringValue]];
    if ([model.isGraduation integerValue] == 1) {
        self.contentLab.text = [NSString stringWithFormat:@"%@年%@留学老油条 | %@/已毕业",model.studyYears,model.countryName,model.schoolName];
    }else if ([model.isGraduation integerValue] == 2){
        self.contentLab.text = [NSString stringWithFormat:@"%@年%@留学老油条 | %@/留学中",model.studyYears,model.countryName,model.schoolName];
    }else if ([model.isGraduation integerValue] == 3){
        self.contentLab.text = [NSString stringWithFormat:@"%@年%@留学老油条 | %@/准备留学",model.studyYears,model.countryName,model.schoolName];
    }
    self.caseView.countLab.text = [@([model.caseCount integerValue]) stringValue];
    self.fansView.countLab.text = [@([model.fanCount integerValue]) stringValue];
    self.serviceView.countLab.text = [@([model.serviceCount integerValue]) stringValue];
    self.consultView.countLab.text = [@([model.askRanking integerValue]) stringValue];
    self.praiseView.countLab.text = [NSString stringWithFormat:@"%@%@",[@([model.ratePraise integerValue]) stringValue],@"%"];
    self.complainView.countLab.text = [NSString stringWithFormat:@"%@%@",[@([model.rateComplaint integerValue]) stringValue],@"%"];
    self.refundView.countLab.text = [NSString stringWithFormat:@"%@%@",[@([model.rateRepay integerValue]) stringValue],@"%"];
    self.evaluationView.countLab.text = [@([model.commentsCount integerValue]) stringValue];
//    model.keywords = @"LOL,奥科吉是否会扣水电费,阿道夫,科技啊回复跨境电商,卡是副科级,接收到回复";
    NSMutableArray *keyArr = [NSMutableArray array];
    if (model.keywords.length) {
        [keyArr addObjectsFromArray:[model.keywords componentsSeparatedByString:@","]];
    }
    [self setTags:keyArr];
    
}
//设置标签
- (void)setTags:(NSMutableArray *)tagesArr{
    
    self.tagList.tags = tagesArr;
    if (tagesArr.count == 0) {
        self.tagList.frame = CGRectMake(ScreenScale(50), self.evaluationView.frame.origin.y+self.evaluationView.frame.size.height+ScreenScale(40), kScreenWidth - ScreenScale(80),0);
    }else{
        self.tagList.frame = CGRectMake(ScreenScale(50), self.evaluationView.frame.origin.y+self.evaluationView.frame.size.height+ScreenScale(40), kScreenWidth - ScreenScale(80),self.tagList.contentHeight);
    }
    
    self.bgImg.frame = CGRectMake(0, 0, kScreenWidth, ScreenScale(540));
}

-(void)initWithUI{
    //根据标签高度调整背景高度
    self.bgImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, ScreenScale(540))];
    [self addSubview:self.bgImg];
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    effectView.alpha = 1;
    effectView.backgroundColor = CZColorCreater(0, 0, 0, 0.3);
    [self.bgImg addSubview:effectView];
    [effectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.bgImg);
    }];

    self.avatarImg = [[UIImageView alloc]init];
    self.avatarImg.layer.masksToBounds = YES;
    self.avatarImg.layer.cornerRadius = ScreenScale(100)/2;
    [self addSubview:self.avatarImg];
    [self.avatarImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.mas_leading).offset(ScreenScale(50));
        make.top.mas_equalTo(self.mas_top).offset(ScreenScale(180));
        make.width.height.mas_equalTo(ScreenScale(100));
    }];

    self.VImg = [[UIImageView alloc]init];
    self.VImg.image = [CZImageProvider imageNamed:@"shou_ye_ren_zheng_cell"];
    [self addSubview:self.VImg];
    [self.VImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.avatarImg.mas_bottom).offset(-ScreenScale(18));
        make.centerX.mas_equalTo(self.avatarImg);
        make.width.mas_equalTo(ScreenScale(80));
        make.height.mas_equalTo(ScreenScale(36));
    }];

    self.nameLab = [[UILabel alloc] init];
    self.nameLab.text = @"-";
    self.nameLab.textColor = CZColorCreater(255, 255, 255, 1);
    self.nameLab.font = [UIFont boldSystemFontOfSize:ScreenScale(34)];
    [self addSubview:self.nameLab];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.avatarImg.mas_trailing).offset(ScreenScale(20));
        make.top.mas_equalTo(self.avatarImg.mas_top);
        make.trailing.mas_equalTo(self.mas_trailing).offset(-ScreenScale(30));
        make.height.mas_greaterThanOrEqualTo(0);
    }];

    self.contentLab = [[UILabel alloc] init];
    self.contentLab.text = @"-";
    self.contentLab.textColor = CZColorCreater(255, 255, 255, 1);
    self.contentLab.font = [UIFont systemFontOfSize:ScreenScale(22)];
    [self addSubview:self.contentLab];
    [self.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.avatarImg.mas_trailing).offset(ScreenScale(20));
        make.top.mas_equalTo(self.nameLab.mas_bottom).offset(ScreenScale(8));
        make.trailing.mas_equalTo(self.mas_trailing).offset(-ScreenScale(30));
        make.height.mas_greaterThanOrEqualTo(0);
    }];

    self.rankView = [CZRankView instanceRankViewByRate:0];
    [self addSubview:self.rankView];
    [self.rankView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(ScreenScale(150));
        make.leading.mas_equalTo(self.avatarImg.mas_trailing).offset(ScreenScale(20));
        make.bottom.mas_equalTo(self.VImg.mas_bottom);
        make.height.mas_equalTo(ScreenScale(28));
    }];

    self.serviceLab = [[UILabel alloc] init];
    self.serviceLab.text = @"服务-人";
    self.serviceLab.textColor = CZColorCreater(255, 255, 255, 1);
    self.serviceLab.font = [UIFont systemFontOfSize:ScreenScale(22)];
    [self addSubview:self.serviceLab];
    [self.serviceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.rankView.mas_trailing);
        make.top.mas_equalTo(self.rankView.mas_top).offset(-ScreenScale(4));
        make.trailing.mas_equalTo(self.mas_trailing).offset(-ScreenScale(30));
        make.height.mas_greaterThanOrEqualTo(0);
    }];

    //数据
    {
        self.caseView = [[CZAdvisorDetailBtnView alloc]init];
        self.caseView.countLab.text = @"-";
        self.caseView.nameLab.text = @"案例";
        [self addSubview:self.caseView];
        [self.caseView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(self.mas_leading);
            make.top.mas_equalTo(self.avatarImg.mas_bottom).offset(ScreenScale(40));
            make.width.mas_equalTo(kScreenWidth/4);
            make.height.mas_equalTo(ScreenScale(60));
        }];
        
        self.fansView = [[CZAdvisorDetailBtnView alloc]init];
        self.fansView.countLab.text = @"-";
        self.fansView.nameLab.text = @"粉丝";
        [self addSubview:self.fansView];
        [self.fansView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(self.caseView.mas_trailing);
            make.top.mas_equalTo(self.caseView);
            make.width.height.mas_equalTo(self.caseView);
        }];
        
        self.serviceView = [[CZAdvisorDetailBtnView alloc]init];
        self.serviceView.countLab.text = @"-";
        self.serviceView.nameLab.text = @"服务次数";
        [self addSubview:self.serviceView];
        [self.serviceView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(self.fansView.mas_trailing);
            make.top.mas_equalTo(self.fansView);
            make.width.height.mas_equalTo(self.fansView);
        }];
        
        self.consultView = [[CZAdvisorDetailBtnView alloc]init];
        self.consultView.countLab.text = @"-";
        self.consultView.nameLab.text = @"咨询排行";
        [self addSubview:self.consultView];
        [self.consultView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(self.serviceView.mas_trailing);
            make.top.mas_equalTo(self.serviceView);
            make.width.height.mas_equalTo(self.serviceView);
        }];
        
        self.praiseView = [[CZAdvisorDetailBtnView alloc]init];
        self.praiseView.countLab.text = @"-%";
        self.praiseView.nameLab.text = @"好评率";
        [self addSubview:self.praiseView];
        [self.praiseView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(self.mas_leading);
            make.top.mas_equalTo(self.caseView.mas_bottom).offset(ScreenScale(50));
            make.width.mas_equalTo(kScreenWidth/4);
            make.height.mas_equalTo(ScreenScale(60));
        }];
        
        self.complainView = [[CZAdvisorDetailBtnView alloc]init];
        self.complainView.countLab.text = @"-%";
        self.complainView.nameLab.text = @"投诉率";
        [self addSubview:self.complainView];
        [self.complainView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(self.praiseView.mas_trailing);
            make.top.mas_equalTo(self.praiseView);
            make.width.mas_equalTo(kScreenWidth/4);
            make.height.mas_equalTo(ScreenScale(60));
        }];
        
        self.refundView = [[CZAdvisorDetailBtnView alloc]init];
        self.refundView.countLab.text = @"-%";
        self.refundView.nameLab.text = @"退款率";
        [self addSubview:self.refundView];
        [self.refundView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(self.complainView.mas_trailing);
            make.top.mas_equalTo(self.complainView);
            make.width.mas_equalTo(kScreenWidth/4);
            make.height.mas_equalTo(ScreenScale(60));
        }];
        
        self.evaluationView = [[CZAdvisorDetailBtnView alloc]init];
        self.evaluationView.countLab.text = @"-";
        self.evaluationView.nameLab.text = @"评价数量";
        [self addSubview:self.evaluationView];
        [self.evaluationView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(self.refundView.mas_trailing);
            make.top.mas_equalTo(self.refundView);
            make.width.mas_equalTo(kScreenWidth/4);
            make.height.mas_equalTo(ScreenScale(60));
        }];
    }

    [self layoutIfNeeded];
    self.tagList = [[JCTagListView alloc]initWithFrame:CGRectMake(ScreenScale(50), self.evaluationView.frame.origin.y+self.evaluationView.frame.size.height+ScreenScale(40), kScreenWidth - ScreenScale(80),0)];
    self.tagList.tagCornerRadius = ScreenScale(3);
    self.tagList.tagBorderWidth = 0;
    self.tagList.tagBackgroundColor = CZColorCreater(255, 255, 255, 0.2);
    self.tagList.tagTextColor = [UIColor whiteColor];
    self.tagList.tagFont = [UIFont systemFontOfSize:ScreenScale(22)];
    self.tagList.tagItemSpacing = ScreenScale(16);
    self.tagList.tagLineSpacing = ScreenScale(16);
    self.tagList.tagContentInset = UIEdgeInsetsMake(ScreenScale(5), ScreenScale(10), ScreenScale(5), ScreenScale(10));
    [self addSubview:self.tagList];

    
}
@end
