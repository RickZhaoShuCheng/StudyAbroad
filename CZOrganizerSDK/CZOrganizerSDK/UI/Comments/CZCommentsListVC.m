

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
#import "CZAdvisorDetailService.h"
#import "QSCommonService.h"
@interface CZCommentsListVC ()
@property (nonatomic ,strong) UIButton *backBtn;
@property (nonatomic ,strong) CZCommentsListTableView *tableView;
@property (nonatomic ,assign) NSInteger pageNum;
@property (nonatomic ,assign) NSInteger filterNum;
@end

@implementation CZCommentsListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"评价列表";
    self.pageNum = 1;
    self.filterNum = 1;
    [self initWithUI];
    [self actionHandle];
    [self requestForApiObjectCommentsFindComments:1];
}

- (void)actionHandle{
    WEAKSELF
    self.tableView.mj_header = [CZMJRefreshHelper lb_headerWithAction:^{
        weakSelf.pageNum = 1;
        [weakSelf requestForApiObjectCommentsFindComments:weakSelf.filterNum];
    }];
    
    self.tableView.mj_footer = [CZMJRefreshHelper lb_footerWithAction:^{
        weakSelf.pageNum ++;
        [weakSelf requestForApiObjectCommentsFindComments:weakSelf.filterNum];
    }];
    
    [self.tableView setSelectedBlock:^(CZCommentModel * _Nonnull model) {
        CZCommentsDetailVC *detailVC = [[CZCommentsDetailVC alloc]init];
        detailVC.idStr = model.socId;
        [weakSelf.navigationController pushViewController:detailVC animated:YES];
    }];
    
    //评价筛选
    [self.tableView setSelectCommentIndex:^(NSInteger index) {
        weakSelf.filterNum = index + 1;
        [weakSelf requestForApiObjectCommentsFindComments:weakSelf.filterNum];
    }];
}
/**
 获取评价
 */
- (void)requestForApiObjectCommentsFindComments:(NSInteger)index{
    WEAKSELF
    CZAdvisorDetailService *service = serviceByType(QSServiceTypeAdvisorDetail);
    [service requestForApiObjectCommentsFindComments:self.commentsType idStr:self.idStr filterSum:index pageNum:self.pageNum pageSize:20 callBack:^(BOOL success, NSInteger code, id  _Nonnull data, NSString * _Nonnull errorMessage) {
       if (success){
            dispatch_async(dispatch_get_main_queue(), ^{
                NSMutableArray *filterCommentArr = [NSMutableArray array];
                if ([data[@"filterComment"] length]) {
                    [filterCommentArr addObjectsFromArray:[data[@"filterComment"] componentsSeparatedByString:@","]];
                }
                [weakSelf.tableView setTagListTags:filterCommentArr];
                
                NSMutableArray *array = [[NSMutableArray alloc] init];
                for (NSDictionary *dic in data[@"list"]) {
                    CZCommentModel *model = [CZCommentModel modelWithDict:dic];
                    CGFloat height = [weakSelf getStringHeightWithText:model.comment font:[UIFont systemFontOfSize:ScreenScale(26)] viewWidth:kScreenWidth - ScreenScale(142)];
                    model.commentHeight = height;
                    [array addObject:model];
                }
                [weakSelf.tableView.headerView setVarStar:weakSelf.varStar];
                [weakSelf.tableView.headerView setAvgMajor:[NSString stringWithFormat:@"%.1f",[data[@"avgMajor"] floatValue]] avgPrice:[NSString stringWithFormat:@"%.1f",[data[@"avgPrice"] floatValue]] avgService:[NSString stringWithFormat:@"%.1f",[data[@"avgService"] floatValue]]];
                if (weakSelf.pageNum == 1) {
                    [weakSelf.tableView.commentsArr removeAllObjects];
                    [weakSelf.tableView.commentsArr addObjectsFromArray:array];
                }else{
                    [weakSelf.tableView.commentsArr addObjectsFromArray:array];
                }
                [weakSelf.tableView reloadData];
                
                if (weakSelf.pageNum == 1) {
                    [weakSelf.tableView.mj_header endRefreshing];
                }
                if (array.count < 20) {
                    [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
                }else{
                    [weakSelf.tableView.mj_footer endRefreshing];
                }
            });
        }
    }];
}

- (CGFloat)getStringHeightWithText:(NSString *)text font:(UIFont *)font viewWidth:(CGFloat)width {
    // 设置文字属性 要和label的一致
    NSDictionary *attrs = @{NSFontAttributeName :font};
    CGSize maxSize = CGSizeMake(width, MAXFLOAT);

    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;

    // 计算文字占据的宽高
    CGSize size = [text boundingRectWithSize:maxSize options:options attributes:attrs context:nil].size;

   // 当你是把获得的高度来布局控件的View的高度的时候.size转化为ceilf(size.height)。
    return  ceilf(size.height);
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
}
//返回
-(void)actionForBack{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
