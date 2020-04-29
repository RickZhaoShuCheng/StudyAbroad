//
//  CZAdvisorDynamicPostCommentCell.m
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/4/28.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZAdvisorDynamicPostCommentCell.h"

@interface CZAdvisorDynamicPostCommentCell()
@property (nonatomic ,strong) UILabel *nameLab;
@property (nonatomic ,strong) UILabel *contentLab;
@end

@implementation CZAdvisorDynamicPostCommentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initWithUI];
    }
    return self;
}

/**
 * 初始化UI
 */
- (void)initWithUI{
    self.nameLab = [[UILabel alloc]init];
    self.nameLab.font = [UIFont boldSystemFontOfSize:ScreenScale(24)];
    self.nameLab.textColor = CZColorCreater(51, 51, 51, 1);
    self.nameLab.text = @"大可爱:";
    [self.contentView addSubview:self.nameLab];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.contentView.mas_leading).offset(ScreenScale(30));
        make.height.width.mas_greaterThanOrEqualTo(0);
        make.top.mas_equalTo(self.contentView.mas_top).offset(ScreenScale(ScreenScale(50)));
    }];
    
    [self.nameLab setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    
    self.contentLab = [[UILabel alloc]init];
    self.contentLab.font = [UIFont systemFontOfSize:ScreenScale(24)];
    self.contentLab.textColor = CZColorCreater(51, 51, 51, 1);
    self.contentLab.text = @"加利福尼亚州西南部";
//    self.contentLab.numberOfLines = 0;
    [self.contentView addSubview:self.contentLab];
    [self.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.nameLab.mas_trailing).offset(ScreenScale(5));
        make.trailing.mas_equalTo(self.contentView.mas_trailing).offset(-ScreenScale(30));
        make.height.mas_greaterThanOrEqualTo(0);
        make.top.mas_equalTo(self.nameLab.mas_top);
    }];
    
    UILabel *line = [[UILabel alloc]init];
    line.backgroundColor = CZColorCreater(232, 232, 232, 1);
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.bottom.trailing.mas_equalTo(self.contentView);
        make.height.mas_equalTo(ScreenScale(1));
    }];
}
@end
