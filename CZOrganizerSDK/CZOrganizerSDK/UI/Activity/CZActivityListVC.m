

//
//  CZActivityListVC.m
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/23.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZActivityListVC.h"
#import "CZActivityListTableView.h"
#import "ActivityDetailVC.h"
#import "CZCommonFilterManager.h"
#import "DropMenuBar.h"
@interface CZActivityListVC ()
@property (nonatomic ,strong) UIButton *backBtn;
@property (nonatomic ,strong) UIButton *searchBtn;
@property (nonatomic ,strong) CZActivityListTableView *tableView;
@property (nonatomic ,strong) DropMenuBar *menuBar;
@property (nonatomic ,strong) CZCommonFilterManager *manager;
@end

@implementation CZActivityListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"全部活动";
    [self initWithUI];
    [self addActionHandle];
}

- (void)addActionHandle{
    WEAKSELF
    [self.tableView setDidSelectCell:^(NSString * _Nonnull str) {
        ActivityDetailVC *detailVC = [[ActivityDetailVC alloc]init];
        detailVC.isEnd = NO;
        [weakSelf.navigationController pushViewController:detailVC animated:YES];
    }];
    
    [self.manager setSelectBlock:^(CZHomeParam * _Nonnull param) {
        NSLog(@"..");
    }];
}

/**
 * 初始化UI
 */
- (void)initWithUI{
    self.view.backgroundColor = [UIColor whiteColor];
    //返回按钮
    self.backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [self.backBtn setImage:[CZImageProvider imageNamed:@"tong_yong_fan_hui"] forState:UIControlStateNormal];
    [self.backBtn addTarget:self action:@selector(actionForBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:self.backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    //右边按钮
    self.searchBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];//heise_fenxiang@2x   guwen_fenxiang
    [self.searchBtn setImage:[CZImageProvider imageNamed:@"sousuo_heise"] forState:UIControlStateNormal];
    [self.searchBtn addTarget:self action:@selector(rbackItemClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rbackItem = [[UIBarButtonItem alloc]initWithCustomView:self.searchBtn];
    self.navigationItem.rightBarButtonItem = rbackItem;
    
    self.manager = [[CZCommonFilterManager alloc]init];
    self.menuBar = [self.manager actionsForType:CZCommonFilterTypeMoreActivity];
    [self.view addSubview:self.menuBar];
    [self.menuBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.top.mas_equalTo(self.view);
        make.height.mas_equalTo(ScreenScale(80));
    }];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view.mas_top).offset(ScreenScale(80));
    }];
}

- (CZActivityListTableView *)tableView{
    if (!_tableView) {
        _tableView = [[CZActivityListTableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    }
    return _tableView;
}

//返回
-(void)actionForBack{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)rbackItemClick{
    
}
@end
