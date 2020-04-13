//
//  ExperienceView.m
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/4/6.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZExperienceView.h"
#import "NSDate+Utils.h"
@interface CZExperienceView ()
@property (nonatomic ,strong) UIView *roundView;
@property (nonatomic ,strong) UIView *lineView;
@property (nonatomic ,strong) UILabel *timeLab;
@property (nonatomic ,strong) UIImageView *statusImg;
@property (nonatomic ,strong) UILabel *schoolLab;
@end
@implementation CZExperienceView

- (instancetype)init{
    self = [super init];
    if (self) {
        [self initWithUI];
    }
    return self;
}
- (void)setIsEnd:(BOOL)isEnd{
    _isEnd = isEnd;
    self.lineView.hidden = isEnd;
}

- (void)setModel:(CZSportEduModel *)model{
    _model = model;
    NSString *beginTime = [NSDate stringYearMonthDayWithDate:[NSDate dateWithTimeIntervalSince1970:[model.startEducationTime integerValue]/1000]];
    NSString *endTime = [NSDate stringYearMonthDayWithDate:[NSDate dateWithTimeIntervalSince1970:[model.endEducationTime integerValue]/1000]];
    self.timeLab.text = [NSString stringWithFormat:@"%@--%@",beginTime,endTime];
    if ([model.certificationStatus integerValue] == 1) {
        self.statusImg.image = [CZImageProvider imageNamed:@"daren_yirenzheng"];
    }else{
        self.statusImg.image = [CZImageProvider imageNamed:@"daren_weirenzheng"];//daren_weirenzheng
    }
    
    self.schoolLab.text = [NSString stringWithFormat:@"%@   本科",model.schoolName];
}

/**
 * 初始化UI
 */
- (void)initWithUI{
    self.roundView = [[UIView alloc]init];
    self.roundView.backgroundColor = [UIColor whiteColor];
    self.roundView.layer.masksToBounds = YES;
    self.roundView.layer.cornerRadius = ScreenScale(24)/2.0;
    self.roundView.layer.borderColor = CZColorCreater(76, 182, 253, 1).CGColor;
    self.roundView.layer.borderWidth = ScreenScale(5);
    [self addSubview:self.roundView];
    [self.roundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self);
        make.size.mas_equalTo(ScreenScale(24));
        make.top.mas_equalTo(self);
    }];
    
    self.lineView = [[UIView alloc]init];
    self.lineView.backgroundColor = CZColorCreater(76, 182, 253, 1);
    [self addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.roundView);
        make.top.mas_equalTo(self.roundView.mas_bottom);
        make.bottom.mas_equalTo(self);
        make.width.mas_equalTo(ScreenScale(2));
    }];
    
    self.timeLab = [[UILabel alloc]init];
    self.timeLab.font = [UIFont systemFontOfSize:ScreenScale(28)];
    self.timeLab.textColor = CZColorCreater(129, 129, 146, 1);
    self.timeLab.text = @"-";
    [self addSubview:self.timeLab];
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.roundView.mas_trailing).offset(ScreenScale(24));
        make.top.mas_equalTo(self.roundView);
        make.width.mas_greaterThanOrEqualTo(0);
        make.height.mas_greaterThanOrEqualTo(0);
    }];
    
    self.statusImg = [[UIImageView alloc]init];
    self.statusImg.backgroundColor = [UIColor redColor];
    self.statusImg.image = [CZImageProvider imageNamed:@"daren_yirenzheng"];//daren_weirenzheng
    [self addSubview:self.statusImg];
    [self.statusImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.timeLab.mas_trailing).offset(ScreenScale(20));
        make.centerY.mas_equalTo(self.timeLab);
        make.size.mas_equalTo(self.statusImg.image.size);
    }];
    
    self.schoolLab = [[UILabel alloc]init];
    self.schoolLab.font = [UIFont systemFontOfSize:ScreenScale(28)];
    self.schoolLab.textColor = CZColorCreater(129, 129, 146, 1);
    self.schoolLab.text = @"-";
    [self addSubview:self.schoolLab];
    [self.schoolLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.timeLab);
        make.top.mas_equalTo(self.timeLab.mas_bottom).offset(ScreenScale(28));
        make.height.mas_greaterThanOrEqualTo(0);
        make.trailing.mas_equalTo(self.mas_trailing).offset(-ScreenScale(30));
    }];
    
}
@end
