
//
//  SchoolStarDetailVC.m
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/4/6.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZSchoolStarDetailVC.h"
#import "CZSchoolStarDetailTableView.h"
#import "QSCommonService.h"
#import "CZAdvisorDetailService.h"
#import "CZUserInfoModel.h"
@interface CZSchoolStarDetailVC ()
@property (nonatomic ,strong)UILabel *titleLab;//标题
@property (nonatomic ,strong)UIButton *backBtn;//返回按钮
@property (nonatomic ,strong)UIButton *shareBtn;//分享按钮
@property (nonatomic ,strong) CZUserInfoModel *model;
@property (nonatomic ,strong) CZSchoolStarDetailTableView *tableView;
@property (nonatomic ,assign) CGFloat alpha;
@end

@implementation CZSchoolStarDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initWithUI];
    [self actionMethod];
    [self requestForApiMyDynamicPersonalHomepage];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar.subviews.firstObject setAlpha:self.alpha];
    [self.titleLab setAlpha:self.alpha];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.navigationController.navigationBar.subviews.firstObject setAlpha:self.alpha];
    [self.titleLab setAlpha:self.alpha];
}
- (void)actionMethod{
    WEAKSELF
    
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
        }else{
            [weakSelf.backBtn setImage:[CZImageProvider imageNamed:@"baise_fanhui"] forState:UIControlStateNormal];
            [weakSelf.shareBtn setImage:[CZImageProvider imageNamed:@"guwen_fenxiang"] forState:UIControlStateNormal];
        }
        //判断是否改变
        if (offsetY < 0) {
            CGRect rect = weakSelf.tableView.headerView.bgImg.frame;
            //改变图片的y值和高度即可
            rect.origin.y = offsetY;
            if (!weakSelf.model.introduceOpen) {
                rect.size.height = ScreenScale(640) - offsetY;
            }else{
                CGFloat height = weakSelf.model.introduceHeight-weakSelf.model.singleHeight*2;
                rect.size.height = ScreenScale(640)+height - offsetY;
            }
            weakSelf.tableView.headerView.bgImg.frame = rect;
        }
        
        //悬浮
        CGFloat header = weakSelf.tableView.headerView.frame.size.height;//这个header其实是section1 的header到顶部的距离（一般为: tableHeaderView的高度）
        if (offsetY < (header - (NaviH)) && offsetY >= 0) {
            //当视图滑动的距离小于header时
            weakSelf.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
            weakSelf.tableView.cell.postVC.tableView.scrollEnabled = NO;
            weakSelf.tableView.cell.piiicVC.tableView.scrollEnabled = NO;
            weakSelf.tableView.cell.diaryVC.tableView.scrollEnabled = NO;
            [weakSelf.tableView.cell.postVC.tableView setContentOffset:CGPointMake(0, 0) animated:NO];
            [weakSelf.tableView.cell.piiicVC.tableView setContentOffset:CGPointMake(0, 0) animated:NO];
            [weakSelf.tableView.cell.diaryVC.tableView setContentOffset:CGPointMake(0, 0) animated:NO];
            weakSelf.tableView.scrollEnabled = YES;
        }else if(offsetY >= (header - (NaviH))){
            //当视图滑动的距离大于header时，这里就可以设置section1的header的位置啦，设置的时候要考虑到导航栏的透明对滚动视图的影响
            weakSelf.tableView.contentInset = UIEdgeInsetsMake(NaviH, 0, 0, 0);
            weakSelf.tableView.cell.postVC.tableView.scrollEnabled = YES;
            weakSelf.tableView.cell.piiicVC.tableView.scrollEnabled = YES;
            weakSelf.tableView.cell.diaryVC.tableView.scrollEnabled = YES;
            weakSelf.tableView.scrollEnabled = NO;
        }
    }];
}
//获取达人详情信息
- (void)requestForApiMyDynamicPersonalHomepage{
    WEAKSELF
    CZAdvisorDetailService *service = [QSCommonService service:QSServiceTypeAdvisorDetail];
    [service requestForApiMyDynamicPersonalHomepage:self.userId type:1 pageNum:1 pageSize:20 callBack:^(BOOL success, NSInteger code, id  _Nonnull data, NSString * _Nonnull errorMessage) {
        if (success) {
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.model = [CZUserInfoModel modelWithDict:data[@"userVo"]];
                weakSelf.titleLab.text = weakSelf.model.userNickName;
                weakSelf.tableView.model = weakSelf.model;
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
    UIBarButtonItem *rbackItem = [[UIBarButtonItem alloc]initWithCustomView:self.shareBtn];
    self.navigationItem.rightBarButtonItem = rbackItem;
    //导航透明
    self.edgesForExtendedLayout = UIRectEdgeTop;
//    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar.subviews.firstObject setAlpha:0.0];
    
    self.titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    self.titleLab.textAlignment = NSTextAlignmentCenter;
    self.titleLab.textColor = [UIColor clearColor];
    self.titleLab.alpha = 0.0;
    [self.navigationItem setTitleView:self.titleLab];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view.mas_top).offset(-NaviH);
    }];
    
    
}
- (void)rbackItemClick{
    
}

//返回
-(void)actionForBack{
    [self.navigationController popViewControllerAnimated:YES];
}
- (CZSchoolStarDetailTableView *)tableView{
    if (!_tableView) {
        _tableView = [[CZSchoolStarDetailTableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.superVC = self;
    }
    return _tableView;
}

@end
