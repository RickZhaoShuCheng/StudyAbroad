//
//  CZOrganizerDetailHeaderView.m
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/8.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZOrganizerDetailHeaderView.h"
#import "UIImageView+WebCache.h"
#import "CZRankView.h"
#import "CZOrganizerDetailBtnView.h"
@interface CZOrganizerDetailHeaderView()<SDCycleScrollViewDelegate>
@property (nonatomic ,strong)UIImageView *avatarImg;
@property (nonatomic ,strong)UIImageView *VImg;
@property (nonatomic ,strong)UILabel *nameLab;
@property (nonatomic ,strong)UILabel *organizerLab;
@property (nonatomic ,strong)UIButton *pkBtn;
@property (nonatomic ,strong)CZRankView *rankView;
@property (nonatomic ,strong)UILabel *serviceLab;
@property (nonatomic ,strong)CZOrganizerDetailBtnView *caseView;
@property (nonatomic ,strong)CZOrganizerDetailBtnView *fansView;
@property (nonatomic ,strong)CZOrganizerDetailBtnView *serviceView;
@property (nonatomic ,strong)CZOrganizerDetailBtnView *consultView;
@property (nonatomic ,strong)CZOrganizerDetailBtnView *praiseView;
@property (nonatomic ,strong)CZOrganizerDetailBtnView *complainView;
@property (nonatomic ,strong)CZOrganizerDetailBtnView *refundView;
@property (nonatomic ,strong)CZOrganizerDetailBtnView *evaluationView;
@property (nonatomic ,strong)UIView *locationView;
@property (nonatomic ,strong)UILabel *locationContent;
@property (nonatomic ,strong)UIImageView *locationImg;
@property (nonatomic ,strong)UIButton *phoneBtn;
@property (nonatomic ,strong)UIView *dynamicView;
@property (nonatomic ,strong)UIButton *foldBtn;
@end
@implementation CZOrganizerDetailHeaderView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = CZColorCreater(245, 245, 249, 1);
        [self initWithUI];
        [self.avatarImg sd_setImageWithURL:[NSURL URLWithString:@"http://ztd00.photos.bdimg.com/ztd/w=700;q=50/sign=dc636c57845494ee87220d191dce91c3/8718367adab44aed01ce530cbb1c8701a08bfb52.jpg"] placeholderImage:nil];
        [self.bgImg sd_setImageWithURL:[NSURL URLWithString:@"http://ztd00.photos.bdimg.com/ztd/w=700;q=50/sign=dc636c57845494ee87220d191dce91c3/8718367adab44aed01ce530cbb1c8701a08bfb52.jpg"] placeholderImage:nil];
    }
    return self;
}
//设置标签
- (void)setTags:(NSMutableArray *)tagesArr{
    self.tagList.tags = tagesArr;
    self.tagList.frame = CGRectMake(WidthRatio(30), self.evaluationView.frame.origin.y+self.evaluationView.frame.size.height+HeightRatio(40), kScreenWidth - WidthRatio(60),self.tagList.contentHeight);
    self.bgImg.frame = CGRectMake(0, 0, kScreenWidth, HeightRatio(540));
}
-(void)initWithUI{
    
    //根据标签高度调整背景高度
    self.bgImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, HeightRatio(540))];
    [self addSubview:self.bgImg];
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    effectView.alpha = 1;
    effectView.backgroundColor = CZColorCreater(0, 0, 0, 0.3);
//    effectView.frame = self.bgImg.bounds;
    [self.bgImg addSubview:effectView];
    [effectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.bgImg);
    }];
    
    //人的信息
    {
        self.avatarImg = [[UIImageView alloc]init];
        self.avatarImg.layer.masksToBounds = YES;
        self.avatarImg.layer.cornerRadius = WidthRatio(100)/2;
        self.avatarImg.layer.borderWidth = 1;
        self.avatarImg.layer.borderColor = [UIColor whiteColor].CGColor;
        [self addSubview:self.avatarImg];
        [self.avatarImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(self.mas_leading).offset(WidthRatio(50));
            make.top.mas_equalTo(self.mas_top).offset(HeightRatio(180));
            make.width.height.mas_equalTo(WidthRatio(100));
        }];
        
        self.VImg = [[UIImageView alloc]init];
        self.VImg.image = [CZImageProvider imageNamed:@"shou_ye_ren_zheng_cell"];
        [self addSubview:self.VImg];
        [self.VImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.avatarImg.mas_bottom).offset(-HeightRatio(18));
            make.centerX.mas_equalTo(self.avatarImg);
            make.width.mas_equalTo(WidthRatio(78));
            make.height.mas_equalTo(HeightRatio(36));
        }];
        
        self.nameLab = [[UILabel alloc] init];
        self.nameLab.text = @"南京市海牛工作室";
        self.nameLab.textColor = CZColorCreater(255, 255, 255, 1);
        self.nameLab.font = [UIFont boldSystemFontOfSize:WidthRatio(34)];
        [self addSubview:self.nameLab];
        [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(self.avatarImg.mas_trailing).offset(WidthRatio(20));
            make.top.mas_equalTo(self.avatarImg.mas_top);
            make.trailing.mas_equalTo(self.mas_trailing).offset(-WidthRatio(30));
            make.height.mas_greaterThanOrEqualTo(0);
        }];
        
        self.organizerLab = [[UILabel alloc] init];
        self.organizerLab.text = @"专业度: 4.9  服务: 4.9  价格: 4.9  响应: 4.9";
        self.organizerLab.textColor = CZColorCreater(255, 255, 255, 1);
        self.organizerLab.font = [UIFont systemFontOfSize:WidthRatio(22)];
        [self addSubview:self.organizerLab];
        [self.organizerLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(self.avatarImg.mas_trailing).offset(WidthRatio(20));
            make.top.mas_equalTo(self.nameLab.mas_bottom).offset(HeightRatio(8));
            make.trailing.mas_equalTo(self.mas_trailing).offset(-WidthRatio(30));
            make.height.mas_greaterThanOrEqualTo(0);
        }];
        
        self.pkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.pkBtn setImage:[CZImageProvider imageNamed:@"jiguo_pk"] forState:UIControlStateNormal];
        [self addSubview:self.pkBtn];
        [self.pkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.mas_equalTo(self).offset(WidthRatio(8));
            make.size.mas_equalTo(self.pkBtn.imageView.image.size);
            make.centerY.mas_equalTo(self.organizerLab);
        }];
        
        self.rankView = [CZRankView instanceRankViewByRate:3.1];
        [self addSubview:self.rankView];
        [self.rankView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(WidthRatio(150));
            make.leading.mas_equalTo(self.avatarImg.mas_trailing).offset(WidthRatio(20));
            make.bottom.mas_equalTo(self.VImg.mas_bottom);
            make.height.mas_equalTo(HeightRatio(28));
        }];
        
        self.serviceLab = [[UILabel alloc] init];
        self.serviceLab.text = @"1622条评价";
        self.serviceLab.textColor = CZColorCreater(255, 255, 255, 1);
        self.serviceLab.font = [UIFont systemFontOfSize:WidthRatio(22)];
        [self addSubview:self.serviceLab];
        [self.serviceLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(self.rankView.mas_trailing);
            make.top.mas_equalTo(self.rankView.mas_top).offset(-HeightRatio(2));
            make.trailing.mas_equalTo(self.mas_trailing).offset(-WidthRatio(30));
            make.height.mas_greaterThanOrEqualTo(0);
        }];
    }
    
    //数据
    {
        self.caseView = [[CZOrganizerDetailBtnView alloc]init];
        self.caseView.countLab.text = @"23";
        self.caseView.nameLab.text = @"案例";
        [self addSubview:self.caseView];
        [self.caseView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(self.mas_leading);
            make.top.mas_equalTo(self.avatarImg.mas_bottom).offset(HeightRatio(40));
            make.width.mas_equalTo(kScreenWidth/4);
            make.height.mas_equalTo(HeightRatio(60));
        }];
        
        self.fansView = [[CZOrganizerDetailBtnView alloc]init];
        self.fansView.countLab.text = @"188";
        self.fansView.nameLab.text = @"预约";
        [self addSubview:self.fansView];
        [self.fansView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(self.caseView.mas_trailing);
            make.top.mas_equalTo(self.caseView);
            make.width.height.mas_equalTo(self.caseView);
        }];
        
        self.serviceView = [[CZOrganizerDetailBtnView alloc]init];
        self.serviceView.countLab.text = @"1.2K";
        self.serviceView.nameLab.text = @"服务次数";
        [self addSubview:self.serviceView];
        [self.serviceView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(self.fansView.mas_trailing);
            make.top.mas_equalTo(self.fansView);
            make.width.height.mas_equalTo(self.fansView);
        }];
        
        self.consultView = [[CZOrganizerDetailBtnView alloc]init];
        self.consultView.countLab.text = @"188";
        self.consultView.nameLab.text = @"咨询排行";
        [self addSubview:self.consultView];
        [self.consultView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(self.serviceView.mas_trailing);
            make.top.mas_equalTo(self.serviceView);
            make.width.height.mas_equalTo(self.serviceView);
        }];
        
        self.praiseView = [[CZOrganizerDetailBtnView alloc]init];
        self.praiseView.countLab.text = @"90%";
        self.praiseView.nameLab.text = @"好评率";
        [self addSubview:self.praiseView];
        [self.praiseView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(self.mas_leading);
            make.top.mas_equalTo(self.caseView.mas_bottom).offset(HeightRatio(50));
            make.width.mas_equalTo(kScreenWidth/4);
            make.height.mas_equalTo(HeightRatio(60));
        }];
        
        self.complainView = [[CZOrganizerDetailBtnView alloc]init];
        self.complainView.countLab.text = @"90%";
        self.complainView.nameLab.text = @"投诉率";
        [self addSubview:self.complainView];
        [self.complainView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(self.praiseView.mas_trailing);
            make.top.mas_equalTo(self.praiseView);
            make.width.mas_equalTo(kScreenWidth/4);
            make.height.mas_equalTo(HeightRatio(60));
        }];
        
        self.refundView = [[CZOrganizerDetailBtnView alloc]init];
        self.refundView.countLab.text = @"20%";
        self.refundView.nameLab.text = @"退款率";
        [self addSubview:self.refundView];
        [self.refundView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(self.complainView.mas_trailing);
            make.top.mas_equalTo(self.complainView);
            make.width.mas_equalTo(kScreenWidth/4);
            make.height.mas_equalTo(HeightRatio(60));
        }];
        
        self.evaluationView = [[CZOrganizerDetailBtnView alloc]init];
        self.evaluationView.countLab.text = @"524";
        self.evaluationView.nameLab.text = @"顾问";
        [self addSubview:self.evaluationView];
        [self.evaluationView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(self.refundView.mas_trailing);
            make.top.mas_equalTo(self.refundView);
            make.width.mas_equalTo(kScreenWidth/4);
            make.height.mas_equalTo(HeightRatio(60));
        }];
    }
    //动态标签
    {
        [self layoutIfNeeded];
        self.tagList = [[JCTagListView alloc]initWithFrame:CGRectMake(WidthRatio(30), self.evaluationView.frame.origin.y+self.evaluationView.frame.size.height+HeightRatio(40), kScreenWidth - WidthRatio(60),0)];
        self.tagList.tagCornerRadius = WidthRatio(3);
        self.tagList.tagBorderWidth = 0;
        self.tagList.tagBackgroundColor = CZColorCreater(52, 172, 255, 1);
        self.tagList.tagTextColor = [UIColor whiteColor];
        self.tagList.tagFont = [UIFont systemFontOfSize:WidthRatio(22)];
        self.tagList.tagItemSpacing = WidthRatio(16);
        self.tagList.tagLineSpacing = WidthRatio(16);
        self.tagList.tagContentInset = UIEdgeInsetsMake(HeightRatio(5), WidthRatio(10), HeightRatio(5), WidthRatio(10));
        [self addSubview:self.tagList];
    }
    
    //营业执照等
    {
        self.containerView = [[UIView alloc]init];
        self.containerView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.containerView];
        [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.mas_equalTo(self);
            make.top.mas_equalTo(self.bgImg.mas_bottom);
            make.height.mas_equalTo(HeightRatio(160));
        }];
        
        NSArray *titleArr = [NSArray arrayWithObjects:@"执业许可",@"机构相册",@"资金托管",@"缴保证金",nil];
        NSArray *imgArr = [NSArray arrayWithObjects:@"jigou_zhengjian",@"jitou_tupian",@"jigou_qianbao",@"jigou_bao", nil];
        [titleArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setImage:[CZImageProvider imageNamed:imgArr[idx]] forState:UIControlStateNormal];
            [btn setImage:[CZImageProvider imageNamed:imgArr[idx]] forState:UIControlStateHighlighted];
            [btn setTitle:obj forState:UIControlStateNormal];
            [btn setTitleColor:CZColorCreater(61, 67, 83, 1) forState:UIControlStateNormal];
            [btn.titleLabel setFont:[UIFont systemFontOfSize:WidthRatio(24)]];
            [btn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, WidthRatio(18))];
            [self.containerView addSubview:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.leading.mas_equalTo(self.containerView.mas_leading).offset(WidthRatio(26)+idx%4 * (WidthRatio(160) + WidthRatio(25)));
                make.width.mas_equalTo(WidthRatio(160));
                make.top.mas_equalTo(self.containerView).offset(HeightRatio(20)+ idx/4 * HeightRatio(60));
                make.height.mas_equalTo(HeightRatio(60));
            }];
        }];
        
        self.foldBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.foldBtn setImage:[CZImageProvider imageNamed:@"jigou_zhedie"] forState:UIControlStateNormal];
        [self.containerView addSubview:self.foldBtn];
        [self.foldBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.containerView);
            make.top.mas_equalTo(self.containerView.mas_top).offset(HeightRatio(80));
            make.size.mas_equalTo(WidthRatio(60));
        }];
        
    }
    
    //动态信息
    {
        self.dynamicView = [[UIView alloc]init];
        self.dynamicView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.dynamicView];
        [self.dynamicView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.mas_equalTo(self);
            make.bottom.mas_equalTo(self.mas_bottom).offset(-HeightRatio(16));
            make.height.mas_equalTo(HeightRatio(96));
        }];
        
        UIImageView *dynamic = [[UIImageView alloc]init];
        dynamic.image = [CZImageProvider imageNamed:@"jigou_dongtai"];
        [self.dynamicView addSubview:dynamic];
        [dynamic mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(self.dynamicView.mas_leading).offset(WidthRatio(30));
            make.size.mas_equalTo(dynamic.image.size);
            make.centerY.mas_equalTo(self.dynamicView);
        }];
        
        self.scrollDynamic = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:nil];
        self.scrollDynamic.onlyDisplayText = YES;
        [self.scrollDynamic disableScrollGesture];
        self.scrollDynamic.backgroundColor = [UIColor whiteColor];
        self.scrollDynamic.scrollDirection = UICollectionViewScrollDirectionVertical;
        self.scrollDynamic.titleLabelTextColor = CZColorCreater(53, 53, 53, 1);
        self.scrollDynamic.titleLabelTextFont = [UIFont systemFontOfSize:WidthRatio(26)];
        self.scrollDynamic.titleLabelBackgroundColor = [UIColor whiteColor];
        
        
        
        NSMutableArray *attributeTitleArr = [NSMutableArray array];
        NSArray *titleArr = [NSArray arrayWithObjects:@"2019年入选「移民服务排行榜」出炉啦~",@"这场人民战争统帅心中的三个“第一”",@"下好一盘棋 京津冀战疫进行时 习近平讲话单行本出版",@"大国数字 | 走近“一亿分之一”", nil];
        [titleArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:obj];
            //NSTextAttachment可以将要插入的图片作为特殊字符处理
            NSTextAttachment *attch = [[NSTextAttachment alloc] init];
            //定义图片内容及位置和大小
            attch.image = [CZImageProvider imageNamed:@"jigou_tiezi"];
            attch.bounds = CGRectMake(0, -HeightRatio(4), WidthRatio(54), HeightRatio(24));
            //创建带有图片的富文本
            NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
            //将图片放在第一位
            [attri insertAttributedString:string atIndex:0];
            //设置空格文本
            [attri insertAttributedString:[[NSAttributedString alloc] initWithString:@" "] atIndex:1];
            //设置间距
            [attri addAttribute:NSKernAttributeName value:@(8)
                                range:NSMakeRange(1,1)];
            [attributeTitleArr addObject:attri];
        }];
        
        self.scrollDynamic.titlesGroup = [attributeTitleArr copy];
        [self.dynamicView addSubview:self.scrollDynamic];
        [self.scrollDynamic mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(dynamic.mas_trailing).offset(WidthRatio(14));
            make.trailing.mas_equalTo(self.dynamicView.mas_trailing).offset(-WidthRatio(24));
            make.centerY.mas_equalTo(self.dynamicView);
            make.height.mas_equalTo(self.dynamicView);
        }];
    }
    
    //定位信息
    {
        self.locationView = [[UIView alloc]init];
        self.locationView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.locationView];
        [self.locationView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.mas_equalTo(self);
            make.bottom.mas_equalTo(self.dynamicView.mas_top).offset(-HeightRatio(12));
            make.height.mas_equalTo(HeightRatio(96));
        }];
        
        self.locationImg = [[UIImageView alloc]initWithImage:[CZImageProvider imageNamed:@"guwen_dingwei"]];
        [self.locationView addSubview:self.locationImg];
        [self.locationImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(self.locationView.mas_leading).offset(WidthRatio(30));
            make.centerY.mas_equalTo(self.locationView);
            make.size.mas_equalTo(self.locationImg.image.size);
        }];

        self.locationContent = [[UILabel alloc] init];
        self.locationContent.text = @"南京市雨花台区达州路32号软件谷科";
        self.locationContent.textColor = CZColorCreater(53, 53, 53, 1);
        self.locationContent.font = [UIFont systemFontOfSize:WidthRatio(28)];
        [self.locationView addSubview:self.locationContent];
        [self.locationContent mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(self.locationImg.mas_trailing).offset(WidthRatio(16));
            make.centerY.mas_equalTo(self.locationImg);
            make.trailing.mas_equalTo(self.locationView.mas_trailing).offset(-WidthRatio(94));
            make.height.mas_greaterThanOrEqualTo(0);
        }];
        
        UILabel *line = [[UILabel alloc] init];
        line.backgroundColor = CZColorCreater(241, 241, 245, 1);
        [self.locationView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.mas_equalTo(self.locationView.mas_trailing).offset(-WidthRatio(94));
            make.centerY.mas_equalTo(self.locationView);
            make.height.mas_equalTo(HeightRatio(32));
            make.width.mas_equalTo(1);
        }];
        
        self.phoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.phoneBtn setImage:[CZImageProvider imageNamed:@"jigou_dianhua"] forState:UIControlStateNormal];
        [self.locationView addSubview:self.phoneBtn];
        [self.phoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.mas_equalTo(self.locationView.mas_trailing).offset(-WidthRatio(20));
            make.centerY.mas_equalTo(self.locationView);
            make.size.mas_equalTo(WidthRatio(48));
        }];
    }
}

@end
