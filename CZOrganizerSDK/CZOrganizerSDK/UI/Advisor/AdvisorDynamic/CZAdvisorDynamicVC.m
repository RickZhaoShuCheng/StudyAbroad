
//
//  AdvisorDynamicVC.m
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/21.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZAdvisorDynamicVC.h"
#import "CZAdvisorDynamicTableView.h"
#import "QSCommonService.h"
#import "CZAdvisorDetailService.h"
#import "QSClient.h"

@interface CZAdvisorDynamicVC ()
@property (nonatomic ,strong) UIView *titleView;
@property (nonatomic ,strong) UIImageView *avatarImg;
@property (nonatomic ,strong) UILabel *nameLab;
@property (nonatomic ,strong) UIButton *focusBtn;
@property (nonatomic ,strong)UIButton *backBtn;//返回按钮
@property (nonatomic ,strong) CZAdvisorDynamicTableView *tableView;
@property (nonatomic ,assign) CGFloat alpha;
@property (nonatomic ,assign) NSInteger pageNum;
@end

@implementation CZAdvisorDynamicVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageNum = 1;
    [self initWithUI];
    [self actionMethod];
    [self requestForApiMyDynamicPersonalHomepage];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar.subviews.firstObject setAlpha:self.alpha];
    [self.titleView setAlpha:self.alpha];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.titleView setAlpha:self.alpha];
    [self.navigationController.navigationBar.subviews.firstObject setAlpha:self.alpha];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar.subviews.firstObject setAlpha:1];
}
- (void)actionMethod{
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
        if (alpha >0.5) {
            [weakSelf.backBtn setImage:[CZImageProvider imageNamed:@"tong_yong_fan_hui"] forState:UIControlStateNormal];
        }else{
            [weakSelf.backBtn setImage:[CZImageProvider imageNamed:@"baise_fanhui"] forState:UIControlStateNormal];
        }
        //判断是否改变
        if (offsetY < 0) {
            CGRect rect = weakSelf.tableView.headerView.bgImg.frame;
            //改变图片的y值和高度即可
            rect.origin.y = offsetY;
            if (!weakSelf.model.introduceOpen) {
                rect.size.height = ScreenScale(560) - offsetY;
            }else{
                CGFloat height = weakSelf.model.introduceHeight-weakSelf.model.singleHeight*3;
                rect.size.height = ScreenScale(560)+height - offsetY;
            }
            weakSelf.tableView.headerView.bgImg.frame = rect;
        }
        
        //悬浮
        CGFloat header = weakSelf.tableView.headerView.frame.size.height;//这个header其实是section1 的header到顶部的距离（一般为: tableHeaderView的高度）
        if (offsetY < (header - (NaviH)) && offsetY >= 0) {
            //当视图滑动的距离小于header时
            weakSelf.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
            weakSelf.tableView.cell.postVC.tableView.scrollEnabled = NO;
            weakSelf.tableView.scrollEnabled = YES;
        }else if(offsetY >= (header - (NaviH))){
            //当视图滑动的距离大于header时，这里就可以设置section1的header的位置啦，设置的时候要考虑到导航栏的透明对滚动视图的影响
            weakSelf.tableView.contentInset = UIEdgeInsetsMake(NaviH, 0, 0, 0);
            weakSelf.tableView.cell.postVC.tableView.scrollEnabled = YES;
            weakSelf.tableView.scrollEnabled = NO;
        }
    }];
    //私信
    self.tableView.headerView.clickChatBlock = ^{
        NSDictionary *param = @{@"conversationType":@"1",
                                @"targetId":weakSelf.userId,
                                @"title":weakSelf.tableView.model.userNickName,
        };
        UIViewController *chatVC = [QSClient instanceChatTabVCByOptions:param];
        [weakSelf.navigationController pushViewController:chatVC animated:YES];
    };
}

- (void)clickFocusBtn:(UIButton *)focusBtn{
    
}
//获取信息
- (void)requestForApiMyDynamicPersonalHomepage{
    WEAKSELF
    CZAdvisorDetailService *service = [QSCommonService service:QSServiceTypeAdvisorDetail];
    [service requestForApiMyDynamicPersonalHomepage:self.userId type:1 pageNum:self.pageNum pageSize:20 callBack:^(BOOL success, NSInteger code, id  _Nonnull data, NSString * _Nonnull errorMessage) {
        if (success) {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"...%@",data);
                weakSelf.model = [CZUserInfoModel modelWithDict:data[@"userVo"]];
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
    
    //导航透明
    self.edgesForExtendedLayout = UIRectEdgeTop;
//    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar.subviews.firstObject setAlpha:0.0];
    
    self.titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth-ScreenScale(120), 44)];
    
    self.avatarImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.titleView.center.y-ScreenScale(60)/2.0, ScreenScale(60), ScreenScale(60))];
    self.avatarImg.layer.masksToBounds = YES;
    self.avatarImg.layer.cornerRadius = ScreenScale(60)/2.0;
    [self.titleView addSubview:self.avatarImg];
    
    self.focusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.focusBtn setFrame:CGRectMake(self.titleView.frame.size.width - ScreenScale(150), self.titleView.center.y - ScreenScale(46)/2.0, ScreenScale(110), ScreenScale(46))];
    [self.focusBtn setTitle:@"+关注" forState:UIControlStateNormal];
    [self.focusBtn setTitle:@"已关注" forState:UIControlStateSelected];
    [self.focusBtn.titleLabel setFont:[UIFont systemFontOfSize:ScreenScale(24)]];
    [self.focusBtn setTitleColor:CZColorCreater(54, 163, 238, 1) forState:UIControlStateNormal];
    [self.focusBtn setTitleColor:CZColorCreater(54, 163, 238, 1) forState:UIControlStateSelected];
    self.focusBtn.layer.masksToBounds = YES;
    self.focusBtn.layer.cornerRadius = ScreenScale(46)/2.0;
    self.focusBtn.layer.borderColor = CZColorCreater(54, 163, 238, 1).CGColor;
    self.focusBtn.layer.borderWidth = ScreenScale(2);
    [self.focusBtn addTarget:self action:@selector(clickFocusBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.titleView addSubview:self.focusBtn];
    
    self.nameLab = [[UILabel alloc]initWithFrame:CGRectMake(ScreenScale(90), self.titleView.center.y - ScreenScale(40)/2.0, self.titleView.frame.size.width - ScreenScale(90) - ScreenScale(160), ScreenScale(40))];
    self.nameLab.font = [UIFont boldSystemFontOfSize:ScreenScale(32)];
    self.nameLab.textColor = CZColorCreater(51, 51, 51, 1);
    self.nameLab.text = @"-";
    [self.titleView addSubview:self.nameLab];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view.mas_top).offset(-NaviH);
    }];
    
    
}
//返回
-(void)actionForBack{
    [self.navigationController popViewControllerAnimated:YES];
}
- (CZAdvisorDynamicTableView *)tableView{
    if (!_tableView) {
        _tableView = [[CZAdvisorDynamicTableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    }
    return _tableView;
}
@end
