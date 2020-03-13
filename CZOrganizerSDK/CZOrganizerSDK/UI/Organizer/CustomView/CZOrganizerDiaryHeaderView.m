

//
//  CZOrganizerDiaryHeaderView.m
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/12.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZOrganizerDiaryHeaderView.h"

@interface CZOrganizerDiaryHeaderView()

@end
@implementation CZOrganizerDiaryHeaderView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.masksToBounds = YES;
        [self initWithUI];
    }
    return self;
}
/**
 * 初始化UI
 */
- (void)initWithUI{
    self.tagList = [[JCTagListView alloc]initWithFrame:CGRectMake(WidthRatio(30),HeightRatio(30), kScreenWidth-WidthRatio(60), 0)];
    self.tagList.backgroundColor = [UIColor whiteColor];
    self.tagList.tagCornerRadius = WidthRatio(28);
    self.tagList.tagBorderWidth = 1;
    self.tagList.tagBorderColor = CZColorCreater(244, 244, 248, 1);
    self.tagList.tagBackgroundColor = CZColorCreater(244, 244, 248, 1);
    self.tagList.tagSelectedBorderColor = CZColorCreater(51, 172, 253, 1);
    self.tagList.tagSelectedTextColor = CZColorCreater(51, 172, 253, 1);
    self.tagList.tagSelectedBackgroundColor = CZColorCreater(244, 244, 248, 1);
    self.tagList.tagTextColor = CZColorCreater(61, 67, 83, 1);
    self.tagList.tagFont = [UIFont systemFontOfSize:WidthRatio(24)];
    self.tagList.supportSelected = YES;
    self.tagList.tagContentInset = UIEdgeInsetsMake(HeightRatio(12), WidthRatio(20), HeightRatio(12), WidthRatio(20));
    [self addSubview:self.tagList];
    
    self.arrowBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.arrowBtn setImage:[CZImageProvider imageNamed:@"jigou_zhedie"] forState:UIControlStateNormal];
    [self addSubview:self.arrowBtn];
    [self.arrowBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mas_bottom);
        make.centerX.mas_equalTo(self);
        make.size.mas_equalTo(WidthRatio(80));
    }];
}
@end
