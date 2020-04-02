//
//  CZMoreSchoolStarVC.m
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/4/1.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZMoreSchoolStarVC.h"
#import "CZMoreSchoolStarTableView.h"
@interface CZMoreSchoolStarVC ()
@property (nonatomic ,strong) UIButton *backBtn;
@property (nonatomic ,strong) UIButton *searchBtn;
@property (nonatomic ,strong) CZMoreSchoolStarTableView *tableView;
@end

@implementation CZMoreSchoolStarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initWithUI];
}


/**
 * 初始化UI
 */
- (void)initWithUI{
    self.title = @"留学达人";
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
    
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(ScreenScale(80));
        make.leading.trailing.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view);
    }];
}

- (CZMoreSchoolStarTableView *)tableView{
    if (!_tableView) {
        _tableView = [[CZMoreSchoolStarTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
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
