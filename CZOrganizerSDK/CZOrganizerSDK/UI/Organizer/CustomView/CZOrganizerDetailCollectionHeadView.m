//
//  CZOrganizerDetailCollectionHeadView.m
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/8.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZOrganizerDetailCollectionHeadView.h"
@interface CZOrganizerDetailCollectionHeadView()
@property (nonatomic ,strong)UILabel *titleLab;
@property (nonatomic ,strong)UILabel *contentLab;
@end
@implementation CZOrganizerDetailCollectionHeadView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self initWithUI];
    }
    return self;
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
        self.tagList.frame = CGRectMake(self.titleLab.frame.origin.x, self.titleLab.frame.origin.y + self.titleLab.frame.size.height + HeightRatio(24), kScreenWidth-WidthRatio(60),self.tagList.contentHeight);
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
    self.titleLab.font = [UIFont boldSystemFontOfSize:WidthRatio(30)];
    self.titleLab.textColor = CZColorCreater(0, 0, 0, 1);
    [self addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.mas_leading).offset(WidthRatio(30));
        make.top.mas_equalTo(self.mas_top).offset(HeightRatio(34));
        make.width.height.mas_greaterThanOrEqualTo(0);
    }];
    
    UILabel *tips = [[UILabel alloc]init];
    tips.backgroundColor = CZColorCreater(76, 182, 253, 1);
    [self addSubview:tips];
    [tips mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self);
        make.width.mas_equalTo(WidthRatio(8));
        make.height.mas_equalTo(HeightRatio(26));
        make.centerY.mas_equalTo(self.titleLab);
    }];
    
    UIImageView *arrowImg = [[UIImageView alloc]initWithImage:[CZImageProvider imageNamed:@"zhu_ye_you_jian_tou"]];
    [self addSubview:arrowImg];
    [arrowImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self.mas_trailing).offset(-WidthRatio(30));
        make.centerY.mas_equalTo(self.titleLab);
        make.height.mas_equalTo(12);
        make.width.mas_equalTo(8);
    }];
    
    self.contentLab = [[UILabel alloc]init];
    self.contentLab.font = [UIFont systemFontOfSize:WidthRatio(24)];
    self.contentLab.text = @"全部";
    self.contentLab.textColor = CZColorCreater(126, 126, 141, 1);
    [self addSubview:self.contentLab];
    [self.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(arrowImg.mas_leading).offset(-WidthRatio(14));
        make.centerY.mas_equalTo(self.titleLab);
        make.width.height.mas_greaterThanOrEqualTo(0);
    }];
    
    [self layoutIfNeeded];
    self.tagList = [[JCTagListView alloc]initWithFrame:CGRectMake(self.titleLab.frame.origin.x, self.titleLab.frame.origin.y + self.titleLab.frame.size.height + HeightRatio(24), kScreenWidth-WidthRatio(60), 0)];
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
}
@end
