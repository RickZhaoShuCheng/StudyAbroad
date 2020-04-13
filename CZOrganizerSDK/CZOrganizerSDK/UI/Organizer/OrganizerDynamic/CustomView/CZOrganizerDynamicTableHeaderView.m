//
//  OrganizerDynamicTableHeaderView.m
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/23.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZOrganizerDynamicTableHeaderView.h"
#import "UIImageView+WebCache.h"
@interface CZOrganizerDynamicTableHeaderView()
@property (nonatomic ,strong)UIImageView *avatarImg;
@property (nonatomic ,strong)UIImageView *VImg;
@property (nonatomic ,strong)UILabel *nameLab;
@property (nonatomic ,strong) UIButton *chatBtn;
@property (nonatomic ,strong) UIButton *focusBtn;
@property (nonatomic ,strong)UILabel *focusContent;
@property (nonatomic ,strong)UILabel *fansContent;
@property (nonatomic ,strong)UILabel *praiseContent;
@property (nonatomic ,strong) UIButton *arrowBtn;
@end
@implementation CZOrganizerDynamicTableHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = CZColorCreater(245, 245, 249, 1);
        [self initWithUI];
    }
    return self;
}
- (void)setModel:(CZOrganizerModel *)model{
    _model = model;
    if (!model) {
        return;
    }
    self.nameLab.text = model.name;
    [self.avatarImg sd_setImageWithURL:[NSURL URLWithString:PIC_URL(model.logo)] placeholderImage:nil];
    [self.bgImg sd_setImageWithURL:[NSURL URLWithString:PIC_URL(model.logo)] placeholderImage:nil];
    if ([model.status integerValue] == 1) {
        self.VImg.hidden = NO;
    }else{
        self.VImg.hidden = YES;
    }
    
    self.contentLab.text = model.desc;
    CGFloat height = [self getStringHeightWithText:model.desc font:[UIFont systemFontOfSize:ScreenScale(28)] viewWidth:kScreenWidth-ScreenScale(100)];
    _model.introduceHeight = height;
    CGFloat singleHeight = [self getStringHeightWithText:@"测试" font:[UIFont systemFontOfSize:ScreenScale(28)] viewWidth:kScreenWidth-ScreenScale(100)];
    _model.singleHeight = singleHeight;
    if (height > singleHeight * 2) {
        self.arrowBtn.hidden = NO;
    }else{
        self.arrowBtn.hidden = YES;
    }
//    self.focusContent.text =
//    self.praiseContent.text =
    self.fansContent.text = [@([model.fanCount integerValue]) stringValue];
    
}
- (CGFloat)getStringHeightWithText:(NSString *)text font:(UIFont *)font viewWidth:(CGFloat)width {
    // 设置文字属性 要和label的一致
    NSDictionary *attrs = @{NSFontAttributeName :font};
    CGSize maxSize = CGSizeMake(width, MAXFLOAT);

    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;

    // 计算文字占据的宽高
    CGSize size = [text boundingRectWithSize:maxSize options:options attributes:attrs context:nil].size;

   // 当你是把获得的高度来布局控件的View的高度的时候.size转化为ceilf(size.height)。
    return  ceilf(size.height);
}
- (void)arrowBtnClick:(UIButton *)arrowBtn{
    if (self.arrowBtnClick) {
        self.arrowBtnClick(arrowBtn);
    }
}
-(void)initWithUI{
    
    //根据标签高度调整背景高度
    self.bgImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, ScreenScale(630))];
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
    self.avatarImg.layer.borderColor = CZColorCreater(255, 255, 255, 0.31).CGColor;
    self.avatarImg.layer.borderWidth = ScreenScale(6);
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
    
    self.focusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.focusBtn setBackgroundColor:CZColorCreater(51, 172, 253, 1)];
    [self.focusBtn setTitle:@"+关注" forState:UIControlStateNormal];
    [self.focusBtn setTitleColor:CZColorCreater(255, 255, 255, 1) forState:UIControlStateNormal];
    [self.focusBtn.titleLabel setFont:[UIFont systemFontOfSize:ScreenScale(28)]];
    [self.focusBtn.layer setMasksToBounds:YES];
    [self.focusBtn.layer setCornerRadius:ScreenScale(5)];
    [self addSubview:self.focusBtn];
    [self.focusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self.mas_trailing).offset(-ScreenScale(60));
        make.height.mas_equalTo(ScreenScale(52));
        make.width.mas_equalTo(ScreenScale(112));
        make.centerY.mas_equalTo(self.avatarImg);
    }];
    
    self.chatBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.chatBtn setBackgroundColor:[UIColor clearColor]];
    [self.chatBtn setTitle:@"私信" forState:UIControlStateNormal];
    [self.chatBtn setTitleColor:CZColorCreater(255, 255, 255, 1) forState:UIControlStateNormal];
    [self.chatBtn.titleLabel setFont:[UIFont systemFontOfSize:ScreenScale(28)]];
    [self.chatBtn.layer setMasksToBounds:YES];
    [self.chatBtn.layer setCornerRadius:ScreenScale(5)];
    [self.chatBtn.layer setBorderColor:CZColorCreater(255, 255, 255, 1).CGColor];
    [self.chatBtn.layer setBorderWidth:ScreenScale(1)];
    [self addSubview:self.chatBtn];
    [self.chatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self.focusBtn.mas_leading).offset(-ScreenScale(30));
        make.height.mas_equalTo(ScreenScale(52));
        make.width.mas_equalTo(ScreenScale(112));
        make.centerY.mas_equalTo(self.avatarImg);
    }];
    
    self.nameLab = [[UILabel alloc] init];
    self.nameLab.text = @"-";
    self.nameLab.textColor = CZColorCreater(255, 255, 255, 1);
    self.nameLab.font = [UIFont boldSystemFontOfSize:ScreenScale(34)];
    [self addSubview:self.nameLab];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.avatarImg.mas_leading);
        make.top.mas_equalTo(self.VImg.mas_bottom).offset(ScreenScale(30));
        make.trailing.mas_equalTo(self.mas_trailing).offset(-ScreenScale(30));
        make.height.mas_greaterThanOrEqualTo(0);
    }];
    
    UILabel * focusTitle = [[UILabel alloc]init];
    focusTitle.font = [UIFont systemFontOfSize:ScreenScale(22)];
    focusTitle.textColor = CZColorCreater(255, 255, 255, 1);
    focusTitle.text = @"关注";
    [self addSubview:focusTitle];
    [focusTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.nameLab.mas_leading);
        make.width.height.mas_greaterThanOrEqualTo(0);
        make.bottom.mas_equalTo(self.bgImg.mas_bottom).offset(-ScreenScale(66));
    }];
    
    UILabel * fansTitle = [[UILabel alloc]init];
    fansTitle.font = [UIFont systemFontOfSize:ScreenScale(22)];
    fansTitle.textColor = CZColorCreater(255, 255, 255, 1);
    fansTitle.text = @"粉丝";
    [self addSubview:fansTitle];
    [fansTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(focusTitle.mas_trailing).offset(ScreenScale(120));
        make.width.height.mas_greaterThanOrEqualTo(0);
        make.bottom.mas_equalTo(self.bgImg.mas_bottom).offset(-ScreenScale(66));
    }];
    
    UILabel * praiseTitle = [[UILabel alloc]init];
    praiseTitle.font = [UIFont systemFontOfSize:ScreenScale(22)];
    praiseTitle.textColor = CZColorCreater(255, 255, 255, 1);
    praiseTitle.text = @"获赞";
    [self addSubview:praiseTitle];
    [praiseTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(fansTitle.mas_trailing).offset(ScreenScale(120));
        make.width.height.mas_greaterThanOrEqualTo(0);
        make.bottom.mas_equalTo(self.bgImg.mas_bottom).offset(-ScreenScale(66));
    }];
    
    self.focusContent = [[UILabel alloc]init];
    self.focusContent.font = [UIFont boldSystemFontOfSize:ScreenScale(36)];
    self.focusContent.textColor = CZColorCreater(255, 255, 255, 1);
    self.focusContent.text = @"12321";
    [self addSubview:self.focusContent];
    [self.focusContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(focusTitle.mas_leading);
        make.bottom.mas_equalTo(focusTitle.mas_top);
        make.width.height.mas_greaterThanOrEqualTo(0);
    }];
    
    self.fansContent = [[UILabel alloc]init];
    self.fansContent.font = [UIFont boldSystemFontOfSize:ScreenScale(36)];
    self.fansContent.textColor = CZColorCreater(255, 255, 255, 1);
    self.fansContent.text = @"456456";
    [self addSubview:self.fansContent];
    [self.fansContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(fansTitle.mas_leading);
        make.bottom.mas_equalTo(fansTitle.mas_top);
        make.width.height.mas_greaterThanOrEqualTo(0);
    }];
    
    self.praiseContent = [[UILabel alloc]init];
    self.praiseContent.font = [UIFont boldSystemFontOfSize:ScreenScale(36)];
    self.praiseContent.textColor = CZColorCreater(255, 255, 255, 1);
    self.praiseContent.text = @"789789";
    [self addSubview:self.praiseContent];
    [self.praiseContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(praiseTitle.mas_leading);
        make.bottom.mas_equalTo(praiseTitle.mas_top);
        make.width.height.mas_greaterThanOrEqualTo(0);
    }];
    
    self.contentLab = [[UILabel alloc]init];
    self.contentLab.font = [UIFont systemFontOfSize:ScreenScale(28)];
    self.contentLab.textColor = CZColorCreater(255, 255, 255, 1);
    self.contentLab.numberOfLines = 2;
    [self addSubview:self.contentLab];
    [self.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.nameLab.mas_leading);
        make.trailing.mas_equalTo(self.mas_trailing).offset(-ScreenScale(50));
        make.height.mas_greaterThanOrEqualTo(0);
        make.top.mas_equalTo(self.nameLab.mas_bottom).offset(ScreenScale(30));
    }];
    
    self.arrowBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.arrowBtn setImage:[CZImageProvider imageNamed:@"jiantou_xia_baise"] forState:UIControlStateNormal];
    [self.arrowBtn addTarget:self action:@selector(arrowBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.arrowBtn];
    [self.arrowBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.contentLab.mas_trailing);
        make.size.mas_equalTo(ScreenScale(40));
        make.bottom.mas_equalTo(self.contentLab.mas_bottom).offset(ScreenScale(5));
    }];
}

@end
