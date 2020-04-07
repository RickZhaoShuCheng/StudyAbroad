
//
//  SchoolStarDetailPostCell.m
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/4/6.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "SchoolStarDetailPostCell.h"
#import "UIImageView+WebCache.h"

@interface SchoolStarDetailPostCell ()
@property (nonatomic ,strong) UIImageView *avatarImg;
@property (nonatomic ,strong) UILabel *nameLab;
@property (nonatomic ,strong) UILabel *timeLab;
@property (nonatomic ,strong) UILabel *contentLab;
@property (nonatomic ,strong) UIButton *tipBtn;
@end
@implementation SchoolStarDetailPostCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initWithUI];
        [self.avatarImg sd_setImageWithURL:[NSURL URLWithString:@"http://uploadfile.bizhizu.cn/2015/0720/20150720033105173.jpg.source.jpg"] placeholderImage:nil];
    }
    return self;
}

/**
 * 初始化UI
 */
- (void)initWithUI{
    self.avatarImg = [[UIImageView alloc]init];
    self.avatarImg.layer.masksToBounds = YES;
    self.avatarImg.layer.cornerRadius = ScreenScale(60)/2;
    [self.contentView addSubview:self.avatarImg];
    [self.avatarImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.contentView.mas_leading).offset(ScreenScale(30));
        make.top.mas_equalTo(self.contentView.mas_top).offset(ScreenScale(30));
        make.size.mas_equalTo(ScreenScale(60));
    }];
    
    self.nameLab = [[UILabel alloc]init];
    self.nameLab.text = @"许一铭";
    self.nameLab.textColor = [UIColor blackColor];
    self.nameLab.font = [UIFont boldSystemFontOfSize:ScreenScale(26)];
    [self.contentView addSubview:self.nameLab];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.avatarImg.mas_trailing).offset(ScreenScale(10));
        make.top.mas_equalTo(self.avatarImg.mas_top);
        make.height.mas_greaterThanOrEqualTo(0);
        make.trailing.mas_equalTo(self.contentView.mas_trailing).offset(-ScreenScale(30));
    }];
    
    self.timeLab = [[UILabel alloc]init];
    self.timeLab.text = @"2小时前 ";
    self.timeLab.textColor = CZColorCreater(159, 159, 178, 1);
    self.timeLab.font = [UIFont boldSystemFontOfSize:ScreenScale(22)];
    [self.contentView addSubview:self.timeLab];
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.avatarImg.mas_trailing).offset(ScreenScale(10));
        make.bottom.mas_equalTo(self.avatarImg.mas_bottom);
        make.height.mas_greaterThanOrEqualTo(0);
        make.trailing.mas_equalTo(self.contentView.mas_trailing).offset(-ScreenScale(30));
    }];
    
    NSMutableArray *tempArr1 = [NSMutableArray array];
    [tempArr1 addObject:@"http://uploadfile.bizhizu.cn/2015/0720/20150720033105173.jpg.source.jpg"];
    [tempArr1 addObject:@"http://pic1.win4000.com/wallpaper/2018-10-12/5bc00af5751a2.jpg"];
    [tempArr1 enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIImageView *imgView = [[UIImageView alloc]init];
        [imgView sd_setImageWithURL:[NSURL URLWithString:obj] placeholderImage:nil];
        [self.contentView addSubview:imgView];
        [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(self.contentView).offset(idx*ScreenScale(10) + idx *(kScreenWidth/2 - ScreenScale(5)));
            make.top.mas_equalTo(self.avatarImg.mas_bottom).offset(ScreenScale(22));
            make.width.mas_equalTo(kScreenWidth/2 - ScreenScale(5));
            make.height.mas_equalTo(imgView.mas_width);
        }];
    }];
    
    self.contentLab = [[UILabel alloc]init];
    self.contentLab.numberOfLines = 0;
    self.contentLab.font = [UIFont systemFontOfSize:ScreenScale(28)];
    self.contentLab.textColor = CZColorCreater(0, 0, 0, 1);
    self.contentLab.text = @"晚餐就在位于公共市场的食在加拿大餐厅用餐这也是一个类似厂房改造的餐厅，超高的空间四面采光坐在这里很舒服，看着吧台忙碌的厨师...";
    [self.contentView addSubview:self.contentLab];
    [self.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.avatarImg.mas_bottom).offset(ScreenScale(22) + kScreenWidth/2 - ScreenScale(5) + ScreenScale(24));
        make.leading.mas_equalTo(self.contentView.mas_leading).offset(ScreenScale(30));
        make.trailing.mas_equalTo(self.contentView.mas_trailing).offset(-ScreenScale(70));
        make.height.mas_greaterThanOrEqualTo(0);
    }];
    
    self.tipBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.tipBtn setTitle:@"#留学糗事#" forState:UIControlStateNormal];
    [self.tipBtn.titleLabel setFont:[UIFont systemFontOfSize:ScreenScale(24)]];
    [self.tipBtn setTitleColor:CZColorCreater(54, 178, 123, 1) forState:UIControlStateNormal];
    [self.tipBtn setBackgroundColor:CZColorCreater(239, 250, 244, 1)];
    [self.tipBtn.layer setMasksToBounds:YES];
    [self.tipBtn.layer setCornerRadius:ScreenScale(48)/2.0];
    [self.contentView addSubview:self.tipBtn];
    [self.tipBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.contentView.mas_leading).offset(ScreenScale(30));
        make.top.mas_equalTo(self.contentLab.mas_bottom).offset(ScreenScale(30));
        make.width.mas_equalTo(ScreenScale(170));
        make.height.mas_equalTo(ScreenScale(48));
    }];
}

@end
