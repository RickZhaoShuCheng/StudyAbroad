//
//  CZCarefullyChooseViewController.m
//  CZOrganizerSDK
//
//  Created by zsc on 2020/2/21.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZCarefullyChooseViewController.h"
#import "CZCarefullyChooseView.h"
#import "QSCommonService.h"
#import "QSOrganizerHomeService.h"
#import "QSClient.h"
#import "CZMJRefreshHelper.h"
#import "CZProductModel.h"
#import "DropMenuBar.h"
#import "CZCommonFilterManager.h"

@interface CZCarefullyChooseViewController ()

@property (nonatomic ,strong) CZCarefullyChooseView *dataCollectionView;
@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, strong) DropMenuBar *menuScreeningView;
@property (nonatomic, strong) CZHomeParam *param;

@property (nonatomic, strong)CZCommonFilterManager *manager;

@end

@implementation CZCarefullyChooseViewController
@synthesize contentScrollView;
@synthesize canScroll;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self requestForCarefullyChoose];
}

-(void)initUI
{
    self.view.backgroundColor = CZColorCreater(245, 245, 249, 1.0);
    
    if (!self.param) {
        self.param = [[CZHomeParam alloc] init];
    }
    self.param.userId = [QSClient userId];
    self.param.serviceSource = @(1);
    if (self.model) {
        NSData *data = [self.model.jsonParams dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        self.param.productCategory = dic[@"productCategory"];
    }
        
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat coverWidth = (screenWidth - 15*3)/2.0;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(coverWidth, coverWidth/165.0*220+15);
    [layout setSectionInset:UIEdgeInsetsMake(0, 15, 0, 15)];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    self.dataCollectionView = [[CZCarefullyChooseView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.menuScreeningView.frame), self.view.bounds.size.width, self.view.bounds.size.height) collectionViewLayout:layout];
    [self.view addSubview:self.dataCollectionView];
    if (!self.model) {
        self.contentScrollView = self.dataCollectionView;
    }
    
    if (self.keywords) {
        self.contentScrollView = nil;
    }
    else
    {
        [self createDefaultFilterMenu];
    }
    
    self.dataCollectionView.alwaysBounceVertical = YES;
    self.dataCollectionView.currentVC = self;
    [self.dataCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (self.menuScreeningView) {
            make.top.mas_equalTo(self.menuScreeningView.mas_bottom);
        }
        else
        {
            make.top.mas_equalTo(0);
        }
        make.left.right.mas_equalTo(0);
        
        if (self.keywords) {
            make.bottom.mas_equalTo(-100);
        }
        else
        {
            make.bottom.mas_equalTo(!self.model?0:-100);
        }
    }];
    
    WEAKSELF
    self.dataCollectionView.mj_header = [CZMJRefreshHelper lb_headerWithAction:^{
        weakSelf.pageIndex = 1;
        [weakSelf requestForCarefullyChoose];
    }];
    
    self.dataCollectionView.mj_footer = [CZMJRefreshHelper lb_footerWithAction:^{
        weakSelf.pageIndex += 1;
        [weakSelf requestForCarefullyChoose];
    }];
}

-(void)requestForCarefullyChoose
{
    WEAKSELF
    QSOrganizerHomeService *service = serviceByType(QSServiceTypeOrganizerHome);
    self.param.pageNum = @(self.pageIndex);
    self.param.pageSize = @(10);
    self.param.name = self.keywords && self.keywords.length > 0 ?self.keywords:nil;
    
    QSOrganizerHomeBack block = ^(BOOL success, NSInteger code, id  _Nonnull data, NSString * _Nonnull errorMessage) {
            
            if (success) {
            
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    NSMutableArray *array = [[NSMutableArray alloc] init];
                    
                    for (NSDictionary *dic in data) {
                        CZProductModel *model = [CZProductModel modelWithDict:dic];
                        [array addObject:model];
                    }
                    
                    [weakSelf.dataCollectionView.mj_header endRefreshing];
                    
                    if (weakSelf.pageIndex == 1) {
                        [weakSelf.dataCollectionView.dataArr removeAllObjects];
                        [weakSelf.dataCollectionView.dataArr addObjectsFromArray:array];
                    }
                    else
                    {
                        [weakSelf.dataCollectionView.dataArr addObjectsFromArray:array];
                    }
                    
                    if (array.count < 10) {
                        [weakSelf.dataCollectionView.mj_footer endRefreshingWithNoMoreData];
                    }
                    else
                    {
                        [weakSelf.dataCollectionView.mj_footer endRefreshing];
                    }
                    
                    [weakSelf.dataCollectionView reloadData];
                    
                    if (self.dataCollectionView.dataArr.count > 0) {
    //                    [self.dataTableView hideNoData];
                    }
                    else
                    {
    //                    [self.dataTableView showNodataView];
                    }
                });
                
            }
            
    };
    
    if (!self.keywords) {
        [service requestForApiProductGetDefaultProductListByParam:self.param callBack:block];
    }
    else
    {
        [service requestForApiProductSearchProductListByNameByParam:self.param callBack:block];
    }
    
}


-(void)createDefaultFilterMenu
{
    WEAKSELF
    self.manager = [[CZCommonFilterManager alloc] init];
    self.manager.param = self.param;
    self.menuScreeningView = [self.manager actionsForType:self.model?CZCommonFilterTypeCarefulyChoose:CZCommonFilterTypeHomeCarefulyChoose];
    [self.view addSubview:self.menuScreeningView];
    self.manager.selectBlock = ^(CZHomeParam * _Nonnull param) {
        weakSelf.pageIndex = 1;
        [weakSelf requestForCarefullyChoose];
    };
    self.manager.filterViewShow = self.filterViewShow;
}

-(void)reloadData
{
    if (self.isViewLoaded) {
        self.pageIndex = 1;
        [self requestForCarefullyChoose];
    }
}
@end
