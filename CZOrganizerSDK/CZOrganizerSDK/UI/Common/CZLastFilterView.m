//
//  CZLastFilterView.m
//  CZOrganizerSDK
//
//  Created by zsc on 2020/3/7.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZLastFilterView.h"

@interface CZLastFilterView ()

@property (nonatomic, strong) UILabel *mainTitleLabel;
@property (nonatomic, strong) UIButton *noPayButton;
@property (nonatomic, strong) UIButton *payedButton;

@property (nonatomic, strong) UILabel *subTitleLabel;
@property (nonatomic, strong) UITextField *lowPriceTextField;
@property (nonatomic, strong) UITextField *highPriceTextField;

@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIButton *confirmButton;

@end

@implementation CZLastFilterView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

-(void)initUI
{
    
}

@end
