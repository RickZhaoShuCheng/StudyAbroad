
//
//  SchoolStarShopCommentHeaderView.m
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/4/6.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "SchoolStarShopCommentHeaderView.h"

@implementation SchoolStarShopCommentHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initWithUI];
    }
    return self;
}
/**
 * 初始化UI
 */
- (void)initWithUI{
    self.titleLab = [[UILabel alloc]init];
    self.titleLab.font = [UIFont boldSystemFontOfSize:ScreenScale(32)];
    self.titleLab.textColor = [UIColor blackColor];
    self.titleLab.text = @"学员评价 (-）";
    [self addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.mas_leading).offset(ScreenScale(30));
        make.centerY.mas_equalTo(self);
        make.width.height.mas_greaterThanOrEqualTo(0);
    }];
}
@end
