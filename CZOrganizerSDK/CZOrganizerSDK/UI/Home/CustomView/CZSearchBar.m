//
//  CZSearchBar.m
//  CZOrganizerSDK
//
//  Created by zsc on 2020/2/25.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZSearchBar.h"

@interface CZSearchBar ()

@property (nonatomic , strong) UITextField *searchBar;

@property (nonatomic , strong) UIImageView *iconView;

@end


@implementation CZSearchBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

-(void)initUI
{
    self.backgroundColor = CZColorCreater(244, 244, 248, 1.0);
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 4;
    self.iconView = [[UIImageView alloc] init];
    self.iconView.image = [CZImageProvider imageNamed:@"zhu_ye_xue_xiao_fang_da_jing"];
    [self addSubview:self.iconView];
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(16);
        make.left.mas_equalTo(10);
        make.centerY.mas_equalTo(0);
    }];
    
    self.searchBar = [[UITextField alloc] init];
    [self addSubview:self.searchBar];
    self.searchBar.placeholder = NSLocalizedString(@"搜索", nil);
    [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(self.iconView);
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(self.iconView.mas_right).offset(6);
        make.right.mas_equalTo(-10);
    }];
}

-(CGSize)intrinsicContentSize
{
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, 33);
}

@end
