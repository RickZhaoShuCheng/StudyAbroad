//
//  CZActivityListCell.m
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/24.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZActivityListCell.h"
#import "UIImageView+WebCache.h"
#import "NSDate+Utils.h"
@interface CZActivityListCell()
@property (nonatomic ,strong) UIImageView *iconImg;
@property (nonatomic ,strong) UILabel *nameLab;
@property (nonatomic ,strong) UILabel *priceLab;
@property (nonatomic ,strong) UILabel *locationLab;
@property (nonatomic ,strong) UILabel *timeLab;
@property (nonatomic ,strong) UIView *endView;
@end
@implementation CZActivityListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initWithUI];
    }
    return self;
}

- (void)setModel:(CZActivityModel *)model{
    _model = model;
    [self.iconImg sd_setImageWithURL:[NSURL URLWithString:PIC_URL(model.logo)] placeholderImage:nil];
    self.nameLab.text = model.title;
    if (model.status == 0) {
        self.endView.hidden = NO;
        self.nameLab.textColor = CZColorCreater(155, 158, 162, 1);
        self.locationLab.textColor = CZColorCreater(155, 158, 162, 1);
        self.timeLab.textColor = CZColorCreater(155, 158, 162, 1);
        self.priceLab.textColor = CZColorCreater(155,158,162,1);//钱255, 68, 85, 1)   免费255，142，0，1    已结束155，158，162，1
        self.priceLab.text = @"已结束";
        self.timeLab.text = @"已结束";
    }else{
        self.endView.hidden = YES;
        self.nameLab.textColor = CZColorCreater(51, 51, 51, 1);
        self.locationLab.textColor = CZColorCreater(183, 183, 196, 1);
        self.timeLab.textColor = CZColorCreater(129, 129, 146, 1);
        if ([model.price floatValue] == 0.0) {
            self.priceLab.text = @"免费";
            self.priceLab.textColor = CZColorCreater(255,142,0,1);//钱255, 68, 85, 1)   免费255，142，0，1    已结束155，158，162，1
        }else{
            if ([model.priceType isEqualToString:@"RMB"]) {
                self.priceLab.text = [NSString stringWithFormat:@"¥%.2f",[model.price floatValue]/100];
                self.priceLab.textColor = CZColorCreater(255, 68, 85, 1);//钱255, 68, 85, 1)   免费255，142，0，1    已结束155，158，162，1
            }else{
                self.priceLab.text = [NSString stringWithFormat:@"A$%.2f",[model.price floatValue]/100];
                self.priceLab.textColor = CZColorCreater(255, 68, 85, 1);//钱255, 68, 85, 1)   免费255，142，0，1    已结束155，158，162，1
            }
        }
        if (model.activitySessionList.count >= 1) {
            CZActivitySession *session =  model.activitySessionList[0];
            NSString *timeStr = [NSDate stringYearMonthDayWithDate:[NSDate dateWithTimeIntervalSince1970:[session.beginTime integerValue]/1000]];
            self.timeLab.text = [NSString stringWithFormat:@"%@开始",timeStr];
        }else{
            self.timeLab.text = @"进行中";
        }
    }
    if (model.activityType == 0) {
        self.locationLab.text = @"线上直播";
    }else{
        self.locationLab.text = model.extAddress;
    }
}

/**
 * 初始化UI
 */
- (void)initWithUI{
    self.iconImg = [[UIImageView alloc]init];
    [self.contentView addSubview:self.iconImg];
    [self.iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.contentView.mas_leading).offset(ScreenScale(30));
        make.size.mas_equalTo(ScreenScale(200));
        make.top.mas_equalTo(self.contentView.mas_top).offset(ScreenScale(10));
    }];
    
    self.nameLab = [[UILabel alloc]init];
    self.nameLab.font = [UIFont boldSystemFontOfSize:ScreenScale(32)];
    self.nameLab.textColor = CZColorCreater(51, 51, 51, 1);
    self.nameLab.text = @"-";
    [self.contentView addSubview:self.nameLab];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.iconImg.mas_trailing).offset(ScreenScale(24));
        make.top.mas_equalTo(self.iconImg.mas_top).offset(ScreenScale(2));
        make.trailing.mas_equalTo(self.contentView.mas_trailing).offset(-ScreenScale(24));
        make.height.mas_greaterThanOrEqualTo(0);
    }];
    
    self.priceLab = [[UILabel alloc]init];
    self.priceLab.font = [UIFont boldSystemFontOfSize:ScreenScale(32)];
    self.priceLab.textColor = CZColorCreater(255, 68, 85, 1);//钱255, 68, 85, 1)   免费255，142，0，1    已结束155，158，162，1
    self.priceLab.text = @"¥-";
    [self.contentView addSubview:self.priceLab];
    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.iconImg.mas_trailing).offset(ScreenScale(24));
        make.top.mas_equalTo(self.nameLab.mas_bottom).offset(ScreenScale(30));
        make.trailing.mas_equalTo(self.contentView.mas_trailing).offset(-ScreenScale(24));
        make.height.mas_greaterThanOrEqualTo(0);
    }];
    
    self.locationLab = [[UILabel alloc]init];
    self.locationLab.font = [UIFont systemFontOfSize:ScreenScale(24)];
    self.locationLab.textColor = CZColorCreater(183, 183, 196, 1);
    self.locationLab.text = @"-";
    [self.contentView addSubview:self.locationLab];
    [self.locationLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.iconImg.mas_trailing).offset(ScreenScale(24));
        make.top.mas_equalTo(self.priceLab.mas_bottom).offset(ScreenScale(20));
        make.trailing.mas_equalTo(self.contentView.mas_trailing).offset(-ScreenScale(24));
        make.height.mas_greaterThanOrEqualTo(0);
    }];
    
    self.timeLab = [[UILabel alloc]init];
    self.timeLab.font = [UIFont systemFontOfSize:ScreenScale(24)];
    self.timeLab.textColor = CZColorCreater(129, 129, 146, 1);
    self.timeLab.text = @"-";
    [self.contentView addSubview:self.timeLab];
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.iconImg.mas_trailing).offset(ScreenScale(24));
        make.bottom.mas_equalTo(self.iconImg.mas_bottom).offset(-ScreenScale(2));
        make.trailing.mas_equalTo(self.contentView.mas_trailing).offset(-ScreenScale(24));
        make.height.mas_greaterThanOrEqualTo(0);
    }];
    
    self.endView = [[UIView alloc]init];
    self.endView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
    self.endView.hidden = YES;
    [self.contentView addSubview:self.endView];
    [self.endView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.mas_equalTo(self.iconImg);
        make.size.mas_equalTo(self.iconImg);
    }];
}
@end
