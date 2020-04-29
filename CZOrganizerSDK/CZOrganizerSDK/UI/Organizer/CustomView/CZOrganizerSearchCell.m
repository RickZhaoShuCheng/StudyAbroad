//
//  CZOrganizerSearchCell.m
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/21.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZOrganizerSearchCell.h"

@interface CZOrganizerSearchCell()

@end
@implementation CZOrganizerSearchCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initWithUI];
    }
    return self;
}

- (void)setDic:(NSDictionary *)dic{
    _dic = dic;
    NSMutableString *tempStr = [NSMutableString stringWithString:dic[@"content1"]];
    if (tempStr.length > 2) {
        [tempStr insertString:@"\n" atIndex:2];
    }
    self.titleLab.text = tempStr;
}

/**
 * 初始化UI
 */
- (void)initWithUI{
    self.titleLab = [[UILabel alloc]init];
    self.titleLab.font = [UIFont systemFontOfSize:ScreenScale(24)];
    self.titleLab.textColor = CZColorCreater(61, 67, 83, 1);
    self.titleLab.text = @"留学\n咨询";
    self.titleLab.textAlignment = NSTextAlignmentCenter;
    self.titleLab.layer.masksToBounds = YES;
    self.titleLab.numberOfLines = 0;
    self.titleLab.layer.cornerRadius = ScreenScale(124)/2.0;
    self.titleLab.backgroundColor = CZColorCreater(242, 248, 248, 1);
    [self.contentView addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.mas_equalTo(self.contentView);
        make.size.mas_equalTo(ScreenScale(124));
    }];
}
@end
