//
//  CZCustomFilterView.m
//  CZOrganizerSDK
//
//  Created by 赵曙诚 on 2020/3/30.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZCustomFilterView.h"

@implementation CZCustomFilterModel

@end


@interface CZCustomFilterView ()

@property (nonatomic , strong) UILabel *serviceTitleLabel;

@property (nonatomic , strong) UILabel *priceTitleLabel;

@property (nonatomic , strong) UIButton *cashButton;

@property (nonatomic , strong) UIButton *payedButton;

@property (nonatomic , strong) UITextField *lowPriceTextField;

@property (nonatomic , strong) UITextField *highPriceTextField;

@property (nonatomic , strong) UIButton *resetButton;

@property (nonatomic , strong) UIButton *confirmButton;

@property (nonatomic , strong) CZCustomFilterModel *selectModel;

@end

@implementation CZCustomFilterView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(void)layoutViews
{
    self.serviceTitleLabel = [[UILabel alloc] init];
    self.serviceTitleLabel.text = NSLocalizedString(@"服务监管", nil);
    self.serviceTitleLabel.font = [UIFont boldSystemFontOfSize:14];
    [self addSubview:self.serviceTitleLabel];
    [self.serviceTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_greaterThanOrEqualTo(0);
        make.left.mas_equalTo(13);
        make.top.mas_equalTo(25);
    }];
    
    self.cashButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.cashButton];
    [self.cashButton addTarget:self action:@selector(actionForCash) forControlEvents:UIControlEventTouchUpInside];
    self.cashButton.layer.masksToBounds = YES;
    self.cashButton.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:13];
    self.cashButton.layer.cornerRadius = 5;
    [self.cashButton setTitle:NSLocalizedString(@"支持资金托运", nil) forState:UIControlStateNormal];
    [self.cashButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(106);
        make.height.mas_equalTo(36);
        make.left.mas_equalTo(13.5);
        make.top.mas_equalTo(self.serviceTitleLabel.mas_bottom).offset(22);
    }];
    
    self.payedButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.payedButton addTarget:self action:@selector(actionForPayed) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.payedButton];
    self.payedButton.layer.masksToBounds = YES;
    self.payedButton.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:13];
    self.payedButton.layer.cornerRadius = 5;
    [self.payedButton setTitle:NSLocalizedString(@"已缴纳保证金", nil) forState:UIControlStateNormal];
    [self.payedButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(106);
        make.height.mas_equalTo(36);
        make.left.mas_equalTo(self.cashButton.mas_right).offset(10.5);
        make.top.mas_equalTo(self.cashButton);
    }];
    
    [self setSelectButton:self.cashButton select:NO];
    [self setSelectButton:self.payedButton select:NO];
    
    [self layoutPriceView:self.cashButton];
    
}

-(void)layoutPriceView:(UIView *)targetView
{
    self.priceTitleLabel = [[UILabel alloc] init];
    self.priceTitleLabel.text = NSLocalizedString(@"价格筛选", nil);
    self.priceTitleLabel.font = [UIFont boldSystemFontOfSize:14];
    [self addSubview:self.priceTitleLabel];
    [self.priceTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_greaterThanOrEqualTo(0);
        make.left.mas_equalTo(13);
        if (targetView) {
            make.top.mas_equalTo(targetView.mas_bottom).offset(27);
        }
        else
        {
            make.top.mas_equalTo(27);
        }
    }];
    
    self.lowPriceTextField = [[UITextField alloc] init];
    self.lowPriceTextField.textAlignment = NSTextAlignmentCenter;
    self.lowPriceTextField.keyboardType = UIKeyboardTypeNumberPad;
    [self.lowPriceTextField addTarget:self action:@selector(actionForLowPrice:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:self.lowPriceTextField];
    self.lowPriceTextField.layer.masksToBounds = YES;
    self.lowPriceTextField.layer.cornerRadius = 5;
    self.lowPriceTextField.backgroundColor = CZColorCreater(250, 250, 250, 1);
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:NSLocalizedString(@"¥ 最低价格", nil)];
    [attrStr addAttribute:NSFontAttributeName
                    value:[UIFont fontWithName:@"PingFang-SC-Medium" size:13]
                    range:NSMakeRange(0, attrStr.string.length)];
    [attrStr addAttribute:NSForegroundColorAttributeName
                    value:CZColorCreater(153, 153, 153, 1)
                    range:NSMakeRange(0, attrStr.string.length)];
    self.lowPriceTextField.attributedPlaceholder = attrStr;
    [self.lowPriceTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(131);
        make.height.mas_equalTo(36);
        make.top.mas_equalTo(self.priceTitleLabel.mas_bottom).offset(22);
        make.left.mas_equalTo(12);
    }];
    
    UIImageView *line = [[UIImageView alloc] init];
    [self addSubview:line];
    line.backgroundColor = CZColorCreater(153, 153, 153, 1);
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(11);
        make.height.mas_equalTo(1.5);
        make.left.mas_equalTo(self.lowPriceTextField.mas_right).offset(9);
        make.centerY.mas_equalTo(self.lowPriceTextField);
    }];
    
    self.highPriceTextField = [[UITextField alloc] init];
    self.highPriceTextField.textAlignment = NSTextAlignmentCenter;
    self.highPriceTextField.keyboardType = UIKeyboardTypeNumberPad;
    [self.highPriceTextField addTarget:self action:@selector(actionForHighPrice:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:self.highPriceTextField];
    self.highPriceTextField.layer.masksToBounds = YES;
    self.highPriceTextField.layer.cornerRadius = 5;
    self.highPriceTextField.backgroundColor = CZColorCreater(250, 250, 250, 1);
    NSMutableAttributedString *attrStr1 = [[NSMutableAttributedString alloc] initWithString:NSLocalizedString(@"¥ 最高价格", nil)];
    [attrStr1 addAttribute:NSFontAttributeName
                    value:[UIFont fontWithName:@"PingFang-SC-Medium" size:13]
                    range:NSMakeRange(0, attrStr1.string.length)];
    [attrStr1 addAttribute:NSForegroundColorAttributeName
                    value:CZColorCreater(153, 153, 153, 1)
                    range:NSMakeRange(0, attrStr1.string.length)];
    self.highPriceTextField.attributedPlaceholder = attrStr1;
    [self.highPriceTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(131);
        make.height.mas_equalTo(36);
        make.top.mas_equalTo(self.priceTitleLabel.mas_bottom).offset(22);
        make.left.mas_equalTo(line.mas_right).offset(9);
    }];
    
    self.resetButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.resetButton.layer.cornerRadius = 20;
    [self.resetButton setTitle:NSLocalizedString(@"重置", nil) forState:UIControlStateNormal];
    [self.resetButton addTarget:self action:@selector(actionForReset) forControlEvents:UIControlEventTouchUpInside];
    self.resetButton.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:16];
    [self.resetButton setTitleColor:CZColorCreater(53, 53, 53, 1) forState:UIControlStateNormal];
    self.resetButton.layer.masksToBounds = YES;
    self.resetButton.layer.borderWidth = 0.5;
    self.resetButton.layer.borderColor = CZColorCreater(230, 230, 230, 1).CGColor;
    [self addSubview:self.resetButton];
    [self.resetButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.highPriceTextField.mas_bottom).offset(47.5);
        make.width.mas_equalTo(166);
        make.height.mas_equalTo(40);
        make.left.mas_equalTo(15.5);
    }];
    
    self.confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.confirmButton setTitle:NSLocalizedString(@"确认", nil) forState:UIControlStateNormal];
    self.confirmButton.layer.cornerRadius = 20;
    self.confirmButton.layer.masksToBounds = YES;
    self.confirmButton.backgroundColor = CZColorCreater(51, 172, 253, 1);
    self.confirmButton.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:16];
    [self.confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self addSubview:self.confirmButton];
    [self.confirmButton addTarget:self action:@selector(actionForConfirm) forControlEvents:UIControlEventTouchUpInside];
    [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.resetButton);
        make.width.mas_equalTo(166);
        make.height.mas_equalTo(40);
        make.left.mas_equalTo(self.resetButton.mas_right).offset(12.5);
    }];
}

- (void)actionForConfirm
{
    if (self.select) {
        self.select(self.selectModel);
    }
}

-(void)actionForReset
{
    self.selectModel = nil;
    [self setSelectButton:self.cashButton select:NO];
    [self setSelectButton:self.payedButton select:NO];
    self.lowPriceTextField.text = @"";
    self.highPriceTextField.text = @"";
}

- (void)actionForCash
{
    self.selectModel.type = @(CZCustomFilteServiceTypeCash);
    [self setSelectButton:self.cashButton select:YES];
    [self setSelectButton:self.payedButton select:NO];
}

-(void)actionForPayed
{
    self.selectModel.type = @(CZCustomFilteServiceTypePayed);
    [self setSelectButton:self.cashButton select:NO];
    [self setSelectButton:self.payedButton select:YES];
}

-(void)setSelectButton:(UIButton *)button select:(BOOL)select
{
    [button setSelected:select];
    if (!select) {
        [button setTitleColor:CZColorCreater(68, 68, 68, 1) forState:UIControlStateNormal];
        button.backgroundColor = CZColorCreater(245, 245, 245, 1);
    }
    else
    {
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.backgroundColor = CZColorCreater(51, 172, 253, 1);
    }
}

-(void)actionForHighPrice:(UITextField *)textField
{
    self.selectModel.highPrice = textField.text;
}

-(void)actionForLowPrice:(UITextField *)textField
{
    self.selectModel.lowPrice = textField.text;
}


-(CZCustomFilterModel *)selectModel
{
    if (!_selectModel) {
        _selectModel = [[CZCustomFilterModel alloc] init];
    }
    return _selectModel;
}

@end
