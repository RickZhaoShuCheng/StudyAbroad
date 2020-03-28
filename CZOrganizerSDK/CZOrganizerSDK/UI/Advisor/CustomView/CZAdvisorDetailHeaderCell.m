//
//  CZAdvisorDetailHeaderCell.m
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/7.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZAdvisorDetailHeaderCell.h"
#import "UIImageView+WebCache.h"

@interface CZAdvisorDetailHeaderCell()
@property (nonatomic, strong)UIImageView *avatarImg;
@end
@implementation CZAdvisorDetailHeaderCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initWithUI];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setModel:(CZDiaryModel *)model{
    _model = model;
    NSMutableArray *imgArr = [NSMutableArray array];
    if (model.smdImgs.length) {
        [imgArr addObjectsFromArray:[model.smdImgs componentsSeparatedByString:@","]];
    }
    [self.avatarImg sd_setImageWithURL:[NSURL URLWithString:PIC_URL(imgArr[0])] placeholderImage:nil];
}

- (void)initWithUI{
    self.avatarImg = [[UIImageView alloc]init];
    self.avatarImg.layer.masksToBounds = YES;
    self.avatarImg.layer.cornerRadius = ScreenScale(5);
    [self.contentView addSubview:self.avatarImg];
    [self.avatarImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.top.bottom.mas_equalTo(self.contentView);
//        make.width.mas_equalTo(self.avatarImg.mas_height);
    }];
}
@end
