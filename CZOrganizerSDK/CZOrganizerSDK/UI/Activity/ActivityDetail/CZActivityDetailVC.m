//
//  ActivityDetailVC.m
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/24.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZActivityDetailVC.h"
#import "CZActivityDetailScrollView.h"
#import "CZActivityDetailTableView.h"
#import "CZAdvisorDetailService.h"
#import "QSCommonService.h"
#import "CZActivityModel.h"
#import "CZMJRefreshHelper.h"

@interface CZActivityDetailVC ()
@property (nonatomic ,strong) UIButton *backBtn;
@property (nonatomic ,strong) UIButton *shareBtn;
@property (nonatomic ,strong) UIButton *loveBtn;
@property (nonatomic ,strong) UILabel *titleLab;
@property (nonatomic ,strong) CZActivityDetailScrollView *scrollView;
@property (nonatomic ,strong) CZActivityDetailTableView *tableView;
@property (nonatomic ,assign) CGFloat alpha;
@property (nonatomic ,strong) UIView *bottomView;
@property (nonatomic ,strong) UIButton *serviceBtn;
@property (nonatomic ,strong) UIButton *cartBtn;
@property (nonatomic ,strong) UILabel *cartCountLab;
@property (nonatomic ,strong) UIButton *addCartBtn;
@property (nonatomic ,strong) UIButton *buyBtn;

@property (nonatomic ,strong) UIView *freeBottomView;
@property (nonatomic ,strong) UIButton *chatBtn;
@property (nonatomic ,strong) UIButton *applyBtn;

@property (nonatomic ,assign) NSInteger pageNum;
@property (nonatomic ,assign) NSInteger pageSize;

@property (nonatomic ,strong) CZActivityModel *model;

@end

@implementation CZActivityDetailVC
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
    self.pageNum = 1;
    self.pageSize = 20;
    self.alpha = 0.0;
    [self initWithUI];
    [self addActionHandle];
    [self requestForApiProductActivitySelectProductActivityInfo];
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
    
    [self.tableView setDidSelectCell:^(NSString * _Nonnull str) {
        CZActivityDetailVC *detailVC = [[CZActivityDetailVC alloc]init];
        detailVC.activityId = str;
        [weakSelf.navigationController pushViewController:detailVC animated:YES];
    }];
    
    self.tableView.mj_header = [CZMJRefreshHelper lb_headerWithAction:^{
        weakSelf.pageNum = 1;
        [weakSelf requestForApiProductActivitySelectRecommendProductActivityList];
    }];
    
    self.tableView.mj_footer = [CZMJRefreshHelper lb_footerWithAction:^{
        weakSelf.pageNum ++;
        [weakSelf requestForApiProductActivitySelectRecommendProductActivityList];
    }];
}
//获取商品详情
- (void)requestForApiProductActivitySelectProductActivityInfo{
    WEAKSELF
    CZAdvisorDetailService *service = serviceByType(QSServiceTypeAdvisorDetail);
    [service requestForApiProductActivitySelectProductActivityInfo:self.activityId callBack:^(BOOL success, NSInteger code, id  _Nonnull data, NSString * _Nonnull errorMessage) {
        if (success){
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.model = [CZActivityModel modelWithDict:data];
        
                if (weakSelf.model.status == 0) {
                    weakSelf.isEnd = YES;
                }else{
                    weakSelf.isEnd = NO;
                }
                
                if ([weakSelf.model.price floatValue] == 0.0) {
                    weakSelf.isFree = YES;
                }else{
                    weakSelf.isFree = NO;
                }
                
                if (weakSelf.isEnd) {
                    weakSelf.tableView.headerView.model = weakSelf.model;
                }else{
                    weakSelf.scrollView.model = weakSelf.model;
                }
            });
        }
    }];
}
//获取推荐活动
- (void)requestForApiProductActivitySelectRecommendProductActivityList{
    WEAKSELF
    //weakSelf.model.productCategory
    CZAdvisorDetailService *service = serviceByType(QSServiceTypeAdvisorDetail);
    [service requestForApiProductActivitySelectRecommendProductActivityList:@"" productActivityId:weakSelf.model.productActivityId pageNum:self.pageNum pageSize:self.pageSize callBack:^(BOOL success, NSInteger code, id  _Nonnull data, NSString * _Nonnull errorMessage) {
        if (success){
            dispatch_async(dispatch_get_main_queue(), ^{
                NSMutableArray *array = [[NSMutableArray alloc] init];
                for (NSDictionary *dic in data) {
                    CZActivityModel *model = [CZActivityModel modelWithDict:dic];
                    [array addObject:model];
                }
                if (weakSelf.pageNum == 1) {
                    [weakSelf.tableView.dataArr removeAllObjects];
                    [weakSelf.tableView.dataArr addObjectsFromArray:array];
                }else{
                    [weakSelf.tableView.dataArr addObjectsFromArray:array];
                }
                [weakSelf.tableView reloadData];
                if (weakSelf.pageNum == 1) {
                    [weakSelf.tableView.mj_header endRefreshing];
                }
                if (array.count < weakSelf.pageSize) {
                    [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
                }else{
                    [weakSelf.tableView.mj_footer endRefreshing];
                }
            });
        }else{
            [weakSelf.tableView.mj_header endRefreshing];
            [weakSelf.tableView.mj_footer endRefreshing];
        }
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
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar.subviews.firstObject setAlpha:0.0];
  
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
                make.bottom.mas_equalTo(self.view.mas_bottom).offset(kBottomSafeHeight);
            }else{
                make.bottom.mas_equalTo(self.view.mas_bottom);
            }
        }];
        if (_bottomView) {
            [self.bottomView removeFromSuperview];
        }
        if (_freeBottomView) {
            [self.freeBottomView removeFromSuperview];
        }
        [self requestForApiProductActivitySelectRecommendProductActivityList];
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
        if (self.isFree) {
            [self addFreeBottomView];
        }else{
            [self addBottomView];
        }
    }
}
/**
 * 添加免费底部view
 */
- (void)addFreeBottomView{
    
    if (_bottomView) {
        [self.bottomView removeFromSuperview];
    }
    self.freeBottomView = [[UIView alloc]init];
    self.freeBottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.freeBottomView];
    [self.freeBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.bottom.trailing.mas_equalTo(self.view);
        // 如果是刘海屏
        if (IPHONE_X) {
            make.height.mas_equalTo(ScreenScale(100) + kBottomSafeHeight);
        }else{
            make.height.mas_equalTo(ScreenScale(100));
        }
    }];
    
    self.chatBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.chatBtn setTitle:@"咨询" forState:UIControlStateNormal];
    [self.chatBtn.titleLabel setFont:[UIFont systemFontOfSize:ScreenScale(28)]];
    [self.chatBtn setTitleColor:CZColorCreater(0, 0, 0, 1) forState:UIControlStateNormal];
    [self.chatBtn setBackgroundColor:CZColorCreater(255, 255, 255, 1)];
    [self.chatBtn setImage:[CZImageProvider imageNamed:@"kefu"] forState:UIControlStateNormal];
    [self.chatBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -ScreenScale(20), 0, 0)];
    [self.freeBottomView addSubview:self.chatBtn];
    [self.chatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.freeBottomView.mas_leading);
        make.top.mas_equalTo(self.freeBottomView);
        make.height.mas_equalTo(ScreenScale(100));
        make.width.mas_equalTo(kScreenWidth/2.0);
    }];
    
    self.applyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.applyBtn setTitle:@"报名" forState:UIControlStateNormal];
    [self.applyBtn.titleLabel setFont:[UIFont systemFontOfSize:ScreenScale(28)]];
    [self.applyBtn setTitleColor:CZColorCreater(255, 255, 255, 1) forState:UIControlStateNormal];
    [self.applyBtn setBackgroundColor:CZColorCreater(76, 182, 253, 1)];
    [self.freeBottomView addSubview:self.applyBtn];
    [self.applyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.chatBtn.mas_trailing);
        make.top.mas_equalTo(self.freeBottomView);
        make.height.mas_equalTo(ScreenScale(100));
        make.width.mas_equalTo(kScreenWidth/2.0);
    }];
}

/**
 * 添加付费底部view
 */
- (void)addBottomView{
    
    if (_freeBottomView) {
        [self.freeBottomView removeFromSuperview];
    }
    
    self.bottomView = [[UIView alloc]init];
    self.bottomView.backgroundColor = [UIColor whiteColor];
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
    [self.serviceBtn setBackgroundColor:[UIColor whiteColor]];
    [self.serviceBtn setTitle:@"客服" forState:UIControlStateNormal];
    [self.serviceBtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.serviceBtn setTitleColor:CZColorCreater(9, 9, 9, 1) forState:UIControlStateNormal];
    [self.serviceBtn.titleLabel setFont:[UIFont systemFontOfSize:ScreenScale(22)]];
    [self.serviceBtn setImage:[CZImageProvider imageNamed:@"kefu"] forState:UIControlStateNormal];
    [self.serviceBtn setImageEdgeInsets:UIEdgeInsetsMake(-ScreenScale(30), ScreenScale(45), 0, 0)];
    [self.serviceBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -ScreenScale(35), -ScreenScale(35), 0)];
    [self.bottomView addSubview:self.serviceBtn];
    [self.serviceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.mas_equalTo(self.bottomView);
        make.width.mas_equalTo(ScreenScale(124));
        make.height.mas_equalTo(ScreenScale(100));
    }];
    
    self.cartBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.cartBtn setTitle:@"购物车" forState:UIControlStateNormal];
    [self.cartBtn setBackgroundColor:[UIColor whiteColor]];
    [self.cartBtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.cartBtn setTitleColor:CZColorCreater(9, 9, 9, 1) forState:UIControlStateNormal];
    [self.cartBtn.titleLabel setFont:[UIFont systemFontOfSize:ScreenScale(22)]];
    [self.cartBtn setImage:[CZImageProvider imageNamed:@"gouwuche"] forState:UIControlStateNormal];
    [self.cartBtn setImageEdgeInsets:UIEdgeInsetsMake(-ScreenScale(30), ScreenScale(44), 0, 0)];
    [self.cartBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -ScreenScale(35), -ScreenScale(35), 0)];
    [self.bottomView addSubview:self.cartBtn];
    [self.cartBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bottomView);
        make.width.mas_equalTo(ScreenScale(124));
        make.leading.mas_equalTo(self.serviceBtn.mas_trailing);
        make.height.mas_equalTo(ScreenScale(100));
    }];
    
    UILabel *line = [[UILabel alloc]init];
    line.text = @"";
    line.backgroundColor = CZColorCreater(241, 241, 241, 1);
    [self.bottomView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bottomView);
        make.height.mas_equalTo(ScreenScale(100));
        make.leading.mas_equalTo(self.serviceBtn.mas_trailing);
        make.width.mas_equalTo(ScreenScale(1));
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
        make.top.mas_equalTo(self.cartBtn.mas_top).offset(ScreenScale(5));
        make.size.mas_equalTo(ScreenScale(30));
        make.trailing.mas_equalTo(self.cartBtn.mas_trailing).offset(-ScreenScale(30));
    }];
    
    self.addCartBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.addCartBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
    [self.addCartBtn.titleLabel setFont:[UIFont systemFontOfSize:ScreenScale(28)]];
    [self.addCartBtn setTitleColor:CZColorCreater(255, 255, 255, 1) forState:UIControlStateNormal];
    [self.addCartBtn setBackgroundColor:CZColorCreater(137, 144, 166, 0.8)];
    [self.bottomView addSubview:self.addCartBtn];
    [self.addCartBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.cartBtn.mas_trailing);
        make.top.mas_equalTo(self.bottomView);
        make.height.mas_equalTo(ScreenScale(100));
        make.width.mas_equalTo((kScreenWidth-ScreenScale(124)*2)/2.0);
    }];
    
    self.buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.buyBtn setTitle:@"立即购买" forState:UIControlStateNormal];
    [self.buyBtn.titleLabel setFont:[UIFont systemFontOfSize:ScreenScale(28)]];
    [self.buyBtn setTitleColor:CZColorCreater(255, 255, 255, 1) forState:UIControlStateNormal];
    [self.buyBtn setBackgroundColor:CZColorCreater(255, 68, 85, 1)];
    [self.bottomView addSubview:self.buyBtn];
    [self.buyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.addCartBtn.mas_trailing);
        make.top.mas_equalTo(self.bottomView);
        make.height.mas_equalTo(ScreenScale(100));
        make.width.mas_equalTo((kScreenWidth-ScreenScale(124)*2)/2.0);
    }];
}

- (CZActivityDetailScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[CZActivityDetailScrollView alloc]initWithFrame:CGRectZero];
    }
    return _scrollView;
}

- (CZActivityDetailTableView *)tableView{
    if (!_tableView) {
        _tableView = [[CZActivityDetailTableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
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
