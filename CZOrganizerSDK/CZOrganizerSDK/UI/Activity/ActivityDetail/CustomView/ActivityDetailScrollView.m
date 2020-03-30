//
//  ActivityDetailScrollView.m
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/24.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "ActivityDetailScrollView.h"
#import <WebKit/WebKit.h>

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
        self.backgroundColor = [UIColor whiteColor];
        [self initWithUI];
        NSMutableArray *imgArr = [NSMutableArray arrayWithObjects:
        @"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=2261487146,3191619974&fm=26&gp=0.jpg",
        @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1584214058429&di=3b61a48930e0edaf6edfbefe6d84dcc9&imgtype=jpg&src=http%3A%2F%2Fimg4.imgtn.bdimg.com%2Fit%2Fu%3D1510410409%2C1802478552%26fm%3D214%26gp%3D0.jpg",
        @"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=228295424,1615952080&fm=26&gp=0.jpg",
        nil];
        self.cycleView.imageURLStringsGroup = imgArr;
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]]];
    }
    return self;
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
        self.nameLab.text = @"零基础达流利生活口语零基础达流利生活口语零基础达流利生活口语";
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
        self.priceLab.text = @"¥7728";
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
        self.sessionLab.text = @"2019-12-19 20:00-21:00";
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
        self.crowdLab.text = @"适合人群：高中生及以上";
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
        self.organizerLab.text = @"组织机构：留学之家&南京航空航天大学";
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
        self.addressLab.text = @"地       址：南京航空航天大学（将军路校区）大学生活动中心生活动中心生活动中心";
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
    
    self.contentSize = CGSizeMake(kScreenWidth, webView.frame.origin.y + contentHeight);
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
