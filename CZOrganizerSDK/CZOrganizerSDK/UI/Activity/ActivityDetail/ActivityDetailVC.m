//
//  ActivityDetailVC.m
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/24.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "ActivityDetailVC.h"
#import "ActivityDetailScrollView.h"

@interface ActivityDetailVC ()
@property (nonatomic ,strong) UIButton *backBtn;
@property (nonatomic ,strong) UIButton *shareBtn;
@property (nonatomic ,strong) UIButton *loveBtn;
@property (nonatomic ,strong) UILabel *titleLab;
@property (nonatomic ,strong) ActivityDetailScrollView *scrollView;
@property (nonatomic ,assign) CGFloat alpha;
@end

@implementation ActivityDetailVC
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.scrollView.cycleView stopTimer];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.scrollView.cycleView startTimer];
    [self.scrollView.cycleView adjustWhenControllerViewWillAppera];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.alpha = 0.0;
    [self initWithUI];
    [self addActionHandle];
}

- (void)addActionHandle{
    WEAKSELF
    //滚动时设置导航条透明度
    [self.scrollView setScrollContentSize:^(CGFloat offsetY) {
        //设置渐变透明度
        CGFloat alpha = (offsetY / NaviH)>0.99?0.99:(offsetY / NaviH);
        weakSelf.alpha = alpha;
        [weakSelf.navigationController.navigationBar.subviews.firstObject setAlpha:alpha];
        weakSelf.titleLab.alpha = alpha;
        weakSelf.titleLab.textColor = [UIColor blackColor];
        if (alpha >0.5) {
            [weakSelf.backBtn setImage:[CZImageProvider imageNamed:@"tong_yong_fan_hui"] forState:UIControlStateNormal];
            [weakSelf.shareBtn setImage:[CZImageProvider imageNamed:@"heise_fenxiang"] forState:UIControlStateNormal];
            [weakSelf.loveBtn setImage:[CZImageProvider imageNamed:@"xingxing_heise"] forState:UIControlStateNormal];
        }else{
            [weakSelf.backBtn setImage:[CZImageProvider imageNamed:@"baise_fanhui"] forState:UIControlStateNormal];
            [weakSelf.shareBtn setImage:[CZImageProvider imageNamed:@"guwen_fenxiang"] forState:UIControlStateNormal];
            [weakSelf.loveBtn setImage:[CZImageProvider imageNamed:@"xingxing_baise"] forState:UIControlStateNormal];
        }
//        //悬浮
//        CGFloat header = weakSelf.collectionView.headerView.frame.size.height;//这个header其实是section1 的header到顶部的距离（一般为: tableHeaderView的高度）
//        if (offsetY < (header - (NaviH+StatusBarHeight+5)) && offsetY >= 0) {
//            //当视图滑动的距离小于header时
//            weakSelf.collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
//        }else if(weakSelf.collectionView.contentOffset.y >= (header - (NaviH+StatusBarHeight+5))){
//            //当视图滑动的距离大于header时，这里就可以设置section1的header的位置啦，设置的时候要考虑到导航栏的透明对滚动视图的影响
//            weakSelf.collectionView.contentInset = UIEdgeInsetsMake(NaviH+StatusBarHeight+5, 0, 0, 0);
//        }
    }];
}

/**
 * 初始化UI
 */
- (void)initWithUI{
    
    self.view.backgroundColor = [UIColor whiteColor];
    //返回按钮
    self.backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];//baise_fanhui  tong_yong_fan_hui
    [self.backBtn setImage:[CZImageProvider imageNamed:@"baise_fanhui"] forState:UIControlStateNormal];
    [self.backBtn addTarget:self action:@selector(actionForBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:self.backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    UIView *rightView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 80, 40)];
    //右边按钮
    self.shareBtn = [[UIButton alloc]initWithFrame:CGRectMake(40, 0, 40, 40)];//heise_fenxiang@2x   guwen_fenxiang
    [self.shareBtn setImage:[CZImageProvider imageNamed:@"guwen_fenxiang"] forState:UIControlStateNormal];
    [self.shareBtn addTarget:self action:@selector(rbackItemClick) forControlEvents:UIControlEventTouchUpInside];
    [rightView addSubview:self.shareBtn];
    //右边按钮
    self.loveBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];//xingxing_heise   xingxing_baise@2x
    [self.loveBtn setImage:[CZImageProvider imageNamed:@"xingxing_baise"] forState:UIControlStateNormal];
    [self.loveBtn addTarget:self action:@selector(rbackItemClick) forControlEvents:UIControlEventTouchUpInside];
    [rightView addSubview:self.loveBtn];
    
    UIBarButtonItem *rbackItem = [[UIBarButtonItem alloc]initWithCustomView:rightView];
    self.navigationItem.rightBarButtonItem = rbackItem;
    
    self.titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    self.titleLab.textAlignment = NSTextAlignmentCenter;
    self.titleLab.textColor = [UIColor clearColor];
    self.titleLab.text = @"        活动详情";
    [self.navigationItem setTitleView:self.titleLab];
    
    //导航透明
    self.edgesForExtendedLayout = UIRectEdgeTop;
//    self.navigationController.navigationBar.translucent = YES;
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar.subviews.firstObject setAlpha:0.0];
    
    
    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-ScreenScale(100));
        make.top.mas_equalTo(self.view.mas_top).offset(-(NaviH+StatusBarHeight+5));
    }];
}

- (ActivityDetailScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[ActivityDetailScrollView alloc]initWithFrame:CGRectZero];
    }
    return _scrollView;
}

//返回
-(void)actionForBack{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)rbackItemClick{
    
}
@end
