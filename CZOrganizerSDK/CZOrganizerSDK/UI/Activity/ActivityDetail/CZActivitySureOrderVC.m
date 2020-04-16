//
//  CZActivitySureOrderVC.m
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/4/17.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZActivitySureOrderVC.h"
#import "QSClient.h"
#import "UIImageView+WebCache.h"

@interface CZActivitySureOrderVC ()
@property (nonatomic ,strong) UIButton *backBtn;
@property (nonatomic ,strong) UIImageView *iconImg;
@property (nonatomic ,strong) UILabel *titleLab;
@property (nonatomic ,strong) UILabel *timeLab;
@property (nonatomic ,strong) UILabel *priceLab;
@property (nonatomic ,strong) UILabel *phoneLab;
@property (nonatomic ,strong) UILabel *nameLab;
@property (nonatomic ,strong) UILabel *orderNumLab;
@property (nonatomic ,strong) UIButton *sureBtn;
@end

@implementation CZActivitySureOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar.subviews.firstObject setAlpha:1];
    [self initWithUI];
}
- (void)setDic:(NSDictionary *)dic{
    _dic = dic;
    [self.iconImg sd_setImageWithURL:[NSURL URLWithString:PIC_URL(dic[@"productLogo"])] placeholderImage:nil];
    self.titleLab.text = dic[@"productTitle"];
    self.orderNumLab.text = dic[@"orderNo"];
    self.timeLab.text = @"场次：2019-12-23 20:00-21:00";
}

- (void)clickSureBtn{
    if (self.sureCallBack) {
        self.sureCallBack();
    }
}
- (void)clickPhone{
    UIViewController *phoneVC = [QSClient instancePhoneTabVC];
    [self.navigationController pushViewController:phoneVC animated:YES];
}
/**
 * 初始化UI
 */
- (void)initWithUI{
    self.title = @"确认订单";
    self.view.backgroundColor = CZColorCreater(245, 245, 249, 1);
    //返回按钮
    self.backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [self.backBtn setImage:[CZImageProvider imageNamed:@"tong_yong_fan_hui"] forState:UIControlStateNormal];
    [self.backBtn addTarget:self action:@selector(actionForBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:self.backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    
    UIImageView *bgImg = [[UIImageView alloc]init];
//    bgImg.backgroundColor = [UIColor redColor];
    [self.view addSubview:bgImg];
    [bgImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.trailing.mas_equalTo(self.view);
        make.height.mas_equalTo(ScreenScale(235));
    }];
    
    UIView *goodsView = [[UIView alloc]init];
    goodsView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:goodsView];
    [goodsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self.view);
        make.height.mas_equalTo(ScreenScale(220));
        make.top.mas_equalTo(bgImg.mas_bottom).offset(-ScreenScale(20));
    }];
    // 左上和右上为圆角
    UIBezierPath *cornerRadiusPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, kScreenWidth, ScreenScale(220)) byRoundingCorners:UIRectCornerTopRight | UIRectCornerTopLeft cornerRadii:CGSizeMake(ScreenScale(20), ScreenScale(20))];
    CAShapeLayer *cornerRadiusLayer = [ [CAShapeLayer alloc ] init];
    cornerRadiusLayer.frame = CGRectMake(0, 0, kScreenWidth, ScreenScale(220));
    cornerRadiusLayer.path = cornerRadiusPath.CGPath;
    goodsView.layer.mask = cornerRadiusLayer;

    self.iconImg = [[UIImageView alloc]init];
    [goodsView addSubview:self.iconImg];
    [self.iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(goodsView.mas_leading).offset(ScreenScale(30));
        make.centerY.mas_equalTo(goodsView);
        make.size.mas_equalTo(ScreenScale(162));
    }];
    
    self.titleLab = [[UILabel alloc]init];
    self.titleLab.font = [UIFont systemFontOfSize:ScreenScale(26)];
    self.titleLab.textColor = [UIColor blackColor];
    self.titleLab.text = @"-";
    self.titleLab.numberOfLines = 2;
    [goodsView addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.iconImg.mas_trailing).offset(ScreenScale(20));
        make.top.mas_equalTo(self.iconImg.mas_top);
        make.trailing.mas_equalTo(goodsView.mas_trailing).offset(-ScreenScale(30));
        make.height.mas_greaterThanOrEqualTo(0);
    }];
    
    self.timeLab = [[UILabel alloc]init];
    self.timeLab.font = [UIFont systemFontOfSize:ScreenScale(24)];
    self.timeLab.textColor = CZColorCreater(129, 129, 146, 1);
    self.timeLab.text = @"场次：2019-12-23 20:00-21:00";
    [goodsView addSubview:self.timeLab];
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.iconImg.mas_trailing).offset(ScreenScale(20));
        make.top.mas_equalTo(self.iconImg.mas_top).offset(ScreenScale(85));
        make.trailing.mas_equalTo(goodsView.mas_trailing).offset(-ScreenScale(30));
        make.height.mas_greaterThanOrEqualTo(0);
    }];
    
    self.priceLab = [[UILabel alloc]init];
    self.priceLab.font = [UIFont systemFontOfSize:ScreenScale(26)];
    self.priceLab.textColor = CZColorCreater(255, 142, 0, 1);
    self.priceLab.text = @"免费";
    [goodsView addSubview:self.priceLab];
    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.iconImg.mas_trailing).offset(ScreenScale(20));
        make.bottom.mas_equalTo(self.iconImg.mas_bottom);
        make.trailing.mas_equalTo(goodsView.mas_trailing).offset(-ScreenScale(30));
        make.height.mas_greaterThanOrEqualTo(0);
    }];
    
    UIView *infoView = [[UIView alloc]init];
    infoView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:infoView];
    [infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self.view);
        make.height.mas_equalTo(ScreenScale(290));
        make.top.mas_equalTo(goodsView.mas_bottom).offset(ScreenScale(22));
    }];
    
    UILabel *phoneTitle = [[UILabel alloc]init];
    phoneTitle.font = [UIFont systemFontOfSize:ScreenScale(28)];
    phoneTitle.text = @"手机号";
    phoneTitle.textColor = CZColorCreater(53, 53, 53, 1);
    [infoView addSubview:phoneTitle];
    [phoneTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(infoView.mas_leading).offset(ScreenScale(30));
        make.top.mas_equalTo(infoView.mas_top).offset(ScreenScale(35));
        make.width.height.mas_greaterThanOrEqualTo(0);
    }];
    
    UILabel *line = [[UILabel alloc]init];
    line.backgroundColor = CZColorCreater(243, 243, 243, 1);
    line.text = @"";
    [infoView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(infoView);
        make.height.mas_equalTo(ScreenScale(1));
        make.top.mas_equalTo(phoneTitle.mas_bottom).offset(ScreenScale(35));
    }];
    
    UILabel *nameTitle = [[UILabel alloc]init];
    nameTitle.font = [UIFont systemFontOfSize:ScreenScale(28)];
    nameTitle.text = @"姓名";
    nameTitle.textColor = CZColorCreater(53, 53, 53, 1);
    [infoView addSubview:nameTitle];
    [nameTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(infoView.mas_leading).offset(ScreenScale(30));
        make.top.mas_equalTo(phoneTitle.mas_bottom).offset(ScreenScale(65));
        make.width.height.mas_greaterThanOrEqualTo(0);
    }];
    
    UILabel *line1 = [[UILabel alloc]init];
    line1.backgroundColor = CZColorCreater(243, 243, 243, 1);
    line1.text = @"";
    [infoView addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(infoView);
        make.height.mas_equalTo(ScreenScale(1));
        make.top.mas_equalTo(nameTitle.mas_bottom).offset(ScreenScale(35));
    }];
    
    UILabel *orderNumTitle = [[UILabel alloc]init];
    orderNumTitle.font = [UIFont systemFontOfSize:ScreenScale(28)];
    orderNumTitle.text = @"订单号";
    orderNumTitle.textColor = CZColorCreater(53, 53, 53, 1);
    [infoView addSubview:orderNumTitle];
    [orderNumTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(infoView.mas_leading).offset(ScreenScale(30));
        make.top.mas_equalTo(nameTitle.mas_bottom).offset(ScreenScale(65));
        make.width.height.mas_greaterThanOrEqualTo(0);
    }];
    
    UIImageView *arrow = [[UIImageView alloc]init];
    arrow.image = [CZImageProvider imageNamed:@"zhu_ye_you_jian_tou"];
    [infoView addSubview:arrow];
    [arrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(infoView.mas_trailing).offset(-ScreenScale(30));
        make.size.mas_equalTo(arrow.image.size);
        make.centerY.mas_equalTo(phoneTitle);
    }];
    
    self.phoneLab = [[UILabel alloc]init];
    self.phoneLab.font = [UIFont systemFontOfSize:ScreenScale(30)];
    self.phoneLab.textColor = CZColorCreater(122, 122, 122, 1);
    self.phoneLab.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"userPhone"];
    self.phoneLab.userInteractionEnabled = YES;
    [self.phoneLab addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickPhone)]];
    [infoView addSubview:self.phoneLab];
    [self.phoneLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(infoView.mas_trailing).offset(-ScreenScale(54));
        make.centerY.mas_equalTo(phoneTitle);
        make.leading.mas_equalTo(phoneTitle.mas_trailing).offset(ScreenScale(30));
        make.height.mas_greaterThanOrEqualTo(0);
    }];
    
    self.nameLab = [[UILabel alloc]init];
    self.nameLab.font = [UIFont systemFontOfSize:ScreenScale(30)];
    self.nameLab.textColor = CZColorCreater(122, 122, 122, 1);
    self.nameLab.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"realName"];
    [infoView addSubview:self.nameLab];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(infoView.mas_trailing).offset(-ScreenScale(30));
        make.centerY.mas_equalTo(nameTitle);
        make.leading.mas_equalTo(nameTitle.mas_trailing).offset(-ScreenScale(30));
        make.height.mas_greaterThanOrEqualTo(0);
    }];
    
    self.orderNumLab = [[UILabel alloc]init];
    self.orderNumLab.font = [UIFont systemFontOfSize:ScreenScale(30)];
    self.orderNumLab.textColor = CZColorCreater(122, 122, 122, 1);
    self.orderNumLab.text = @"-";
    [infoView addSubview:self.orderNumLab];
    [self.orderNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(infoView.mas_trailing).offset(-ScreenScale(30));
        make.centerY.mas_equalTo(orderNumTitle);
        make.leading.mas_equalTo(orderNumTitle.mas_trailing).offset(-ScreenScale(30));
        make.height.mas_greaterThanOrEqualTo(0);
    }];
    
    self.sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.sureBtn setTitle:@"确认" forState:UIControlStateNormal];
    [self.sureBtn setTitleColor:CZColorCreater(255, 255, 255, 1) forState:UIControlStateNormal];
    [self.sureBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:ScreenScale(32)]];
    [self.sureBtn setBackgroundColor:CZColorCreater(51, 172, 253, 1)];
    [self.sureBtn addTarget:self action:@selector(clickSureBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.sureBtn];
    [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.view.mas_leading).offset(ScreenScale(30));
        make.trailing.mas_equalTo(self.view.mas_trailing).offset(-ScreenScale(30));
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-ScreenScale(160));
        make.height.mas_equalTo(ScreenScale(94));
    }];
}
//返回
-(void)actionForBack{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
