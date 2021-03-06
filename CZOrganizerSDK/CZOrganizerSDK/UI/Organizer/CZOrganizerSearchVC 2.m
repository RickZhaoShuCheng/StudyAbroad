//
//  CZOrganizerSearchVC.m
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/21.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZOrganizerSearchVC.h"
#import "CZOrganizerSearchCollectionView.h"

@interface CZOrganizerSearchVC ()
@property (nonatomic ,strong) UIButton *backBtn;//返回按钮
@property (nonatomic ,strong) UIButton *shareBtn;//分享按钮
@property (nonatomic ,strong) UIView *titleView;
@property (nonatomic ,strong) UILabel *titleLab;
@property (nonatomic ,strong) UIButton *focusBtn;
@property (nonatomic ,strong) UISearchBar *searchBar;
@property (nonatomic ,strong) UIButton *searchBtn;
@property (nonatomic ,strong) CZOrganizerSearchCollectionView *collectionView;
@end

@implementation CZOrganizerSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initWithUI];
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
    [self.shareBtn addTarget:self action:@selector(rbackItemClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rbackItem = [[UIBarButtonItem alloc]initWithCustomView:self.shareBtn];
    self.navigationItem.rightBarButtonItem = rbackItem;
    
    self.titleView = [[UIView alloc]initWithFrame:CGRectMake(60, 0, kScreenWidth-120, 44)];
    self.titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, ScreenScale(25), kScreenWidth-140, ScreenScale(30))];
    self.titleLab.font = [UIFont boldSystemFontOfSize:ScreenScale(30)];
    self.titleLab.textColor = CZColorCreater(0, 0, 0, 1);
    self.titleLab.text = self.titleName;
    [self.titleView addSubview:self.titleLab];
    
    self.focusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.focusBtn setFrame:CGRectMake(kScreenWidth-140-ScreenScale(75), ScreenScale(15), ScreenScale(116), ScreenScale(46))];
    [self.focusBtn setBackgroundColor:CZColorCreater(51, 172, 253, 1)];
    [self.focusBtn setTitle:@"+关注" forState:UIControlStateNormal];
    [self.focusBtn setTitleColor:CZColorCreater(255, 255, 255, 1) forState:UIControlStateNormal];
    [self.focusBtn.titleLabel setFont:[UIFont systemFontOfSize:ScreenScale(26)]];
    [self.focusBtn.layer setMasksToBounds:YES];
    [self.focusBtn.layer setCornerRadius:ScreenScale(46)/2];
    [self.titleView addSubview:self.focusBtn];
    self.navigationItem.titleView = self.titleView;
    
    UIView *topView = [[UIView alloc]init];
    topView.backgroundColor = [UIColor whiteColor];
    topView.layer.shadowOpacity = 0.3;//阴影透明度
    topView.layer.shadowOffset = CGSizeMake(0, 1);//阴影偏移量
    topView.layer.shadowRadius = 4;//阴影的半径
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
    [self.searchBar setBackgroundImage:[[UIImage alloc]init]];
    self.searchBar.tintColor = [UIColor blackColor];
    self.searchBar.searchTextField.backgroundColor = [UIColor clearColor];
    self.searchBar.searchTextField.placeholder = @"搜索";
    self.searchBar.searchTextField.font = [UIFont systemFontOfSize:ScreenScale(28)];
    self.searchBar.searchTextField.returnKeyType = UIReturnKeySearch;
    [topView addSubview:self.searchBar];
    [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(topView.mas_leading).offset(ScreenScale(30));
        make.centerY.mas_equalTo(topView);
        make.height.mas_equalTo(ScreenScale(62));
        make.trailing.mas_equalTo(topView.mas_trailing).offset(-ScreenScale(158));
    }];
    
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
- (void)searchBtnClick{
    
}
- (void)backItemClick{

}

//返回
-(void)actionForBack{
    [self.navigationController popViewControllerAnimated:YES];
}

- (CZOrganizerSearchCollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        _collectionView = [[CZOrganizerSearchCollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    }
    return _collectionView;
}
@end
