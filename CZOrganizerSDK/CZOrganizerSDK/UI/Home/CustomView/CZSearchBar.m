//
//  CZSearchBar.m
//  CZOrganizerSDK
//
//  Created by zsc on 2020/2/25.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZSearchBar.h"

@interface CZSearchBar ()<UITextFieldDelegate>

@property (nonatomic , strong) UITextField *searchBar;

@property (nonatomic , strong) UIImageView *iconView;

@property (nonatomic , strong) void(^textChangeBlock)(NSString *text);

@property (nonatomic , strong) void(^searchBlock)(void);

@property (nonatomic , strong) UIButton *maskButton;

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
    self.searchBar.delegate = self;
    self.searchBar.returnKeyType = UIReturnKeyDone;
    [self addSubview:self.searchBar];
    [self.searchBar addTarget:self action:@selector(textDidChanged:) forControlEvents:UIControlEventEditingChanged];
    self.searchBar.placeholder = NSLocalizedString(@"搜索", nil);
    [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(self.iconView);
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(self.iconView.mas_right).offset(6);
        make.right.mas_equalTo(-10);
    }];
    
    self.maskButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.maskButton];
    [self.maskButton addTarget:self action:@selector(actionForSearch) forControlEvents:UIControlEventTouchUpInside];
    [self.maskButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}

-(void)actionForSearch
{
    if (self.searchBlock) {
        self.searchBlock();
    }
}

-(CGSize)intrinsicContentSize
{
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, 33);
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self textDidChanged:textField];
    return YES;
}

-(void)textDidChanged:(UITextField *)textField
{
    UITextRange *selectedRange = [textField markedTextRange];
    //获取高亮部分
    UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
    // 没有高亮选择的字，说明不是拼音输入
    if (!position) {
        if (self.textChangeBlock) {
            self.textChangeBlock(textField.text);
        }
    }
    else {
        // 有高亮选择的字符串，不做处理
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)setEditTextChangedListener:(void(^)(NSString *text))block
{
    self.textChangeBlock = block;
}

-(void)setSearchAction:(void(^)(void))block
{
    self.searchBlock = block;
}

-(void)enableEdit:(BOOL)edit
{
    self.maskButton.hidden = edit;
}

@end
