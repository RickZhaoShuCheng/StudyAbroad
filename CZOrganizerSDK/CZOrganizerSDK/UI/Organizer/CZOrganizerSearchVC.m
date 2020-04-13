//
//  CZOrganizerSearchVC.m
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/21.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZOrganizerSearchVC.h"
#import "CZOrganizerSearchCollectionView.h"
#import "CZAdvisorDetailService.h"
#import "QSCommonService.h"
#import "CZOrganizerListViewController.h"
@interface CZOrganizerSearchVC ()<UISearchBarDelegate>
@property (nonatomic ,strong) UIButton *backBtn;//返回按钮
@property (nonatomic ,strong) UIButton *shareBtn;//分享按钮
@property (nonatomic ,strong) UIView *titleView;
@property (nonatomic ,strong) UILabel *titleLab;
@property (nonatomic ,strong) UIButton *focusBtn;
@property (nonatomic ,strong) UISearchBar *searchBar;
@property (nonatomic ,strong) UIButton *searchBtn;
@property (nonatomic ,strong) CZOrganizerSearchCollectionView *collectionView;
@property (nonatomic ,strong) CZOrganizerListViewController *listView;
@end

@implementation CZOrganizerSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initWithUI];
    [self requestForApiPlaceholderFindPlaceholderByType];
    WEAKSELF
    [self.collectionView setSelectSearchKey:^(NSString * _Nonnull key) {
        weakSelf.searchBar.text = key;
        [weakSelf searchBtnClick];
    }];
}

- (void)clickFocusBtn:(UIButton *)focusBtn{
    if (!focusBtn.isSelected) {
        [self requestForApiFocusFanSaveFocusFan];
    }else{
        [self requestForApiFocusFanCancelFocusFan];
    }
}

/**
获取顾问
*/
- (void)requestForApiPlaceholderFindPlaceholderByType{
    WEAKSELF
    CZAdvisorDetailService *service = serviceByType(QSServiceTypeAdvisorDetail);
    [service requestForApiPlaceholderFindPlaceholderByType:@"1" zoneType:@"3" callBack:^(BOOL success, NSInteger code, id  _Nonnull data, NSString * _Nonnull errorMessage) {
        if (success){
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.collectionView.dataArr removeAllObjects];
                [weakSelf.collectionView.dataArr addObjectsFromArray:data];
                [weakSelf.collectionView reloadData];
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
    [service requestForApiFocusFanSaveFocusFan:self.model.userId callBack:^(BOOL success, NSInteger code, id  _Nonnull data, NSString * _Nonnull errorMessage) {
        if (success){
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.model.isFocus = @(1);
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
    [service requestForApiFocusFanCancelFocusFan:self.model.userId callBack:^(BOOL success, NSInteger code, id  _Nonnull data, NSString * _Nonnull errorMessage) {
        if (success){
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.model.isFocus = @(0);
                [weakSelf.focusBtn setSelected:NO];
                [weakSelf.focusBtn setTitle:@"+关注" forState:UIControlStateNormal];
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
    [self.backBtn setImage:[CZImageProvider imageNamed:@"tong_yong_fan_hui"] forState:UIControlStateNormal];
    [self.backBtn addTarget:self action:@selector(actionForBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:self.backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    
    //右边按钮
    self.shareBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];//heise_fenxiang@2x   guwen_fenxiang
    [self.shareBtn setImage:[CZImageProvider imageNamed:@"heise_fenxiang"] forState:UIControlStateNormal];
    [self.shareBtn addTarget:self action:@selector(shareItemClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.focusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.focusBtn setFrame:CGRectMake(kScreenWidth-140-ScreenScale(75), ScreenScale(15), ScreenScale(116), ScreenScale(46))];
    [self.focusBtn setBackgroundColor:[UIColor whiteColor]];
    [self.focusBtn setTitle:@"+关注" forState:UIControlStateNormal];
    [self.focusBtn setTitleColor:CZColorCreater(61, 172, 247, 1) forState:UIControlStateNormal];
    [self.focusBtn.titleLabel setFont:[UIFont systemFontOfSize:ScreenScale(26)]];
    [self.focusBtn.layer setMasksToBounds:YES];
    [self.focusBtn.layer setCornerRadius:ScreenScale(46)/2];
    [self.focusBtn.layer setBorderColor:CZColorCreater(51, 172, 253, 1).CGColor];
    [self.focusBtn.layer setBorderWidth:ScreenScale(2)];
    [self.focusBtn addTarget:self action:@selector(clickFocusBtn:) forControlEvents:UIControlEventTouchUpInside];
    if ([self.model.isFocus boolValue]) {
        [self.focusBtn setSelected:YES];
        [self.focusBtn setTitle:@"已关注" forState:UIControlStateNormal];
    }else{
        [self.focusBtn setSelected:NO];
        [self.focusBtn setTitle:@"+关注" forState:UIControlStateNormal];
    }
    
    UIBarButtonItem *focusItem = [[UIBarButtonItem alloc]initWithCustomView:self.focusBtn];
    
    UIBarButtonItem *rbackItem = [[UIBarButtonItem alloc]initWithCustomView:self.shareBtn];
    self.navigationItem.rightBarButtonItems = @[rbackItem,focusItem];
    
    self.titleView = [[UIView alloc]initWithFrame:CGRectMake(60, 0, kScreenWidth-120, 44)];
    self.titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, ScreenScale(25), kScreenWidth-140, ScreenScale(30))];
    self.titleLab.font = [UIFont boldSystemFontOfSize:ScreenScale(30)];
    self.titleLab.textColor = CZColorCreater(0, 0, 0, 1);
    self.titleLab.text = self.model.name;
    [self.titleView addSubview:self.titleLab];
    
    self.navigationItem.titleView = self.titleView;
    
    UIView *topView = [[UIView alloc]init];
    topView.backgroundColor = [UIColor whiteColor];
//    topView.layer.shadowOpacity = 0.3;//阴影透明度
//    topView.layer.shadowOffset = CGSizeMake(0, 1);//阴影偏移量
//    topView.layer.shadowRadius = 4;//阴影的半径
    [self.view addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.trailing.mas_equalTo(self.view);
        make.height.mas_equalTo(ScreenScale(86));
    }];
    
    UIView *searchView = [[UIView alloc]init];
    searchView.backgroundColor = CZColorCreater(244, 244, 248, 1);
    searchView.layer.masksToBounds = YES;
    searchView.layer.cornerRadius = ScreenScale(62)/2.0;
    [topView addSubview:searchView];
    [searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(topView.mas_leading).offset(ScreenScale(30));
        make.centerY.mas_equalTo(topView);
        make.height.mas_equalTo(ScreenScale(62));
        make.trailing.mas_equalTo(topView.mas_trailing).offset(-ScreenScale(158));
    }];
    
    self.searchBar = [[UISearchBar alloc]init];
    [self.searchBar setBackgroundImage:[UIImage new]];
    self.searchBar.placeholder = @"搜索";
    self.searchBar.returnKeyType = UIReturnKeySearch;
    self.searchBar.delegate = self;
    [topView addSubview:self.searchBar];
    [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(topView.mas_leading).offset(ScreenScale(30));
        make.centerY.mas_equalTo(topView);
        make.height.mas_equalTo(ScreenScale(62));
        make.trailing.mas_equalTo(topView.mas_trailing).offset(-ScreenScale(158));
    }];
    UITextField *searchTF = [self.searchBar valueForKey:@"searchField"];
    searchTF.backgroundColor = [UIColor clearColor];
    searchTF.font = [UIFont systemFontOfSize:ScreenScale(28)];
    
    self.searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.searchBtn setTitle:@"搜本机构" forState:UIControlStateNormal];
    [self.searchBtn setTitleColor:CZColorCreater(61, 67, 83, 1) forState:UIControlStateNormal];
    [self.searchBtn.titleLabel setFont:[UIFont systemFontOfSize:ScreenScale(28)]];
    [self.searchBtn addTarget:self action:@selector(searchBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:self.searchBtn];
    [self.searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.searchBar.mas_trailing).offset(ScreenScale(20));
        make.height.width.mas_greaterThanOrEqualTo(0);
        make.centerY.mas_equalTo(self.searchBar);
    }];
    
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(topView.mas_bottom);
    }];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self searchBtnClick];
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    if (!searchBar.text.length) {
        [self.listView.view removeFromSuperview];
    }
}

- (void)searchBtnClick{
    [self.view endEditing:YES];
    if (self.searchBar.text.length) {
        self.listView.keywords = self.searchBar.text;
        if (self.listView.view.superview) {
             [self.listView reloadData];
        }else{
            [self.view addSubview:self.listView.view];
            [self.listView.view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.leading.trailing.bottom.mas_equalTo(self.view);
                make.top.mas_equalTo(self.view.mas_top).offset(ScreenScale(86));
            }];
        }
    }else{
        [self.listView.view removeFromSuperview];
    }
}
- (void)shareItemClick{

}

//返回
-(void)actionForBack{
    if (self.callBackIsFocus) {
        self.callBackIsFocus([self.model.isFocus boolValue]);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (CZOrganizerSearchCollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        _collectionView = [[CZOrganizerSearchCollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    }
    return _collectionView;
}
- (CZOrganizerListViewController *)listView{
    if (!_listView) {
        _listView = [[CZOrganizerListViewController alloc]init];
        [self addChildViewController:_listView];
    }
    return _listView;
}
@end
