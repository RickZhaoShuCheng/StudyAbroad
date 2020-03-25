//
//  ActivityDetailVC.m
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/24.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "ActivityDetailVC.h"
#import "ActivityDetailScrollView.h"
#import "ActivityDetailTableView.h"

@interface ActivityDetailVC ()
@property (nonatomic ,strong) UIButton *backBtn;
@property (nonatomic ,strong) UIButton *shareBtn;
@property (nonatomic ,strong) UIButton *loveBtn;
@property (nonatomic ,strong) UILabel *titleLab;
@property (nonatomic ,strong) ActivityDetailScrollView *scrollView;
@property (nonatomic ,strong) ActivityDetailTableView *tableView;
@property (nonatomic ,assign) CGFloat alpha;
@property (nonatomic ,strong) UIView *bottomView;
@property (nonatomic ,strong) UIButton *serviceBtn;
@property (nonatomic ,strong) UIButton *cartBtn;
@property (nonatomic ,strong) UILabel *cartCountLab;



@property (nonatomic ,strong) UIView *freeBottomView;
@end

@implementation ActivityDetailVC
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (self.scrollView.superview) {
        [self.scrollView.cycleView stopTimer];
    }
    if (self.tableView.superview) {
        [self.tableView.headerView.cycleView stopTimer];
    }
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar.subviews.firstObject setAlpha:self.alpha];
    if (self.scrollView.superview) {
        [self.scrollView.cycleView startTimer];
        [self.scrollView.cycleView adjustWhenControllerViewWillAppera];
    }
    
    if (self.tableView.superview) {
        [self.tableView.headerView.cycleView startTimer];
        [self.tableView.headerView.cycleView adjustWhenControllerViewWillAppera];
    }
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
//        if (offsetY < (header - NaviH) && offsetY >= 0) {
//            //当视图滑动的距离小于header时
//            weakSelf.collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
//        }else if(weakSelf.collectionView.contentOffset.y >= (header - NaviH)){
//            //当视图滑动的距离大于header时，这里就可以设置section1的header的位置啦，设置的时候要考虑到导航栏的透明对滚动视图的影响
//            weakSelf.collectionView.contentInset = UIEdgeInsetsMake(NaviH, 0, 0, 0);
//        }
    }];

    //滚动时设置导航条透明度
    [self.tableView setScrollContentSize:^(CGFloat offsetY) {
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
//        if (offsetY < (header - NaviH) && offsetY >= 0) {
//            //当视图滑动的距离小于header时
//            weakSelf.collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
//        }else if(weakSelf.collectionView.contentOffset.y >= (header - NaviH)){
//            //当视图滑动的距离大于header时，这里就可以设置section1的header的位置啦，设置的时候要考虑到导航栏的透明对滚动视图的影响
//            weakSelf.collectionView.contentInset = UIEdgeInsetsMake(NaviH, 0, 0, 0);
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
  
    self.bottomView = [[UIView alloc]init];
    self.bottomView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.bottom.trailing.mas_equalTo(self.view);
        // 如果是刘海屏
        if (IPHONE_X) {
            make.height.mas_equalTo(ScreenScale(100) + kBottomSafeHeight);
        }else{
            make.height.mas_equalTo(ScreenScale(100));
        }
    }];
    
    self.serviceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.serviceBtn setBackgroundColor:[UIColor yellowColor]];
    [self.serviceBtn setTitle:@"客服" forState:UIControlStateNormal];
    [self.serviceBtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.serviceBtn setTitleColor:CZColorCreater(9, 9, 9, 1) forState:UIControlStateNormal];
    [self.serviceBtn.titleLabel setFont:[UIFont systemFontOfSize:ScreenScale(22)]];
    [self.serviceBtn setImage:[CZImageProvider imageNamed:@"kefu"] forState:UIControlStateNormal];
    [self.serviceBtn setImageEdgeInsets:UIEdgeInsetsMake(-ScreenScale(40), ScreenScale(25), 0, 0)];
    [self.serviceBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -ScreenScale(40), -ScreenScale(20), 0)];
    [self.bottomView addSubview:self.serviceBtn];
    [self.serviceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.mas_equalTo(self.bottomView);
        make.width.mas_equalTo(ScreenScale(124));
        make.height.mas_equalTo(ScreenScale(100));
    }];
    
    self.cartBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.cartBtn setTitle:@"购物车" forState:UIControlStateNormal];
    [self.cartBtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.cartBtn setTitleColor:CZColorCreater(9, 9, 9, 1) forState:UIControlStateNormal];
    [self.cartBtn.titleLabel setFont:[UIFont systemFontOfSize:ScreenScale(22)]];
    [self.cartBtn setImage:[CZImageProvider imageNamed:@"gouwuche"] forState:UIControlStateNormal];
    [self.bottomView addSubview:self.cartBtn];
    [self.cartBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bottomView);
        make.width.mas_equalTo(ScreenScale(124));
        make.leading.mas_equalTo(self.serviceBtn.mas_trailing);
        make.height.mas_equalTo(ScreenScale(100));
    }];
    
    self.cartCountLab = [[UILabel alloc]init];
    self.cartCountLab.font = [UIFont systemFontOfSize:ScreenScale(20)];
    self.cartCountLab.textColor = CZColorCreater(255, 255, 255, 1);
    self.cartCountLab.text = @"12";
    self.cartCountLab.textAlignment = NSTextAlignmentCenter;
    self.cartCountLab.layer.masksToBounds = YES;
    self.cartCountLab.layer.cornerRadius = ScreenScale(30)/2.0;
    self.cartCountLab.backgroundColor = CZColorCreater(255, 68, 85, 1);
    [self.cartBtn addSubview:self.cartCountLab];
    [self.cartCountLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.top.mas_equalTo(self.cartBtn);
        make.size.mas_equalTo(ScreenScale(30));
    }];
    
}

- (void)setIsEnd:(BOOL)isEnd{
    _isEnd = isEnd;
    if (isEnd) {
        if (_scrollView) {
            [self.scrollView removeFromSuperview];
        }
        [self.view addSubview:self.tableView];
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.mas_equalTo(self.view);
            make.top.mas_equalTo(self.view.mas_top).offset(-NaviH);
            // 如果是刘海屏
            if (IPHONE_X) {
                make.bottom.mas_equalTo(self.view.mas_bottom).offset(-(ScreenScale(100) + kBottomSafeHeight));
            }else{
                make.bottom.mas_equalTo(self.view.mas_bottom).offset(-ScreenScale(100));
            }
        }];
    }else{
        if (_tableView) {
            [self.tableView removeFromSuperview];
        }
        [self.view addSubview:self.scrollView];
        [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.mas_equalTo(self.view);
            make.top.mas_equalTo(self.view.mas_top).offset(-NaviH);
            // 如果是刘海屏
            if (IPHONE_X) {
                make.bottom.mas_equalTo(self.view.mas_bottom).offset(-(ScreenScale(100) + kBottomSafeHeight));
            }else{
                make.bottom.mas_equalTo(self.view.mas_bottom).offset(-ScreenScale(100));
            }
        }];
    }
}

- (ActivityDetailScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[ActivityDetailScrollView alloc]initWithFrame:CGRectZero];
    }
    return _scrollView;
}

- (ActivityDetailTableView *)tableView{
    if (!_tableView) {
        _tableView = [[ActivityDetailTableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    }
    return _tableView;
}

//返回
-(void)actionForBack{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)rbackItemClick{
    
}
@end
