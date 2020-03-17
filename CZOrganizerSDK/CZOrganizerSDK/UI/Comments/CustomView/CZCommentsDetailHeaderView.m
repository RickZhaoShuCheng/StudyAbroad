



//
//  CZCommentsDetailHeaderView.m
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/15.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZCommentsDetailHeaderView.h"
#import "UIImageView+WebCache.h"
#import "CZRankView.h"


@interface CZCommentsDetailHeaderView()<SDCycleScrollViewDelegate>
@property (nonatomic ,strong) UILabel *imgCountLab;
@property (nonatomic ,strong) UIImageView *avatarView;
@property (nonatomic ,strong) UILabel *nameLab;
@property (nonatomic ,strong) UILabel *browseLab;
@property (nonatomic ,strong) UILabel *timeLab;
@property (nonatomic ,strong) UILabel *contentLab;
@property (nonatomic ,strong) CZRankView *rankView;
@property (nonatomic ,strong) UILabel *tipsLab;
@property (nonatomic ,strong) UILabel *evaluateLab;
@property (nonatomic ,strong) UIImageView *goodsImg;
@property (nonatomic ,strong) UILabel *goodsName;
@property (nonatomic ,strong) UILabel *organizerName;
@property (nonatomic ,strong) UILabel *priceLab;
@property (nonatomic ,strong) UILabel *oldPriceLab;
@property (nonatomic ,strong) UILabel *countLab;
@end
@implementation CZCommentsDetailHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self initWithUI];
        [self.avatarView sd_setImageWithURL:[NSURL URLWithString:@"http://pics2.baidu.com/feed/6f061d950a7b0208861260d9c2b4e9d5562cc8a7.png?token=a660efbc8f229953136baa823633d889&s=9F1405CE8E9000D4F395A8BA0300D011"] placeholderImage:nil];
        [self.goodsImg sd_setImageWithURL:[NSURL URLWithString:@"https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1782152781,1392496249&fm=26&gp=0.jpg"] placeholderImage:nil];
    }
    return self;
}

- (void)setImgArr:(NSMutableArray *)imgArr{
    if (imgArr.count <= 0) {
        return;
    }
    self.cycleScrollView.imageURLStringsGroup = imgArr;
    NSString *tempStr = [NSString stringWithFormat:@"1/%lu",(unsigned long)imgArr.count];
    NSMutableAttributedString *imgCount = [[NSMutableAttributedString alloc]initWithString:tempStr];
    [imgCount addAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:ScreenScale(24)]} range:NSMakeRange(0, 1)];
    [imgCount addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:ScreenScale(20)]} range:NSMakeRange(1, tempStr.length - 1)];
    self.imgCountLab.attributedText = imgCount;
}

/**
 * 初始化UI
 */
- (void)initWithUI{
    self.cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth) delegate:self placeholderImage:nil];
    self.cycleScrollView.backgroundColor = [UIColor whiteColor];
    self.cycleScrollView.showPageControl = NO;
    [self addSubview:self.cycleScrollView];
    
    self.imgCountLab = [[UILabel alloc]init];
    self.imgCountLab.backgroundColor = CZColorCreater(0, 0, 0, 0.5);
    self.imgCountLab.layer.masksToBounds = YES;
    self.imgCountLab.layer.cornerRadius = ScreenScale(36)/2.0;
    self.imgCountLab.textColor = [UIColor whiteColor];
    self.imgCountLab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.imgCountLab];
    [self.imgCountLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self.mas_trailing).offset(-ScreenScale(30));
        make.bottom.mas_equalTo(self.cycleScrollView.mas_bottom).offset(-ScreenScale(20));
        make.width.mas_greaterThanOrEqualTo(ScreenScale(80));
        make.height.mas_equalTo(ScreenScale(36));
    }];
    
    self.avatarView = [[UIImageView alloc]init];
    self.avatarView.layer.masksToBounds = YES;
    self.avatarView.layer.cornerRadius = ScreenScale(70)/2;
    [self addSubview:self.avatarView];
    [self.avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.mas_leading).offset(ScreenScale(30));
        make.top.mas_equalTo(self.cycleScrollView.mas_bottom).offset(ScreenScale(32));
        make.size.mas_equalTo(ScreenScale(70));
    }];
    
    self.browseLab = [[UILabel alloc]init];
    self.browseLab.textColor = CZColorCreater(159, 159, 178, 1);
    self.browseLab.font = [UIFont systemFontOfSize:ScreenScale(22)];
    self.browseLab.text = @"浏览1522";
    [self addSubview:self.browseLab];
    
    self.nameLab = [[UILabel alloc]init];
    self.nameLab.textColor = CZColorCreater(32, 32, 32, 1);
    self.nameLab.font = [UIFont boldSystemFontOfSize:ScreenScale(26)];
    self.nameLab.text = @"百世可乐";
    [self addSubview:self.nameLab];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.avatarView.mas_trailing).offset(ScreenScale(20));
        make.top.mas_equalTo(self.avatarView);
        make.trailing.mas_equalTo(self.browseLab.mas_leading).offset(-ScreenScale(20)).priorityLow();
        make.height.mas_greaterThanOrEqualTo(0);
    }];
    
    [self.browseLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self.mas_trailing).offset(-ScreenScale(30));
        make.centerY.mas_equalTo(self.nameLab);
        make.width.height.mas_greaterThanOrEqualTo(0);
    }];
    
    self.timeLab = [[UILabel alloc]init];
    self.timeLab.textColor = CZColorCreater(159, 159, 178, 1);
    self.timeLab.font = [UIFont systemFontOfSize:ScreenScale(22)];
    self.timeLab.text = @"6小时前";
    [self addSubview:self.timeLab];
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.avatarView.mas_trailing).offset(ScreenScale(20));
        make.bottom.mas_equalTo(self.avatarView);
        make.height.width.mas_greaterThanOrEqualTo(0);
    }];
    
    self.contentLab = [[UILabel alloc]init];
    self.contentLab.textColor = CZColorCreater(51, 51, 51, 1);
    self.contentLab.font = [UIFont systemFontOfSize:ScreenScale(26)];
    self.contentLab.text = @"力学课内全部内容及相关自招考试内容掌握热学电学的基础内容，培养完整的抽象思维方式";
    self.contentLab.numberOfLines = 0;
    [self addSubview:self.contentLab];
    [self.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.mas_leading).offset(ScreenScale(30));
        make.height.mas_greaterThanOrEqualTo(0);
        make.top.mas_equalTo(self.avatarView.mas_bottom).offset(ScreenScale(25));
        make.trailing.mas_equalTo(self.mas_trailing).offset(-ScreenScale(30));
    }];
    
    self.rankView = [CZRankView instanceRankViewByRate:3.1];
    [self addSubview:self.rankView];
    [self.rankView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(ScreenScale(150));
        make.leading.mas_equalTo(self.mas_leading).offset(ScreenScale(30));
        make.top.mas_equalTo(self.contentLab.mas_bottom).offset(ScreenScale(30));
        make.height.mas_equalTo(ScreenScale(28));
    }];
    
    self.tipsLab = [[UILabel alloc]init];
    self.tipsLab.font = [UIFont systemFontOfSize:ScreenScale(18)];
    self.tipsLab.textColor = CZColorCreater(51, 172, 253, 1);
    self.tipsLab.text = @"  消费后评价  ";
    self.tipsLab.layer.masksToBounds = YES;
    self.tipsLab.layer.cornerRadius = ScreenScale(3);
    self.tipsLab.layer.borderWidth = ScreenScale(1);
    self.tipsLab.layer.borderColor = CZColorCreater(51, 172, 253, 1).CGColor;
    [self addSubview:self.tipsLab];
    [self.tipsLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.rankView.mas_trailing);
        make.top.mas_equalTo(self.rankView.mas_top).offset(-ScreenScale(5));
        make.width.mas_greaterThanOrEqualTo(0);
        make.height.mas_equalTo(ScreenScale(24));
    }];
    
    self.evaluateLab = [[UILabel alloc]init];
    self.evaluateLab.font = [UIFont systemFontOfSize:ScreenScale(24)];
    self.evaluateLab.textColor = CZColorCreater(129, 129, 146, 1);
    self.evaluateLab.text = @"专业度: 4.9  服务: 4.9  价格: 4.9";
    [self addSubview:self.evaluateLab];
    [self.evaluateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.mas_leading).offset(ScreenScale(30));
        make.top.mas_equalTo(self.rankView.mas_bottom).offset(ScreenScale(10));
        make.height.mas_greaterThanOrEqualTo(0);
        make.trailing.mas_equalTo (self.mas_trailing).offset(-ScreenScale(30));
    }];
    
    UIView *goodsView = [[UIView alloc]init];
    goodsView.backgroundColor = CZColorCreater(76, 182, 253, 0.05);
    [self addSubview:goodsView];
    [goodsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.mas_leading).offset(ScreenScale(30));
        make.trailing.mas_equalTo(self.mas_trailing).offset(-ScreenScale(30));
        make.top.mas_equalTo(self.evaluateLab.mas_bottom).offset(ScreenScale(50));
        make.height.mas_equalTo(ScreenScale(186));
    }];
    
    self.goodsImg = [[UIImageView alloc]init];
    [goodsView addSubview:self.goodsImg];
    [self.goodsImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(goodsView.mas_leading).offset(ScreenScale(18));
        make.top.mas_equalTo(goodsView.mas_top).offset(ScreenScale(18));
        make.bottom.mas_equalTo(goodsView.mas_bottom).offset(-ScreenScale(18));
        make.width.mas_equalTo(self.goodsImg.mas_height);
    }];
    
    self.goodsName = [[UILabel alloc]init];
    self.goodsName.font = [UIFont systemFontOfSize:ScreenScale(26)];
    self.goodsName.textColor = CZColorCreater(0, 0, 0, 1);
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"学了就会用的思维导图课——思维导图世锦赛冠军总教练刘艳独家开讲"];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = ScreenScale(15); // 调整行间距
    NSRange range = NSMakeRange(0, [@"学了就会用的思维导图课——思维导图世锦赛冠军总教练刘艳独家开讲" length]);
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
    self.goodsName.attributedText = attributedString;
    self.goodsName.numberOfLines = 2;
    [goodsView addSubview:self.goodsName];
    [self.goodsName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.goodsImg.mas_trailing).offset(ScreenScale(20));
        make.top.mas_equalTo(self.goodsImg.mas_top);
        make.height.mas_greaterThanOrEqualTo(0);
        make.trailing.mas_equalTo (goodsView.mas_trailing).offset(-ScreenScale(30));
    }];
    
    self.organizerName = [[UILabel alloc]init];
    self.organizerName.font = [UIFont systemFontOfSize:ScreenScale(24)];
    self.organizerName.textColor = CZColorCreater( 170, 170, 187, 1);
    self.organizerName.text = @"海牛留学工作室";
    [self addSubview:self.organizerName];
    [self.organizerName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.goodsImg.mas_trailing).offset(ScreenScale(20));
        make.top.mas_equalTo(self.goodsName.mas_bottom).offset(ScreenScale(10));
        make.height.mas_greaterThanOrEqualTo(0);
        make.trailing.mas_equalTo (goodsView.mas_trailing).offset(-ScreenScale(30));
    }];
    
    
    NSString *str = @"¥1229.00";
    NSMutableAttributedString *tempStr = [[NSMutableAttributedString alloc]initWithString:str];
    [tempStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:ScreenScale(24)]} range:NSMakeRange(0, 1)];
    [tempStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:ScreenScale(30)]} range:NSMakeRange(1, str.length -1)];
    
    self.priceLab = [[UILabel alloc]init];
    self.priceLab.textColor = CZColorCreater( 255, 68, 85, 1);
    self.priceLab.attributedText = tempStr;
    [self addSubview:self.priceLab];
    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.goodsImg.mas_trailing).offset(ScreenScale(20));
        make.height.width.mas_greaterThanOrEqualTo(0);
        make.bottom.mas_equalTo(self.goodsImg.mas_bottom);
    }];
    
    NSString *str1 = @"¥1980.00";
    NSMutableAttributedString *tempStr1 = [[NSMutableAttributedString alloc]initWithString:str1];
    [tempStr1 addAttributes:@{NSStrikethroughStyleAttributeName:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle)} range:NSMakeRange(0, str1.length)];
    
    self.oldPriceLab = [[UILabel alloc]init];
    self.oldPriceLab.font = [UIFont systemFontOfSize:ScreenScale(22)];
    self.oldPriceLab.textColor = CZColorCreater( 183, 183, 196, 1);
    self.oldPriceLab.attributedText = tempStr1;
    [self addSubview:self.oldPriceLab];
    [self.oldPriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.priceLab.mas_trailing).offset(ScreenScale(16));
        make.centerY.mas_equalTo(self.priceLab);
        make.height.mas_greaterThanOrEqualTo(0);
        make.trailing.mas_equalTo (goodsView.mas_trailing).offset(-ScreenScale(30));
    }];
    
    UILabel *allCommentsLab = [[UILabel alloc]init];
    allCommentsLab.font = [UIFont boldSystemFontOfSize:ScreenScale(32)];
    allCommentsLab.textColor = CZColorCreater(9, 10, 15, 1);
    allCommentsLab.text = @"全部评论";
    [self addSubview:allCommentsLab];
    [allCommentsLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.mas_leading).offset(ScreenScale(30));
        make.top.mas_equalTo(goodsView.mas_bottom).offset(ScreenScale(48));
        make.width.height.mas_greaterThanOrEqualTo(0);
    }];
    
    self.countLab = [[UILabel alloc]init];
    self.countLab.font = [UIFont systemFontOfSize:ScreenScale(24)];
    self.countLab.textColor = CZColorCreater(129, 129, 146, 1);
    self.countLab.text = @"9条";
    [self addSubview:self.countLab];
    [self.countLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(allCommentsLab.mas_trailing).offset(ScreenScale(16));
        make.centerY.mas_equalTo(allCommentsLab);
        make.width.height.mas_greaterThanOrEqualTo(0);
    }];
    
    
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{
    
    NSString *indexStr = [NSString stringWithFormat:@"%ld",index+1];
    NSString *tempStr = [NSString stringWithFormat:@"%ld",cycleScrollView.imageURLStringsGroup.count];
    NSString *text = [NSString stringWithFormat:@"%@/%@",indexStr,tempStr];
    NSMutableAttributedString *imgCount = [[NSMutableAttributedString alloc]initWithString:text];
    [imgCount addAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:ScreenScale(24)]} range:NSMakeRange(0, indexStr.length)];
    [imgCount addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:ScreenScale(20)]} range:NSMakeRange(indexStr.length, tempStr.length + 1)];
    self.imgCountLab.attributedText = imgCount;
}
@end
