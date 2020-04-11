
//
//  CZOrganizerInfoImgCell.m
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/4/12.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZOrganizerInfoImgCell.h"
#import "UIImageView+WebCache.h"
@interface CZOrganizerInfoImgCell ()
@property (nonatomic ,strong) UIImageView *iconImg;
@end
@implementation CZOrganizerInfoImgCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initWithUI];
    }
    return self;
}
- (void)setImgUrl:(NSString *)imgUrl{
    _imgUrl = imgUrl;
    [self.iconImg sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:nil];
}

/**
 * 初始化UI
 */
- (void)initWithUI{
    self.iconImg = [[UIImageView alloc]init];
    [self.contentView addSubview:self.iconImg];
    [self.iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
}
@end
