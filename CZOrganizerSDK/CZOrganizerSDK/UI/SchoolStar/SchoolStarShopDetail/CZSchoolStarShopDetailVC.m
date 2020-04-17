//
//  SchoolStarShopDetailVC.m
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/4/6.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZSchoolStarShopDetailVC.h"
#import "CZSchoolStarShopDetailTableView.h"
#import "UIImageView+WebCache.h"
#import "CZAdvisorDetailService.h"
#import "QSCommonService.h"
#import "CZSchoolStarModel.h"
#import "CZSchoolStarDetailVC.h"
@interface CZSchoolStarShopDetailVC ()
@property (nonatomic ,strong) UIView *titleView;
@property (nonatomic ,strong) UIImageView *avatarImg;
@property (nonatomic ,strong) UILabel *titleLab;//标题
@property (nonatomic ,strong) UIButton *focusBtn;
@property (nonatomic ,strong) UIButton *backBtn;//返回按钮
@property (nonatomic ,strong) UIButton *shareBtn;//分享按钮
@property (nonatomic ,strong) CZSchoolStarShopDetailTableView *tableView;
@property (nonatomic ,assign) CGFloat alpha;
@property (nonatomic ,strong) UIView *bottomView;
@property (nonatomic ,strong) UIButton *collectBtn;
@property (nonatomic ,strong) UIButton *contrastBtn;
@property (nonatomic ,strong) UIButton *chatBtn;

@end

@implementation CZSchoolStarShopDetailVC
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar.subviews.firstObject setAlpha:self.alpha];
    [self.titleView setAlpha:self.alpha];
    self.focusBtn.alpha = self.alpha;
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.navigationController.navigationBar.subviews.firstObject setAlpha:self.alpha];
    [self.titleView setAlpha:self.alpha];
    self.focusBtn.alpha = self.alpha;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar.subviews.firstObject setAlpha:1];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.alpha = 0;
    [self initWithUI];
    [self addHandleAction];
    [self requestForApiSportUserSelectSportUserInfo];
}

- (void)addHandleAction{
    WEAKSELF
    //滚动时设置导航条透明度
    [self.tableView setScrollContentSize:^(CGFloat offsetY) {
        //设置渐变透明度
        CGFloat alpha = (offsetY / NaviH)>0.99?0.99:(offsetY / NaviH);
        weakSelf.alpha = alpha;
        [weakSelf.navigationController.navigationBar.subviews.firstObject setAlpha:alpha];
        if (!weakSelf.titleView.superview) {
            weakSelf.navigationItem.titleView = weakSelf.titleView;
        }
        weakSelf.titleView.alpha = alpha;
        weakSelf.focusBtn.alpha = alpha;
        if (alpha >0.5) {
            [weakSelf.backBtn setImage:[CZImageProvider imageNamed:@"tong_yong_fan_hui"] forState:UIControlStateNormal];
            [weakSelf.shareBtn setImage:[CZImageProvider imageNamed:@"heise_fenxiang"] forState:UIControlStateNormal];
        }else{
            [weakSelf.backBtn setImage:[CZImageProvider imageNamed:@"baise_fanhui"] forState:UIControlStateNormal];
            [weakSelf.shareBtn setImage:[CZImageProvider imageNamed:@"guwen_fenxiang"] forState:UIControlStateNormal];
        }
        //判断是否改变
        if (offsetY < 0) {
            CGRect rect = weakSelf.tableView.headerView.bgImg.frame;
            //改变图片的y值和高度即可
            rect.origin.y = offsetY;
            rect.size.height = ScreenScale(540)+weakSelf.tableView.headerView.tagList.contentHeight + ScreenScale(20) - offsetY;
            weakSelf.tableView.headerView.bgImg.frame = rect;
        }
        
        //悬浮
        CGFloat header = weakSelf.tableView.headerView.frame.size.height;//这个header其实是section1 的header到顶部的距离（一般为: tableHeaderView的高度）
        if (offsetY < (header - NaviH) && offsetY >= 0) {
            //当视图滑动的距离小于header时
            weakSelf.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
            weakSelf.tableView.cell.serviceVC.tableView.scrollEnabled = NO;
            weakSelf.tableView.cell.commentVC.tableView.scrollEnabled = NO;
            weakSelf.tableView.cell.caseVC.collectionView.scrollEnabled = NO;
            [weakSelf.tableView.cell.serviceVC.tableView setContentOffset:CGPointMake(0, 0) animated:NO];
            [weakSelf.tableView.cell.commentVC.tableView setContentOffset:CGPointMake(0, 0) animated:NO];
            [weakSelf.tableView.cell.caseVC.collectionView setContentOffset:CGPointMake(0, 0) animated:NO];
            weakSelf.tableView.scrollEnabled = YES;
        }else if(offsetY >= (header - NaviH)){
            //当视图滑动的距离大于header时，这里就可以设置section1的header的位置啦，设置的时候要考虑到导航栏的透明对滚动视图的影响
            weakSelf.tableView.contentInset = UIEdgeInsetsMake(NaviH, 0, 0, 0);
            weakSelf.tableView.cell.serviceVC.tableView.scrollEnabled = YES;
            weakSelf.tableView.cell.commentVC.tableView.scrollEnabled = YES;
            weakSelf.tableView.cell.caseVC.collectionView.scrollEnabled = YES;
            weakSelf.tableView.scrollEnabled = NO;
        }
    }];
    //查看达人
    [self.tableView setClickAvatarBlock:^{
        CZSchoolStarDetailVC *detailVC = [[CZSchoolStarDetailVC alloc]init];
        detailVC.userId = weakSelf.tableView.model.userId;
        [weakSelf.navigationController pushViewController:detailVC animated:YES];
    }];
}

- (void)clickFocusBtn:(UIButton *)focusBtn{
    if (!focusBtn.isSelected) {
        [self requestForApiFocusFanSaveFocusFan];
    }else{
        [self requestForApiFocusFanCancelFocusFan];
    }
}
- (void)clickCollectBtn:(UIButton *)collectBtn{
    if (!collectBtn.isSelected) {
        [self requestForApiCollectCollect];
    }else{
        [self requestForApiCollectCancelCollect];
    }
}

//获取店铺详情
-(void)requestForApiSportUserSelectSportUserInfo{
    WEAKSELF
    CZAdvisorDetailService *service = serviceByType(QSServiceTypeAdvisorDetail);
    [service requestForApiSportUserSelectSportUserInfo:self.sportUserId callBack:^(BOOL success, NSInteger code, id  _Nonnull data, NSString * _Nonnull errorMessage) {
        if (success) {
            dispatch_async(dispatch_get_main_queue(), ^{
                CZSchoolStarModel *model = [CZSchoolStarModel modelWithDict:data];
                [weakSelf.avatarImg sd_setImageWithURL:[NSURL URLWithString:PIC_URL(model.userImg)] placeholderImage:nil];
                weakSelf.titleLab.text = model.realName;
                if ([model.isFocus boolValue]) {
                    [weakSelf.focusBtn setTitle:@"已关注" forState:UIControlStateNormal];
                    [weakSelf.focusBtn setSelected:YES];
                }else{
                    [weakSelf.focusBtn setTitle:@"+关注" forState:UIControlStateNormal];
                    [weakSelf.focusBtn setSelected:NO];
                }
                
                if ([model.isCollect boolValue]) {
                    [weakSelf.collectBtn setSelected:YES];
                    [weakSelf.collectBtn setTitle:@"已收藏" forState:UIControlStateNormal];
                    [weakSelf.collectBtn setImage:[CZImageProvider imageNamed:@"yi_shou_cang"] forState:UIControlStateNormal];
                }else{
                    [weakSelf.collectBtn setSelected:NO];
                    [weakSelf.collectBtn setTitle:@"收藏" forState:UIControlStateNormal];
                    [weakSelf.collectBtn setImage:[CZImageProvider imageNamed:@"xingxing_heise"] forState:UIControlStateNormal];
                }
                weakSelf.tableView.model = model;
            });
        }
    }];
}
/**
 关注
 */
- (void)requestForApiFocusFanSaveFocusFan{
    WEAKSELF
    CZAdvisorDetailService *service = serviceByType(QSServiceTypeAdvisorDetail);
    [service requestForApiFocusFanSaveFocusFan:self.tableView.model.userId callBack:^(BOOL success, NSInteger code, id  _Nonnull data, NSString * _Nonnull errorMessage) {
        if (success){
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.tableView.model.isFocus = @(1);
                [weakSelf.focusBtn setSelected:YES];
                [weakSelf.focusBtn setTitle:@"已关注" forState:UIControlStateNormal];
            });
        }
    }];
}

/**
 取消关注
 */
- (void)requestForApiFocusFanCancelFocusFan{
    WEAKSELF
    CZAdvisorDetailService *service = serviceByType(QSServiceTypeAdvisorDetail);
    [service requestForApiFocusFanCancelFocusFan:self.tableView.model.userId callBack:^(BOOL success, NSInteger code, id  _Nonnull data, NSString * _Nonnull errorMessage) {
        if (success){
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.tableView.model.isFocus = @(0);
                [weakSelf.focusBtn setSelected:NO];
                [weakSelf.focusBtn setTitle:@"+关注" forState:UIControlStateNormal];
            });
        }
    }];
}

/**
 收藏
 */
- (void)requestForApiCollectCollect{
    WEAKSELF
    CZAdvisorDetailService *service = serviceByType(QSServiceTypeAdvisorDetail);
    [service requestForApiCollectCollect:self.tableView.model.userId collectType:9 callBack:^(BOOL success, NSInteger code, id  _Nonnull data, NSString * _Nonnull errorMessage) {
        if (success){
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.tableView.model.isCollect = @(1);
                [weakSelf.collectBtn setSelected:YES];
                [weakSelf.collectBtn setTitle:@"已收藏" forState:UIControlStateNormal];
                [weakSelf.collectBtn setImage:[CZImageProvider imageNamed:@"yi_shou_cang"] forState:UIControlStateNormal];
            });
        }
    }];
}

/**
 取消收藏
 */
- (void)requestForApiCollectCancelCollect{
    WEAKSELF
    CZAdvisorDetailService *service = serviceByType(QSServiceTypeAdvisorDetail);
    [service requestForApiCollectCancelCollect:self.tableView.model.userId collectType:9 callBack:^(BOOL success, NSInteger code, id  _Nonnull data, NSString * _Nonnull errorMessage) {
        if (success){
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.tableView.model.isCollect = @(0);
                [weakSelf.collectBtn setSelected:NO];
                [weakSelf.collectBtn setTitle:@"收藏" forState:UIControlStateNormal];
                [weakSelf.collectBtn setImage:[CZImageProvider imageNamed:@"xingxing_heise"] forState:UIControlStateNormal];
            });
        }
    }];
}

/**
 * 初始化UI
 */
- (void)initWithUI{
    self.view.backgroundColor = [UIColor whiteColor];
    //返回按钮
    self.backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];//baise_fanhui@2x  tong_yong_fan_hui
    [self.backBtn setImage:[CZImageProvider imageNamed:@"baise_fanhui"] forState:UIControlStateNormal];
    [self.backBtn addTarget:self action:@selector(actionForBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:self.backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    
    //右边按钮
    self.shareBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];//heise_fenxiang@2x   guwen_fenxiang
    [self.shareBtn setImage:[CZImageProvider imageNamed:@"guwen_fenxiang"] forState:UIControlStateNormal];
    [self.shareBtn addTarget:self action:@selector(rbackItemClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.focusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.focusBtn setFrame:CGRectMake(0, 0, ScreenScale(116), ScreenScale(46))];
    [self.focusBtn setBackgroundColor:CZColorCreater(51, 172, 253, 1)];
    [self.focusBtn setTitle:@"+关注" forState:UIControlStateNormal];
    [self.focusBtn setTitleColor:CZColorCreater(255, 255, 255, 1) forState:UIControlStateNormal];
    [self.focusBtn.titleLabel setFont:[UIFont systemFontOfSize:ScreenScale(26)]];
    [self.focusBtn.layer setMasksToBounds:YES];
    [self.focusBtn.layer setCornerRadius:ScreenScale(46)/2];
    [self.focusBtn addTarget:self action:@selector(clickFocusBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.focusBtn.alpha = 0;
    
    UIBarButtonItem *focusItem = [[UIBarButtonItem alloc]initWithCustomView:self.focusBtn];
    UIBarButtonItem *rbackItem = [[UIBarButtonItem alloc]initWithCustomView:self.shareBtn];
    
    self.navigationItem.rightBarButtonItems = @[rbackItem,focusItem];
    //导航透明
    self.edgesForExtendedLayout = UIRectEdgeTop;
//    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar.subviews.firstObject setAlpha:0.0];
    
    self.titleView = [[UIView alloc]initWithFrame:CGRectMake(60, 0, kScreenWidth-120, NaviH)];
    
    self.avatarImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, ScreenScale(8), ScreenScale(64), ScreenScale(64))];
    self.avatarImg.layer.masksToBounds = YES;
    self.avatarImg.layer.cornerRadius = ScreenScale(64)/2.0;
    [self.titleView addSubview:self.avatarImg];
    
    self.titleLab = [[UILabel alloc]initWithFrame:CGRectMake(ScreenScale(84), ScreenScale(26), kScreenWidth-250, ScreenScale(30))];
    self.titleLab.font = [UIFont boldSystemFontOfSize:ScreenScale(30)];
    self.titleLab.textColor = [UIColor blackColor];
    [self.titleView addSubview:self.titleLab];
    
    
    self.bottomView = [[UIView alloc]init];
    self.bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.mas_equalTo(self.view);
        if (IPHONE_X) {
            make.height.mas_equalTo(ScreenScale(100) + kBottomSafeHeight);
        }else{
            make.height.mas_equalTo(ScreenScale(100));
        }
    }];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.bottomView.mas_top);
        make.top.mas_equalTo(self.view.mas_top).offset(-NaviH);
    }];
    
    self.collectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.collectBtn setTitle:@"收藏" forState:UIControlStateNormal];
    [self.collectBtn setTitleColor:CZColorCreater(0, 0, 0, 1) forState:UIControlStateNormal];
    [self.collectBtn.titleLabel setFont:[UIFont systemFontOfSize:ScreenScale(28)]];
    [self.collectBtn setImage:[CZImageProvider imageNamed:@"xingxing_heise"] forState:UIControlStateNormal];
    [self.collectBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -ScreenScale(20), 0, 0 )];
    [self.collectBtn addTarget:self action:@selector(clickCollectBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:self.collectBtn];
    [self.collectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.mas_equalTo(self.bottomView);
        make.height.mas_equalTo(ScreenScale(100));
        make.width.mas_equalTo(ScreenScale(172));
    }];
    
    self.contrastBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.contrastBtn setTitle:@"对比达人" forState:UIControlStateNormal];
    [self.contrastBtn setTitleColor:CZColorCreater(0, 0, 0, 1) forState:UIControlStateNormal];
    [self.contrastBtn.titleLabel setFont:[UIFont systemFontOfSize:ScreenScale(28)]];
    [self.bottomView addSubview:self.contrastBtn];
    [self.contrastBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bottomView);
        make.height.mas_equalTo(ScreenScale(100));
        make.leading.mas_equalTo(self.collectBtn.mas_trailing);
        make.width.mas_equalTo(ScreenScale(191));
    }];
    
    self.chatBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.chatBtn setTitle:@"在线问" forState:UIControlStateNormal];
    [self.chatBtn setTitleColor:CZColorCreater(255,255, 255, 1) forState:UIControlStateNormal];
    [self.chatBtn.titleLabel setFont:[UIFont systemFontOfSize:ScreenScale(32)]];
    [self.chatBtn setBackgroundColor:CZColorCreater(51, 172, 253, 1)];
    [self.chatBtn setImage:[CZImageProvider imageNamed:@"daren_dianhua"] forState:UIControlStateNormal];
    [self.chatBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -ScreenScale(20), 0, 0 )];
    [self.bottomView addSubview:self.chatBtn];
    [self.chatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bottomView);
        make.height.mas_equalTo(ScreenScale(100));
        make.leading.mas_equalTo(self.contrastBtn.mas_trailing);
        make.trailing.mas_equalTo(self.bottomView.mas_trailing);
    }];
    
    UILabel *line = [[UILabel alloc]init];
    line.backgroundColor = CZColorCreater(241, 241, 241, 1);
    line.text = @"";
    [self.bottomView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.collectBtn.mas_trailing);
        make.width.mas_equalTo(ScreenScale(1));
        make.height.mas_equalTo(ScreenScale(100));
        make.top.mas_equalTo(self.bottomView);
    }];
    
    
    
}
- (void)rbackItemClick{
    
}

//返回
-(void)actionForBack{
    [self.navigationController popViewControllerAnimated:YES];
}

- (CZSchoolStarShopDetailTableView *)tableView{
    if (!_tableView) {
        _tableView = [[CZSchoolStarShopDetailTableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.superVC = self;
    }
    return _tableView;
}
@end
