

//
//  CZCommentsListVC.m
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/14.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZCommentsListVC.h"
#import "CZCommentsListTableView.h"
#import "CZMJRefreshHelper.h"
#import "CZCommentsDetailVC.h"
@interface CZCommentsListVC ()
@property (nonatomic ,strong) UIButton *backBtn;
@property (nonatomic ,strong) CZCommentsListTableView *tableView;
@end

@implementation CZCommentsListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"评价列表";
    [self initWithUI];
    [self actionHandle];
}

- (void)actionHandle{
    WEAKSELF
    self.tableView.mj_header = [CZMJRefreshHelper lb_headerWithAction:^{
        [weakSelf.tableView.mj_header endRefreshing];
    }];
    
    self.tableView.mj_footer = [CZMJRefreshHelper lb_footerWithAction:^{
        [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
    }];
    [self.tableView setSelectedBlock:^{
        CZCommentsDetailVC *detailVC = [[CZCommentsDetailVC alloc]init];
        [weakSelf.navigationController pushViewController:detailVC animated:YES];
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
    
    self.tableView = [[CZCommentsListTableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
    NSMutableArray *tagesArr = [NSMutableArray array];
    [tagesArr addObject:@"全部"];
    [tagesArr addObject:@"最新"];
    [tagesArr addObject:@"好评 50"];
    [tagesArr addObject:@"消费后评价 38"];
    [tagesArr addObject:@"消费评价 38"];
    [tagesArr addObject:@"消费后价 38"];
    [tagesArr addObject:@"消后评价 38"];
    [tagesArr addObject:@"差评 50"];
    [self.tableView setTagListTags:tagesArr];
    
    //测试评价图片
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSMutableArray *tempArr = [NSMutableArray array];
    [tempArr addObject:@"http://pic1.win4000.com/wallpaper/c/57ad6e8f410eb.jpg"];
    [tempArr addObject:@"http://up.enterdesk.com/edpic/c3/84/b0/c384b0e8f05432c78c72f8d0cd1ab9ac.jpg"];
    [dic setValue:tempArr forKey:@"pics"];
    
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    NSMutableArray *tempArr1 = [NSMutableArray array];
    [tempArr1 addObject:@"http://uploadfile.bizhizu.cn/2015/0720/20150720033105173.jpg.source.jpg"];
    [tempArr1 addObject:@"http://pic1.win4000.com/wallpaper/2018-10-12/5bc00af5751a2.jpg"];
    [tempArr1 addObject:@"http://uploadfile.bizhizu.cn/2015/0720/20150720033105173.jpg.source.jpg"];
    [tempArr1 addObject:@"http://pic1.win4000.com/wallpaper/2018-10-12/5bc00af5751a2.jpg"];
    [dic1 setValue:tempArr1 forKey:@"pics"];
    
    NSMutableDictionary *dic2 = [NSMutableDictionary dictionary];
    NSMutableArray *tempArr2 = [NSMutableArray array];
    [dic2 setValue:tempArr2 forKey:@"pics"];
               
    [self.tableView.commentsArr addObject:dic];
    [self.tableView.commentsArr addObject:dic1];
    [self.tableView.commentsArr addObject:dic2];
    [self.tableView reloadData];
}
//返回
-(void)actionForBack{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
