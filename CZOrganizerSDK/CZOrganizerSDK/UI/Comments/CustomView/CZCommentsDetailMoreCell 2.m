

//
//  CZCommentsDetailMoreCell.m
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/18.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZCommentsDetailMoreCell.h"

@interface CZCommentsDetailMoreCell()
@property (nonatomic ,strong) UILabel *moreLab;
@end
@implementation CZCommentsDetailMoreCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initWithUI];
    }
    return self;
}
/**
 * 初始化UI
 */
- (void)initWithUI{
    self.moreLab = [[UILabel alloc]init];
    self.moreLab.font = [UIFont systemFontOfSize:ScreenScale(26)];
    self.moreLab.textColor = CZColorCreater(29, 112, 193, 1);
    self.moreLab.text = @"查看4条回复";
    [self.contentView addSubview:self.moreLab];
    [self.moreLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.contentView.mas_leading).offset(ScreenScale(120));
        make.height.width.mas_greaterThanOrEqualTo(0);
        make.top.mas_equalTo(self.contentView.mas_top).offset(ScreenScale(32));
    }];
    
    UIImageView *arrowImg = [[UIImageView alloc]init];
    arrowImg.image = [CZImageProvider imageNamed:@"you_lanse_jiatou"];
    [self.contentView addSubview:arrowImg];
    [arrowImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.moreLab.mas_trailing).offset(ScreenScale(10));
        make.centerY.mas_equalTo(self.moreLab);
        make.width.mas_equalTo(ScreenScale(11));
        make.height.mas_equalTo(ScreenScale(18));
    }];
    
    UILabel *line = [[UILabel alloc]init];
    line.text = @"";
    line.backgroundColor = CZColorCreater(243, 243, 246, 1);
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.top.mas_equalTo(self.contentView);
        make.leading.mas_equalTo(self.contentView.mas_leading).offset(ScreenScale(120));
        make.height.mas_equalTo(ScreenScale(1));
    }];
}

@end
