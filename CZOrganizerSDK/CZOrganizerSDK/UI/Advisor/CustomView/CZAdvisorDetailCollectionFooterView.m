//
//  CZAdvisorDetailCollectionFooterView.m
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/6.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZAdvisorDetailCollectionFooterView.h"

@interface CZAdvisorDetailCollectionFooterView()
@property (nonatomic ,strong)UILabel *titleLab;
@property (nonatomic ,strong) UIButton *allBtn;
@end
@implementation CZAdvisorDetailCollectionFooterView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self initWithUI];
    }
    return self;
}

- (void)allBtnClick{
    if (self.allBtnBlock) {
        self.allBtnBlock();
    }
}

-(void)setTitleStr:(NSString *)titleStr{
    _titleStr = titleStr;
    self.titleLab.text = titleStr;
}

-(void)initWithUI{
    self.titleLab = [[UILabel alloc]init];
    self.titleLab.font = [UIFont systemFontOfSize:WidthRatio(26)];
    self.titleLab.textColor = CZColorCreater(54, 173, 255, 1);
    [self addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.width.height.mas_greaterThanOrEqualTo(0);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-HeightRatio(40));
    }];
    
    UIImageView *arrowImg = [[UIImageView alloc]init];
    arrowImg.image = [CZImageProvider imageNamed:@"you_lanse_jiatou"];
    [self addSubview:arrowImg];
    [arrowImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.titleLab.mas_trailing).offset(WidthRatio(10));
        make.centerY.mas_equalTo(self.titleLab);
        make.width.mas_equalTo(WidthRatio(11));
        make.height.mas_equalTo(HeightRatio(18));
    }];
    
    self.lineView = [[UIView alloc]init];
    self.lineView.backgroundColor = CZColorCreater(245, 245, 249, 1);
    [self addSubview: self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.mas_equalTo(self);
        make.height.mas_equalTo(HeightRatio(12));
    }];
    
    self.allBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.allBtn addTarget:self action:@selector(allBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.allBtn];
    [self.allBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(arrowImg.mas_trailing);
        make.centerY.mas_equalTo(self.titleLab);
        make.leading.mas_equalTo(self.titleLab.mas_leading);
        make.height.mas_equalTo(self.titleLab.mas_height);
    }];
}
@end
