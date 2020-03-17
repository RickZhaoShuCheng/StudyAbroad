//
//  CZAdvisorDetailCollectionHeadView.m
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/5.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZAdvisorDetailCollectionHeadView.h"

@interface CZAdvisorDetailCollectionHeadView()
@property (nonatomic ,strong)UILabel *titleLab;
@property (nonatomic ,strong)UILabel *contentLab;
@property (nonatomic ,strong) UIButton *allBtn;
@end

@implementation CZAdvisorDetailCollectionHeadView
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

//设置标签
- (void)setTags:(NSMutableArray *)tagesArr{
    if (tagesArr.count > 0) {
        [self layoutIfNeeded];
        self.tagList.hidden = NO;
        if (self.tagList.selectedTags.count <= 0) {
            [self.tagList.selectedTags addObject:tagesArr[0]];
        }
        self.tagList.tags = tagesArr;
        self.tagList.frame = CGRectMake(self.titleLab.frame.origin.x, self.titleLab.frame.origin.y + self.titleLab.frame.size.height + ScreenScale(24), kScreenWidth-ScreenScale(60),self.tagList.contentHeight);
    }else{
        self.tagList.hidden = YES;
    }
}

-(void)setTitleStr:(NSString *)titleStr{
    _titleStr = titleStr;
    self.titleLab.text = titleStr;
}

- (void)setContentStr:(NSString *)contentStr{
    _contentStr = contentStr;
    self.contentLab.text = contentStr;
}

-(void)initWithUI{
    self.titleLab = [[UILabel alloc]init];
    self.titleLab.font = [UIFont boldSystemFontOfSize:ScreenScale(30)];
    self.titleLab.textColor = CZColorCreater(0, 0, 0, 1);
    [self addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.mas_leading).offset(ScreenScale(30));
        make.top.mas_equalTo(self.mas_top).offset(ScreenScale(34));
        make.width.height.mas_greaterThanOrEqualTo(0);
    }];
    
    UILabel *tips = [[UILabel alloc]init];
    tips.backgroundColor = CZColorCreater(76, 182, 253, 1);
    [self addSubview:tips];
    [tips mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self);
        make.width.mas_equalTo(ScreenScale(8));
        make.height.mas_equalTo(ScreenScale(26));
        make.centerY.mas_equalTo(self.titleLab);
    }];
    
    UIImageView *arrowImg = [[UIImageView alloc]initWithImage:[CZImageProvider imageNamed:@"zhu_ye_you_jian_tou"]];
    [self addSubview:arrowImg];
    [arrowImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self.mas_trailing).offset(-ScreenScale(30));
        make.centerY.mas_equalTo(self.titleLab);
        make.height.mas_equalTo(12);
        make.width.mas_equalTo(8);
    }];
    
    self.contentLab = [[UILabel alloc]init];
    self.contentLab.font = [UIFont systemFontOfSize:ScreenScale(24)];
    self.contentLab.text = @"全部";
    self.contentLab.textColor = CZColorCreater(126, 126, 141, 1);
    [self addSubview:self.contentLab];
    [self.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(arrowImg.mas_leading).offset(-ScreenScale(14));
        make.centerY.mas_equalTo(self.titleLab);
        make.width.height.mas_greaterThanOrEqualTo(0);
    }];
    
    [self layoutIfNeeded];
    self.tagList = [[JCTagListView alloc]initWithFrame:CGRectMake(self.titleLab.frame.origin.x, self.titleLab.frame.origin.y + self.titleLab.frame.size.height + ScreenScale(24), kScreenWidth-ScreenScale(60), 0)];
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
    
    self.allBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.allBtn addTarget:self action:@selector(allBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.allBtn];
    [self.allBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(arrowImg.mas_trailing);
        make.centerY.mas_equalTo(self.contentLab);
        make.leading.mas_equalTo(self.contentLab.mas_leading);
        make.height.mas_equalTo(self.contentLab.mas_height);
    }];
}

@end
