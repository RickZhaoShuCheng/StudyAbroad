

//
//  CZActivityListVC.m
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/23.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZActivityListVC.h"

@interface CZActivityListVC ()
@property (nonatomic ,strong) UIButton *backBtn;
@property (nonatomic ,strong) UIButton *searchBtn;
@end

@implementation CZActivityListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"全部活动";
    [self initWithUI];
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
    [self.searchBtn setImage:[CZImageProvider imageNamed:@"zhu_ye_xue_xiao_fang_da_jing"] forState:UIControlStateNormal];
    [self.searchBtn addTarget:self action:@selector(rbackItemClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rbackItem = [[UIBarButtonItem alloc]initWithCustomView:self.searchBtn];
    self.navigationItem.rightBarButtonItem = rbackItem;
}
//返回
-(void)actionForBack{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)rbackItemClick{
    
}
@end
