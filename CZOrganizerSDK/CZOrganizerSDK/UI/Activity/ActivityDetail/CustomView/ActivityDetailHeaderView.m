
//
//  ActivityDetailHeaderView.m
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/25.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "ActivityDetailHeaderView.h"

@interface ActivityDetailHeaderView()<SDCycleScrollViewDelegate>
@property (nonatomic ,strong) UILabel *nameLab;
@property (nonatomic ,strong) UILabel *priceLab;
@end
@implementation ActivityDetailHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initWithUI];
    }
    return self;
}

- (void)setModel:(CZActivityModel *)model{
    _model = model;
    NSMutableArray *imgsArr = [NSMutableArray array];
    NSMutableArray *imgUrlArr = [NSMutableArray array];
    if (model.banners.length) {
        [imgsArr addObjectsFromArray:[model.banners componentsSeparatedByString:@","]];
    }
    [imgsArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [imgUrlArr addObject:PIC_URL(obj)];
    }];
    self.cycleView.imageURLStringsGroup = imgUrlArr;
    
    self.nameLab.text = model.title;
    if ([model.price floatValue] > 0.0) {
        if ([model.priceType isEqualToString:@"RMB"]) {
            self.priceLab.text = [NSString stringWithFormat:@"¥%.2f",[model.price floatValue]];
        }else{
            self.priceLab.text = [NSString stringWithFormat:@"A$%.2f",[model.price floatValue]];
        }
    }else{
        self.priceLab.text = @"免费";
    }
}

/**
 * 初始化UI
 */
- (void)initWithUI{
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.cycleView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth) delegate:self placeholderImage:nil];
    self.cycleView.backgroundColor = [UIColor whiteColor];
    self.cycleView.showPageControl = YES;
    [self addSubview:self.cycleView];
    
    self.nameLab = [[UILabel alloc]init];
    self.nameLab.font = [UIFont boldSystemFontOfSize:ScreenScale(32)];
    self.nameLab.textColor = CZColorCreater(51, 51, 51, 1);
    self.nameLab.text = @"-";
    [self addSubview:self.nameLab];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self).offset(ScreenScale(30));
        make.top.mas_equalTo(self.cycleView.mas_bottom).offset(ScreenScale(30));
        make.trailing.mas_equalTo(self.mas_trailing).offset(-ScreenScale(30));
        make.height.mas_greaterThanOrEqualTo(0);
    }];
    
    self.priceLab = [[UILabel alloc]init];
    self.priceLab.font = [UIFont boldSystemFontOfSize:ScreenScale(32)];
    self.priceLab.textColor = CZColorCreater(255, 68, 85, 1);
    self.priceLab.text = @"¥-";
    [self addSubview:self.priceLab];
    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self).offset(ScreenScale(30));
        make.top.mas_equalTo(self.nameLab.mas_bottom).offset(ScreenScale(24));
        make.trailing.mas_equalTo(self.mas_trailing).offset(-ScreenScale(30));
        make.height.mas_greaterThanOrEqualTo(0);
    }];
    
    
    UIView *bgView = [[UIView alloc]init];
    bgView.backgroundColor = CZColorCreater(245, 245, 249, 1);
    [self addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self);
        make.height.mas_equalTo(ScreenScale(88));
        make.top.mas_equalTo(self.priceLab.mas_bottom).offset(ScreenScale(30));
    }];
    
    UILabel *title = [[UILabel alloc]init];;
    title.text = @"活动已结束";
    title.textColor = CZColorCreater(129, 129, 146, 1);
    title.font = [UIFont systemFontOfSize:ScreenScale(32)];
    [bgView addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.mas_equalTo(bgView);
        make.height.width.mas_greaterThanOrEqualTo(0);
    }];
}
@end
