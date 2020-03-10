//
//  CZOrganizerDetailBtnView.m
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/8.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZOrganizerDetailBtnView.h"

@implementation CZOrganizerDetailBtnView

- (instancetype)init{
    self = [super init];
    if (self) {
        [self initWithUI];
    }
    return self;
}

-(void)initWithUI{
    self.nameLab = [[UILabel alloc] init];
    self.nameLab.textColor = CZColorCreater(255, 255, 255,1);
    self.nameLab.textAlignment = NSTextAlignmentCenter;
    self.nameLab.font = [UIFont systemFontOfSize:WidthRatio(24)];
    [self addSubview:self.nameLab];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.mas_equalTo(self);
        make.height.mas_greaterThanOrEqualTo(0);
    }];
    
    
    self.countLab = [[UILabel alloc] init];
    self.countLab.textColor = CZColorCreater(255, 255, 255,1);
    self.countLab.textAlignment = NSTextAlignmentCenter;
    self.countLab.font = [UIFont boldSystemFontOfSize:WidthRatio(30)];
    [self addSubview:self.countLab];
    [self.countLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.top.mas_equalTo(self);
        make.height.mas_greaterThanOrEqualTo(0);
    }];
    
    UILabel *line = [[UILabel alloc]init];
    line.backgroundColor = CZColorCreater(243, 243, 247, 0.18);
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self);
        make.centerY.mas_equalTo(self);
        make.height.mas_equalTo(HeightRatio(50));
        make.width.mas_equalTo(WidthRatio(1));
    }];
}

@end
