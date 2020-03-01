//
//  CZPersionInfoCell.m
//  CZOrganizerSDK
//
//  Created by zsc on 2020/2/29.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZPersonInfoCell.h"
#import "CZPersonInfoView.h"
#import "CZAdvisorModel.h"
#import "UIImageView+WebCache.h"
#import "CZOrganizerModel.h"

@interface CZPersonInfoCell ()

@property (nonatomic , strong) CZPersonInfoView *infoView;

@end

@implementation CZPersonInfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initWithUI];
    }
    return self;
}
/**
 * 赋值信息
 */
- (void)setModel:(CZAdvisorModel *)model
{
    _model = model;
    [self.infoView.avatarImageView sd_setImageWithURL:[NSURL URLWithString:PIC_URL(model.counselorImg)] placeholderImage:nil];
    self.infoView.infoLabel.text = model.counselorName;
    self.infoView.organizeNameLabel.text = model.organName;
    NSString *formatterString = NSLocalizedString(@"服务%@人", nil);
    self.infoView.subTitleLabel.text = [NSString stringWithFormat:formatterString,model.serviceCount];
}

-(void)setOmodel:(CZOrganizerModel *)omodel
{
    _omodel = omodel;
    [self.infoView.avatarImageView sd_setImageWithURL:[NSURL URLWithString:PIC_URL(omodel.logo)] placeholderImage:nil];
    self.infoView.infoLabel.text = omodel.name;
    NSString *formatterString = NSLocalizedString(@"专业度：%@ 服务：%@ 价格：%@ 响应：%@", nil);
    self.infoView.organizeNameLabel.text = [NSString stringWithFormat:formatterString ,omodel.valProfessional.stringValue , omodel.valService.stringValue,omodel.valPrice.stringValue,omodel.valResponse.stringValue];
    formatterString = NSLocalizedString(@"%@条评价", nil);
    self.infoView.subTitleLabel.text = [NSString stringWithFormat:formatterString,omodel.comments];
}

/**
 * 初始化UI
 */
- (void)initWithUI{
    self.infoView = [[CZPersonInfoView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 70) container:self.contentView];
}

@end
