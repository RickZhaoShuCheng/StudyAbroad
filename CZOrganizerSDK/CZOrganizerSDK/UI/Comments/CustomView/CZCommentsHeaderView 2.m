

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

- (void)setVarStar:(NSNumber *)varStar{
    self.starLab.text = [NSString stringWithFormat:@"%.1f",[varStar floatValue]];
    [self.rankView setRankByRate:[varStar floatValue]];
}

- (void)setAvgMajor:(NSString *)avgMajor avgPrice:(NSString *)avgPrice avgService:(NSString *)avgService{    
    self.organizerLab.text = [NSString stringWithFormat:@"专业度: %@  服务: %@  价格: %@",avgMajor,avgService,avgPrice];
}

/**
 * 初始化UI
 */
- (void)initWithUI{
    self.starLab = [[UILabel alloc]init];
    self.starLab.font = [UIFont boldSystemFontOfSize:ScreenScale(37)];
    self.starLab.textColor = CZColorCreater(51, 51, 51, 1);
    self.starLab.text = @"-";
    [self addSubview:self.starLab];
    [self.starLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.mas_leading).offset(ScreenScale(30));
        make.top.mas_equalTo(self.mas_top).offset(ScreenScale(50));
        make.height.width.mas_greaterThanOrEqualTo(0);
    }];
    
    self.rankView = [CZRankView instanceRankViewByRate:0.0];
    [self addSubview:self.rankView];
    [self.rankView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(ScreenScale(150));
        make.leading.mas_equalTo(self.starLab.mas_trailing).offset(ScreenScale(20));
        make.bottom.mas_equalTo(self.starLab.mas_bottom);
        make.height.mas_equalTo(ScreenScale(28));
    }];
    
    self.organizerLab = [[UILabel alloc] init];
    self.organizerLab.text = @"专业度: -  服务: -  价格: -";
    self.organizerLab.textColor = CZColorCreater(129, 129, 146, 1);
    self.organizerLab.font = [UIFont systemFontOfSize:ScreenScale(24)];
    [self addSubview:self.organizerLab];
    [self.organizerLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.mas_leading).offset(ScreenScale(30));
        make.top.mas_equalTo(self.starLab.mas_bottom).offset(ScreenScale(16));
        make.trailing.mas_equalTo(self.mas_trailing).offset(-ScreenScale(30));
        make.height.mas_greaterThanOrEqualTo(0);
    }];
    
    self.tagList = [[JCTagListView alloc]initWithFrame:CGRectMake(ScreenScale(30),ScreenScale(150), kScreenWidth-ScreenScale(60), 0)];
    self.tagList.backgroundColor = [UIColor whiteColor];
    self.tagList.tagCornerRadius = ScreenScale(28);
    self.tagList.tagBorderWidth = 1;
    self.tagList.tagBorderColor = CZColorCreater(244, 244, 248, 1);
    self.tagList.tagBackgroundColor = CZColorCreater(244, 244, 248, 1);
    self.tagList.tagSelectedBorderColor = CZColorCreater(51, 172, 253, 1);
    self.tagList.tagSelectedTextColor = CZColorCreater(51, 172, 253, 1);
    self.tagList.tagSelectedBackgroundColor = CZColorCreater(244, 244, 248, 1);
    self.tagList.tagTextColor = CZColorCreater(61, 67, 83, 1);
    self.tagList.tagFont = [UIFont systemFontOfSize:ScreenScale(24)];
    self.tagList.supportSelected = YES;
    self.tagList.tagContentInset = UIEdgeInsetsMake(ScreenScale(12), ScreenScale(20), ScreenScale(12), ScreenScale(20));
    [self addSubview:self.tagList];
    
    self.arrowBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.arrowBtn.hidden = YES;
    [self.arrowBtn setImage:[CZImageProvider imageNamed:@"jigou_zhedie"] forState:UIControlStateNormal];
    [self addSubview:self.arrowBtn];
    [self.arrowBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mas_bottom);
        make.centerX.mas_equalTo(self);
        make.size.mas_equalTo(ScreenScale(80));
    }];
}
@end
