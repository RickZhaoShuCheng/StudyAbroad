//
//  CZCustomFilterView.m
//  CZOrganizerSDK
//
//  Created by 赵曙诚 on 2020/3/30.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZCustomFilterView.h"

@interface CZCustomFilterView ()

@property (nonatomic , strong) UILabel *serviceTitleLabel;

@property (nonatomic , strong) UIButton *cashButton;

@property (nonatomic , strong) UIButton *payedButton;

@property (nonatomic , strong) UITextField *lowPriceTextField;

@property (nonatomic , strong) UITextField *highPriceTextField;

@end

@implementation CZCustomFilterView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(void)layoutViews
{
    self.serviceTitleLabel = [[UILabel alloc] init];
    self.serviceTitleLabel.text = NSLocalizedString(@"服务监管", nil);
    self.serviceTitleLabel.font = [UIFont boldSystemFontOfSize:15];
    [self addSubview:self.serviceTitleLabel];
    [self.serviceTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_greaterThanOrEqualTo(0);
        make.left.mas_equalTo(12);
        make.top.mas_equalTo(18);
    }];
    
    self.cashButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.cashButton];
    [self.cashButton setTitle:NSLocalizedString(@"支持资金托运", nil) forState:UIControlStateNormal];
    
    self.payedButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.payedButton];
    [self.payedButton setTitle:NSLocalizedString(@"已缴纳保证金", nil) forState:UIControlStateNormal];
}

@end
