

//
//  CZCommentsHeaderView.m
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/14.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZCommentsHeaderView.h"
#import "CZRankView.h"


@interface CZCommentsHeaderView()
@property (nonatomic ,strong) UILabel *starLab;
@property (nonatomic ,strong) CZRankView *rankView;
@property (nonatomic ,strong) UILabel *organizerLab;
@end
@implementation CZCommentsHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.masksToBounds = YES;
        [self initWithUI];
    }
    return self;
}
/**
 * 初始化UI
 */
- (void)initWithUI{
    self.starLab = [[UILabel alloc]init];
    self.starLab.font = [UIFont boldSystemFontOfSize:WidthRatio(37)];
    self.starLab.textColor = CZColorCreater(51, 51, 51, 1);
    self.starLab.text = @"5.0";
    [self addSubview:self.starLab];
    [self.starLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.mas_leading).offset(WidthRatio(30));
        make.top.mas_equalTo(self.mas_top).offset(HeightRatio(40));
        make.height.width.mas_greaterThanOrEqualTo(0);
    }];
    
    self.rankView = [CZRankView instanceRankViewByRate:3.1];
    [self addSubview:self.rankView];
    [self.rankView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(WidthRatio(150));
        make.leading.mas_equalTo(self.starLab.mas_trailing).offset(WidthRatio(20));
        make.bottom.mas_equalTo(self.starLab.mas_bottom).offset(HeightRatio(5));
        make.height.mas_equalTo(HeightRatio(28));
    }];
    
    self.organizerLab = [[UILabel alloc] init];
    self.organizerLab.text = @"专业度: 4.9  服务: 4.9  价格: 4.9";
    self.organizerLab.textColor = CZColorCreater(129, 129, 146, 1);
    self.organizerLab.font = [UIFont systemFontOfSize:WidthRatio(24)];
    [self addSubview:self.organizerLab];
    [self.organizerLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.mas_leading).offset(WidthRatio(30));
        make.top.mas_equalTo(self.starLab.mas_bottom).offset(HeightRatio(16));
        make.trailing.mas_equalTo(self.mas_trailing).offset(-WidthRatio(30));
        make.height.mas_greaterThanOrEqualTo(0);
    }];
    
    self.tagList = [[JCTagListView alloc]initWithFrame:CGRectMake(WidthRatio(30),HeightRatio(150), kScreenWidth-WidthRatio(60), 0)];
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
    self.arrowBtn.hidden = YES;
    [self.arrowBtn setImage:[CZImageProvider imageNamed:@"jigou_zhedie"] forState:UIControlStateNormal];
    [self addSubview:self.arrowBtn];
    [self.arrowBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mas_bottom);
        make.centerX.mas_equalTo(self);
        make.size.mas_equalTo(WidthRatio(80));
    }];
}
@end
