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
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[CZImageProvider imageNamed:@"tong_yong_fan_hui"] style:UIBarButtonItemStylePlain target:self action:@selector(actionForBack)];
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
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.countryTableView) {
        return self.datas.count;
    }
    return self.provinceDatas.count;
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
    }
    else
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
    }
    
    [self.countryTableView reloadData];
    [self.proviceTableView reloadData];
    [self.cityCollectionView reloadData];
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
    self.selectCity = self.selectProvince.relatedArray[indexPath.row];
    [self.cityCollectionView reloadData];
}

@end
