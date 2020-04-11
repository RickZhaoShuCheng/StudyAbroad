
//
//  CZOrganizerInfoHeaderView.m
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/4/12.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZOrganizerInfoHeaderView.h"
#import "NSDate+Utils.h"
@interface CZOrganizerInfoHeaderView ()
@property (nonatomic ,strong) UILabel *titleLab;
@property (nonatomic ,strong) UILabel *timeLab;
@property (nonatomic ,strong) UILabel *areaLab;
@end
@implementation CZOrganizerInfoHeaderView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initWithUI];
    }
    return self;
}

- (void)setModel:(CZOrganizerModel *)model{
    _model = model;
    self.timeLab.text = [NSDate stringYearMonthDayWithDate:[NSDate dateWithTimeIntervalSince1970:[model.buildTime doubleValue]/1000]];
    self.areaLab.text = [NSString stringWithFormat:@"%@平方米",model.buildArea];
    self.contentLab.text = model.desc;
}

/**
 * 初始化UI
 */
- (void)initWithUI{
    self.titleLab = [[UILabel alloc]init];
    self.titleLab.font = [UIFont boldSystemFontOfSize:ScreenScale(30)];
    self.titleLab.textColor = CZColorCreater(27, 27, 27, 1);
    self.titleLab.text = @"基本信息";
    [self addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.mas_leading).offset(ScreenScale(30));
        make.top.mas_equalTo(self.mas_top).offset(ScreenScale(30));
        make.height.width.mas_greaterThanOrEqualTo(0);
    }];
    
    UILabel *timeTitle = [[UILabel alloc]init];
    timeTitle.font = [UIFont systemFontOfSize:ScreenScale(26)];
    timeTitle.textColor = CZColorCreater(102, 102, 102, 1);
    timeTitle.text = @"成立时间";
    [self addSubview:timeTitle];
    [timeTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.mas_leading).offset(ScreenScale(30));
        make.top.mas_equalTo(self.titleLab.mas_bottom).offset(ScreenScale(34));
        make.width.height.mas_greaterThanOrEqualTo(0);
    }];
    
    self.timeLab = [[UILabel alloc]init];
    self.timeLab.font = [UIFont systemFontOfSize:ScreenScale(26)];
    self.timeLab.textColor = CZColorCreater(41, 41, 41, 1);
    self.timeLab.text = @"-";
    [self addSubview:self.timeLab];
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(timeTitle.mas_trailing).offset(ScreenScale(20));
        make.centerY.mas_equalTo(timeTitle);
        make.trailing.mas_equalTo(self.mas_trailing).offset(-ScreenScale(30));
        make.height.mas_greaterThanOrEqualTo(0);
    }];
    
    UILabel *areaTitle = [[UILabel alloc]init];
    areaTitle.font = [UIFont systemFontOfSize:ScreenScale(26)];
    areaTitle.textColor = CZColorCreater(102, 102, 102, 1);
    areaTitle.text = @"机构面积";
    [self addSubview:areaTitle];
    [areaTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.mas_leading).offset(ScreenScale(30));
        make.top.mas_equalTo(timeTitle.mas_bottom).offset(ScreenScale(34));
        make.width.height.mas_greaterThanOrEqualTo(0);
    }];
    
    self.areaLab = [[UILabel alloc]init];
    self.areaLab.font = [UIFont systemFontOfSize:ScreenScale(26)];
    self.areaLab.textColor = CZColorCreater(41, 41, 41, 1);
    self.areaLab.text = @"-";
    [self addSubview:self.areaLab];
    [self.areaLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(areaTitle.mas_trailing).offset(ScreenScale(20));
        make.centerY.mas_equalTo(areaTitle);
        make.trailing.mas_equalTo(self.mas_trailing).offset(-ScreenScale(30));
        make.height.mas_greaterThanOrEqualTo(0);
    }];
    
    UILabel *contentTitle = [[UILabel alloc]init];
    contentTitle.font = [UIFont systemFontOfSize:ScreenScale(26)];
    contentTitle.textColor = CZColorCreater(102, 102, 102, 1);
    contentTitle.text = @"机构简介";
    [self addSubview:contentTitle];
    [contentTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.mas_leading).offset(ScreenScale(30));
        make.top.mas_equalTo(areaTitle.mas_bottom).offset(ScreenScale(34));
        make.width.height.mas_greaterThanOrEqualTo(0);
    }];
    //设置抗压缩优先级高 可以正常显示
    [contentTitle setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    self.contentLab = [[UILabel alloc]init];
    self.contentLab.font = [UIFont systemFontOfSize:ScreenScale(26)];
    self.contentLab.textColor = CZColorCreater(41, 41, 41, 1);
    self.contentLab.text = @"-";
    self.contentLab.numberOfLines = 0;
    [self addSubview:self.contentLab];
    [self.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(contentTitle.mas_trailing).offset(ScreenScale(20));
        make.top.mas_equalTo(contentTitle);
        make.trailing.mas_equalTo(self.mas_trailing).offset(-ScreenScale(30));
        make.height.mas_greaterThanOrEqualTo(0);
    }];
    [self layoutIfNeeded];
}
@end
