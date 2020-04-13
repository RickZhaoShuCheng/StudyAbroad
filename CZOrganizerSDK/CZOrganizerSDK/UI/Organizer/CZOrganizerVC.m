//
//  CZOrganizerVC.m
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/10.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZOrganizerVC.h"
#import "SPPageMenu.h"
#import "CZOrganizerDetailViewController.h"
#import "CZRankView.h"
#import "CZOrganizerProjectVC.h"
#import "CZOrganizerDiaryVC.h"
#import "CZOrganizerAdvisorVC.h"
#import "QSOrganizerHomeService.h"
#import "QSCommonService.h"
#import "CZAdvisorDetailService.h"
#import "CZOrganizerModel.h"
#import "CZOrganizerSearchVC.h"
#import "CZOrganizerInfoView.h"

#define PageMenuHeight          ScreenScale(88)

@interface CZOrganizerVC ()<SPPageMenuDelegate,UIScrollViewDelegate>
@property (nonatomic ,strong)UIButton *backBtn;//返回按钮
@property (nonatomic ,strong)UIButton *shareBtn;//分享按钮
@property (nonatomic,strong) SPPageMenu *pageMenu;
@property (nonatomic,strong) NSArray *titleArr;
@property (nonatomic,strong) NSMutableArray *myChildViewControllers;
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIView *topView;
@property (nonatomic ,strong) UIButton *searchBtn;
@property (nonatomic ,strong) UIView *titleView;
@property (nonatomic ,strong) UILabel *titleLab;
@property (nonatomic ,strong) CZRankView *rankView;
@property (nonatomic ,strong) UILabel *scoreLab;
@property (nonatomic ,strong) UILabel *countLab;
@property (nonatomic ,strong) UIButton *focusBtn;
@property (nonatomic ,assign) CGFloat alpha;
@property (nonatomic ,strong) UIButton *chatBtn;
@property (nonatomic ,strong) UIView *bottomView;
@property (nonatomic ,strong) CZOrganizerInfoView *infoView;
@end

@implementation CZOrganizerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.alpha = 0;
    [self initWithUI];
    [self initPageMenu];
    [self firstPageScrollHandle];
    [self requestOrganizerDetail];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar.subviews.firstObject setAlpha:self.alpha];
    self.titleView.alpha = self.alpha;
    self.focusBtn.alpha = self.alpha;
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.navigationController.navigationBar.subviews.firstObject setAlpha:self.alpha];
    self.titleView.alpha = self.alpha;
    self.focusBtn.alpha = self.alpha;
}
/**
 * 主页滚动处理导航条
 */
- (void)firstPageScrollHandle{
    //滚动时设置导航条透明度
    WEAKSELF
    __weak CZOrganizerDetailViewController *baseVc = self.myChildViewControllers[0];
    [baseVc.collectionView setScrollContentSize:^(CGFloat offsetY) {
        //设置渐变透明度
        CGFloat alpha = (offsetY / NaviH)>0.99?0.99:(offsetY / NaviH);
        weakSelf.alpha = alpha;
        [weakSelf.navigationController.navigationBar.subviews.firstObject setAlpha:alpha];
        weakSelf.topView.alpha = alpha;
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
            CGRect rect = baseVc.collectionView.headerView.bgImg.frame;
            //改变图片的y值和高度即可
            rect.origin.y = offsetY;
            //动态展示动态时，判断高度
            if (baseVc.collectionView.model.myDynamicVo.count <= 0) {
                rect.size.height = ScreenScale(540)+baseVc.collectionView.tagListHeight + ScreenScale(96) - offsetY;
            }else{
                rect.size.height = ScreenScale(540)+baseVc.collectionView.tagListHeight - offsetY;
            }
            baseVc.collectionView.headerView.bgImg.frame = rect;
        }
        //悬浮
        CGFloat header = baseVc.collectionView.headerView.frame.size.height;//这个header其实是section1 的header到顶部的距离（一般为: tableHeaderView的高度）
        //此处需要加上pageMenu的高度
        if (offsetY < (header - (NaviH+PageMenuHeight)) && offsetY >= 0) {
            //当视图滑动的距离小于header时
            baseVc.collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        }else if(baseVc.collectionView.contentOffset.y >= (header - (NaviH+PageMenuHeight))){
            //当视图滑动的距离大于header时，这里就可以设置section1的header的位置啦，设置的时候要考虑到导航栏的透明对滚动视图的影响
            baseVc.collectionView.contentInset = UIEdgeInsetsMake(NaviH+PageMenuHeight, 0, 0, 0);
        }
    }];
    
    //点击折叠
    [baseVc.collectionView setClickFoldBtnBlock:^{
        baseVc.collectionView.scrollEnabled = NO;
//        [weakSelf.scrollView setScrollEnabled:NO];
        [baseVc.collectionView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
        if (!weakSelf.infoView.superview) {
            [baseVc.view addSubview:weakSelf.infoView];
        }
        [weakSelf.infoView.tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
        weakSelf.infoView.model = baseVc.collectionView.model;
        CGRect rect = baseVc.collectionView.headerView.bgImg.frame;
        [UIView animateWithDuration:0.25 animations:^{
            [weakSelf.infoView setFrame:CGRectMake(0, rect.size.height, kScreenWidth, kScreenHeight - rect.size.height)];
            [weakSelf.bottomView setAlpha:0];
        } completion:^(BOOL finished) {
            [weakSelf.bottomView setHidden:YES];
        }];
    }];
}

- (void)clickSearchBtn:(UIButton *)searchBtn{
    WEAKSELF
    CZOrganizerDetailViewController *baseVc = self.myChildViewControllers[0];
    CZOrganizerSearchVC *serchVC = [[CZOrganizerSearchVC alloc]init];
    serchVC.model = baseVc.collectionView.model;
    serchVC.callBackIsFocus = ^(BOOL isFocus) {
        if (isFocus) {
            [weakSelf.focusBtn setTitle:@"已关注" forState:UIControlStateNormal];
            [weakSelf.focusBtn setSelected:YES];
        }else{
            [weakSelf.focusBtn setTitle:@"+关注" forState:UIControlStateNormal];
            [weakSelf.focusBtn setSelected:NO];
        }
    };
    [self.navigationController pushViewController:serchVC animated:YES];
}

- (void)clickFocusBtn:(UIButton *)focusBtn{
    if (!focusBtn.isSelected) {
        [self requestForApiFocusFanSaveFocusFan];
    }else{
        [self requestForApiFocusFanCancelFocusFan];
    }
}

/**
 获取机构详情
 */
- (void)requestOrganizerDetail{
    WEAKSELF
    QSOrganizerHomeService *service = serviceByType(QSServiceTypeOrganizerHome);
    [service requestForApiOrganGetOrganDetails:self.organId callBack:^(BOOL success, NSInteger code, id  _Nonnull data, NSString * _Nonnull errorMessage) {
        if (success){
            dispatch_async(dispatch_get_main_queue(), ^{
                CZOrganizerModel *model = [CZOrganizerModel modelWithDict:data];
                weakSelf.titleLab.text = model.name;
                [weakSelf.rankView setRankByRate:[model.valStar floatValue]];
                weakSelf.scoreLab.text = [NSString stringWithFormat:@"%.1f",[model.valStar floatValue]];
                weakSelf.countLab.text = [NSString stringWithFormat:@"粉丝数 %@",[@([model.fanCount integerValue]) stringValue]];
                if ([model.isFocus boolValue]) {
                    [weakSelf.focusBtn setTitle:@"已关注" forState:UIControlStateNormal];
                    [weakSelf.focusBtn setSelected:YES];
                }else{
                    [weakSelf.focusBtn setTitle:@"+关注" forState:UIControlStateNormal];
                    [weakSelf.focusBtn setSelected:NO];
                }
//                model.myDynamicVo = [NSMutableArray arrayWithObjects:@{@"smdType":@"1",@"diaryTitle":@"测试标题哈哈哈哈1",@"smdContent":@"标题嘿嘿嘿1"},@{@"smdType":@"4",@"diaryTitle":@"",@"smdContent":@"测试标题嘿嘿嘿2"},@{@"smdType":@"5",@"diaryTitle":@"测试标题哈哈哈哈3",@"smdContent":@"标题嘿嘿嘿3"}, nil];
                CZOrganizerDetailViewController *baseVc = weakSelf.myChildViewControllers[0];
                baseVc.collectionView.model = model;
                baseVc.organId = model.organId;
            });
        }
    }];
}

/**
 关注
 */
- (void)requestForApiFocusFanSaveFocusFan{
    WEAKSELF
    __weak CZOrganizerDetailViewController *baseVc = weakSelf.myChildViewControllers[0];
    CZAdvisorDetailService *service = serviceByType(QSServiceTypeAdvisorDetail);
    [service requestForApiFocusFanSaveFocusFan:baseVc.collectionView.model.userId callBack:^(BOOL success, NSInteger code, id  _Nonnull data, NSString * _Nonnull errorMessage) {
        if (success){
            dispatch_async(dispatch_get_main_queue(), ^{
                baseVc.collectionView.model.isFocus = @(1);
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
    __weak CZOrganizerDetailViewController *baseVc = weakSelf.myChildViewControllers[0];
    CZAdvisorDetailService *service = serviceByType(QSServiceTypeAdvisorDetail);
    [service requestForApiFocusFanCancelFocusFan:baseVc.collectionView.model.userId callBack:^(BOOL success, NSInteger code, id  _Nonnull data, NSString * _Nonnull errorMessage) {
        if (success){
            dispatch_async(dispatch_get_main_queue(), ^{
                baseVc.collectionView.model.isFocus = @(0);
                [weakSelf.focusBtn setSelected:NO];
                [weakSelf.focusBtn setTitle:@"+关注" forState:UIControlStateNormal];
            });
        }
    }];
}

/**
 * 初始化PageMenu
 */
-(void)initPageMenu{
    
    self.topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, PageMenuHeight)];
    self.topView.backgroundColor = [UIColor whiteColor];
    self.topView.layer.shadowOpacity = 0.3;//阴影透明度
    self.topView.layer.shadowOffset = CGSizeMake(0, 1);//阴影偏移量
    self.topView.layer.shadowRadius = 4;//阴影的半径
    //初始隐藏
    self.topView.alpha = 0.0;
    
    self.titleArr = @[@"主页",@"项目",@"日记",@"顾问"];
    // trackerStyle:跟踪器的样式
    self.pageMenu = [SPPageMenu pageMenuWithFrame:CGRectMake(ScreenScale(200), 0, kScreenWidth-ScreenScale(216), PageMenuHeight) trackerStyle:SPPageMenuTrackerStyleLine];
    self.pageMenu.permutationWay = SPPageMenuPermutationWayNotScrollAdaptContent;
    self.pageMenu.selectedItemTitleColor = CZColorCreater(0, 0, 0, 1);
    self.pageMenu.unSelectedItemTitleColor = CZColorCreater(0, 0, 0, 1);
    self.pageMenu.itemTitleFont = [UIFont boldSystemFontOfSize:ScreenScale(30)];
    self.pageMenu.tracker.backgroundColor = CZColorCreater(51, 172, 253, 1);
    // 传递数组，默认选中第0个
    [self.pageMenu setItems:self.titleArr selectedItemIndex:0];
    // 设置代理
    self.pageMenu.delegate = self;
    
    CZOrganizerDetailViewController *detailVC = [[CZOrganizerDetailViewController alloc]init];
    [self addChildViewController:detailVC];
    [self.myChildViewControllers addObject:detailVC];
    
    CZOrganizerProjectVC *projectVC = [[CZOrganizerProjectVC alloc]init];
    projectVC.caseType = @"1";
    projectVC.idStr = self.organId;
    [self addChildViewController:projectVC];
    [self.myChildViewControllers addObject:projectVC];
    
    CZOrganizerDiaryVC *diaryVC = [[CZOrganizerDiaryVC alloc]init];
    diaryVC.caseType = @"1";
    diaryVC.idStr = self.organId;
    [self addChildViewController:diaryVC];
    [self.myChildViewControllers addObject:diaryVC];
    
    CZOrganizerAdvisorVC *advisorVC = [[CZOrganizerAdvisorVC alloc]init];
    advisorVC.caseType = @"1";
    advisorVC.idStr = self.organId;
    [self addChildViewController:advisorVC];
    [self.myChildViewControllers addObject:advisorVC];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, -NaviH, kScreenWidth,kScreenHeight)];
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.scrollView];
    
    // 这一行赋值，可实现pageMenu的跟踪器时刻跟随scrollView滑动的效果
    self.pageMenu.bridgeScrollView = self.scrollView;
    [self.topView addSubview:self.pageMenu];
    [self.view addSubview:self.topView];
    
    // pageMenu.selectedItemIndex就是选中的item下标
    if (self.pageMenu.selectedItemIndex < self.myChildViewControllers.count) {
        UIViewController *baseVc = self.myChildViewControllers[self.pageMenu.selectedItemIndex];
        [self.scrollView addSubview:baseVc.view];
        baseVc.view.frame = CGRectMake(kScreenWidth*self.pageMenu.selectedItemIndex, 0, kScreenWidth, kScreenHeight);
        self.scrollView.contentOffset = CGPointMake(kScreenWidth*self.pageMenu.selectedItemIndex, 0);
        self.scrollView.contentSize = CGSizeMake(self.titleArr.count*kScreenWidth, 0);
        [self.view bringSubviewToFront:self.bottomView];
    }
    
    //搜索按钮
    self.searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [self.searchBtn setTitleColor:CZColorCreater(188, 188, 201, 1) forState:UIControlStateNormal];
    [self.searchBtn.titleLabel setFont:[UIFont systemFontOfSize:ScreenScale(28)]];
    [self.searchBtn setImage:[CZImageProvider imageNamed:@"zhu_ye_xue_xiao_fang_da_jing"] forState:UIControlStateNormal];
    [self.searchBtn setImage:[CZImageProvider imageNamed:@"zhu_ye_xue_xiao_fang_da_jing"] forState:UIControlStateHighlighted];
    [self.searchBtn setBackgroundColor:CZColorCreater(244, 244, 248, 1)];
    [self.searchBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, ScreenScale(16))];
    [self.searchBtn.layer setMasksToBounds:YES];
    [self.searchBtn.layer setCornerRadius:ScreenScale(50)/2];
    [self.searchBtn addTarget:self action:@selector(clickSearchBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.topView addSubview:self.searchBtn];
    [self.searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.topView).offset(ScreenScale(40));
        make.centerY.mas_equalTo(self.topView);
        make.width.mas_equalTo(ScreenScale(140));
        make.height.mas_equalTo(ScreenScale(50));
    }];
}
#pragma mark - SPPageMenu的代理方法
- (void)pageMenu:(SPPageMenu *)pageMenu itemSelectedFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    
    if (fromIndex == toIndex) {
        return;
    }
    if (fromIndex == 0 && toIndex == 1) {
        if (self.topView.alpha < 1) {
            //页面滑动过去的，需要处理导航条
            [self.navigationController.navigationBar.subviews.firstObject setAlpha:1];
            self.topView.alpha = 1;
            if (!self.titleView.superview) {
                self.navigationItem.titleView = self.titleView;
            }
            self.titleView.alpha = 1;
            self.focusBtn.alpha = 1;
            [self.backBtn setImage:[CZImageProvider imageNamed:@"tong_yong_fan_hui"] forState:UIControlStateNormal];
            [self.shareBtn setImage:[CZImageProvider imageNamed:@"heise_fenxiang"] forState:UIControlStateNormal];
        }
    }else if(toIndex == 0){
        //页面滑动回来的，需要处理导航条
        [self.navigationController.navigationBar.subviews.firstObject setAlpha:self.alpha];
        self.topView.alpha = self.alpha;
        self.titleView.alpha = self.alpha;
        self.focusBtn.alpha = self.alpha;
        if (self.alpha > 0.5) {
            [self.backBtn setImage:[CZImageProvider imageNamed:@"tong_yong_fan_hui"] forState:UIControlStateNormal];
            [self.shareBtn setImage:[CZImageProvider imageNamed:@"heise_fenxiang"] forState:UIControlStateNormal];
        }else{
            [self.backBtn setImage:[CZImageProvider imageNamed:@"baise_fanhui"] forState:UIControlStateNormal];
            [self.shareBtn setImage:[CZImageProvider imageNamed:@"guwen_fenxiang"] forState:UIControlStateNormal];
        }
            
    }
    
    // 如果fromIndex与toIndex之差大于等于2,说明跨界面移动了,此时不动画.
    if (labs(toIndex - fromIndex) >= 2) {
        [self.scrollView setContentOffset:CGPointMake(kScreenWidth * toIndex, 0) animated:NO];
    } else {
        [self.scrollView setContentOffset:CGPointMake(kScreenWidth * toIndex, 0) animated:YES];
    }
    if (self.myChildViewControllers.count <= toIndex) {
        return;
    }
    if (toIndex == 0) {
        if (self.infoView.superview) {
            [UIView animateWithDuration:0.25 animations:^{
                [self.bottomView setAlpha:0];
            } completion:^(BOOL finished) {
                [self.bottomView setHidden:YES];
            }];
        }
    }else{
        [UIView animateWithDuration:0.25 animations:^{
            [self.bottomView setAlpha:1];
        } completion:^(BOOL finished) {
            [self.bottomView setHidden:NO];
        }];
    }
    [self.view bringSubviewToFront:self.bottomView];
    UIViewController *targetViewController = self.myChildViewControllers[toIndex];
    // 如果已经加载过，就不再加载
    if ([targetViewController isViewLoaded]){
        return;
    };
    targetViewController.view.frame = CGRectMake(kScreenWidth * toIndex, PageMenuHeight + NaviH, kScreenWidth, kScreenHeight - NaviH - PageMenuHeight);
    [self.scrollView addSubview:targetViewController.view];
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
    [self.focusBtn setAlpha:0];
    
    UIBarButtonItem *focusItem = [[UIBarButtonItem alloc]initWithCustomView:self.focusBtn];
    
    UIBarButtonItem *rbackItem = [[UIBarButtonItem alloc]initWithCustomView:self.shareBtn];
    self.navigationItem.rightBarButtonItems = @[rbackItem,focusItem];
    
    self.titleView = [[UIView alloc]initWithFrame:CGRectMake(60, 0, kScreenWidth-120, NaviH)];
    
    self.titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, ScreenScale(20), kScreenWidth-140, ScreenScale(30))];
    self.titleLab.font = [UIFont boldSystemFontOfSize:ScreenScale(30)];
    self.titleLab.textColor = CZColorCreater(0, 0, 0, 1);
    self.titleLab.text = @"-";
    [self.titleView addSubview:self.titleLab];
    
    self.rankView = [CZRankView instanceRankViewByRate:0.0];
    self.rankView.frame = CGRectMake(0, ScreenScale(60), ScreenScale(150), ScreenScale(28));
    [self.titleView addSubview:self.rankView];
    
    self.scoreLab = [[UILabel alloc]initWithFrame:CGRectMake(ScreenScale(155), ScreenScale(53), ScreenScale(50), ScreenScale(30))];
    self.scoreLab.font = [UIFont systemFontOfSize:ScreenScale(22)];
    self.scoreLab.textColor = CZColorCreater(129, 129, 146, 1);
    self.scoreLab.text = @"-";
    [self.titleView addSubview:self.scoreLab];
    
    self.countLab = [[UILabel alloc]initWithFrame:CGRectMake(ScreenScale(155)+ScreenScale(50)+ScreenScale(34), ScreenScale(53), ScreenScale(180), ScreenScale(30))];
    self.countLab.font = [UIFont systemFontOfSize:ScreenScale(22)];
    self.countLab.textColor = CZColorCreater(129, 129, 146, 1);
    self.countLab.text = @"粉丝数 8122";
    [self.titleView addSubview:self.countLab];
    
    //导航透明
    self.edgesForExtendedLayout = UIRectEdgeTop;
//    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar.subviews.firstObject setAlpha:0.0];
    
    self.bottomView = [[UIView alloc]init];
    self.bottomView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(ScreenScale(140));
    }];
    
    self.chatBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.chatBtn.layer.masksToBounds = YES;
    self.chatBtn.layer.cornerRadius = ScreenScale(80)/2.0;
    [self.chatBtn setBackgroundColor:CZColorCreater(51, 172, 253, 1)];
    [self.chatBtn setTitle:@"咨询一下" forState:UIControlStateNormal];
    [self.chatBtn setTitleColor:CZColorCreater(255, 255, 255, 1) forState:UIControlStateNormal];
    [self.chatBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:ScreenScale(30)]];
    [self.chatBtn setImage:[CZImageProvider imageNamed:@"guwen_xiaoxi"] forState:UIControlStateNormal];
    [self.chatBtn setImage:[CZImageProvider imageNamed:@"guwen_xiaoxi"] forState:UIControlStateHighlighted];
    [self.chatBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, ScreenScale(14))];
    [self.bottomView addSubview:self.chatBtn];
    [self.chatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.bottomView);
        make.height.mas_equalTo(ScreenScale(80));
        make.width.mas_equalTo(ScreenScale(690));
        make.top.mas_equalTo(self.bottomView.mas_top);
    }];
}

- (void)rbackItemClick{

}

//返回
-(void)actionForBack{
    [self.navigationController popViewControllerAnimated:YES];
}
/**
 * 懒加载子vc arr
 */
- (NSMutableArray *)myChildViewControllers {
    if (!_myChildViewControllers) {
        _myChildViewControllers = [NSMutableArray array];
    }
    return _myChildViewControllers;
}

- (CZOrganizerInfoView *)infoView{
    if (!_infoView) {
        __weak CZOrganizerDetailViewController *baseVc = self.myChildViewControllers[0];
        CGRect rect = baseVc.collectionView.headerView.bgImg.frame;
        _infoView = [[CZOrganizerInfoView alloc]initWithFrame:CGRectMake(0, rect.size.height, kScreenWidth, 0)];
        WEAKSELF
        [_infoView setClickFoldBtnBlock:^{
            CGRect rect = baseVc.collectionView.headerView.bgImg.frame;
            [weakSelf.bottomView setHidden:NO];
            [UIView animateWithDuration:0.25 animations:^{
                [weakSelf.infoView setFrame:CGRectMake(0, rect.size.height, kScreenWidth,0)];
                [weakSelf.bottomView setAlpha:1];
            } completion:^(BOOL finished) {
                [weakSelf.infoView removeFromSuperview];
                baseVc.collectionView.scrollEnabled = YES;
                [weakSelf.scrollView setScrollEnabled:YES];
            }];
        }];
    }
    return _infoView;
}
- (BOOL)prefersStatusBarHidden{
    return NO;
}
@end
