//
//  CZAdvisorDetailHeaderView.m
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/4.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZAdvisorDetailHeaderView.h"
#import "UIImageView+WebCache.h"
#import "CZRankView.h"
#import "CZAdvisorDetailBtnView.h"
#import "CZAdvisorDetailHeaderCell.h"


@interface CZAdvisorDetailHeaderView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic ,strong)UIImageView *avatarImg;
@property (nonatomic ,strong)UIImageView *VImg;
@property (nonatomic ,strong)UILabel *nameLab;
@property (nonatomic ,strong)UILabel *organizerLab;
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
@property (nonatomic ,strong)UIView *locationView;
@property (nonatomic ,strong)UILabel *locationTitle;
@property (nonatomic ,strong)UILabel *locationContent;
@property (nonatomic ,strong)UIImageView *locationImg;
@property (nonatomic ,strong)UIView *dynamicView;
@property (nonatomic ,strong)UICollectionView *collectionView;
@property (nonatomic ,strong) UIButton *notDataBtn;
@end
@implementation CZAdvisorDetailHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = CZColorCreater(245, 245, 249, 1);
        [self initWithUI];
    }
    return self;
}

- (void)setModel:(CZAdvisorInfoModel *)model{
    _model = model;
    if (!model) {
        return;
    }
    self.nameLab.text = model.counselorName;
    [self.avatarImg sd_setImageWithURL:[NSURL URLWithString:PIC_URL(model.counselorImg)] placeholderImage:nil];
    [self.bgImg sd_setImageWithURL:[NSURL URLWithString:PIC_URL(model.counselorImg)] placeholderImage:nil];
    [self.rankView setRankByRate:[model.valStar floatValue]];
    self.organizerLab.text = model.organName;
    self.serviceLab.text = [NSString stringWithFormat:@"服务%@人",[@([model.servicePersonCount integerValue]) stringValue]];
    if ([model.status integerValue] == 1) {
        self.VImg.hidden = NO;
    }else{
        self.VImg.hidden = YES;
    }
    self.caseView.countLab.text = [@([model.caseCount integerValue]) stringValue];
    self.fansView.countLab.text = [@([model.fanCount integerValue]) stringValue];
    self.serviceView.countLab.text = [@([model.serviceCount integerValue]) stringValue];
    self.consultView.countLab.text = [@([model.askRanking integerValue]) stringValue];
    self.praiseView.countLab.text = [NSString stringWithFormat:@"%@%@",[@([model.ratePraise integerValue]) stringValue],@"%"];
    self.complainView.countLab.text = [NSString stringWithFormat:@"%@%@",[@([model.rateComplaint integerValue]) stringValue],@"%"];
    self.refundView.countLab.text = [NSString stringWithFormat:@"%@%@",[@([model.rateRepay integerValue]) stringValue],@"%"];
    self.evaluationView.countLab.text = [@([model.commentsCount integerValue]) stringValue];
    
    self.locationTitle.text = model.organName;
    self.locationContent.text = [NSString stringWithFormat:@"%@%@%@%@",model.countryName,model.provinceName,model.cityName,model.disName];

    NSMutableArray *keyArr = [NSMutableArray array];
    if (model.keywords.length) {
        [keyArr addObjectsFromArray:[model.keywords componentsSeparatedByString:@","]];
    }
    [self setTags:keyArr];
    if (model.dynamicVoList.count == 0) {
        self.collectionView.hidden = YES;
        self.notDataBtn.hidden = NO;
    }else{
        self.collectionView.hidden = NO;
        self.notDataBtn.hidden = YES;
        [self.collectionView reloadData];
    }
    
}

- (void)dynamicViewClick{
    if (self.dynamicClick) {
        self.dynamicClick();
    }
}

- (void)locationViewClick{
    if (self.locationClick) {
        self.locationClick();
    }
}

//设置标签
- (void)setTags:(NSMutableArray *)tagesArr{
    
    self.tagList.tags = tagesArr;
    if (tagesArr.count == 0) {
        self.tagList.frame = CGRectMake(ScreenScale(30), self.evaluationView.frame.origin.y+self.evaluationView.frame.size.height+ScreenScale(40), kScreenWidth - ScreenScale(60),0);
    }else{
        self.tagList.frame = CGRectMake(ScreenScale(30), self.evaluationView.frame.origin.y+self.evaluationView.frame.size.height+ScreenScale(40), kScreenWidth - ScreenScale(60),self.tagList.contentHeight);
    }
    
    self.bgImg.frame = CGRectMake(0, 0, kScreenWidth, ScreenScale(540));
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.model.dynamicVoList.count;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CZAdvisorDetailHeaderCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CZAdvisorDetailHeaderCell class]) forIndexPath:indexPath];
    cell.model = [CZDiaryModel modelWithDict:self.model.dynamicVoList[indexPath.row]];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(ScreenScale(116), ScreenScale(116));
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
    
    self.organizerLab = [[UILabel alloc] init];
    self.organizerLab.text = @"-";
    self.organizerLab.textColor = CZColorCreater(255, 255, 255, 1);
    self.organizerLab.font = [UIFont systemFontOfSize:ScreenScale(22)];
    [self addSubview:self.organizerLab];
    [self.organizerLab mas_makeConstraints:^(MASConstraintMaker *make) {
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
    self.tagList = [[JCTagListView alloc]initWithFrame:CGRectMake(ScreenScale(30), self.evaluationView.frame.origin.y+self.evaluationView.frame.size.height+ScreenScale(40), kScreenWidth - ScreenScale(60),0)];
    self.tagList.tagCornerRadius = ScreenScale(3);
    self.tagList.tagBorderWidth = 0;
    self.tagList.tagBackgroundColor = CZColorCreater(52, 172, 255, 1);
    self.tagList.tagTextColor = [UIColor whiteColor];
    self.tagList.tagFont = [UIFont systemFontOfSize:ScreenScale(22)];
    self.tagList.tagItemSpacing = ScreenScale(16);
    self.tagList.tagLineSpacing = ScreenScale(16);
    self.tagList.tagContentInset = UIEdgeInsetsMake(ScreenScale(5), ScreenScale(10), ScreenScale(5), ScreenScale(10));
    [self addSubview:self.tagList];
    
    
    self.locationView = [[UIView alloc]init];
    self.locationView.backgroundColor = [UIColor whiteColor];
    self.locationView.userInteractionEnabled = YES;
    [self.locationView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(locationViewClick)]];
    [self addSubview:self.locationView];
    [self.locationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self);
        make.top.mas_equalTo(self.bgImg.mas_bottom).offset(ScreenScale(16));
        make.height.mas_equalTo(ScreenScale(135));
    }];
    
    self.locationTitle = [[UILabel alloc] init];
    self.locationTitle.text = @"-";
    self.locationTitle.textColor = CZColorCreater(0, 0, 0, 1);
    self.locationTitle.font = [UIFont boldSystemFontOfSize:ScreenScale(30)];
    [self.locationView addSubview:self.locationTitle];
    [self.locationTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.locationView.mas_leading).offset(ScreenScale(30));
        make.top.mas_equalTo(self.locationView.mas_top).offset(ScreenScale(30));
        make.trailing.mas_equalTo(self.locationView.mas_trailing).offset(-ScreenScale(94));
        make.height.mas_greaterThanOrEqualTo(0);
    }];
    
    self.locationContent = [[UILabel alloc] init];
    self.locationContent.text = @"南京市雨花台区达州路32号软件谷科";
    self.locationContent.textColor = CZColorCreater(170, 170, 187, 1);
    self.locationContent.font = [UIFont systemFontOfSize:ScreenScale(26)];
    [self.locationView addSubview:self.locationContent];
    [self.locationContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.locationView.mas_leading).offset(ScreenScale(30));
        make.top.mas_equalTo(self.locationTitle.mas_bottom).offset(ScreenScale(16));
        make.trailing.mas_equalTo(self.locationView.mas_trailing).offset(-ScreenScale(94));
        make.height.mas_greaterThanOrEqualTo(0);
    }];
    
    
    self.locationImg = [[UIImageView alloc]initWithImage:[CZImageProvider imageNamed:@"guwen_dingwei"]];
    [self.locationView addSubview:self.locationImg];
    [self.locationImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self.locationView.mas_trailing).offset(-ScreenScale(30));
        make.centerY.mas_equalTo(self.locationView);
        make.size.mas_equalTo(self.locationImg.image.size);
    }];
    
    UILabel *line = [[UILabel alloc] init];
    line.backgroundColor = CZColorCreater(241, 241, 245, 1);
    [self.locationView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self.locationImg.mas_leading).offset(-ScreenScale(32));
        make.centerY.mas_equalTo(self.locationView);
        make.height.mas_equalTo(ScreenScale(64));
        make.width.mas_equalTo(1);
    }];
    
    self.dynamicView = [[UIView alloc]init];
    self.dynamicView.backgroundColor = [UIColor whiteColor];
    self.dynamicView.userInteractionEnabled = YES;
    [self.dynamicView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dynamicViewClick)]];
    [self addSubview:self.dynamicView];
    [self.dynamicView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-ScreenScale(16));
        make.height.mas_equalTo(ScreenScale(198));
    }];
    
    UILabel *tips = [[UILabel alloc]init];
    tips.backgroundColor = CZColorCreater(76, 182, 253, 1);
    [self.dynamicView addSubview:tips];
    [tips mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.centerY.mas_equalTo(self.dynamicView);
        make.width.mas_equalTo(ScreenScale(8));
        make.height.mas_equalTo(ScreenScale(26));
    }];
    
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.text = @"顾问动态";
    titleLab.textColor = CZColorCreater(0, 0, 0, 1);
    titleLab.font = [UIFont boldSystemFontOfSize:ScreenScale(30)];
    [self.dynamicView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(tips.mas_trailing).offset(ScreenScale(22));
        make.centerY.mas_equalTo(self.dynamicView);
        make.height.width.mas_greaterThanOrEqualTo(0);
    }];
    
    UIImageView *arrowImg = [[UIImageView alloc]initWithImage:[CZImageProvider imageNamed:@"zhu_ye_you_jian_tou"]];
    [self.dynamicView addSubview:arrowImg];
    [arrowImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self.dynamicView.mas_trailing).offset(-ScreenScale(30));
        make.centerY.mas_equalTo(self.dynamicView);
        make.height.mas_equalTo(12);
        make.width.mas_equalTo(8);
    }];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = ScreenScale(18);
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.collectionView registerClass:[CZAdvisorDetailHeaderCell class] forCellWithReuseIdentifier:NSStringFromClass([CZAdvisorDetailHeaderCell class])];
    [self.dynamicView addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(titleLab.mas_trailing).offset(ScreenScale(28));
        make.centerY.mas_equalTo(self.dynamicView);
        make.top.bottom.mas_equalTo(self.dynamicView);
        make.trailing.mas_equalTo(arrowImg.mas_leading).offset(-ScreenScale(18));
    }];
    
    self.notDataBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.notDataBtn setTitle:@"暂无动态" forState:UIControlStateNormal];
    [self.notDataBtn setTitleColor:CZColorCreater(153, 153, 153, 1) forState:UIControlStateNormal];
    [self.notDataBtn.titleLabel setFont:[UIFont systemFontOfSize:ScreenScale(28)]];
    [self.notDataBtn setImage:[CZImageProvider imageNamed:@"guwen_chazhao"] forState:UIControlStateNormal];
    [self.notDataBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, ScreenScale(20), 0, 0 )];
    self.notDataBtn.enabled = NO;
    [self.dynamicView addSubview:self.notDataBtn];
    [self.notDataBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(titleLab.mas_trailing).offset(ScreenScale(28));
        make.centerY.mas_equalTo(self.dynamicView);
        make.width.mas_equalTo(ScreenScale(200));
        make.height.mas_equalTo(ScreenScale(50));
    }];
}
@end
