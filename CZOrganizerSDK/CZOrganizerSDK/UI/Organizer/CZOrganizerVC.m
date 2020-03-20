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
#import "CZOrganizerModel.h"

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
@end

@implementation CZOrganizerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.alpha = 0.0;
    [self initWithUI];
    [self initPageMenu];
    [self firstPageScrollHandle];
    [self requestOrganizerDetail];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    __weak CZOrganizerDetailViewController *baseVc = self.myChildViewControllers[0];
    if (baseVc.collectionView.contentOffset.y > 0) {
        [self.navigationController.navigationBar.subviews.firstObject setAlpha:1];
        [self.backBtn setImage:[CZImageProvider imageNamed:@"tong_yong_fan_hui"] forState:UIControlStateNormal];
        [self.shareBtn setImage:[CZImageProvider imageNamed:@"heise_fenxiang"] forState:UIControlStateNormal];
    }
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
            rect.size.height = ScreenScale(540)+baseVc.collectionView.tagListHeight - offsetY;
            baseVc.collectionView.headerView.bgImg.frame = rect;
        }
        //悬浮
        CGFloat header = baseVc.collectionView.headerView.frame.size.height;//这个header其实是section1 的header到顶部的距离（一般为: tableHeaderView的高度）
        //此处需要加上pageMenu的高度
        if (offsetY < (header - (NaviH+StatusBarHeight+5+PageMenuHeight)) && offsetY >= 0) {
            //当视图滑动的距离小于header时
            baseVc.collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        }else if(baseVc.collectionView.contentOffset.y >= (header - (NaviH+StatusBarHeight+5+PageMenuHeight))){
            //当视图滑动的距离大于header时，这里就可以设置section1的header的位置啦，设置的时候要考虑到导航栏的透明对滚动视图的影响
            baseVc.collectionView.contentInset = UIEdgeInsetsMake(NaviH+StatusBarHeight+5+PageMenuHeight, 0, 0, 0);
        }
    }];
}

- (void)clickSearchBtn:(UIButton *)searchBtn{
    
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
                weakSelf.countLab.text = [NSString stringWithFormat:@"粉丝数 %@",[@([model.fanCount integerValue]) stringValue]];
                if ([model.isFocus boolValue]) {
                    [weakSelf.focusBtn setTitle:@"已关注" forState:UIControlStateNormal];
                }else{
                    [weakSelf.focusBtn setTitle:@"+关注" forState:UIControlStateNormal];
                }
                
                CZOrganizerDetailViewController *baseVc = self.myChildViewControllers[0];
                baseVc.collectionView.model = model;
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
    
    
    NSArray *controllerClassNames = [NSArray arrayWithObjects:@"CZOrganizerDetailViewController",@"CZOrganizerProjectVC",@"CZOrganizerDiaryVC",@"CZOrganizerAdvisorVC",nil];
    for (int i = 0; i < self.titleArr.count; i++) {
        if (controllerClassNames.count > i) {
            UIViewController *baseVC = [[NSClassFromString(controllerClassNames[i]) alloc] init];
            [self addChildViewController:baseVC];
        //控制器本来自带childViewControllers,但是遗憾的是该数组的元素顺序永远无法改变，只要是addChildViewController,都是添加到最后一个，而控制器不像数组那样，可以插入或删除任意位置，所以这里自己定义可变数组，以便插入(删除)(如果没有插入(删除)功能，直接用自带的childViewControllers即可)
            [self.myChildViewControllers addObject:baseVC];
        }
    }
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, -(NaviH+StatusBarHeight+5), kScreenWidth,kScreenHeight)];
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
        baseVc.view.frame = CGRectMake(kScreenWidth*self.pageMenu.selectedItemIndex, 0, kScreenWidth, kScreenHeight-NaviH-StatusBarHeight-5);
        self.scrollView.contentOffset = CGPointMake(kScreenWidth*self.pageMenu.selectedItemIndex, 0);
        self.scrollView.contentSize = CGSizeMake(self.titleArr.count*kScreenWidth, 0);
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
            [self.backBtn setImage:[CZImageProvider imageNamed:@"tong_yong_fan_hui"] forState:UIControlStateNormal];
            [self.shareBtn setImage:[CZImageProvider imageNamed:@"heise_fenxiang"] forState:UIControlStateNormal];
        }
    }else if(toIndex == 0){
        //页面滑动回来的，需要处理导航条
        [self.navigationController.navigationBar.subviews.firstObject setAlpha:self.alpha];
        self.topView.alpha = self.alpha;
        self.titleView.alpha = self.alpha;
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
    
    UIViewController *targetViewController = self.myChildViewControllers[toIndex];
    // 如果已经加载过，就不再加载
    if ([targetViewController isViewLoaded]){
        return;
    };
    targetViewController.view.frame = CGRectMake(kScreenWidth * toIndex, PageMenuHeight + NaviH + StatusBarHeight, kScreenWidth, kScreenHeight - NaviH - StatusBarHeight - ScreenScale(140) - PageMenuHeight);
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
    UIBarButtonItem *rbackItem = [[UIBarButtonItem alloc]initWithCustomView:self.shareBtn];
    self.navigationItem.rightBarButtonItem = rbackItem;
    
    self.titleView = [[UIView alloc]initWithFrame:CGRectMake(60, 0, kScreenWidth-120, 44)];

    self.titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, ScreenScale(20), kScreenWidth-140, ScreenScale(30))];
    self.titleLab.font = [UIFont boldSystemFontOfSize:ScreenScale(30)];
    self.titleLab.textColor = CZColorCreater(0, 0, 0, 1);
    self.titleLab.text = @"-";
    [self.titleView addSubview:self.titleLab];
    
    self.rankView = [CZRankView instanceRankViewByRate:3.1];
    self.rankView.frame = CGRectMake(0, ScreenScale(65), ScreenScale(150), ScreenScale(28));
    [self.titleView addSubview:self.rankView];
    
    self.scoreLab = [[UILabel alloc]initWithFrame:CGRectMake(ScreenScale(155), ScreenScale(56), ScreenScale(50), ScreenScale(30))];
    self.scoreLab.font = [UIFont systemFontOfSize:ScreenScale(22)];
    self.scoreLab.textColor = CZColorCreater(129, 129, 146, 1);
    self.scoreLab.text = @"3.1";
    [self.titleView addSubview:self.scoreLab];
    
    self.countLab = [[UILabel alloc]initWithFrame:CGRectMake(ScreenScale(155)+ScreenScale(50)+ScreenScale(34), ScreenScale(56), ScreenScale(180), ScreenScale(30))];
    self.countLab.font = [UIFont systemFontOfSize:ScreenScale(22)];
    self.countLab.textColor = CZColorCreater(129, 129, 146, 1);
    self.countLab.text = @"粉丝数 8122";
    [self.titleView addSubview:self.countLab];
    
    self.focusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.focusBtn setFrame:CGRectMake(kScreenWidth-140-ScreenScale(50), ScreenScale(30), ScreenScale(116), ScreenScale(46))];
    [self.focusBtn setBackgroundColor:CZColorCreater(51, 172, 253, 1)];
    [self.focusBtn setTitle:@"+关注" forState:UIControlStateNormal];
    [self.focusBtn setTitleColor:CZColorCreater(255, 255, 255, 1) forState:UIControlStateNormal];
    [self.focusBtn.titleLabel setFont:[UIFont systemFontOfSize:ScreenScale(26)]];
    [self.focusBtn.layer setMasksToBounds:YES];
    [self.focusBtn.layer setCornerRadius:ScreenScale(46)/2];
    [self.titleView addSubview:self.focusBtn];
    
    //导航透明
    self.edgesForExtendedLayout = UIRectEdgeTop;
//    self.navigationController.navigationBar.translucent = YES;
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar.subviews.firstObject setAlpha:0.0];
    
    UIView *bottomView = [[UIView alloc]init];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
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
    [bottomView addSubview:self.chatBtn];
    [self.chatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bottomView);
        make.height.mas_equalTo(ScreenScale(80));
        make.width.mas_equalTo(ScreenScale(690));
        make.top.mas_equalTo(bottomView.mas_top);
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
@end
