//
//  SchoolStarShopCommentVC.m
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/4/6.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZSchoolStarShopCommentVC.h"
#import "CZAdvisorDetailService.h"
#import "QSCommonService.h"
#import "CZMJRefreshHelper.h"
#import "CZCommentModel.h"
#import "CZCommentsDetailVC.h"

@interface CZSchoolStarShopCommentVC ()
@property (nonatomic ,assign) NSInteger pageNum;
@end

@implementation CZSchoolStarShopCommentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageNum = 1;
    [self initWithUI];
    [self actionMethod];
    [self requestForApiObjectCommentsFindComments];
}

- (void)actionMethod{
    WEAKSELF
    self.tableView.mj_footer = [CZMJRefreshHelper lb_footerWithAction:^{
        weakSelf.pageNum ++;
        [weakSelf requestForApiObjectCommentsFindComments];
    }];
    //点击评价
    self.tableView.selectCommentBlock = ^(CZCommentModel * _Nonnull model) {
        CZCommentsDetailVC *detailVC = [[CZCommentsDetailVC alloc]init];
        detailVC.idStr = model.socId;
        [weakSelf.superVC.navigationController pushViewController:detailVC animated:YES];
    };
}

/**
 获取评价
 */
- (void)requestForApiObjectCommentsFindComments{
    WEAKSELF
    CZAdvisorDetailService *service = serviceByType(QSServiceTypeAdvisorDetail);
    [service requestForApiObjectCommentsFindComments:@"3" idStr:self.sportUserId filterSum:1 pageNum:self.pageNum pageSize:20 callBack:^(BOOL success, NSInteger code, id  _Nonnull data, NSString * _Nonnull errorMessage) {
       if (success){
            dispatch_async(dispatch_get_main_queue(), ^{
                NSMutableArray *array = [[NSMutableArray alloc] init];
                for (NSDictionary *dic in data[@"list"]) {
                    CZCommentModel *model = [CZCommentModel modelWithDict:dic];
                    CGFloat height = [weakSelf getStringHeightWithText:model.comment font:[UIFont systemFontOfSize:ScreenScale(26)] viewWidth:kScreenWidth - ScreenScale(146)];
                    model.commentHeight = height;
                    [array addObject:model];
                }
                weakSelf.tableView.headerView.titleLab.text = [NSString stringWithFormat:@"学员评价(%@)",data[@"totalSize"]];
                if (weakSelf.pageNum == 1) {
                    [weakSelf.tableView.dataArr removeAllObjects];
                    [weakSelf.tableView.dataArr addObjectsFromArray:array];
                }else{
                    [weakSelf.tableView.dataArr addObjectsFromArray:array];
                }
                [weakSelf.tableView reloadData];
                
//                if (weakSelf.pageNum == 1) {
//                    [weakSelf.tableView.mj_header endRefreshing];
//                }
                if (array.count < 20) {
                    [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
                }else{
                    [weakSelf.tableView.mj_footer endRefreshing];
                }
            });
        }
    }];
}

/**
 * 初始化UI
 */
- (void)initWithUI{
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

- (CZSchoolStarShopCommentTableView *)tableView{
    if (!_tableView) {
        _tableView = [[CZSchoolStarShopCommentTableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    }
    return _tableView;
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
@end
