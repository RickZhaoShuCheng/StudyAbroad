//
//  CZSelectCityViewController.m
//  CZOrganizerSDK
//
//  Created by zsc on 2020/3/1.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZSelectCityViewController.h"
#import "CZCountryUtil.h"
#import "CZSelectCountryCell.h"
#import "CZSelectProvinceCell.h"
#import "CZSelectCityCell.h"
#import "CZSearchBar.h"

@interface CZSelectCityViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic , strong) UITableView *countryTableView;
@property (nonatomic , strong) UITableView *proviceTableView;
@property (nonatomic , strong) UICollectionView *cityCollectionView;
@property (nonatomic , strong) NSMutableArray *datas;

@property (nonatomic , strong) NSArray *provinceDatas;
@property (nonatomic , strong) NSArray *cityDatas;

@property (nonatomic , strong) CZSCountryModel *selectCountry;
@property (nonatomic , strong) CZSCountryModel *selectProvince;
@property (nonatomic , strong) CZSCountryModel *selectCity;

@property (nonatomic , strong) CZSearchBar *searchBar;

@property (nonatomic , strong) UITableView *searchResultTableView;
@property (nonatomic , strong) NSMutableArray *searchResultArray;


@end

@implementation CZSelectCityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

-(void)actionForBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)initUI
{
    self.searchBar = [[CZSearchBar alloc] initWithFrame:CGRectMake(0, 0, 400, 33)];
    self.navigationItem.titleView = self.searchBar;
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 44, 44);
    [leftButton setImage:[CZImageProvider imageNamed:@"tong_yong_fan_hui"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(actionForBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = backButton;
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.countryTableView = [[UITableView alloc] init];
    self.countryTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.countryTableView.tableFooterView = [UIView new];
    self.countryTableView.delegate = self;
    self.countryTableView.dataSource = self;
    [self.countryTableView registerClass:[CZSelectCountryCell class] forCellReuseIdentifier:NSStringFromClass([CZSelectCountryCell class])];
    [self.view addSubview:self.countryTableView];
    [self.countryTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo((self.view.bounds.size.width/2.0-7.5)/2.0);
        make.left.bottom.top.mas_equalTo(0);
    }];
    
    self.proviceTableView = [[UITableView alloc] init];
    self.proviceTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.proviceTableView.tableFooterView = [UIView new];
    self.proviceTableView.delegate = self;
    self.proviceTableView.dataSource = self;
    [self.proviceTableView registerClass:[CZSelectProvinceCell class] forCellReuseIdentifier:NSStringFromClass([CZSelectProvinceCell class])];
    [self.view addSubview:self.proviceTableView];
    [self.proviceTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo((self.view.bounds.size.width/2.0-7.5)/2.0);
        make.bottom.top.mas_equalTo(0);
        make.left.mas_equalTo(self.countryTableView.mas_right);
    }];
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width/2.0-7.5;
    CGFloat coverWidth = (screenWidth - 15*2)/2.0;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(coverWidth, coverWidth/75.0*35.0);
    [layout setSectionInset:UIEdgeInsetsMake(0, 15, 15, 15)];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    self.cityCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.cityCollectionView.backgroundColor = [UIColor whiteColor];
    self.cityCollectionView.delegate = self;
    self.cityCollectionView.dataSource = self;
    [self.cityCollectionView registerClass:[CZSelectCityCell class] forCellWithReuseIdentifier:NSStringFromClass([CZSelectCityCell class])];
    [self.view addSubview:self.cityCollectionView];
    [self.cityCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.proviceTableView.mas_right);
        make.top.right.bottom.mas_equalTo(0);
    }];
    
    self.datas = [CZCountryUtil sharedInstance].datas;
    self.selectCountry = self.datas[0];
    self.provinceDatas = self.selectCountry.relatedArray;
    self.selectProvince = self.selectCountry.relatedArray[0];
    if (self.selectProvince.relatedArray && self.selectProvince.relatedArray.count > 0) {
        self.selectCity = self.selectProvince.relatedArray[0];
        self.cityDatas = self.selectProvince.relatedArray;
    }
    
    self.searchResultTableView = [[UITableView alloc] init];
    self.searchResultTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.searchResultTableView.tableFooterView = [UIView new];
    self.searchResultTableView.delegate = self;
    self.searchResultTableView.dataSource = self;
    [self.searchResultTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    [self.view addSubview:self.searchResultTableView];
    [self.searchResultTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    self.searchResultTableView.hidden = YES;
    WEAKSELF
    [self.searchBar setEditTextChangedListener:^(NSString * _Nonnull text) {
        weakSelf.searchResultTableView.hidden = text.length == 0;
        [weakSelf searchForCitiesByKeywords:text];
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.countryTableView) {
        return self.datas.count;
    }
    if (tableView == self.proviceTableView) {
        return self.provinceDatas.count;
    }
    return self.searchResultArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.countryTableView) {
        
        CZSelectCountryCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CZSelectCountryCell class]) forIndexPath:indexPath];
        CZSCountryModel *model = self.datas[indexPath.row];
        [cell setModel:model];
        if ([model.country.ID isEqualToString:self.selectCountry.country.ID]) {
            [cell setDidSelect:YES];
        }
        else
        {
            [cell setDidSelect:NO];
        }
        return cell;
    }
    else if (tableView == self.proviceTableView) {
        
        CZSelectProvinceCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CZSelectProvinceCell class]) forIndexPath:indexPath];
        CZSCountryModel *model = self.provinceDatas[indexPath.row];
        [cell setModel:model];
        if ([model.country.ID isEqualToString:self.selectProvince.country.ID]) {
            [cell setDidSelect:YES];
        }
        else
        {
            [cell setDidSelect:NO];
        }
        return cell;
    }
    else
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
        CZSCountryModel *model = self.searchResultArray[indexPath.row];
        cell.textLabel.text = model.country.area_name;
        cell.textLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:14];
        cell.textLabel.textColor = [UIColor blackColor];
        return cell;
    }
    

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (tableView == self.countryTableView) {
        self.selectCountry = self.datas[indexPath.row];
        self.provinceDatas = self.selectCountry.relatedArray;
        self.selectProvince = self.selectCountry.relatedArray[0];
        if (self.selectProvince.relatedArray && self.selectProvince.relatedArray.count > 0) {
            self.selectCity = self.selectProvince.relatedArray[0];
            self.cityDatas = self.selectProvince.relatedArray;
        }
        else
        {
            self.cityDatas = nil;
            self.selectCity = nil;
        }
        [self.countryTableView reloadData];
        [self.proviceTableView reloadData];
        [self.cityCollectionView reloadData];
    }
    else if (tableView == self.proviceTableView)
    {
        self.selectProvince = self.selectCountry.relatedArray[indexPath.row];
        if (self.selectProvince.relatedArray && self.selectProvince.relatedArray.count > 0) {
            self.selectCity = self.selectProvince.relatedArray[0];
            self.cityDatas = self.selectProvince.relatedArray;
        }
        else
        {
            self.cityDatas = nil;
            self.selectCity = nil;
        }
        [self.countryTableView reloadData];
        [self.proviceTableView reloadData];
        [self.cityCollectionView reloadData];
    }
    else
    {
        if (self.delegate && [self.delegate respondsToSelector:@selector(selectCity:viewController:)]) {
            CZSCountryModel *country = self.searchResultArray[indexPath.row];
            [self.delegate selectCity:country viewController:self];
        }
    }

}

#pragma mark ----------UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.cityDatas.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CZSelectCityCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CZSelectCityCell class]) forIndexPath:indexPath];
    [cell setModel:self.cityDatas[indexPath.row]];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectCity:viewController:)]) {
        self.selectCity = self.selectProvince.relatedArray[indexPath.row];
        [self.delegate selectCity:self.selectCity viewController:self];
    }
}

#pragma -mark 搜索

-(void)searchForCitiesByKeywords:(NSString *)keywords
{
    if (!keywords.length) {
        return;
    }
    NSArray *cities = [CZCountryUtil sharedInstance].cities;

    NSString *formatString = [NSString stringWithFormat:@"self.country.area_name CONTAINS[cd] '%@' AND self.country.level = '3'",keywords];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:formatString];
    NSMutableArray *array = [NSMutableArray arrayWithArray:cities];
    [array filterUsingPredicate:predicate];
    
    self.searchResultArray = array;
    [self.searchResultTableView reloadData];
}

@end
