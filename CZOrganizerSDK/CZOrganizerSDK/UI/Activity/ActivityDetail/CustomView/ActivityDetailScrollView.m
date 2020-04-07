//
//  ActivityDetailScrollView.m
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/24.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "ActivityDetailScrollView.h"
#import <WebKit/WebKit.h>
#import "NSDate+Utils.h"

@interface ActivityDetailScrollView()<UIScrollViewDelegate,SDCycleScrollViewDelegate,WKNavigationDelegate>
@property (nonatomic ,strong) UILabel *nameLab;
@property (nonatomic ,strong) UILabel *priceLab;
@property (nonatomic ,strong) UILabel *sessionLab;
@property (nonatomic ,strong) UILabel *crowdLab;
@property (nonatomic ,strong) UILabel *organizerLab;
@property (nonatomic ,strong) UILabel *addressLab;
@property (nonatomic ,strong) WKWebView *webView;
@end
@implementation ActivityDetailScrollView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        self.bounces = YES;
        self.backgroundColor = [UIColor whiteColor];
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
    
    if (model.activitySessionList.count >= 1) {
        CZActivitySession *session =  model.activitySessionList[0];
        NSString *beginTime = [NSDate stringYearMonthDayWithDate:[NSDate dateWithTimeIntervalSince1970:[session.beginTime integerValue]/1000]];
        NSString *endTime = [NSDate stringYearMonthDayWithDate:[NSDate dateWithTimeIntervalSince1970:[session.endTime integerValue]/1000]];
        self.sessionLab.text = [NSString stringWithFormat:@"%@ %@",beginTime,endTime];
    }else{
        
    }
    self.crowdLab.text = [NSString stringWithFormat:@"适合人群：%@",model.extRangeUser];
    self.organizerLab.text = [NSString stringWithFormat:@"组织机构：%@",model.extOrganization];
    self.addressLab.text = [NSString stringWithFormat:@"地       址：%@",model.extAddress];
    [self.webView loadHTMLString:model.desc baseURL:nil];
}

/**
 * 初始化UI
 */
- (void)initWithUI{
    self.cycleView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth) delegate:self placeholderImage:nil];
    self.cycleView.backgroundColor = [UIColor whiteColor];
    self.cycleView.showPageControl = YES;
    [self addSubview:self.cycleView];
    
    //标题
    {
        self.nameLab = [[UILabel alloc]init];
        self.nameLab.font = [UIFont boldSystemFontOfSize:ScreenScale(32)];
        self.nameLab.textColor = CZColorCreater(51, 51, 51, 1);
        self.nameLab.text = @"-";
        [self addSubview:self.nameLab];
        [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(self).offset(ScreenScale(30));
            make.top.mas_equalTo(self.cycleView.mas_bottom).offset(ScreenScale(30));
            make.width.mas_lessThanOrEqualTo(kScreenWidth-ScreenScale(60));
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
            make.width.mas_lessThanOrEqualTo(kScreenWidth-ScreenScale(60));
            make.height.mas_greaterThanOrEqualTo(0);
        }];
    }
    
    UILabel *line = [[UILabel alloc]init];
    line.backgroundColor = CZColorCreater(245, 245, 249, 1);
    line.text = @"";
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self);
        make.width.mas_equalTo(kScreenWidth);
        make.height.mas_equalTo(ScreenScale(22));
        make.top.mas_equalTo(self.priceLab.mas_bottom).offset(ScreenScale(30));
    }];
    //活动场次
    {
        UILabel *sessionTitle = [[UILabel alloc]init];
        sessionTitle.font = [UIFont boldSystemFontOfSize:ScreenScale(30)];
        sessionTitle.textColor = CZColorCreater(0, 0, 0, 1);
        sessionTitle.text = @"活动场次";
        [self addSubview:sessionTitle];
        [sessionTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(self.mas_leading).offset(ScreenScale(30));
            make.width.height.mas_greaterThanOrEqualTo(0);
            make.top.mas_equalTo(line.mas_bottom).offset(ScreenScale(30));
        }];
        
        self.sessionLab = [[UILabel alloc]init];
        self.sessionLab.font = [UIFont systemFontOfSize:ScreenScale(22)];
        self.sessionLab.textColor = CZColorCreater(129, 129, 146, 1);
        self.sessionLab.text = @"-";
        [self addSubview:self.sessionLab];
        [self.sessionLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(self).offset(ScreenScale(30));
            make.top.mas_equalTo(sessionTitle.mas_bottom).offset(ScreenScale(30));
            make.width.mas_lessThanOrEqualTo(kScreenWidth-ScreenScale(60));
            make.height.mas_greaterThanOrEqualTo(0);
        }];
        
        UILabel *line1 = [[UILabel alloc]init];
        line1.backgroundColor = CZColorCreater(76, 182, 253, 1);
        line1.text = @"";
        [self addSubview:line1];
        [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(self);
            make.width.mas_equalTo(ScreenScale(8));
            make.height.mas_equalTo(ScreenScale(26));
            make.centerY.mas_equalTo(sessionTitle);
        }];
    }
    
    UILabel *line2 = [[UILabel alloc]init];
    line2.backgroundColor = CZColorCreater(245, 245, 249, 1);
    line2.text = @"";
    [self addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self);
        make.width.mas_equalTo(kScreenWidth);
        make.height.mas_equalTo(ScreenScale(22));
        make.top.mas_equalTo(self.sessionLab.mas_bottom).offset(ScreenScale(30));
    }];
    
    //活动描述
    {
        UIImageView *crowdImg = [[UIImageView alloc]initWithImage:[CZImageProvider imageNamed:@"huodong_renqun"]];
        [self addSubview:crowdImg];
        [crowdImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(self.mas_leading).offset(ScreenScale(30));
            make.size.mas_equalTo(crowdImg.image.size);
            make.top.mas_equalTo(line2.mas_bottom).offset(ScreenScale(30));
        }];
        
        self.crowdLab = [[UILabel alloc]init];
        self.crowdLab.font = [UIFont systemFontOfSize:ScreenScale(24)];
        self.crowdLab.textColor = CZColorCreater(129, 129, 146, 1);
        self.crowdLab.text = @"适合人群：-";
        [self addSubview:self.crowdLab];
        [self.crowdLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(self.mas_leading).offset(ScreenScale(70));
            make.height.mas_greaterThanOrEqualTo(0);
            make.centerY.mas_equalTo(crowdImg);
            make.width.mas_equalTo(kScreenWidth-ScreenScale(100));
        }];
        
        UILabel *line3 = [[UILabel alloc]init];
        line3.backgroundColor = CZColorCreater(243, 243, 247, 1);
        line3.text = @"";
        [self addSubview:line3];
        [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(crowdImg.mas_leading);
            make.width.mas_equalTo(kScreenWidth-ScreenScale(60));
            make.height.mas_equalTo(ScreenScale(1));
            make.top.mas_equalTo(crowdImg.mas_bottom).offset(ScreenScale(30));
        }];
        
        UIImageView *organizerImg = [[UIImageView alloc]initWithImage:[CZImageProvider imageNamed:@"huodong_zuzhi"]];
        [self addSubview:organizerImg];
        [organizerImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(self.mas_leading).offset(ScreenScale(30));
            make.size.mas_equalTo(organizerImg.image.size);
            make.top.mas_equalTo(line3.mas_bottom).offset(ScreenScale(30));
        }];
        
        self.organizerLab = [[UILabel alloc]init];
        self.organizerLab.font = [UIFont systemFontOfSize:ScreenScale(24)];
        self.organizerLab.textColor = CZColorCreater(129, 129, 146, 1);
        self.organizerLab.text = @"组织机构：-";
        [self addSubview:self.organizerLab];
        [self.organizerLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(self.mas_leading).offset(ScreenScale(70));
            make.height.mas_greaterThanOrEqualTo(0);
            make.centerY.mas_equalTo(organizerImg);
            make.width.mas_equalTo(kScreenWidth-ScreenScale(100));
        }];
        
        UILabel *line4 = [[UILabel alloc]init];
        line4.backgroundColor = CZColorCreater(243, 243, 247, 1);
        line4.text = @"";
        [self addSubview:line4];
        [line4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(crowdImg.mas_leading);
            make.width.mas_equalTo(kScreenWidth-ScreenScale(60));
            make.height.mas_equalTo(ScreenScale(1));
            make.top.mas_equalTo(organizerImg.mas_bottom).offset(ScreenScale(30));
        }];
        
        UIImageView *addressImg = [[UIImageView alloc]initWithImage:[CZImageProvider imageNamed:@"huodong_dizhi"]];
        [self addSubview:addressImg];
        [addressImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(self.mas_leading).offset(ScreenScale(30));
            make.size.mas_equalTo(addressImg.image.size);
            make.top.mas_equalTo(line4.mas_bottom).offset(ScreenScale(30));
        }];
        
        self.addressLab = [[UILabel alloc]init];
        self.addressLab.font = [UIFont systemFontOfSize:ScreenScale(24)];
        self.addressLab.textColor = CZColorCreater(129, 129, 146, 1);
        self.addressLab.text = @"地       址：-";
        [self addSubview:self.addressLab];
        [self.addressLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(self.mas_leading).offset(ScreenScale(70));
            make.height.mas_greaterThanOrEqualTo(0);
            make.centerY.mas_equalTo(addressImg);
            make.width.mas_equalTo(kScreenWidth-ScreenScale(100));
        }];
    }
    
    UILabel *line5 = [[UILabel alloc]init];
    line5.backgroundColor = CZColorCreater(245, 245, 249, 1);
    line5.text = @"";
    [self addSubview:line5];
    [line5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self);
        make.width.mas_equalTo(kScreenWidth);
        make.height.mas_equalTo(ScreenScale(22));
        make.top.mas_equalTo(self.addressLab.mas_bottom).offset(ScreenScale(30));
    }];
    
    UILabel *detailTitle = [[UILabel alloc]init];
    detailTitle.font = [UIFont boldSystemFontOfSize:ScreenScale(30)];
    detailTitle.textColor = CZColorCreater(0, 0, 0, 1);
    detailTitle.text = @"活动详情";
    [self addSubview:detailTitle];
    [detailTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.mas_leading).offset(ScreenScale(30));
        make.width.height.mas_greaterThanOrEqualTo(0);
        make.top.mas_equalTo(line5.mas_bottom).offset(ScreenScale(30));
    }];
    
    UILabel *line6 = [[UILabel alloc]init];
    line6.backgroundColor = CZColorCreater(76, 182, 253, 1);
    line6.text = @"";
    [self addSubview:line6];
    [line6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self);
        make.width.mas_equalTo(ScreenScale(8));
        make.height.mas_equalTo(ScreenScale(26));
        make.centerY.mas_equalTo(detailTitle);
    }];
    
    self.webView = [[WKWebView alloc]init];
    self.webView.navigationDelegate = self;
    self.webView.scrollView.scrollEnabled = NO;
    self.webView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self);
        make.width.mas_equalTo(kScreenWidth);
        make.top.mas_equalTo(detailTitle.mas_bottom).offset(ScreenScale(30));
        make.height.mas_equalTo(kScreenHeight);
    }];
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation{
    CGFloat contentHeight = self.webView.scrollView.contentSize.height;
    if (contentHeight == 0) {
        self.contentSize = CGSizeMake(kScreenWidth, webView.frame.origin.y + ScreenScale(80));
    }else{
        self.contentSize = CGSizeMake(kScreenWidth, webView.frame.origin.y + contentHeight);
    }
    [self.webView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(contentHeight);
    }];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.scrollContentSize) {
        self.scrollContentSize(scrollView.contentOffset.y);
    }
}
@end
