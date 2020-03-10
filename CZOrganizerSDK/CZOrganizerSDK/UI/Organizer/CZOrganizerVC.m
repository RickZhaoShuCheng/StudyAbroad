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

#define PageMenuHeight          HeightRatio(60)

@interface CZOrganizerVC ()<SPPageMenuDelegate,UIScrollViewDelegate>
@property (nonatomic ,strong)UIButton *backBtn;//返回按钮
@property (nonatomic ,strong)UIButton *shareBtn;//分享按钮
@property (nonatomic,strong) SPPageMenu *pageMenu;
@property (nonatomic,strong) NSArray *titleArr;
@property (nonatomic,strong) NSMutableArray *myChildViewControllers;
@property (nonatomic,strong) UIScrollView *scrollView;
@end

@implementation CZOrganizerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initWithUI];
    [self initPageMenu];
    [self firstPageScrollHandle];
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
        [weakSelf.navigationController.navigationBar.subviews.firstObject setAlpha:alpha];
        weakSelf.pageMenu.alpha = alpha;
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
            rect.size.height =/Users/roc/Documents/LXZJ/StudyAbroad HeightRatio(540)+baseVc.collectionView.tagListHeight - offsetY;
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

/**
 * 初始化PageMenu
 */
-(void)initPageMenu{
    self.titleArr = @[@"主页",@"项目",@"日记",@"顾问"];
    // trackerStyle:跟踪器的样式
    self.pageMenu = [SPPageMenu pageMenuWithFrame:CGRectMake(0, 0, kScreenWidth, PageMenuHeight) trackerStyle:SPPageMenuTrackerStyleLine];
    self.pageMenu.permutationWay = SPPageMenuPermutationWayNotScrollAdaptContent;
    self.pageMenu.selectedItemTitleColor = CZColorCreater(0, 0, 0, 1);
    self.pageMenu.unSelectedItemTitleColor = CZColorCreater(0, 0, 0, 1);
    self.pageMenu.itemTitleFont = [UIFont boldSystemFontOfSize:WidthRatio(30)];
    self.pageMenu.tracker.backgroundColor = CZColorCreater(51, 172, 253, 1);
    // 传递数组，默认选中第0个
    [self.pageMenu setItems:self.titleArr selectedItemIndex:0];
    // 设置代理
    self.pageMenu.delegate = self;
    //初始隐藏
    self.pageMenu.alpha = 0.0;
    
    
    NSArray *controllerClassNames = [NSArray arrayWithObjects:@"CZOrganizerDetailViewController",@"UIViewController",@"UIViewController",@"UIViewController",nil];
    for (int i = 0; i < self.titleArr.count; i++) {
        if (controllerClassNames.count > i) {
            UIViewController *baseVC = [[NSClassFromString(controllerClassNames[i]) alloc] init];
            [self addChildViewController:baseVC];
            // 控制器本来自带childViewControllers,但是遗憾的是该数组的元素顺序永远无法改变，只要是addChildViewController,都是添加到最后一个，而控制器不像数组那样，可以插入或删除任意位置，所以这里自己定义可变数组，以便插入(删除)(如果没有插入(删除)功能，直接用自带的childViewControllers即可)
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
    [self.view addSubview:self.pageMenu];
    
    // pageMenu.selectedItemIndex就是选中的item下标
    if (self.pageMenu.selectedItemIndex < self.myChildViewControllers.count) {
        CZOrganizerDetailViewController *baseVc = self.myChildViewControllers[self.pageMenu.selectedItemIndex];
        [self.scrollView addSubview:baseVc.view];
        baseVc.view.frame = CGRectMake(kScreenWidth*self.pageMenu.selectedItemIndex, 0, kScreenWidth, kScreenHeight);
        self.scrollView.contentOffset = CGPointMake(kScreenWidth*self.pageMenu.selectedItemIndex, 0);
        self.scrollView.contentSize = CGSizeMake(self.titleArr.count*kScreenWidth, 0);
    }
}
#pragma mark - SPPageMenu的代理方法
- (void)pageMenu:(SPPageMenu *)pageMenu itemSelectedFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    
    if (fromIndex == toIndex) {
        return;
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
    targetViewController.view.frame = CGRectMake(kScreenWidth * toIndex, 0, kScreenWidth, kScreenHeight - PageMenuHeight - NaviH);
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
    
    //导航透明
    self.edgesForExtendedLayout = UIRectEdgeTop;
//    self.navigationController.navigationBar.translucent = YES;
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar.subviews.firstObject setAlpha:0.0];
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
