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
        [self.avatarImg sd_setImageWithURL:[NSURL URLWithString:@"http://pics2.baidu.com/feed/6f061d950a7b0208861260d9c2b4e9d5562cc8a7.png?token=a660efbc8f229953136baa823633d889&s=9F1405CE8E9000D4F395A8BA0300D011"] placeholderImage:nil];
    }
    return self;
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
